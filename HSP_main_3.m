%% check if basic variables are defined and import preprocessed data
if ~exist('sessionStr', 'var')
  cfg           = [];
  cfg.filename  = 'HSP_02_preproc';
  sessionStr    = sprintf('%03d', HSP_getSessionNum( cfg ));                % estimate current session number
end

if ~exist('desPath', 'var')
  desPath       = '/data/pt_01821/DualEEG_AD_auditory_processedData/';      % destination path for processed data  
end

cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_02_preproc';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');

fprintf('Loading %s ...\n', file_path);
HSP_load( cfg );                                                            % load preprocessed data

if ~exist('numOfPart', 'var')                                               % number of participants
  numOfPart = squeeze(cell2mat(struct2cell(dyads)))';
end

%% segmentation of the preprocessed trials
% split the data of every condition into subtrials with a length of 5
% seconds
cfg           = [];
cfg.numOfPart = numOfPart;

data_seg1New  = HSP_segmentation( cfg, data_preproc );

clear data_preproc

%% export the segmented data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_03_seg1';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_seg1 = data_seg1New;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_seg1 = HSP_mergeDataset(cfgMerge, data_seg1New, data_seg1);
  clear cfgMerge;
end

fprintf('The segmented data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_seg1', data_seg1, 'dyads', dyads);
fprintf('Data stored!\n');

%% clear workspace
clear dest_folder file_name file_path file_version file_pattern file_num ...
      cfg