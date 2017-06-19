%% general settings
preproc = 1;                                                                % 0 / 1 = use not / use preprocessing

%% import data from brain vision eeg files and bring it into an order
path_raw          = '../../data/HyperScanPilot/raw_data/';
numOfPart     = 1;

data_raw = HSP_importAllDatasets( path_raw, numOfPart );

%% export the imported and sorted data into an *.mat file
dest_folder = '../../processed/HyperScanPilot/';
file_name = strcat(dest_folder, 'HSP_01_raw');
file_path = strcat(file_name, '_001.mat');
file_version = '_001.mat';
if exist(file_path, 'file') == 2
  file_pattern = strcat(file_name, '_*.mat');
  file_num = length(dir(file_pattern))+1;
  file_version = sprintf('_%03d.mat', file_num);
  file_path = strcat(file_name, file_version);
end
save(file_path, 'data_raw');

%% preprocess the raw data
if preproc == 1
  data_preproc = HSP_preprocessing( data_raw, numOfPart );
else
  data_preproc = data_raw;
end

%% export the preprocessed data into a *.mat file
if preproc == 1
  file_name = strcat(dest_folder, 'HSP_02_preproc');
  file_path = strcat(file_name, file_version);
  save(file_path, 'data_preproc');
end

%% segmentation of the preprocessed trials
% split every the data of every condition into subtrials with a length of 5
% seconds
data_seg1 = HSP_segmentation( data_preproc, numOfPart);

%% export the segmented data into a *.mat file
file_name = strcat(dest_folder, 'HSP_03_seg1');
file_path = strcat(file_name, file_version);
save(file_path, 'data_seg1');


clear preproc path_generic numOfPart_generic path_raw numOfPart ...
      dest_folder file_name file_path file_version file_pattern file_num