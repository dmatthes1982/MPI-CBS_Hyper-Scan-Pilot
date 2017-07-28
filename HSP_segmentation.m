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
cfg.length          = 5;                                                    % segmentation into 5 seconds long segments
cfg.overlap         = 0;                                                    % no overlap

% -------------------------------------------------------------------------
% Segmentation
% -------------------------------------------------------------------------
% segLength = cfg.length;

parfor i = numOfPart
%   sampleinfo = data(i).part1.sampleinfo;                                  % calc trialinfo for subsegmented data in case of overlapping trials
%   trialinfo = data(i).part1.trialinfo;
%   overlap = 0;
%   
%   for j=2:1:size(sampleinfo, 1)
%     if sampleinfo(j,1) < sampleinfo(j-1, 2)
%       overlap = 1;
%       break;
%     end
%   end
%   if (overlap == 1)
%     numOfTrials = length(trialinfo);
% %   fsample = data(i).part1.fsample;
%     subseg = (sampleinfo(1,2)-sampleinfo(1,1)+1) / (segLength * 500);
%     tmpTrialinfo = zeros(subseg * numOfTrials, 1);
%     for k=1:1:numOfTrials
%       for l=1:1:subseg
%         tmpTrialinfo((k-1)*subseg + l) = trialinfo(k);
%       end
%     end
%     trialinfo = tmpTrialinfo;
%   end
  
  fprintf('Segment data of participant 1 of dyad %d...\n', i);
  ft_info off;
  ft_warning off;
  data(i).part1 = ft_redefinetrial(cfg, data(i).part1);
%   if (overlap == 1)                                                       % correct trialinfo for subsegmented data in case of overlapping trials
%     data(i).part1.trialinfo = trialinfo;
%   end
  
  fprintf('Segment data of participant 2 of dyad %d...\n', i);
  ft_info off;
  ft_warning off;
  data(i).part2 = ft_redefinetrial(cfg, data(i).part2);
%   if (overlap == 1)                                                       % correct trialinfo for subsegmented data in case of overlapping trials
%     data(i).part2.trialinfo =  trialinfo;
%   end
end

ft_info on;
ft_warning on;
