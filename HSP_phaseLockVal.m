function [ data ] = HSP_phaseLockVal( cfg, data )
% HSP_PHASELOCKVAL calculates the phase locking value of between the
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
centerFreq = (  data(1).Earphone2HzS{1}.cfg.previous.bpfreq(1) + ...
                data(1).Earphone2HzS{1}.cfg.previous.bpfreq(2)  ) ./ 2;

% -------------------------------------------------------------------------
% Calculate Phase Locking Value (PLV)
% -------------------------------------------------------------------------

for i=1:1:numOfPart
  fprintf('Calc PLVs in set Earphone2HzS of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone2HzS{1})
    data(i).Earphone2HzS      = phaseLockingValue(cfg, ...
                                     data(i).Earphone2HzS);
  else
    data(i).Earphone2HzS      = [];
  end
  
  fprintf('Calc PLVs in set Speaker2HzS of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker2HzS{1})
    data(i).Speaker2HzS       = phaseLockingValue(cfg, ...
                                       data(i).Speaker2HzS);
  else
    data(i).Speaker2HzS       = [];
  end
  
  fprintf('Calc PLVs in set Tapping2HzS of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Tapping2HzS{1})
    data(i).Tapping2HzS       = phaseLockingValue(cfg, ...
                                       data(i).Tapping2HzS);
  else
    data(i).Tapping2HzS       = [];
  end
  
  fprintf('Calc PLVs in set Dialogue2HzS of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Dialogue2HzS{1})
    data(i).Dialogue2HzS      = phaseLockingValue(cfg, ...
                                       data(i).Dialogue2HzS);
  else
    data(i).Dialogue2HzS      = [];
  end
  
  fprintf('Calc PLVs in set Speaker20HzS of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker20HzS{1})
    data(i).Speaker20HzS      = phaseLockingValue(cfg, ...
                                       data(i).Speaker20HzS);
 else
    data(i).Speaker20HzS      = [];
  end
  
  fprintf('Calc PLVs in set Earphone20HzS of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone20HzS{1})
    data(i).Earphone20HzS     = phaseLockingValue(cfg, ...
                                       data(i).Earphone20HzS);
  else
    data(i).Earphone20HzS     = [];
  end
  
  fprintf('Calc PLVs in set Speaker20HzA of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker20HzA{1})
    data(i).Speaker20HzA      = phaseLockingValue(cfg, ...
                                       data(i).Speaker20HzA);
  else
    data(i).Speaker20HzA      = [];
  end
  
  fprintf('Calc PLVs in set Earphone20HzA of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone20HzA{1})
    data(i).Earphone20HzA     = phaseLockingValue(cfg, ...
                                       data(i).Earphone20HzA);
  else
    data(i).Earphone20HzA       = [];
  end
  
  fprintf('Calc PLVs in set Earphone2HzA of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone2HzA{1})
    data(i).Earphone2HzA      = phaseLockingValue(cfg, ...
                                       data(i).Earphone2HzA);
  else
    data(i).Earphone2HzA      = [];
  end
  
  fprintf('Calc PLVs in set Speaker2HzA of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker2HzA{1})
    data(i).Speaker2HzA       = phaseLockingValue(cfg, ...
                                       data(i).Speaker2HzA);
  else
    data(i).Speaker2HzA       = [];
  end
    
  fprintf('Calc PLVs in set Earphone40HzS of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone40HzS{1})
    data(i).Earphone40HzS     = phaseLockingValue(cfg, ...
                                       data(i).Earphone40HzS);
  else
    data(i).Earphone40HzS     = [];
  end
  
  fprintf('Calc PLVs in set Speaker40HzS of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker40HzS{1})
    data(i).Speaker40HzS      = phaseLockingValue(cfg, ...
                                       data(i).Speaker40HzS);
  else
    data(i).Speaker40HzS      = [];
  end
  
  fprintf('Calc PLVs in set Atalks2B of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Atalks2B{1})
    data(i).Atalks2B          = phaseLockingValue(cfg, ...
                                       data(i).Atalks2B);
  else
    data(i).Atalks2B          = [];
  end
  
  fprintf('Calc PLVs in set Btalks2A of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Btalks2A{1})
    data(i).Btalks2A          = phaseLockingValue(cfg, ...
                                       data(i).Btalks2A);
  else
    data(i).Btalks2A          = [];
  end
  
  fprintf('Calc PLVs in set Dialogue of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Dialogue{1})
    data(i).Dialogue          = phaseLockingValue(cfg, ...
                                       data(i).Dialogue);
  else
    data(i).Dialogue          = [];
  end
  
  fprintf('Calc PLVs in set SilEyesOpen of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).SilEyesOpen{1})
    data(i).SilEyesOpen       = phaseLockingValue(cfg, ...
                                       data(i).SilEyesOpen);
  else
    data(i).SilEyesOpen       = [];
  end
  
  fprintf('Calc PLVs in set SilEyesClosed of dyad %d at a frequency of interest of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).SilEyesClosed{1})
    data(i).SilEyesClosed     = phaseLockingValue(cfg, ...
                                       data(i).SilEyesClosed);
  else
    data(i).SilEyesClosed     = [];
  end
end

end

function [data_out] = phaseLockingValue(cfgPLV, data_in)

numOfTrials             = length(data_in{1}.trial);
numOfElec               = length(data_in{1}.label);
timeOrg                 = data_in{1}.time;
trial1                  = data_in{1}.trial;
trial2                  = data_in{2}.trial;

trialdiff{numOfTrials}  = [];
for i=1:1:numOfTrials
  trialdiff{i}          = trial1{i} - trial2{i};
end

N                       = cfgPLV.winlen * data_in{1}.fsample;
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

data_out                  = keepfields(data_in{1}, {'hdr', 'fsample'});
data_out.trialinfo        = data_in{1}.trialinfo(1);
data_out.PLV              = {cell2mat(PLV)};
data_out.time             = {cell2mat(time)};
data_out.label            = data_in{1}.label;
data_out.cfg              = cfgPLV;
data_out.cfg.previous{1}  = data_in{1}.cfg;
data_out.cfg.previous{2}  = data_in{2}.cfg;

end