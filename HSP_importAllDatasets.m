function [data] = HSP_importAllDatasets( cfg )
% HSP_IMPORTALLDATASETS imports data of all participants, which are under a 
% specific source location.
%
% Use as
%   [data] = HSP_importAllDatasets(cfg)
%
% The configuration options are
%   cfg.path = 'source folder' (default: '../../data/HyperScanPilot/raw_data/')
%
% You can use relativ path specifications like in the default settings or
% absolute path specifications (i.e. '/home/user/MATLAB/data/'). Please be 
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
path = ft_getopt(cfg, 'path', '../../data/HyperScanPilot/raw_data/');

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
data(numOfPart).Earphone40Hz      = [];
data(numOfPart).Speaker40Hz       = [];
data(numOfPart).Earphone2Hz       = [];
data(numOfPart).Speaker2Hz        = [];
data(numOfPart).Silence           = [];
data(numOfPart).SilEyesClosed     = [];
data(numOfPart).MixNoiseEarphones = [];
data(numOfPart).MixNoiseSpeaker   = [];
data(numOfPart).Tapping           = [];
data(numOfPart).DialoguePlus2Hz   = [];
data(numOfPart).AreadsB           = [];
data(numOfPart).BreadsA           = [];
data(numOfPart).Dialogue          = [];

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
    dataImport = HSP_importSingleDataset(cfg);
    
    data(i).Earphone40Hz        = dataImport.Earphone40Hz;
    data(i).Speaker40Hz         = dataImport.Speaker40Hz;
    data(i).Earphone2Hz         = dataImport.Earphone2Hz;
    data(i).Speaker2Hz          = dataImport.Speaker2Hz;
    data(i).Silence             = dataImport.Silence;
    data(i).SilEyesClosed       = dataImport.SilEyesClosed;
    data(i).MixNoiseEarphones   = dataImport.MixNoiseEarphones;
    data(i).MixNoiseSpeaker     = dataImport.MixNoiseSpeaker;
    data(i).Tapping             = dataImport.Tapping;
    data(i).DialoguePlus2Hz     = dataImport.DialoguePlus2Hz;
    data(i).AreadsB             = dataImport.AreadsB;
    data(i).BreadsA             = dataImport.BreadsA;
    data(i).Dialogue            = dataImport.Dialogue;
  end
  
end

end
