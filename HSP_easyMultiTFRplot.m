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
%   cfg.person      = number of participant (1 or 2) (default: 1)
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
person  = ft_getopt(cfg, 'person', 1);
trl     = ft_getopt(cfg, 'trial', 1);
freqlim = ft_getopt(cfg, 'freqlimits', [2 30]);
timelim = ft_getopt(cfg, 'timelimits', [4 176]);

if person < 1 || person > 2
  error('cfg.participant has to be 1 or 2');
end

warning('off','all');

% -------------------------------------------------------------------------
% Plot time frequency spectrum
% -------------------------------------------------------------------------

colormap 'jet';

cfg             = [];
cfg.parameter   = 'powspctrm';
cfg.maskstyle   = 'saturation';
cfg.xlim        = timelim;
cfg.ylim        = freqlim;
cfg.zlim        = 'maxmin';
cfg.trials      = trl;

if person == 1
  cfg.channel   = 1:1:30;
  cfg.layout    = 'mpi_customized_acticap32_part1.mat';
elseif person ==2
  cfg.channel   = 33:1:62;
  cfg.layout    = 'mpi_customized_acticap32_part2.mat';
end
cfg.trials      = 1;

cfg.showlabels  = 'no';
cfg.showoutline = 'yes';
cfg.colorbar    = 'yes';

switch cond
  case 'Earphone40Hz'
    ft_multiplotTFR(cfg, data(dyad).Earphone40Hz);
    title(sprintf('Earphone40Hz - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'Speaker40Hz'
    ft_multiplotTFR(cfg, data(dyad).Speaker40Hz);
    title(sprintf('Speaker40Hz - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'Earphone2Hz'
    ft_multiplotTFR(cfg, data(dyad).Earphone2Hz);
    title(sprintf('Earphone2Hz - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'Speaker2Hz'
    ft_multiplotTFR(cfg, data(dyad).Speaker2Hz);
    title(sprintf('Speaker2Hz - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'Silence'
    ft_multiplotTFR(cfg, data(dyad).Silence);
    title(sprintf('Silence - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'SilEyesClosed'
    ft_multiplotTFR(cfg, data(dyad).SilEyesClosed);
    title(sprintf('SilEyesClosed - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'MixNoiseEarphones'
    ft_multiplotTFR(cfg, data(dyad).MixNoiseEarphones);
    title(sprintf('MixNoiseEarphones - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'MixNoiseSpeaker'
    ft_multiplotTFR(cfg, data(dyad).MixNoiseSpeaker);
    title(sprintf('MixNoiseSpeaker - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'Tapping'
    ft_multiplotTFR(cfg, data(dyad).Tapping);
    title(sprintf('Tapping - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'DialoguePlus2Hz'
    ft_multiplotTFR(cfg, data(dyad).DialoguePlus2Hz);
    title(sprintf('DialoguePlus2Hz - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'AreadsB'
    ft_multiplotTFR(cfg, data(dyad).AreadsB);
    title(sprintf('AreadsB - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'BreadsA'
    ft_multiplotTFR(cfg, data(dyad).BreadsA);
    title(sprintf('BreadsA - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
  case 'Dialogue'
    ft_multiplotTFR(cfg, data(dyad).Dialogue);
    title(sprintf('Dialogue - Dyad: %d - Participant: % d - Trial: %d', ...
          dyad, person, trl));
end

warning('on','all');

end