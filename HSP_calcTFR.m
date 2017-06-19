function [ data_out ] = HSP_calcTFR( data_in )
% HSP_CALCTFR performs a time frequency analysis with the 
% following settings:
%   freq range:       2...50 Hz
%   freq resolution:  1 Hz
%   time of interest: from 4 to 176 sec every 500 ms
%
% Params:
%   data_in         fieldtrip data structure
%
% Output:
%   data_out        fieldtrip data structure
%
% This function requires the fieldtrip toolbox
%
% See also FT_FREQANALYSIS

% Copyright (C) 2017, Daniel Matthes, MPI CBS

warning('off','all');

cfg                 = [];
cfg.method          = 'wavelet';
cfg.output          = 'pow';
cfg.channel         = 'all';                                                % calculate spectrum for specified channel
cfg.trials          = 'all';                                                % calculate spectrum for every trial  
cfg.keeptrials      = 'yes';                                                % do not average over trials
cfg.pad             = 'maxperlen';                                          % do not use padding
cfg.taper           = 'hanning';                                            % hanning taper the segments
cfg.foi             = 2:1:50;                                               % analysis from 1 to 50 Hz in steps of 1 Hz 
cfg.width           = 7;
cfg.gwidth          = 3;
cfg.toi             = 4:0.5:176;                                            % spectral estimates every 500 ms
cfg.feedback        = 'no';                                                 % suppress feedback output
cfg.showcallinfo    = 'no';                                                 % suppress function call output

data_out = ft_freqanalysis(cfg, data_in);                                   % calculate time frequency responses

warning('on','all');

end                                                                                                                     