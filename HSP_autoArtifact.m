function [ cfgAutoArt ] = HSP_autoArtifact( cfg, data )
% HSP_AUTOREJECT marks timeslots as an artifact in which the level of 'Cz',
% 'O2' and 'O4' exceeds or fall below +/- 75 mV.
%
% Use as
%   [ data ] = HSP_autoArtifact(cfg, data)
%
% where data has to be a result of HSP_SEGMENTATION
%
% The configuration options are
%   cfg.channel = cell-array with channel labels (default: {'Cz', 'O1', 'O2'}))
%   cfg.min     = lower limit in uV (default: -75)
%   cfg.max     = upper limit in uV (default: 75)
%   cfg.numOfPart = numbers of participants, i.e. [1:1:6] or [1,3,5] (default: [])
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_SEGMENTATION, FT_ARTIFACT_THRESHOLD

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------

chan      = ft_getopt(cfg, 'channel', {'Cz', 'O1', 'O2'});
minVal    = ft_getopt(cfg, 'min', -75);
maxVal    = ft_getopt(cfg, 'max', 75);
numOfPart = ft_getopt(cfg, 'numOfPart', []);

if isempty(numOfPart)                                                       % get numOfPart
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
ft_info off;

cfg                               = [];
cfg.continuous                    = 'no';                                   % data are already trial based
cfg.artfctdef.threshold.channel   = chan;                                   % specify channels of interest
cfg.artfctdef.threshold.bpfilter  = 'no';                                   % use no additional bandpass
cfg.artfctdef.threshold.min       = minVal;                                 % minimum threshold
cfg.artfctdef.threshold.max       = maxVal;                                 % maximum threshold
cfg.showcallinfo                  = 'no';

% -------------------------------------------------------------------------
% Estimate artifacts
% -------------------------------------------------------------------------
cfgAutoArt(max(numOfPart)).part1 = [];                                      % build output structure
cfgAutoArt(max(numOfPart)).part2 = [];
cfgAutoArt(max(numOfPart)).bad1Num = []; 
cfgAutoArt(max(numOfPart)).bad2Num = [];
cfgAutoArt(max(numOfPart)).trialsNum = [];

for i = numOfPart
  cfgAutoArt(i).trialsNum = length(data(i).part1.trial);                    
  
  cfg.trl = data(i).part1.cfg.previous.trl;
  fprintf('Estimate artifacts in participant 1 of dyad %d...\n', i);
  cfgAutoArt(i).part1    = ft_artifact_threshold(cfg, data(i).part1); 
  cfgAutoArt(i).bad1Num = length(cfgAutoArt(i).part1.artfctdef.threshold.artifact);
  fprintf('%d artifacts detected!\n', cfgAutoArt(i).bad1Num);
  
  cfg.trl = data(i).part2.cfg.previous.trl;
  fprintf('Estimate artifacts in participant 2 of dyad %d...\n', i);
  cfgAutoArt(i).part2    = ft_artifact_threshold(cfg, data(i).part2);
  cfgAutoArt(i).bad2Num = length(cfgAutoArt(i).part2.artfctdef.threshold.artifact);
  fprintf('%d artifacts detected!\n', cfgAutoArt(i).bad2Num);
end

ft_info on;

end

