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

%% calculation of the inter-trial phase coherence (ITPC)
cfg           = [];
cfg.numOfPArt = numOfPart;
cfg.toi       = 0:0.02:10;
cfg.foi       = 1:0.5:48;

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
clear file_path file_num cfg dyads dyadsNew i
