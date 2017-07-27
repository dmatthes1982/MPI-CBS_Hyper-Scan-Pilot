%% check if basic variables are defined and import segmented data
if ~exist('sessionStr', 'var')
  cfg           = [];
  cfg.filename  = 'HSP_08a_hilbert2Hz';
  sessionStr    = sprintf('%03d', HSP_getSessionNum( cfg ));                % estimate current session number
end

if ~exist('desPath', 'var')
  desPath       = '/data/pt_01821/DualEEG_AD_auditory_processedData/';      % destination path for processed data  
end

% load Hilbert phase data for 2 Hz passband
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_08a_hilbert2Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');

fprintf('Loading %s ...\n', file_path);
HSP_loadData( cfg );                                                        % load Hilbert phase data

if ~exist('numOfPart', 'var')                                               % number of participants
  numOfPart = squeeze(cell2mat(struct2cell(dyads)))';
end

dyadsNew(max(numOfPart)).number = [];                                       % initialize dyadsNew structure

for i = numOfPart                                                           
  dyadsNew(i).number = i;
end

for i = 1:1:length(data_hilbert_2Hz)                                        % remove dyads which are not selected from input
  if ~ismember(i, numOfPart)
    data_hilbert_2Hz(i).part1 = []; %#ok<SAGROW>
    data_hilbert_2Hz(i).part2 = []; %#ok<SAGROW>
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% general adjustment
selection = false;
while selection == false
  cprintf([0,0.6,0], '\n<strong>Should rejection of detected artifacts be applied before PLV estimation?</strong>\n');
  x = input('Select [y/n]: ','s');
  if strcmp('y', x)
    selection = true;
    artifactRejection = true;
  elseif strcmp('n', x)
    selection = true;
    artifactRejection = false;
  else
    selection = false;
  end
end
if artifactRejection == true
  cfg             = [];
  cfg.desFolder   = desPath;
  cfg.filename    = 'HSP_06_allArt';
  cfg.sessionStr  = sessionStr;

  file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
  if ~isempty(dir(file_path))
    fprintf('\nLoading %s ...\n', file_path);
    HSP_loadData( cfg );                                                      % load artifact definitions
  else
    fprintf('File %s is not existent, artifact rejection is not possible!\n', file_path);
    artifactRejection = false;
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 Hz branch
%% artifact rejection at 2 Hz
if artifactRejection == true
  cfg           = [];
  cfg.artifact  = cfg_allArt;
  cfg.numOfPart = numOfPart;
  
  fprintf('Artifact Rejection of Hilbert phase data at 2 Hz.\n');
  data_hilbert_2Hz = HSP_rejectArtifacts(cfg, data_hilbert_2Hz);
end

%% calculate PLV at 2Hz
cfg           = [];
cfg.winlen    = 5;                                                          % window length for one PLV value in seconds
cfg.numOfPart = numOfPart;

data_plv_2HzNew = HSP_phaseLockVal(cfg, data_hilbert_2Hz);
clear data_hilbert_2Hz

