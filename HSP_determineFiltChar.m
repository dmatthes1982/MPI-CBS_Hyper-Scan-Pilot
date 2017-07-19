function HSP_determineFiltChar(cfg, data)
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
f(2,:) = ft_preproc_bandpassfilter(s, fSample, [1 3], order(1), ...         % apply first bandpass
  type, 'twopass', 'no');
f(3,:) = ft_preproc_bandpassfilter(s, fSample, [1 3], 5, ...              
  'but', 'twopass', 'split');
f(4,:) = ft_preproc_bandpassfilter(s, fSample, [9 11], order(2), ...        % apply second bandpass
  type, 'twopass', 'no');
f(5,:) = ft_preproc_bandpassfilter(s, fSample, [9 11], 1, ...             
  'but', 'twopass', 'split');
f(6,:) = ft_preproc_bandpassfilter(s, fSample, [39 41], order(3), ...       % apply third bandpass
  type, 'twopass', 'no');
f(7,:) = ft_preproc_bandpassfilter(s, fSample, [39 41], 2, ...             
  'but', 'twopass', 'split');

F       = fft(f, [], 2).^2;                                                 % fast fourier transformation
F2side  = abs(F/L);                                                         % amplitude response
F1side  = F2side(:, 1:floor(L/2)+1);                                        % single-side amplitude spectrum

figure(1);
str = 'compare different cutoff frequencies';

subplot(1,2,1);                                                             % plot the different time courses
plot(t, f-repmat([0, 40, 40, 60, 60, 70, 70]',1,L)); 
grid on; 
set(gca, 'ylim', [-80 50]); 
xlabel('time (s)'); 
ylabel(str);
title('Raw, 10 Hz, 20 Hz, 30 Hz');

subplot(1,2,2);                                                             % plot the different amplitude spectra                                 
semilogy(freq, F1side'); 
grid on; 
set(gca, 'ylim', [10^-5 10^ 5]); 
set(gca, 'xlim', [0 50]); 
xlabel('freq (Hz)');   
ylabel(str);
title('FIR-Filter');

end