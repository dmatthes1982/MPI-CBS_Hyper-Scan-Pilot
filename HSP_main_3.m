%% import preprocessed and segmented data
dest_folder = '/data/pt_01821/DualEEG_AD_auditory_processedData/';
file_name = strcat(dest_folder, 'HSP_04_seg1');
file_path = strcat(file_name, '_*.mat');
file_num = length(dir(file_path));
if file_num ~= 0
  file_version = sprintf('_%03d.mat', file_num);
  file_path = strcat(file_name, file_version);
  load(file_path);
else
  error('A dataset with segmented data seems not available.');
end

%% bandpass filter data at 2Hz
cfg           = [];
cfg.bpfreq    = [1.9 2.1];
cfg.fixorder  = true;

data_bpfilt_2Hz = HSP_bpFiltering(cfg, data_seg1);

%% export the segmented data into a *.mat file
file_name = strcat(dest_folder, 'HSP_05a_bpfilt2Hz');
file_path = strcat(file_name, file_version);
fprintf('The bandpass filtered data (2Hz) will be saved in %s ...\n', file_path);
save(file_path, 'data_bpfilt_2Hz', '-v7.3');

clear data_bpfilt_2Hz

%% bandpass filter data at 10Hz
cfg           = [];
cfg.bpfreq    = [9 11];
cfg.fixorder  = true;

data_bpfilt_10Hz = HSP_bpFiltering(cfg, data_seg1);

%% export the segmented data into a *.mat file
file_name = strcat(dest_folder, 'HSP_05b_bpfilt10Hz');
file_path = strcat(file_name, file_version);
fprintf('The bandpass filtered data (10Hz) will be saved in %s ...\n', file_path);
save(file_path, 'data_bpfilt_10Hz', '-v7.3');

clear data_bpfilt_10Hz

%% bandpass filter data at 40Hz
cfg           = [];
cfg.bpfreq    = [39 41];
cfg.fixorder  = true;

data_bpfilt_40Hz = HSP_bpFiltering(cfg, data_seg1);

%% export the segmented data into a *.mat file
file_name = strcat(dest_folder, 'HSP_05c_bpfilt40Hz');
file_path = strcat(file_name, file_version);
fprintf('The bandpass filtered data (40Hz) will be saved in %s ...\n', file_path);
save(file_path, 'data_bpfilt_40Hz', '-v7.3');

clear data_bpfilt_40Hz

clear cfg data_seg1 dest_folder file_name file_path file_version ...
      file_num