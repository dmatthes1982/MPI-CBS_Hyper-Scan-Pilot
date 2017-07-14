function [ data ] = HSP_calcMeanPLV( cfg, data )
% HSP_CALCMEANPLV estimates the mean of the phase locking values for all
% dyads and electrodes over the different conditions.
%
% Use as
%   [ data ] = HSP_calcMeanPLV( cfg, data )
%
%  where the input data have to be the result from HSP_PHASELOCKVAL
%
% The configuration options are
%   cfg.numOfPart = numbers of participants, i.e. [1:1:6] or [1,3,5] (default: [])
%
% This function requires the fieldtrip toolbox
% 
% See also HSP_DATASTRUCTURE, HSP_PHASELOCKVAL

% Copyright (C) 2017, Daniel Matthes, MPI CBS 

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
numOfPart   = ft_getopt(cfg, 'numOfPart', []);

if isempty(numOfPart)
  numOfSources = size(data, 2);
  notEmpty = zeros(1, numOfSources);
  for i=1:1:numOfSources
      notEmpty(i) = (~isempty(data(i).dyad));
  end
  numOfPart = find(notEmpty);  
end

% -------------------------------------------------------------------------
% Get center frequency of fildered input signal
% -------------------------------------------------------------------------
centerFreq = (  data(1).dyad.cfg.previous{1}.previous.bpfreq(1) + ...
                data(1).dyad.cfg.previous{1}.previous.bpfreq(2)  ) ./ 2;

% -------------------------------------------------------------------------
% Estimate mean Phase Locking Value (mPLV)
% -------------------------------------------------------------------------
for i = numOfPart
  fprintf('Calc mean PLVs of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  numOfTrials = length(data(i).dyad.PLV);
  data(i).dyad.mPLV{1,numOfTrials} = [];
  for j=1:1:numOfTrials
    data(i).dyad.mPLV{j} = mean(data(i).dyad.PLV{j}, 2);
  end
  data(i).dyad = rmfield(data(i).dyad, {'time', 'PLV'});
end

end

