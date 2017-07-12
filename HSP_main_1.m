%% check if basic variables are defined
if ~exist('dyadSpec', 'var')
  dyadSpec = 'all';                                                         % process all dyads                                                         
end

if ~exist('session', 'var')
  session = 0;                                                              % new Session
end

if ~exist('sessionStr', 'var')
  cfg         = [];                                                         
  sessionStr  = sprintf('%03d', HSP_getSessionNum( cfg ) + 1);              % calculate next session number
end

if ~exist('srcPath', 'var')
  srcPath = '/data/pt_01821/DualEEG_AD_auditory_rawData/';                  % source path to raw data
end

if ~exist('desPath', 'var')
  desPath = '/data/pt_01821/DualEEG_AD_auditory_processedData/';            % destination path for processed data  
end

if ~exist('numOfPart', 'var')                                               % estimate number of participants in raw data folder
  sourceList    = dir([srcPath, '/*.vhdr']);
  sourceList    = struct2cell(sourceList);
  sourceList    = sourceList(1,:);
  numOfSources  = length(sourceList);
  numOfPart     = zeros(1, numOfSources);

  for i=1:1:numOfSources
    numOfPart(i)  = sscanf(sourceList{i}, 'DualEEG_AD_auditory_%d.vhdr');
  end
end

%% import data from brain vision eeg files and bring it into an order
cfg           = [];
cfg.path      = srcPath;
cfg.numOfPart = numOfPart;

fprintf('Import data from: %s ...\n', cfg.path);
ft_info off;
data_rawNew = HSP_importAllDatasets( cfg );
ft_info on;

%% export the imported and sorted data into an *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_01_raw';
cfg.sessionStr  = sessionStr;
dyads(max(numOfPart)).number = [];

if session == 0
  data_raw = data_rawNew;
  for i = numOfPart
    dyads(i).number = i;
  end
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_raw = HSP_mergeDataset(cfgMerge, data_rawNew, data_raw);
  for i = numOfPart
    dyads(i).number = i;
  end
  clear cfgMerge;
end

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');  
fprintf('The RAW data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_raw', data_raw, 'dyads', dyads);
fprintf('Data stored!\n');

%% preprocess the raw data
cfg         = [];
cfg.bpfreq  = [0.1 48];                                                     % passband from 0.3 to 48 Hz
cfg.numOfPart = numOfPart;

ft_info off;
data_preprocNew = HSP_preprocessing( cfg, data_rawNew);
ft_info on;

clear data_rawNew

%% export the preprocessed data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_02_preproc';
cfg.sessionStr  = sessionStr;

if session == 0
  data_preproc = data_preprocNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_preproc = HSP_mergeDataset(cfgMerge, data_preprocNew, data_preproc);
  clear cfgMerge;
end

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');  
fprintf('The preprocessed data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_preproc', data_preproc, 'dyads', dyads);
fprintf('Data stored!\n');

%% calculate TFRs of the preprocessed data
cfg         = [];
cfg.foi     = 2:1:50;                                                       % frequency of interest
cfg.toi     = 4:0.5:176;                                                    % time of interest
cfg.numOfPart = numOfPart;
  
data_tfr1New = HSP_timeFreqanalysis( cfg, data_preprocNew );

clear data_preprocNew

%% export the preprocessed data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_03_tfr1';
cfg.sessionStr  = sessionStr;

if session == 0
  data_tfr1 = data_tfr1New;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_tfr1 = HSP_mergeDataset(cfgMerge, data_tfr1New, data_tfr1);
  clear cfgMerge;
end

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');  
fprintf('The time-frequency response data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_tfr1', data_tfr1, 'dyads', dyads);
fprintf('Data stored!\n');

clear dest_folder file_name file_path file_version file_pattern file_num ...
      cfg