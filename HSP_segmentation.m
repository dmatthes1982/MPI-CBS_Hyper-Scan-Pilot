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
segLength = cfg.length;

parfor i=1:1:numOfPart
  ft_info off;
  sampleinfo = data(i).part1.sampleinfo;                                    % calc trialinfo for subsegmented data in case of overlapping trials
  overlap = 0;
  
  for j=2:1:size(sampleinfo, 1)
    if sampleinfo(j,1) < sampleinfo(j-1, 2)
      overlap = 1;
      break;
    end
  end
  if (overlap == 1)
    trialinfo = data(i).part1.trialinfo;
    numOfTrials = length(trialinfo);
%   fsample = data(i).part1.fsample;
    subseg = (sampleinfo(1,2)-sampleinfo(1,1)+1) / (segLength * 500);
    newTrialinfo = zeros(subseg * numOfTrials, 1);
    for k=1:1:numOfTrials
      for l=1:1:subseg
        newTrialinfo((k-1)*subseg + l) = trialinfo(k);
      end
    end
  end
  
  fprintf('Segment data of participant 1 of dyad %d...\n', i);
  data(i).part1 = ft_redefinetrial(cfg, data(i).part1);  
  if (overlap == 1)                                                         % correct trialinfo for subsegmented data in case of overlapping trials
    data(i).part1.trialinfo = newTrialinfo;
  end
  
  fprintf('Segment data of participant 2 of dyad %d...\n', i);
  data(i).part2 = ft_redefinetrial(cfg, data(i).part2);
  if (overlap == 1)                                                         % correct trialinfo for subsegmented data in case of overlapping trials
    data(i).part2.trialinfo =  newTrialinfo;
  end
  
  ft_info on;
end

