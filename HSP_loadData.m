function HSP_loadData( cfg )
% HSP_LOADDATA loads a specific HSP dataset
%
% Use as
%   HSP_loadData( cfg )
%
% The configuration options are
%   cfg.desFolder   = source folder (default: '/data/pt_01821/DualEEG_AD_auditory_processedData/')
%   cfg.filename    = filename (default: 'HSP_01_raw')
%   cfg.sessionStr  = number of session, format: %03d, i.e.: '003' (default: '001')
%
% This function requires the fieldtrip toolbox.
%
% SEE also LOAD

% Copyright (C) 2017, Daniel Matthes, MPI CBS

desFolder   = ft_getopt(cfg, 'desFolder', '/data/pt_01821/DualEEG_AD_auditory_processedData/');
filename    = ft_getopt(cfg, 'filename', 'HSP_01_raw');
sessionStr  = ft_getopt(cfg, 'sessionStr', '001');

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num ~= 0
  newData = load(file_path);
  vars = fieldnames(newData);
  for i = 1:length(vars)
    assignin('base', vars{i}, newData.(vars{i}));
  end
else
  error('File %s does not exist.', file_path);
end

end

