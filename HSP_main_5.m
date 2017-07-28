%% check if basic variables are defined and import segmented data
if ~exist('sessionStr', 'var')
  cfg           = [];
  cfg.filename  = 'HSP_04_seg1';
  sessionStr    = sprintf('%03d', HSP_getSessionNum( cfg ));                % estimate current session number
end

if ~exist('desPath', 'var')
  desPath       = '/data/pt_01821/DualEEG_AD_auditory_processedData/';      % destination path for processed data  
end

cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_04_seg1';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');

fprintf('Loading %s ...\n', file_path);
HSP_loadData( cfg );                                                        % load segmented data

if ~exist('numOfPart', 'var')                                               % number of participants
  numOfPart = squeeze(cell2mat(struct2cell(dyads)))';
end

dyadsNew(max(numOfPart)).number = [];                                       % initialize dyadsNew structure

for i = numOfPart                                                           
  dyadsNew(i).number = i;
end

for i = 1:1:length(data_seg1)                                               % remove dyads which are not selected from input
  if ~ismember(i, numOfPart)
    data_seg1(i).part1 = []; %#ok<SAGROW>
    data_seg1(i).part2 = []; %#ok<SAGROW>
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 Hz branch
%% bandpass filter data at 2Hz
cfg           = [];
cfg.bpfreq    = [1.9 2.1];
cfg.filtorder = 125;
cfg.numOfPart = numOfPart;

data_bpfilt_2HzNew = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_07a_bpfilt2Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_bpfilt_2Hz = data_bpfilt_2HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_bpfilt_2Hz = HSP_mergeDataset(cfgMerge, data_bpfilt_2HzNew, ...
                                    data_bpfilt_2Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving bandpass filtered data (2Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_bpfilt_2Hz', data_bpfilt_2Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_bpfilt_2Hz

%% calculate hilbert phase at 2Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_hilbert_2HzNew = HSP_hilbertPhase(cfg, data_bpfilt_2HzNew);
clear data_bpfilt_2HzNew 

%% export the hilbert phase data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_08a_hilbert2Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_hilbert_2Hz = data_hilbert_2HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_hilbert_2Hz = HSP_mergeDataset(cfgMerge, data_hilbert_2HzNew, ...
                                    data_hilbert_2Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving Hilbert phase data (2Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_hilbert_2Hz', data_hilbert_2Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_hilbert_2Hz data_hilbert_2HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 10 Hz branch
%% bandpass filter data at 10Hz
cfg           = [];
cfg.bpfreq    = [9 11];
cfg.filtorder = 62;
cfg.numOfPart = numOfPart;

data_bpfilt_10HzNew = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_07b_bpfilt10Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_bpfilt_10Hz = data_bpfilt_10HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_bpfilt_10Hz = HSP_mergeDataset(cfgMerge, data_bpfilt_10HzNew, ...
                                    data_bpfilt_10Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving bandpass filtered data (10Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_bpfilt_10Hz', data_bpfilt_10Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_bpfilt_10Hz

%% calculate hilbert phase at 10Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_hilbert_10HzNew = HSP_hilbertPhase(cfg, data_bpfilt_10HzNew);
clear data_bpfilt_10HzNew 

%% export the hilbert phase data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_08b_hilbert10Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_hilbert_10Hz = data_hilbert_10HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_hilbert_10Hz = HSP_mergeDataset(cfgMerge, data_hilbert_10HzNew, ...
                                    data_hilbert_10Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving Hilbert phase data (10Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_hilbert_10Hz', data_hilbert_10Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_hilbert_10Hz data_hilbert_10HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 20 Hz branch
%% bandpass filter data at 20Hz
cfg           = [];
cfg.bpfreq    = [19 21];
cfg.filtorder = 62;
cfg.numOfPart = numOfPart;

data_bpfilt_20HzNew = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_07c_bpfilt20Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_bpfilt_20Hz = data_bpfilt_20HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_bpfilt_20Hz = HSP_mergeDataset(cfgMerge, data_bpfilt_20HzNew, ...
                                    data_bpfilt_20Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving bandpass filtered data (20Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_bpfilt_20Hz', data_bpfilt_20Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_bpfilt_20Hz

%% calculate hilbert phase at 20Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_hilbert_20HzNew = HSP_hilbertPhase(cfg, data_bpfilt_20HzNew);
clear data_bpfilt_20HzNew 

%% export the hilbert phase data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_08c_hilbert20Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_hilbert_20Hz = data_hilbert_20HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_hilbert_20Hz = HSP_mergeDataset(cfgMerge, data_hilbert_20HzNew, ...
                                    data_hilbert_20Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving Hilbert phase data (20Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_hilbert_20Hz', data_hilbert_20Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_hilbert_20Hz data_hilbert_20HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 40 Hz branch
%% bandpass filter data at 40Hz
cfg           = [];
cfg.bpfreq    = [39 41];
cfg.filtorder = 62;
cfg.numOfPart = numOfPart;

data_bpfilt_40HzNew = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_07d_bpfilt40Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_bpfilt_40Hz = data_bpfilt_40HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_bpfilt_40Hz = HSP_mergeDataset(cfgMerge, data_bpfilt_40HzNew, ...
                                    data_bpfilt_40Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving bandpass filtered data (40Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_bpfilt_40Hz', data_bpfilt_40Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_bpfilt_40Hz

%% calculate hilbert phase at 40Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_hilbert_40HzNew = HSP_hilbertPhase(cfg, data_bpfilt_40HzNew);
clear data_bpfilt_40HzNew 

%% export the hilbert phase data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_08d_hilbert40Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_hilbert_40Hz = data_hilbert_40HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_hilbert_40Hz = HSP_mergeDataset(cfgMerge, data_hilbert_40HzNew, ...
                                    data_hilbert_40Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving Hilbert phase data (40Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_hilbert_40Hz', data_hilbert_40Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_hilbert_40Hz data_hilbert_40HzNew

%% clear workspace
clear cfg data_seg1 file_path file_num dyads dyadsNew i
