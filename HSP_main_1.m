%% check if basic variables are defined
if ~exist('sessionStr', 'var')
  cfg         = [];                                                         
  sessionStr  = sprintf('%03d', HSP_getSessionNum( cfg ) + 1);              % calculate next session number
end

if ~exist('srcPath', 'var')
  srcPath     = '/data/pt_01821/DualEEG_AD_auditory_rawData/';              % source path to raw data
end

if ~exist('desPath', 'var')
  desPath     = '/data/pt_01821/DualEEG_AD_auditory_processedData/';        % destination path for processed data  
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

dyadsNew(max(numOfPart)).number = [];                                       % initialize dyadsNew structure

for i = numOfPart                                                           
  dyadsNew(i).number = i;
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
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_01_raw';
cfg.sessionStr  = sessionStr;
dyads(max(numOfPart)).number = [];

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_raw = data_rawNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_raw = HSP_mergeDataset(cfgMerge, data_rawNew, data_raw);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('The RAW data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_raw', data_raw, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_raw

%% preprocess the raw data
cfg                   = [];
cfg.bpfreq            = [1 48];                                             % passband from 0.3 to 48 Hz
cfg.bpfilttype        = 'but';
cfg.bpinstabilityfix  = 'split';
cfg.numOfPart         = numOfPart;

selection = false;
while selection == false
  cprintf([0,0.6,0], '\nPlease select sampling rate:\n');
  fprintf('[1] - 500 Hz (original sampling rate)\n');
  fprintf('[2] - 250 Hz (downsampling factor 2)\n');
  fprintf('[3] - 125 Hz (downsampling factor 4)\n');
  x = input('Option: ');
  
  switch x
    case 1
      selection = true;
      cfg.samplingRate = 500;
    case 2
      selection = true;
      cfg.samplingRate = 250;
    case 3
      selection = true;
      cfg.samplingRate = 125;
    otherwise
      cprintf([1,0.5,0], 'Wrong input!\n');
  end
end
fprintf('\n');

ft_info off;
data_preprocNew = HSP_preprocessing( cfg, data_rawNew);
ft_info on;

clear data_rawNew

%% export the preprocessed data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_02_preproc';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_preproc = data_preprocNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_preproc = HSP_mergeDataset(cfgMerge, data_preprocNew, data_preproc);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('The preprocessed data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_preproc', data_preproc, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_preproc

%% calculate TFRs of the preprocessed data
cfg         = [];
cfg.foi     = 2:1:50;                                                       % frequency of interest
cfg.toi     = 4:0.5:176;                                                    % time of interest
cfg.numOfPart = numOfPart;
  
data_tfr1New = HSP_timeFreqanalysis( cfg, data_preprocNew );

clear data_preprocNew

%% export the preprocessed data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_03_tfr1';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_tfr1 = data_tfr1New;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_tfr1 = HSP_mergeDataset(cfgMerge, data_tfr1New, data_tfr1);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('The time-frequency response data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_tfr1', data_tfr1, 'dyads', dyads);
fprintf('Data stored!\n\n');
clear data_tfr1 data_tfr1New

%% clear workspace
clear file_path file_num cfg sourceList numOfSources dyads dyadsNew i ...
      selection
