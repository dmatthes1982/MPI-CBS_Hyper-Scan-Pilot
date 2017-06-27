function HSP_databrowser( cfg, data )
% HSP_DATABROWSER displays a certain hyperscanning pilot project dataset 
% using a appropriate scaling.
%
% Use as
%   HSP_databrowser( data )
%
% where the input can be the result of HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION
%
% The configuration options are
%   cfg.condition = condition (default: 'Earphone40Hz', see HSP data structure)
%   cfg.dyad      = number of dyad (default: 1)
%   cfg.part      = number of participant (default: 1)
%
% This function requires the fieldtrip toolbox
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, HSP_SEGMENTATION, FT_DATABROWSER

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
cond = ft_getopt(cfg, 'condition', 'Earphone40Hz');
dyad = ft_getopt(cfg, 'dyad', 1);
part = ft_getopt(cfg, 'part', 1);

% -------------------------------------------------------------------------
% Configure and start databrowser
% -------------------------------------------------------------------------
cfg = [];
cfg.ylim      = [-80 80];
cfg.viewmode = 'vertical';
cfg.continuous = 'no';
cfg.channel = 'all';

switch cond
  case 'Earphone40Hz'
    ft_databrowser(cfg, data(dyad).Earphone40Hz{part});
    windowTitle = sprintf('Earphone40Hz - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Speaker40Hz'
    ft_databrowser(cfg, data(dyad).Speaker40Hz{part});
    windowTitle = sprintf('Speaker40Hz - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Earphone2Hz'
    ft_databrowser(cfg, data(dyad).Earphone2Hz{part});
    windowTitle = sprintf('Earphone2Hz - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Speaker2Hz'
    ft_databrowser(cfg, data(dyad).Speaker2Hz{part});
    windowTitle = sprintf('Speaker2Hz - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Silence'
    ft_databrowser(cfg, data(dyad).Silence{part});
    windowTitle = sprintf('Silence - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'SilEyesClosed'
    ft_databrowser(cfg, data(dyad).SilEyesClosed{part});
    windowTitle = sprintf('SilEyesClosed - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'MixNoiseEarphones'
    ft_databrowser(cfg, data(dyad).MixNoiseEarphones{part});
    windowTitle = sprintf('MixNoiseEarphones - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'MixNoiseSpeaker'
    ft_databrowser(cfg, data(dyad).MixNoiseSpeaker{part});
    windowTitle = sprintf('MixNoiseSpeaker - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Tapping'
    ft_databrowser(cfg, data(dyad).Tapping{part});
    windowTitle = sprintf('Tapping - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'DialoguePlus2Hz'
    ft_databrowser(cfg, data(dyad).DialoguePlus2Hz{part});
    windowTitle = sprintf('DialoguePlus2Hz - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'AreadsB'
    ft_databrowser(cfg, data(dyad).AreadsB{part});
    windowTitle = sprintf('AreadsB - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'BreadsA'
    ft_databrowser(cfg, data(dyad).BreadsA{part});
    windowTitle = sprintf('BreadsA - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Dialogue'
    ft_databrowser(cfg, data(dyad).Dialogue{part});
    windowTitle = sprintf('Dialogue - Dyad: %d - Participant %d', ...
                          dyad, part);
end

h = gcf;
h.Name = (windowTitle);

end