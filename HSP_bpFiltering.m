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
bpfreq = ft_getopt(cfg, 'bpfreq', [1.9 2.1]);
order  = ft_getopt(cfg, 'filtorder', 250);

numOfPart = size(data, 2);

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

parfor i=1:1:numOfPart
  fprintf('Apply bandpass to participant 1 of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  data(i).part1   = ft_preprocessing(cfg, data(i).part1);        
          
  fprintf('Apply bandpass to participant 2 of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  data(i).part2   = ft_preprocessing(cfg, data(i).part2);
end

end
