function HSP_detFiltChar(cfg, data)
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
order = ft_getopt(cfg, 'filtorder', [500, 250, 250]); 

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
% Extract data from HSP_datastructure
% -------------------------------------------------------------------------

s       = data(1).part1.trial{trial}(elec,:);                               % extract the signal
t       = data(1).part1.time{trial};                                        % extract the time vector

L       = length(data(1).part1.time{trial});                                % get the signal length
fSample = data(1).part1.fsample;                                            % get sample frequency
freq    = fSample * (0:(L/2)) / L;                                          % calculate the frequency vector

clear f
f(1,:) = s;                                                                 % the raw signal
f(2,:) = ft_preproc_bandpassfilter(s, fSample, [0.3 48], 4, ...             % apply generall bandpass
  'but', 'twopass', 'split');
f(3,:) = ft_preproc_bandpassfilter(s, fSample, [1 48], 4, ...               % apply generall bandpass
  'but', 'twopass', 'split');
f(4,:) = ft_preproc_bandpassfilter(f(2,:), fSample, [1.9 2.1], order(1), ... % apply 2 Hz narrow band bandpass
  type, 'twopass', 'no');
f(5,:) = ft_preproc_bandpassfilter(f(3,:), fSample, [1.9 2.1], order(1), ... % apply 2 Hz narrow band bandpass
  type, 'twopass', 'no');
f(6,:) = ft_preproc_bandpassfilter(f(2,:), fSample, [9 11], order(2), ...   % apply 10 Hz narrow band bandpass
  type, 'twopass', 'no');
f(7,:) = ft_preproc_bandpassfilter(f(3,:), fSample, [9 11], order(2), ...   % apply 10 Hz narrow band bandpass
  type, 'twopass', 'no');

F       = fft(f, [], 2).^2;                                                 % fast fourier transformation
F2side  = abs(F/L);                                                         % amplitude response
F1side  = F2side(:, 1:floor(L/2)+1);                                        % single-side amplitude spectrum

figure(1);
str = 'compare different filter cascades';

subplot(1,2,1);                                                             % plot the different time courses
a = ...
      plot(t, f(1:end,:)-repmat([-100, -100, -100, 0, 0, 15, 15]',1,L)); 
grid on; 
set(gca, 'ylim', [-20 10]);
set(gca, 'xlim', [0 5]);
xlabel('time (s)'); 
ylabel(str);
legend([a(4),a(5),a(6),a(7)], '2Hz - 0.3 Hz', '2Hz - 1 Hz', ...
                              '10Hz - 0.3 Hz','10Hz - 1 Hz');
title('Filtered, 2 Hz, 10 Hz');

subplot(1,2,2);                                                             % plot the different amplitude spectra                                 
semilogy(freq, F1side'); 
grid on; 
set(gca, 'ylim', [10^-2 10^ 5]); 
set(gca, 'xlim', [0 5]); 
xlabel('freq (Hz)');   
ylabel(str);
title('Filter responses');

% -------------------------------------------------------------------------
% Save graphic as pdf-File
% -------------------------------------------------------------------------
h=gcf;
set(h, 'PaperOrientation','landscape');
set(h, 'PaperType','a3');
set(h, 'PaperUnit', 'centimeters');
set(h, 'PaperSize', [42 29.7]);
set(h, 'unit', 'normalized', 'Position', [0 0 0.9 0.9]);
doc_title = '/data/pt_01821/DualEEG_AD_auditory_results/FiltChar';
file_path = strcat(doc_title, '_001.pdf');
if exist(file_path, 'file') == 2
  file_pattern = strcat(doc_title, '_*.pdf');
  file_num = length(dir(file_pattern))+1;
  file_path = sprintf('/data/pt_01821/DualEEG_AD_auditory_results/FiltChar_%03d.pdf', ... 
              file_num);
end
print(gcf, '-dpdf', file_path);

end