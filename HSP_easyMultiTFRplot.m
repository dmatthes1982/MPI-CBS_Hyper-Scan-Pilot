function HSP_easyMultiTFRplot(cfg, data)
% HSP_EASYTFRPLOT is a function, which makes it easier to create a multi
% time frequency response plot of all electrodes of a specific trial in a 
% particular condition on a head model.
%
% Use as
%   HSP_easyTFRPlot(cfg, data)
%
% where the input data is a results from HSP_CALCTFR.
%
% The configuration options are 
%   cfg.condition   = condition (default: 'SilEyesClosed', see HSP data structure)
%   cfg.dyad        = number of dyad (default: 2)
%   cfg.part        = number of participant (1 or 2) (default: 1)
%   cfg.trial       = number of trial (default: 1)
%   cfg.freqlimits  = [begin end] (default: [2 30])
%   cfg.timelimits  = [begin end] (default: [4 176])
%
% This function requires the fieldtrip toolbox
%
% See also FT_MULTIPLOTTFR, HSP_CALCTFR

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
cond    = ft_getopt(cfg, 'condition', 'SilEyesClosed');
dyad    = ft_getopt(cfg, 'dyad', 2);
part    = ft_getopt(cfg, 'part', 1);
trl     = ft_getopt(cfg, 'trial', 1);
freqlim = ft_getopt(cfg, 'freqlimits', [2 30]);
timelim = ft_getopt(cfg, 'timelimits', [4 176]);

if part < 1 || part > 2
  error('cfg.part has to be 1 or 2');
end

ft_warning off;

% -------------------------------------------------------------------------
% Plot time frequency spectrum
% -------------------------------------------------------------------------

colormap 'jet';

cfg               = [];
cfg.parameter     = 'powspctrm';
cfg.maskstyle     = 'saturation';
cfg.xlim          = timelim;
cfg.ylim          = freqlim;
cfg.zlim          = 'maxmin';
cfg.trials        = trl;
cfg.channel       = 1:1:30;
cfg.layout        = 'mpi_customized_acticap32.mat';
cfg.trials        = 1;

cfg.showlabels    = 'no';
cfg.showoutline   = 'yes';
cfg.colorbar      = 'yes';

cfg.showcallinfo  = 'no';                                                   % suppress function call output

switch cond
  case 'Earphone40Hz'
    ft_multiplotTFR(cfg, data(dyad).Earphone40Hz{part});
    title(sprintf('Earphone40Hz - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Speaker40Hz'
    ft_multiplotTFR(cfg, data(dyad).Speaker40Hz{part});
    title(sprintf('Speaker40Hz - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Earphone2Hz'
    ft_multiplotTFR(cfg, data(dyad).Earphone2Hz{part});
    title(sprintf('Earphone2Hz - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Speaker2Hz'
    ft_multiplotTFR(cfg, data(dyad).Speaker2Hz{part});
    title(sprintf('Speaker2Hz - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Silence'
    ft_multiplotTFR(cfg, data(dyad).Silence{part});
    title(sprintf('Silence - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'SilEyesClosed'
    ft_multiplotTFR(cfg, data(dyad).SilEyesClosed{part});
    title(sprintf('SilEyesClosed - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'MixNoiseEarphones'
    ft_multiplotTFR(cfg, data(dyad).MixNoiseEarphones{part});
    title(sprintf('MixNoiseEarphones - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'MixNoiseSpeaker'
    ft_multiplotTFR(cfg, data(dyad).MixNoiseSpeaker{part});
    title(sprintf('MixNoiseSpeaker - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Tapping'
    ft_multiplotTFR(cfg, data(dyad).Tapping{part});
    title(sprintf('Tapping - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'DialoguePlus2Hz'
    ft_multiplotTFR(cfg, data(dyad).DialoguePlus2Hz{part});
    title(sprintf('DialoguePlus2Hz - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'AreadsB'
    ft_multiplotTFR(cfg, data(dyad).AreadsB{part});
    title(sprintf('AreadsB - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'BreadsA'
    ft_multiplotTFR(cfg, data(dyad).BreadsA{part});
    title(sprintf('BreadsA - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Dialogue'
    ft_multiplotTFR(cfg, data(dyad).Dialogue{part});
    title(sprintf('Dialogue - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
end

ft_warning on;

end