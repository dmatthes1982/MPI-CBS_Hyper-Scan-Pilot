function [ num ] = HSP_getSessionNum( cfg )
% HSP_GETSESSIONNUM determines the highest session number of a specific 
% data file 
%
% Use as
%   [ num ] = HSP_getSessionNum( cfg )
%
% The configuration options are
%   cfg.desFolder   = destination folder (default: '/data/pt_01821/DualEEG_AD_auditory_processedData/')
%   cfg.filename    = filename (default: HSP_01_raw)
%
% This function requires the fieldtrip toolbox.

% Copyright (C) 2017, Daniel Matthes, MPI CBS

desFolder   = ft_getopt(cfg, 'srcFolder', '/data/pt_01821/DualEEG_AD_auditory_processedData/');
filename    = ft_getopt(cfg, 'filename', 'HSP_01_raw');

file_path = strcat(desFolder, filename, '_*.mat');

sessionList    = dir(file_path);
if isempty(sessionList)
  num = 0;
else
  sessionList    = struct2cell(sessionList);
  sessionList    = sessionList(1,:);
  numOfSessions  = length(sessionList);

  sessionNum     = zeros(1, numOfSessions);

  for i=1:1:numOfSessions
    sessionNum(i) = sscanf(sessionList{i}, 'HSP_01_raw_%d.mat');
  end

  num = max(sessionNum);
end

end

