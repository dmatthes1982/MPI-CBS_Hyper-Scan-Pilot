function HSP_saveData( cfg, varargin )
% HSP_SAVEDATA stores the data of various structure elements (generally 
% HSP-datastructures and dyads-info-structures) into a MAT_File.
%
% Use as
%   HSP_saveData( cfg, varargin )
%
% The configuration options are
%   cfg.srcFolder   = source folder (default: '/data/pt_01821/DualEEG_AD_auditory_processedData/')
%   cfg.filename    = filename (default: 'HSP_01_raw')
%   cfg.sessionStr  = number of session, format: %03d, i.e.: '003' (default: '001')
%
% This function requires the fieldtrip toolbox.
%
% SEE also SAVE

% Copyright (C) 2017, Daniel Matthes, MPI CBS

srcFolder   = ft_getopt(cfg, 'srcFolder', '/data/pt_01821/DualEEG_AD_auditory_processedData/');
filename    = ft_getopt(cfg, 'filename', 'HSP_01_raw');
sessionStr  = ft_getopt(cfg, 'sessionStr', '010');

file_path = strcat(srcFolder, filename, '_', sessionStr, '.mat');

inputElements = length(varargin);

if inputElements == 0
  error('No elements to save!');
elseif mod(inputElements, 2)
  error('Numbers of input are not even!');
else
  for i = 1:2:inputElements-1
    if ~isvarname(varargin{i})
      error('varargin{%d} is not a valid varname');
    else
      str = [varargin{i}, ' = varargin{i+1};'];
      eval(str);
    end
  end
end

save(file_path, '-regexp','^data','^dyads', '-v7.3');

end

