function [ data ] = HSP_bpFiltering( cfg, data) 
% HSP_BPFILTERING applies a specific bandpass filter to every channel in
% the HSP_DATASTRUCTURE
%
% Use as
%   [ data ] = HSP_bpFiltering( cfg, data)
%
% where the input data have to be the result from HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION 
%
% The configuration options are
%   cfg.bpfreq      = passband range [begin end] (default: [1.9 2.1])
%   cfg.filtorder   = define order of bandpass filter (default: 250)
%   cfg.numOfPart = numbers of participants, i.e. [1:1:6] or [1,3,5] (default: [])
%
% This function is configured with a fixed filter order, to generate
% comparable filter charakteristics for every operating point.
%
% This function requires the fieldtrip toolbox
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, HSP_SEGMENTATION, 
% HSP_DATASTRUCTURE, FT_PREPROCESSING

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
bpfreq    = ft_getopt(cfg, 'bpfreq', [1.9 2.1]);
order     = ft_getopt(cfg, 'filtorder', 250);
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
% Filtering settings
% -------------------------------------------------------------------------
cfg                 = [];
cfg.trials          = 'all';                                                % apply bandpass to all trials
cfg.channel         = {'all', '-REF', '-EOGV', '-EOGH'};                    % apply bandpass to every channel except REF, EOGV und EOGH
cfg.bpfilter        = 'yes';
cfg.bpfilttype      = 'fir';                                                % use a simple fir
cfg.bpfreq          = bpfreq;                                               % define bandwith
cfg.feedback        = 'no';                                                 % suppress feedback output
cfg.showcallinfo    = 'no';                                                 % suppress function call output
cfg.bpfiltord       = order;                                                % define filter order

centerFreq = (bpfreq(2) + bpfreq(1))/2;

% -------------------------------------------------------------------------
% Bandpass filtering
% -------------------------------------------------------------------------
data(max(numOfPart)).centerFreq = [];

parfor i = numOfPart
  fprintf('Apply bandpass to participant 1 of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  data(i).part1   = ft_preprocessing(cfg, data(i).part1);        
          
  fprintf('Apply bandpass to participant 2 of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  data(i).part2   = ft_preprocessing(cfg, data(i).part2);
  
  data(i).centerFreq = centerFreq;
end

end
