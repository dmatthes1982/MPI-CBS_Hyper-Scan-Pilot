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
cfg.channel       = 1:1:28;
cfg.layout        = 'mpi_customized_acticap32.mat';
cfg.trials        = 1;

cfg.showlabels    = 'no';
cfg.showoutline   = 'yes';
cfg.colorbar      = 'yes';

cfg.showcallinfo  = 'no';                                                   % suppress function call output

switch cond
  case 'Earphone2HzS'
    ft_multiplotTFR(cfg, data(dyad).Earphone2HzS{part});
    title(sprintf('Earphone2HzS - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Speaker2HzS'
    ft_multiplotTFR(cfg, data(dyad).Speaker2HzS{part});
    title(sprintf('Speaker2HzS - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Tapping2HzS'
    ft_multiplotTFR(cfg, data(dyad).Tapping2HzS{part});
    title(sprintf('Tapping2HzS - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Dialogue2HzS'
    ft_multiplotTFR(cfg, data(dyad).Dialogue2HzS{part});
    title(sprintf('Dialogue2HzS - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Speaker20HzS'
    ft_multiplotTFR(cfg, data(dyad).Speaker20HzS{part});
    title(sprintf('Speaker20HzS - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Earphone20HzS'
    ft_multiplotTFR(cfg, data(dyad).Earphone20HzS{part});
    title(sprintf('Earphone20HzS - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Speaker20HzA'
    ft_multiplotTFR(cfg, data(dyad).Speaker20HzA{part});
    title(sprintf('Speaker20HzA - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Earphone20HzA'
    ft_multiplotTFR(cfg, data(dyad).Earphone20HzA{part});
    title(sprintf('Earphone20HzA - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Earphone2HzA'
    ft_multiplotTFR(cfg, data(dyad).Earphone2HzA{part});
    title(sprintf('Earphone2HzA - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Speaker2HzA'
    ft_multiplotTFR(cfg, data(dyad).Speaker2HzA{part});
    title(sprintf('Speaker2HzA - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Earphone40HzS'
    ft_multiplotTFR(cfg, data(dyad).Earphone40HzS{part});
    title(sprintf('Earphone40HzS - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Speaker40HzS'
    ft_multiplotTFR(cfg, data(dyad).Speaker40HzS{part});
    title(sprintf('Speaker40HzS - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Atalks2B'
    ft_multiplotTFR(cfg, data(dyad).Atalks2B{part});
    title(sprintf('Atalks2B - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));
  case 'Btalks2A'
    ft_multiplotTFR(cfg, data(dyad).Btalks2A{part});
    title(sprintf('Btalks2A - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));      
  case 'Dialogue'
    ft_multiplotTFR(cfg, data(dyad).Dialogue{part});
    title(sprintf('Dialogue - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));      
   case 'SilEyesOpen'
    ft_multiplotTFR(cfg, data(dyad).SilEyesOpen{part});
    title(sprintf('SilEyesOpen - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));     
   case 'SilEyesClosed'
    ft_multiplotTFR(cfg, data(dyad).SilEyesClosed{part});
    title(sprintf('SilEyesClosed - Dyad: %d - % d - Trial: %d', ...
          dyad, part, trl));        
end

ft_warning on;

end