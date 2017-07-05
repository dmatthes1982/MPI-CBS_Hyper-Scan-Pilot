function [data] = HSP_importAllDatasets( cfg )
% HSP_IMPORTALLDATASETS imports data of all dyads and participants, which 
% are under a specific source location.
%
% Use as
%   [data] = HSP_importAllDatasets(cfg)
%
% The configuration options are
%   cfg.path = 'source folder' (default: '/data/pt_01821/DualEEG_AD_auditory_rawData/')
%
% You can use relativ path specifications (i.e. '/home/user/MATLAB/data/') 
% or absolute path specifications like in the default settings. Please be 
% aware that you have to mask space signs of the path names under linux 
% with a backslash char (i.e. '/home/user/test\ data')
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_IMPORTSINGLEDATASET

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
path = ft_getopt(cfg, 'path', '/data/pt_01821/DualEEG_AD_auditory_rawData/');

% -------------------------------------------------------------------------
% Import data
% -------------------------------------------------------------------------
folder      = path;                                                         % specifies the data folder
filelist    = dir([folder, '/*.vhdr']);                                     % gets the filelist of the folder
filelist    = struct2cell(filelist);
filelist    = filelist(1,:);

numOfPart = length(filelist);                                               % get number of participants

if(numOfPart == 0)
  error('No files *.vhdr under specified location found');                  % throw error if no files were found
end

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
data(numOfPart) = struct;

% -------------------------------------------------------------------------
% Import of all data in the data folder
% -------------------------------------------------------------------------
for i=1:1:numOfPart                                                        
  
  cellnumber  = find(contains(filelist, num2str(i,'%02.0f')), 1);
  
  if ~isempty(cellnumber)
    header = char(filelist(cellnumber));
    dataset = strcat(folder, header);
    
    cfg = [];
    cfg.dataset = dataset;
    fprintf('Import data from: %s ...\n', dataset);
    dataImport = HSP_importSingleDataset(cfg);
    
    data(i).part1    = dataImport.part1;
    data(i).part2    = dataImport.part2;
  end
  
end

end
