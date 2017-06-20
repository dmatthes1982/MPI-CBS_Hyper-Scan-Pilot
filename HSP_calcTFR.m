function [ data ] = HSP_calcTFR( cfg, data )
% HSP_CALCTFR performs a time frequency analysis on a specific dataset of 
% the hyperscanning pilot project data. 
%
% Use as
%   [ data ] = HSP_calcTFR( cfg, data )
%
% where the input data can come from HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION
%
% The configuration options are
%   config.foi = frequency of interest - begin:resolution:end (default: 2:1:50)
%   config.toi = time of interest - begin:resolution:end (default: 4:0.5:176)
%
% This function requires the fieldtrip toolbox.
%
% See also FT_FREQANALYSIS

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
foi = ft_getopt(cfg, 'foi', 2:1:50);
toi = ft_getopt(cfg, 'toi', 4:0.5:176);

% -------------------------------------------------------------------------
% Calc time frequency spectrum
% -------------------------------------------------------------------------
warning('off','all');

cfg                 = [];
cfg.method          = 'wavelet';
cfg.output          = 'pow';
cfg.channel         = 'all';                                                % calculate spectrum for specified channel
cfg.trials          = 'all';                                                % calculate spectrum for every trial  
cfg.keeptrials      = 'yes';                                                % do not average over trials
cfg.pad             = 'maxperlen';                                          % do not use padding
cfg.taper           = 'hanning';                                            % hanning taper the segments
cfg.foi             = foi;                                                  % frequencies of interest
cfg.width           = 7;                                                    % wavlet specific parameter 1 (default value)
cfg.gwidth          = 3;                                                    % wavlet specific parameter 2 (default value) 
cfg.toi             = toi;                                                  % time of interest
cfg.feedback        = 'no';                                                 % suppress feedback output
cfg.showcallinfo    = 'no';                                                 % suppress function call output

data = ft_freqanalysis(cfg, data);                                          % calculate time frequency responses

warning('on','all');

end                                                                                                                     