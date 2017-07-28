function HSP_detFiltCharFor2Sig(cfg, data)
% HSP_DETERMINEFILTCHAR illustrates and compares the frequency response and 
% the output of three different bandpass filters. It could be used to 
% evaluate different filter types and orders
%
% Use as
%  HSP_determineFiltChar(cfg, data)
%
% where input data can be resultsof HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION
%
% The configuration options are
%   cfg.trial       = number of desired trial (default: 1)
%   cfg.electrode   = number of desired electrode (default: 'Cz')
%   cfg.filttype    = 'but', 'firws', 'fir', 'firls' or 'brickwall' (default: 'fir')
%   cfg.filtorder   = 1xN Vectorof filter order values (default: [166, 166, 166])
%
% This function requires the fieldtrip toolbox
%
% See also FT_PREPROC_BANDPASSFILTER, HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING, HSP_SEGMENTATION and HSP_DATASTRUCTURE

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
trial = ft_getopt(cfg, 'trial', 1); 
elec  = ft_getopt(cfg, 'electrode', 'Cz'); 
type  = ft_getopt(cfg, 'filttype', 'fir'); 
order = ft_getopt(cfg, 'filtorder', [500, 250, 125, 62]); 

label = data(1).part1.label;

if isnumeric(elec)
  if elec < 1 || elec > 32
    error('cfg.elec hast to be a number between 1 and 32 or a existing label like ''Cz''.');
  end
else
  elec = find(strcmp(label, elec));
  if isempty(elec)
    error('cfg.elec hast to be a existing label like ''Cz''or a number between 1 and 32.');
  end
end
% -------------------------------------------------------------------------
% Resample data
% -------------------------------------------------------------------------
cfg.resamplefs = 125;
data2 = ft_resampledata(cfg, data(1).part1); 

% -------------------------------------------------------------------------
% Extract data from HSP_datastructure (signal 1)
% -------------------------------------------------------------------------
s1       = data(1).part1.trial{trial}(elec,:);                              % extract the signal
t1       = data(1).part1.time{trial};                                       % extract the time vector

L1       = length(data(1).part1.time{trial});                               % get the signal length
fSample1 = data(1).part1.fsample;                                           % get sample frequency
freq1    = fSample1 * (0:(L1/2)) / L1;                                      % calculate the frequency vector

% -------------------------------------------------------------------------
% Extract signal 2
% -------------------------------------------------------------------------
s2       = data2.trial{trial}(elec,:);                                      % extract the signal
t2       = data2.time{trial};

L2       = length(data2.time{trial});                                       % get the signal length
fSample2 = cfg.resamplefs;                                                  % get sample frequency
freq2    = fSample2 * (0:(L2/2)) / L2;                                      % calculate the frequency vector

clear f
f(1,:) = s1;                                                                % the raw signal
f(2,:) = ft_preproc_bandpassfilter(s1, fSample1, [1.9 2.1], order(1), ...   % apply 2 Hz narrow band bandpass
  type, 'twopass', 'no');
f(3,:) = ft_preproc_bandpassfilter(s1, fSample1, [39 41], order(2), ...      % apply 10 Hz narrow band bandpass
  type, 'twopass', 'no');

clear g
g(1,:) = s2;                                                                % the raw signal
g(2,:) = ft_preproc_bandpassfilter(s2, fSample2, [1.9 2.1], order(3), ...   % apply 2 Hz narrow band bandpass
  type, 'twopass', 'no');
g(3,:) = ft_preproc_bandpassfilter(s2, fSample2, [39 41], order(4), ...      % apply 10 Hz narrow band bandpass
  type, 'twopass', 'no');


F       = fft(f, [], 2).^2;                                                 % fast fourier transformation
F2side  = abs(F/L1);                                                        % amplitude response
F1side  = F2side(:, 1:floor(L1/2)+1);                                       % single-side amplitude spectrum

G       = fft(g, [], 2).^2;                                                 % fast fourier transformation
G2side  = abs(G/L2);                                                        % amplitude response
G1side  = G2side(:, 1:floor(L2/2)+1);                                       % single-side amplitude spectrum


figure(1);
str = 'compare downsampling vs. original sampling';

subplot(1,2,1);                                                             % plot the different time courses
plot(t1, f(1:end, :) - repmat([0, 35, 45]', 1, L1));
hold on;
plot(t2, g(1:end, :) - repmat([0, 35, 45]', 1, L2));
grid on; 
set(gca, 'ylim', [-55 25]);
set(gca, 'xlim', [0 5]);
xlabel('time (s)'); 
ylabel(str);
title('Filtered, 2 Hz, 40 Hz');
hold off;

subplot(1,2,2);                                                             % plot the different amplitude spectra                                 
semilogy(freq1, F1side');
hold on;
semilogy(freq2, G1side');
grid on; 
set(gca, 'ylim', [10^-2 10^ 5]); 
set(gca, 'xlim', [0 50]); 
xlabel('freq (Hz)');   
ylabel(str);
title('Filter responses');
hold off;

% -------------------------------------------------------------------------
% Save graphic as pdf-File
% -------------------------------------------------------------------------
h=gcf;
set(h, 'PaperOrientation','landscape');
set(h, 'PaperType','a3');
set(h, 'PaperUnit', 'centimeters');
set(h, 'PaperSize', [42 29.7]);
set(h, 'unit', 'normalized', 'Position', [0 0 0.9 0.9]);
doc_title = '/data/pt_01821/DualEEG_AD_auditory_results/FiltCharResamp';
file_path = strcat(doc_title, '_001.pdf');
if exist(file_path, 'file') == 2
  file_pattern = strcat(doc_title, '_*.pdf');
  file_num = length(dir(file_pattern))+1;
  file_path = sprintf('/data/pt_01821/DualEEG_AD_auditory_results/FiltCharResamp_%03d.pdf', ... 
              file_num);
end
print(gcf, '-dpdf', file_path);

end