%% import preprocessed data
dest_folder = '/data/pt_01821/DualEEG_AD_auditory_processedData/';
file_name = strcat(dest_folder, 'HSP_02_preproc');
file_path = strcat(file_name, '_*.mat');
file_num = length(dir(file_path));
if file_num ~= 0
  file_version = sprintf('_%03d.mat', file_num);
  file_path = strcat(file_name, file_version);
  fprintf('Loading %s ...\n', file_path);
  load(file_path);
else
  error('A dataset with preprocessed data seems not available.');
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
fprintf('Data stored!\n');

clear dest_folder file_name file_path file_version file_pattern file_num ...
      cfg