%% export the PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_09a_plv2Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_2Hz = data_plv_2HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_2Hz = HSP_mergeDataset(cfgMerge, data_plv_2HzNew, ...
                                    data_plv_2Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving PLVs (2Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_plv_2Hz', data_plv_2Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_plv_2Hz

%% calculate mean PLV at 2Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_mplv_2HzNew = HSP_calcMeanPLV(cfg, data_plv_2HzNew);
clear data_plv_2HzNew

%% export the mean PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_10a_mplv2Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_mplv_2Hz = data_mplv_2HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_mplv_2Hz = HSP_mergeDataset(cfgMerge, data_mplv_2HzNew, ...
                                    data_mplv_2Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving mean PLVs (2Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_mplv_2Hz', data_mplv_2Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_mplv_2Hz data_mplv_2HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 10 Hz branch
%% load Hilbert phase data for 10 Hz passband
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_08b_hilbert10Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');

fprintf('Loading %s ...\n', file_path);
HSP_loadData( cfg );                                                        % load Hilbert phase data

for i = 1:1:length(data_hilbert_10Hz)                                       % remove dyads which are not selected from input
  if ~ismember(i, numOfPart)
    data_hilbert_10Hz(i).part1 = []; %#ok<SAGROW>
    data_hilbert_10Hz(i).part2 = []; %#ok<SAGROW>
  end
end

%% artifact rejection at 10 Hz
if artifactRejection == true
  cfg           = [];
  cfg.artifact  = cfg_allArt;
  cfg.numOfPart = numOfPart;
  
  fprintf('Artifact Rejection of Hilbert phase data at 10 Hz.\n');
  data_hilbert_10Hz = HSP_rejectArtifacts(cfg, data_hilbert_10Hz);
end

%% calculate PLV at 10Hz
cfg           = [];
cfg.winlen    = 1;                                                          % window length for one PLV value in seconds
cfg.numOfPart = numOfPart;

data_plv_10HzNew = HSP_phaseLockVal(cfg, data_hilbert_10Hz);
clear data_hilbert_10Hz

%% export the PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_09b_plv10Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_10Hz = data_plv_10HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_10Hz = HSP_mergeDataset(cfgMerge, data_plv_10HzNew, ...
                                    data_plv_10Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving PLVs (10Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_plv_10Hz', data_plv_10Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_plv_10Hz

%% calculate mean PLV at 10Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_mplv_10HzNew = HSP_calcMeanPLV(cfg, data_plv_10HzNew);
clear data_plv_10HzNew

%% export the mean PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_10b_mplv10Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_mplv_10Hz = data_mplv_10HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_mplv_10Hz = HSP_mergeDataset(cfgMerge, data_mplv_10HzNew, ...
                                    data_mplv_10Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving mean PLVs (10Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_mplv_10Hz', data_mplv_10Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_mplv_10Hz data_mplv_10HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 20 Hz branch
%% load Hilbert phase data for 20 Hz passband
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_08c_hilbert20Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');

fprintf('Loading %s ...\n', file_path);
HSP_loadData( cfg );                                                        % load Hilbert phase data

for i = 1:1:length(data_hilbert_20Hz)                                       % remove dyads which are not selected from input
  if ~ismember(i, numOfPart)
    data_hilbert_20Hz(i).part1 = []; %#ok<SAGROW>
    data_hilbert_20Hz(i).part2 = []; %#ok<SAGROW>
  end
end

%% artifact rejection at 20 Hz
if artifactRejection == true
  cfg           = [];
  cfg.artifact  = cfg_allArt;
  cfg.numOfPart = numOfPart;
  
  fprintf('Artifact Rejection of Hilbert phase data at 20 Hz.\n');
  data_hilbert_20Hz = HSP_rejectArtifacts(cfg, data_hilbert_20Hz);
end

%% calculate PLV at 20Hz
cfg           = [];
cfg.winlen    = 1;                                                          % window length for one PLV value in seconds
cfg.numOfPart = numOfPart;

data_plv_20HzNew = HSP_phaseLockVal(cfg, data_hilbert_20Hz);
clear data_hilbert_20Hz

%% export the PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_09c_plv20Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_20Hz = data_plv_20HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_20Hz = HSP_mergeDataset(cfgMerge, data_plv_20HzNew, ...
                                    data_plv_20Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving PLVs (20Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_plv_20Hz', data_plv_20Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_plv_20Hz

%% calculate mean PLV at 20Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_mplv_20HzNew = HSP_calcMeanPLV(cfg, data_plv_20HzNew);
clear data_plv_20HzNew

%% export the mean PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_10c_mplv20Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_mplv_20Hz = data_mplv_20HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_mplv_20Hz = HSP_mergeDataset(cfgMerge, data_mplv_20HzNew, ...
                                    data_mplv_20Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving mean PLVs (20Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_mplv_20Hz', data_mplv_20Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_mplv_20Hz data_mplv_20HzNew

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 40 Hz branch
%% load Hilbert phase data for 40 Hz passband
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_08d_hilbert40Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');

fprintf('Loading %s ...\n', file_path);
HSP_loadData( cfg );                                                        % load Hilbert phase data

for i = 1:1:length(data_hilbert_40Hz)                                       % remove dyads which are not selected from input
  if ~ismember(i, numOfPart)
    data_hilbert_40Hz(i).part1 = []; %#ok<SAGROW>
    data_hilbert_40Hz(i).part2 = []; %#ok<SAGROW>
  end
end

%% artifact rejection at 40 Hz
if artifactRejection == true
  cfg           = [];
  cfg.artifact  = cfg_allArt;
  cfg.numOfPart = numOfPart;
  
  fprintf('Artifact Rejection of Hilbert phase data at 40 Hz.\n');
  data_hilbert_40Hz = HSP_rejectArtifacts(cfg, data_hilbert_40Hz);
end

%% calculate PLV at 40Hz
cfg           = [];
cfg.winlen    = 1;                                                          % window length for one PLV value in seconds
cfg.numOfPart = numOfPart;

data_plv_40HzNew = HSP_phaseLockVal(cfg, data_hilbert_40Hz);
clear data_hilbert_40Hz

%% export the PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_09d_plv40Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_plv_40Hz = data_plv_40HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_plv_40Hz = HSP_mergeDataset(cfgMerge, data_plv_40HzNew, ...
                                    data_plv_40Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving PLVs (40Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_plv_40Hz', data_plv_40Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_plv_40Hz

%% calculate mean PLV at 40Hz
cfg           = [];
cfg.numOfPart = numOfPart;

data_mplv_40HzNew = HSP_calcMeanPLV(cfg, data_plv_40HzNew);
clear data_plv_40HzNew

%% export the mean PLVs into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_10d_mplv40Hz';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_mplv_40Hz = data_mplv_40HzNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_mplv_40Hz = HSP_mergeDataset(cfgMerge, data_mplv_40HzNew, ...
                                    data_mplv_40Hz);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('Saving mean PLVs (40Hz) in %s ...\n', file_path);
HSP_saveData(cfg, 'data_mplv_40Hz', data_mplv_40Hz, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_mplv_40Hz data_mplv_40HzNew

%% clear workspace
clear cfg file_path file_num dyads dyadsNew i cfg_allArt
