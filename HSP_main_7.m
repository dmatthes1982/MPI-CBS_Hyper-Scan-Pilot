%% check if basic variables are defined and import segmented data
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
HSP_loadData( cfg );                                                        % load preprocessed data

if ~exist('numOfPart', 'var')                                               % number of participants
  numOfPart = squeeze(cell2mat(struct2cell(dyads)))';
end

dyadsNew(max(numOfPart)).number = [];                                       % initialize dyadsNew structure

for i = numOfPart                                                           
  dyadsNew(i).number = i;
end

for i = 1:1:length(data_preproc)                                            % remove dyads which are not selected from input
  if ~ismember(i, numOfPart)
    data_preproc(i).part1 = []; %#ok<SAGROW>
    data_preproc(i).part2 = []; %#ok<SAGROW>
  end
end

%% segmentation of the preprocessed trials for ITPC calculation
% split the data of every condition into subtrials with a length of 10
% seconds
cfg           = [];
cfg.numOfPart = numOfPart;
cfg.length    = 10;

data_isegNew  = HSP_segmentation( cfg, data_preproc );
clear data_preproc

%% export the segmented data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_12_iseg';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_iseg = data_isegNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_iseg = HSP_mergeDataset(cfgMerge, data_isegNew, data_iseg);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('The segmented data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_iseg', data_iseg, 'dyads', dyads);
fprintf('Data stored!\n\n');
clear data_iseg

%% artifact rejection
choise = false;
while choise == false
  cprintf([0,0.6,0], 'Should rejection of detected artifacts be applied before ITPC estimation?\n');
  x = input('Select [y/n]: ','s');
  if strcmp('y', x)
    choise = true;
    artifactRejection = true;
  elseif strcmp('n', x)
    choise = true;
    artifactRejection = false;
  else
    choise = false;
  end
end

if artifactRejection == true                                                % load artifact definitions
  cfg             = [];
  cfg.desFolder   = desPath;
  cfg.filename    = 'HSP_06_allArt';
  cfg.sessionStr  = sessionStr;

  file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
  if ~isempty(dir(file_path))
    fprintf('\nLoading %s ...\n\n', file_path);
    HSP_loadData( cfg );                                                    
  else
    fprintf('File %s is not existent, artifact rejection is not possible!\n', file_path);
    artifactRejection = false;
  end
end
if artifactRejection == true                                                % reject artifacts
  cfg           = [];
  cfg.artifact  = cfg_allArt;
  cfg.type      = 'single';
  cfg.numOfPart = numOfPart;
  
  fprintf('Rejection of trials with artifacts.\n');
  data_isegNew = HSP_rejectArtifacts(cfg, data_isegNew);
  fprintf('\n');
end

%% estimation of the inter-trial phase coherence (ITPC)
cfg           = [];
cfg.toi       = 0:0.2:9.8;
cfg.foi       = 1:0.5:48;
cfg.numOfPart = numOfPart;

data_itpcNew = HSP_interTrialPhaseCoh(cfg, data_isegNew);
clear data_isegNew

%% export the itpc data into a *.mat file
cfg             = [];
cfg.desFolder   = desPath;
cfg.filename    = 'HSP_13_itpc';
cfg.sessionStr  = sessionStr;

file_path = strcat(desPath, cfg.filename, '_', sessionStr, '.mat');
file_num = length(dir(file_path));

if file_num == 0
  data_itpc = data_itpcNew;
  dyads = dyadsNew;
else
  HSP_loadData( cfg );
  cfgMerge.numOfNewPart = numOfPart;
  data_itpc = HSP_mergeDataset(cfgMerge, data_itpcNew, data_itpc);
  dyads = HSP_mergeDataset(cfgMerge, dyadsNew, dyads);
  clear cfgMerge;
end

fprintf('The ITPC data will be saved in %s ...\n', file_path);
HSP_saveData(cfg, 'data_itpc', data_itpc, 'dyads', dyads);
fprintf('Data stored!\n');
clear data_itpc data_itpcNew

%% clear workspace
clear file_path file_num cfg dyads dyadsNew i cfg_allArt artifactRejection ...
      x choise
