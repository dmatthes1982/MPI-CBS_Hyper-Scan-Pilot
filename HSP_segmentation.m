function [ data ] = HSP_segmentation( cfg, data )
% HSP_SEGMENTATION segments the data of each condition into segments with a
% duration of 5 seconds
%
% Use as
%   [ data ] = HSP_segmentation(cfg, data)
%
% where the input data can be the result from HSP_IMPORTALLDATASETS or
% HSP_PREPROCESSING
%
% The configuration options are
%   cfg.numOfPart = numbers of participants, i.e. [1:1:6] or [1,3,5] (default: [])
%   cfg.length    = length of segments (excepted values: 1, 5, 10 seconds)
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, FT_REDEFINETRIAL,
% HSP_DATASTRUCTURE

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
numOfPart = ft_getopt(cfg, 'numOfPart', []);
segLength = ft_getopt(cfg, 'length', 10);

possibleLengths = [1, 5, 10];

if ~any(ismember(possibleLengths, segLength))
  error('Excepted cfg.length values are only 1, 5 and 10 seconds');
end

if isempty(numOfPart)
  numOfSources = size(data, 2);
  notEmpty = zeros(1, numOfSources);
  for i=1:1:numOfSources
      notEmpty(i) = (~isempty(data(i).part1));
  end
  numOfPart = find(notEmpty);  
end

% -------------------------------------------------------------------------
% Segmentation settings
% -------------------------------------------------------------------------
cfg                 = [];
cfg.feedback        = 'no';
cfg.showcallinfo    = 'no';
cfg.trials          = 'all';                                                  
cfg.length          = segLength;                                            
cfg.overlap         = 0;                                                    % no overlap

% -------------------------------------------------------------------------
% Segmentation
% -------------------------------------------------------------------------
for i = numOfPart
  fprintf('Segment data of participant 1 of dyad %d...\n', i);
  ft_info off;
  ft_warning off;
  data(i).part1 = ft_redefinetrial(cfg, data(i).part1);
    
  fprintf('Segment data of participant 2 of dyad %d...\n', i);
  ft_info off;
  ft_warning off;
  data(i).part2 = ft_redefinetrial(cfg, data(i).part2);  
end

ft_info on;
ft_warning on;
