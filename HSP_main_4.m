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

%% auto artifact detection (threshold +-75 uV)
cfg           = [];
cfg.chan      = {'Cz', 'O1', 'O2'};
cfg.minVal    = -75;
cfg.maxVal    = 75;
cfg.numOfPart = numOfPart;

cfg_autoArtNew = HSP_autoArtifact(cfg, data_seg1);

%% export the automatic selected artifacts into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_05_autoArt';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  cfg_autoArt = cfg_autoArtNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  cfg_autoArt = HSP_mergeDataset(cfgMerge, cfg_autoArtNew, cfg_autoArt);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('The automatic selected artifacts will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'cfg_autoArt', cfg_autoArt, 'dyads', dyads);
fprintf('Data stored!\n');
clear cfg_autoArt

%% verify automatic detected artifacts / manual artifact detection
cfg           = [];
cfg.artifact  = cfg_autoArtNew;
cfg.numOfPart = numOfPart;

cfg_allArtNew = HSP_manArtifact(cfg, data_seg1);

clear data_seg1 cfg_autoArtNew

dyadsArti     = [];
numOfPartArti = [];

for i = 1:1:length(cfg_allArtNew)
  if ~isempty(cfg_allArtNew(i).part1)
    dyadsArti(i).number = i; %#ok<SAGROW>
    numOfPartArti       = [numOfPartArti, i]; %#ok<AGROW>
  end
end

%% export the verified and the additional artifacts into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_06_allArt';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  cfg_allArt = cfg_allArtNew;
  dyads = dyadsArti;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPartArti;
  cfg_allArt = HSP_mergeDataset(cfgMerge, cfg_allArtNew, cfg_allArt);
  dyads = HSP_mergeDataset(cfgMerge, dyadsArti, dyads);
  clear cfgMerge;
end

fprintf('The visual verified artifacts will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'cfg_allArt', cfg_allArt, 'dyads', dyads);
fprintf('Data stored!\n');
clear cfg_allArt cfg_allArtNew dyadsArti numOfPartArti


%% clear workspace
clear file_path file_num cfg dyads dyadsNew i



