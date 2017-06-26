%% general settings
preproc = 1;                                                                % 0 / 1 = use not / use preprocessing
if preproc == 1
  tfrOfpreproc = 1;                                                         % 0 / 1 = calculate TFRs of preprocessed signals
end
  
%% import data from brain vision eeg files and bring it into an order
cfg       = [];
cfg.path  = '/data/pt_01821/DualEEG_AD_auditory_rawData/';

fprintf('Import data from: %s ...\n', cfg.path);
ft_info off;
data_raw = HSP_importAllDatasets( cfg );
ft_info on;

%% export the imported and sorted data into an *.mat file
dest_folder = '/data/pt_01821/DualEEG_AD_auditory_processedData/';
file_name = strcat(dest_folder, 'HSP_01_raw');
file_path = strcat(file_name, '_001.mat');
file_version = '_001.mat';
if exist(file_path, 'file') == 2
  file_pattern = strcat(file_name, '_*.mat');
  file_num = length(dir(file_pattern))+1;
  file_version = sprintf('_%03d.mat', file_num);
  file_path = strcat(file_name, file_version);
end
fprintf('The RAW data will be saved in %s ...\n', file_path);
save(file_path, 'data_raw', '-v7.3');

%% preprocess the raw data
if preproc == 1
  cfg         = [];
  cfg.bpfreq  = [0.3 48];                                                   % passband from 0.3 to 48 Hz
  
  data_preproc = HSP_preprocessing( cfg, data_raw);
else
  data_preproc = data_raw;
end

clear data_raw

%% export the preprocessed data into a *.mat file
if preproc == 1
  file_name = strcat(dest_folder, 'HSP_02_preproc');
  file_path = strcat(file_name, file_version);
  fprintf('The preprocessed data will be saved in %s ...\n', file_path);
  save(file_path, 'data_preproc', '-v7.3');
end

%% calculate TFRs of the preprocessed data
if tfrOfpreproc == 1
  cfg         = [];
  cfg.foi     = 2:1:50;                                                     % frequency of interest
  cfg.toi     = 4:0.5:176;                                                  % time of interest
  
  data_tfr1 = HSP_timeFreqanalysis( cfg, data_preproc );
end

%% export the preprocessed data into a *.mat file
if tfrOfpreproc == 1
  file_name = strcat(dest_folder, 'HSP_03_tfr1');
  file_path = strcat(file_name, file_version);
  fprintf('The time-frequency response data will be saved in %s ...\n', file_path);
  save(file_path, 'data_tfr1', '-v7.3');
end

%% segmentation of the preprocessed trials
% split every the data of every condition into subtrials with a length of 5
% seconds
data_seg1 = HSP_segmentation( data_preproc );

clear data_preproc

%% export the segmented data into a *.mat file
file_name = strcat(dest_folder, 'HSP_04_seg1');
file_path = strcat(file_name, file_version);
fprintf('The segmented data will be saved in %s ...\n', file_path);
save(file_path, 'data_seg1', '-v7.3');

clear preproc path_generic numOfPart_generic path_raw numOfPart ...
      dest_folder file_name file_path file_version file_pattern file_num ...
      tfrOfpreproc cfg