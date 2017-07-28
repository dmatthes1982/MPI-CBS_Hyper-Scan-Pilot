function [ data ] = HSP_timeFreqanalysis( cfg, data )
% HSP_TIMEFREQANALYSIS performs a time frequency analysis on the whole
% hyperscanning pilot project dataset.
%
% Use as
%   [ data ] = HSP_timeFreqanalysis(cfg, data)
%
% where the input data have to be the result from HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION
%
% The configuration options are
%   config.foi = frequency of interest - begin:resolution:end (default: 2:1:50)
%   config.toi = time of interest - begin:resolution:end (default: 4:0.5:176)
%   cfg.numOfPart = numbers of participants, i.e. [1:1:6] or [1,3,5] (default: [])
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, HSP_SEGMENTATION, 
% HSP_DATASTRUCTURE

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
foi       = ft_getopt(cfg, 'foi', 2:1:50);
toi       = ft_getopt(cfg, 'toi', 4:0.5:176);
numOfPart = ft_getopt(cfg, 'numOfPart', []);

if isempty(numOfPart)
  numOfSources = size(data, 2);
  notEmpty = zeros(1, numOfSources);
  for i=1:1:numOfSources
      notEmpty(i) = (~isempty(data(i).part1));
  end
  numOfPart = find(notEmpty);  
end

% -------------------------------------------------------------------------
% TFR settings
% -------------------------------------------------------------------------
cfg                 = [];
cfg.method          = 'wavelet';
cfg.output          = 'pow';
cfg.channel         = 'all';                                                % calculate spectrum for specified channel
cfg.trials          = 'all';                                                % calculate spectrum for every trial  
cfg.keeptrials      = 'yes';                                                % do not average over trials
cfg.pad             = 'maxperlen';                                          % do not use padding
cfg.taper           = 'hanning';                                            % hanning taper the segments
cfg.foi             = foi;                                                  % frequencies of interest
cfg.width           = 7;                                                    % wavlet specific parameter 1 (default value)
cfg.gwidth          = 3;                                                    % wavlet specific parameter 2 (default value) 
cfg.toi             = toi;                                                  % time of interest
cfg.feedback        = 'no';                                                 % suppress feedback output
cfg.showcallinfo    = 'no';                                                 % suppress function call output

% -------------------------------------------------------------------------
% Time-Frequency Response (Analysis)
% -------------------------------------------------------------------------
parfor i = numOfPart
  fprintf('Calc TFRs of participant 1 of dyad %d...\n', i);
  ft_warning off;
  data(i).part1 = ft_freqanalysis(cfg, data(i).part1);
  
  fprintf('Calc TFRs of participant 2 of dyad %d...\n', i);
  ft_warning off;
  data(i).part2 = ft_freqanalysis(cfg, data(i).part2); 
end

ft_warning on;

end
