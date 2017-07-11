%% import preprocessed and segmented data
dest_folder = '/data/pt_01821/DualEEG_AD_auditory_processedData/';
file_name = strcat(dest_folder, 'HSP_04_seg1');
file_path = strcat(file_name, '_*.mat');
file_num = length(dir(file_path));
if file_num ~= 0
  file_version = sprintf('_%03d.mat', file_num);
  file_path = strcat(file_name, file_version);
  fprintf('Loading %s ...\n', file_path);
  load(file_path);
else
  error('A dataset with segmented data seems not available.');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2 Hz branch
%% bandpass filter data at 2Hz
cfg           = [];
cfg.bpfreq    = [1.9 2.1];
cfg.filtorder = 500;

data_bpfilt_2Hz = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
file_name = strcat(dest_folder, 'HSP_05a_bpfilt2Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving bandpass filtered data (2Hz) in %s ...\n', file_path);
save(file_path, 'data_bpfilt_2Hz', '-v7.3');
fprintf('Data stored!\n');

%% calculate hilbert phase at 2Hz
data_hilbert_2Hz = HSP_hilbertPhase(data_bpfilt_2Hz);
clear data_bpfilt_2Hz

%% export the hilbert phase data into a *.mat file
file_name = strcat(dest_folder, 'HSP_06a_hilbert2Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving Hilbert phase data (2Hz) in %s ...\n', file_path);
save(file_path, 'data_hilbert_2Hz', '-v7.3');
fprintf('Data stored!\n');

%% calculate PLV at 2 Hz
cfg           = [];
cfg.winlen    = 5;                                                          % window length for one PLV value in seconds

data_plv_2Hz = HSP_phaseLockVal(cfg, data_hilbert_2Hz);
clear data_hilbert_2Hz

%% export the PLVs into a *.mat file
file_name = strcat(dest_folder, 'HSP_07a_plv2Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving PLVs (2Hz) in %s ...\n', file_path);
save(file_path, 'data_plv_2Hz', '-v7.3');
fprintf('Data stored!\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 10 Hz branch
%% bandpass filter data at 10Hz
cfg           = [];
cfg.bpfreq    = [9 11];
cfg.filtorder = 250;

data_bpfilt_10Hz = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
file_name = strcat(dest_folder, 'HSP_05b_bpfilt10Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving bandpass filtered data (10Hz) in %s ...\n', file_path);
save(file_path, 'data_bpfilt_10Hz', '-v7.3');
fprintf('Data stored!\n');

%% calculate hilbert phase at 10Hz
data_hilbert_10Hz = HSP_hilbertPhase(data_bpfilt_10Hz);
clear data_bpfilt_10Hz

%% export the hilbert phase data into a *.mat file
file_name = strcat(dest_folder, 'HSP_06b_hilbert10Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving Hilbert phase data (10Hz) will be saved in %s ...\n', file_path);
save(file_path, 'data_hilbert_10Hz', '-v7.3');
fprintf('Data stored!\n');

%% calculate PLV at 10 Hz
cfg           = [];
cfg.winlen    = 1;                                                          % window length for one PLV value in seconds

data_plv_10Hz = HSP_phaseLockVal(cfg, data_hilbert_10Hz);
clear data_hilbert_10Hz

%% export the PLVs into a *.mat file
file_name = strcat(dest_folder, 'HSP_07b_plv10Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving PLVs (10Hz) in %s ...\n', file_path);
save(file_path, 'data_plv_10Hz', '-v7.3');
fprintf('Data stored!\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 40 Hz branch
%% bandpass filter data at 40Hz
cfg           = [];
cfg.bpfreq    = [39 41];
cfg.filtorder = 250;

data_bpfilt_40Hz = HSP_bpFiltering(cfg, data_seg1);

%% export the filtered data into a *.mat file
file_name = strcat(dest_folder, 'HSP_05c_bpfilt40Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving bandpass filtered data (40Hz) in %s ...\n', file_path);
save(file_path, 'data_bpfilt_40Hz', '-v7.3');
fprintf('Data stored!\n');

%% calculate hilbert phase at 40Hz
data_hilbert_40Hz = HSP_hilbertPhase(data_bpfilt_40Hz);
clear data_bpfilt_40Hz

%% export the hilbert phase data into a *.mat file
file_name = strcat(dest_folder, 'HSP_06c_hilbert40Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving Hilbert phase data (40Hz) in %s ...\n', file_path);
save(file_path, 'data_hilbert_40Hz', '-v7.3');
fprintf('Data stored!\n');

%% calculate PLV at 40 Hz
cfg           = [];
cfg.winlen    = 1;                                                          % window length for one PLV value in seconds

data_plv_40Hz = HSP_phaseLockVal(cfg, data_hilbert_40Hz);
clear data_hilbert_40Hz

%% export the PLVs into a *.mat file
file_name = strcat(dest_folder, 'HSP_07c_plv40Hz');
file_path = strcat(file_name, file_version);
fprintf('Saving PLVs (40Hz) in %s ...\n', file_path);
save(file_path, 'data_plv_40Hz', '-v7.3');
fprintf('Data stored!\n');

clear cfg data_seg1 dest_folder file_name file_path file_version ...
      file_num