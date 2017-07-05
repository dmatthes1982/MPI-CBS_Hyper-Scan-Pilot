function [ data ] = HSP_segmentation( data )
% HSP_SEGMENTATION segments the data of each condition into segments with a
% duration of 5 seconds
%
% Use as
%   [ data ] = HSP_segmentation(data)
%
% where the input data can be the result from HSP_IMPORTALLDATASETS or
% HSP_PREPROCESSING
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, FT_REDEFINETRIAL,
% HSP_DATASTRUCTURE

% Copyright (C) 2017, Daniel Matthes, MPI CBS


% -------------------------------------------------------------------------
% Get number of participants
% -------------------------------------------------------------------------
numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% Segmentation settings
% -------------------------------------------------------------------------
cfg                 = [];
cfg.feedback        = 'no';
cfg.showcallinfo    = 'no';
cfg.trials          = 'all';                                                  
cfg.length          = 5;                                                    % segmentation into 5 seconds long segments
cfg.overlap         = 0;                                                    % no overlap

% -------------------------------------------------------------------------
% Segmentation
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Segment data of participant 1 of dyad %d...\n', i);
  data(i).part1 = ft_redefinetrial(cfg, data(i).part1);
  
  fprintf('Segment data of participant 2 of dyad %d...\n', i);
  data(i).part2 = ft_redefinetrial(cfg, data(i).part2);
  
end

