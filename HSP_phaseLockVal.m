function [ data ] = HSP_phaseLockVal( cfg, data )
% HSP_PHASELOCKVAL calculates the phase locking value between the
% the participants of the dyads over all conditions and trials in the 
% HSP_DATASTRUCTURE
%
% Use as
%   [ data ] = HSP_phaseLockVal( data )
%
% where the input data have to be the result from HSP_HILBERTPHASE
%
% The configuration options are
%   cfg.winlen = length of window over which the PLV will be calculated. (default: 5 sec)
%                minimum = 1 sec
% 
% Theoretical Background:                                    T
% The phase locking value is originally defined by Lachaux as a summation
% over N trials. Since this definition is only applicable for comparing
% event-related data, this function provides a variant of the originally
% version. In this case the summation is done over a sliding time
% intervall. This version has been frequently used in EEG hyperscanning
% studies.
%
% Equation:         PLV(t) = 1/T | Sigma(e^j(phi(n,t) - psi(n,t)) |
%                                   n=1
%
% Reference:
%   [Lachaux1999]   "Measuring Phase Synchrony in Brain Signals"
%
% See also HSP_DATASTRUCTURE, HSP_HILBERTPHASE

% Copyright (C) 2017, Daniel Matthes, MPI CBS 

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
cfg.winlen = ft_getopt(cfg, 'winlen', 5);

numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% Get center frequency of fildered input signal
% -------------------------------------------------------------------------
centerFreq = (  data(1).part1.cfg.previous.bpfreq(1) + ...
                data(1).part1.cfg.previous.bpfreq(2)  ) ./ 2;

% -------------------------------------------------------------------------
% Calculate Phase Locking Value (PLV)
% -------------------------------------------------------------------------
dataTmp(numOfPart) = struct;
dataTmp(numOfPart).part1 = [];
dataTmp(numOfPart).part2 = [];

for i=1:1:numOfPart
  fprintf('Calc PLVs of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  dataTmp(i)   = phaseLockingValue(cfg, data(i).part1, data(i).part2);
end

data = dataTmp;

end

function [data_out] = phaseLockingValue(cfgPLV, dataPart1, dataPart2)

numOfTrials             = length(dataPart1.trial);
numOfElec               = length(dataPart1.label);
timeOrg                 = dataPart1.time;
trial1                  = dataPart1.trial;
trial2                  = dataPart2.trial;

trialdiff{numOfTrials}  = [];
for i=1:1:numOfTrials
  trialdiff{i}          = trial1{i} - trial2{i};
end

N                       = cfgPLV.winlen * dataPart1.fsample;
PLV{numOfTrials}        = []; 
time{numOfTrials}       = [];

for i=1:1:numOfTrials
  lenOfTrial = length(trialdiff{i}(1,:));
  if N > lenOfTrial
    error('PLV window length is larger than the trial length, choose another size!');
  else
    numOfPLV = fix(lenOfTrial/N);
    for j=1:1:numOfPLV
      time{i}(1,j) = timeOrg{i}((j-1)*N + (N./2+1));
    end
  end
  for k=1:1:numOfElec
    for l=1:1:numOfPLV
      window = trialdiff{i}(k,(l-1)*N + 1:l*N);
      PLV{i}(k,l) = abs(sum(exp(1i*window))/N);
    end
  end
end

data_out                  = keepfields(dataPart1, {'hdr', 'fsample'});
data_out.trialinfo        = dataPart1.trialinfo(1);
data_out.PLV              = {cell2mat(PLV)};
data_out.time             = {cell2mat(time)};
data_out.label            = dataPart1.label;
data_out.cfg              = cfgPLV;
data_out.cfg.previous{1}  = dataPart1.cfg;
data_out.cfg.previous{2}  = dataPart2.cfg;

end