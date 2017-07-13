%% check if basic variables are defined and import preprocessed data
if ~exist('sessionStr', 'var')
  cfg           = [];
  cfg.filename  = 'HSP_04_seg1';
  sessionStr    = sprintf('%03d', HSP_getSessionNum( cfg ));                % estimate current session number
end

if ~exist('desPath', 'var')
  desPath       = '/data/pt_01821/DualEEG_AD_auditory_processedData/';      % destination path for processed data  
end

cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_04_seg1';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');

fprintf('Loading %s ...\n', file_path);
HSP_load( cfg );                                                            % load segmented data

if ~exist('numOfPart', 'var')                                               % number of participants
  numOfPart = squeeze(cell2mat(struct2cell(dyads)))';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 Hz branch
%% bandpass filter data at 2Hz
cfg           = [];
cfg.bpfreq    = [1.9 2.1];
cfg.filtorder = 500;
cfg.numOfPart = numOfPart;

data_bpfilt_2HzNew = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_05a_bpfilt2Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_2Hz = data_bpfilt_2HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_2Hz = HSP_mergeDataset(cfgMerge, data_bpfilt_2HzNew, ...
                                    data_plv_2Hz);
  clear cfgMerge;
end

fprintf('Saving bandpass filtered data (2Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_bpfilt_2Hz', data_plv_2Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_bpfilt_2Hz

%% calculate hilbert phase at 2Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_hilbert_2HzNew = HSP_hilbertPhase(cfg, data_bpfilt_2HzNew);
clear data_bpfilt_2HzNew 

%% export the hilbert phase data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_06a_hilbert2Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_2Hz = data_hilbert_2HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_2Hz = HSP_mergeDataset(cfgMerge, data_hilbert_2HzNew, ...
                                    data_plv_2Hz);
  clear cfgMerge;
end

fprintf('Saving Hilbert phase data (2Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_hilbert_2Hz', data_plv_2Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_hilbert_2Hz

%% calculate PLV at 2Hz
cfg           = [];
cfg.winlen    = 5;                                                          % window length for one PLV value in seconds
cfg.numOfPart = numOfPart;

data_plv_2HzNew = HSP_phaseLockVal(cfg, data_hilbert_2HzNew);
clear data_hilbert_2Hz

%% export the PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_07a_plv2Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_2Hz = data_plv_2HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_2Hz = HSP_mergeDataset(cfgMerge, data_plv_2HzNew, ...
                                    data_plv_2Hz);
  clear cfgMerge;
end

fprintf('Saving PLVs (2Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_plv_2Hz', data_plv_2Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_plv_2Hz data_plv_2HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 10 Hz branch
%% bandpass filter data at 10Hz
cfg           = [];
cfg.bpfreq    = [9 11];
cfg.filtorder = 250;
cfg.numOfPart = numOfPart;

data_bpfilt_10HzNew = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_05a_bpfilt10Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_10Hz = data_bpfilt_10HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_10Hz = HSP_mergeDataset(cfgMerge, data_bpfilt_10HzNew, ...
                                    data_plv_10Hz);
  clear cfgMerge;
end

fprintf('Saving bandpass filtered data (10Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_bpfilt_10Hz', data_plv_10Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_bpfilt_10Hz

%% calculate hilbert phase at 10Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_hilbert_10HzNew = HSP_hilbertPhase(cfg, data_bpfilt_10HzNew);
clear data_bpfilt_10HzNew 

%% export the hilbert phase data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_06a_hilbert10Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_10Hz = data_hilbert_10HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_10Hz = HSP_mergeDataset(cfgMerge, data_hilbert_10HzNew, ...
                                    data_plv_10Hz);
  clear cfgMerge;
end

fprintf('Saving Hilbert phase data (10Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_hilbert_10Hz', data_plv_10Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_hilbert_10Hz

%% calculate PLV at 10Hz
cfg           = [];
cfg.winlen    = 1;                                                          % window length for one PLV value in seconds
cfg.numOfPart = numOfPart;

data_plv_10HzNew = HSP_phaseLockVal(cfg, data_hilbert_10HzNew);
clear data_hilbert_10Hz

%% export the PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_07a_plv10Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_10Hz = data_plv_10HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_10Hz = HSP_mergeDataset(cfgMerge, data_plv_10HzNew, ...
                                    data_plv_10Hz);
  clear cfgMerge;
end

fprintf('Saving PLVs (10Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_plv_10Hz', data_plv_10Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_plv_10Hz data_plv_10HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 20 Hz branch
%% bandpass filter data at 20Hz
cfg           = [];
cfg.bpfreq    = [19 21];
cfg.filtorder = 250;
cfg.numOfPart = numOfPart;

data_bpfilt_20HzNew = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_05a_bpfilt20Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_20Hz = data_bpfilt_20HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_20Hz = HSP_mergeDataset(cfgMerge, data_bpfilt_20HzNew, ...
                                    data_plv_20Hz);
  clear cfgMerge;
end

fprintf('Saving bandpass filtered data (20Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_bpfilt_20Hz', data_plv_20Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_bpfilt_20Hz

%% calculate hilbert phase at 20Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_hilbert_20HzNew = HSP_hilbertPhase(cfg, data_bpfilt_20HzNew);
clear data_bpfilt_20HzNew 

%% export the hilbert phase data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_06a_hilbert20Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_20Hz = data_hilbert_20HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_20Hz = HSP_mergeDataset(cfgMerge, data_hilbert_20HzNew, ...
                                    data_plv_20Hz);
  clear cfgMerge;
end

fprintf('Saving Hilbert phase data (20Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_hilbert_20Hz', data_plv_20Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_hilbert_20Hz

%% calculate PLV at 20Hz
cfg           = [];
cfg.winlen    = 1;                                                          % window length for one PLV value in seconds
cfg.numOfPart = numOfPart;

data_plv_20HzNew = HSP_phaseLockVal(cfg, data_hilbert_20HzNew);
clear data_hilbert_20Hz

%% export the PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_07a_plv20Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_20Hz = data_plv_20HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_20Hz = HSP_mergeDataset(cfgMerge, data_plv_20HzNew, ...
                                    data_plv_20Hz);
  clear cfgMerge;
end

fprintf('Saving PLVs (20Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_plv_20Hz', data_plv_20Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_plv_20Hz data_plv_20HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 40 Hz branch
%% bandpass filter data at 40Hz
cfg           = [];
cfg.bpfreq    = [39 41];
cfg.filtorder = 250;
cfg.numOfPart = numOfPart;

data_bpfilt_40HzNew = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_05a_bpfilt40Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_40Hz = data_bpfilt_40HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_40Hz = HSP_mergeDataset(cfgMerge, data_bpfilt_40HzNew, ...
                                    data_plv_40Hz);
  clear cfgMerge;
end

fprintf('Saving bandpass filtered data (40Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_bpfilt_40Hz', data_plv_40Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_bpfilt_40Hz

%% calculate hilbert phase at 40Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_hilbert_40HzNew = HSP_hilbertPhase(cfg, data_bpfilt_40HzNew);
clear data_bpfilt_40HzNew 

%% export the hilbert phase data into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_06a_hilbert40Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_40Hz = data_hilbert_40HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_40Hz = HSP_mergeDataset(cfgMerge, data_hilbert_40HzNew, ...
                                    data_plv_40Hz);
  clear cfgMerge;
end

fprintf('Saving Hilbert phase data (40Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_hilbert_40Hz', data_plv_40Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_hilbert_40Hz

%% calculate PLV at 40Hz
cfg           = [];
cfg.winlen    = 1;                                                          % window length for one PLV value in seconds
cfg.numOfPart = numOfPart;

data_plv_40HzNew = HSP_phaseLockVal(cfg, data_hilbert_40HzNew);
clear data_hilbert_40Hz

%% export the PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desFolder;
cfg.filename    = 'HSP_07a_plv40Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desFolder, filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_40Hz = data_plv_40HzNew;
else
  HSP_load( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_40Hz = HSP_mergeDataset(cfgMerge, data_plv_40HzNew, ...
                                    data_plv_40Hz);
  clear cfgMerge;
end

fprintf('Saving PLVs (40Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_plv_40Hz', data_plv_40Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_plv_40Hz data_plv_40HzNew

%% clear workspace
clear cfg data_seg1 dest_folder file_name file_path file_version ...
      file_num