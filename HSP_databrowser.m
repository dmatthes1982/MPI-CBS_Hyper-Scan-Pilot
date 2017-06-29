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
%   cfg.condition = condition (default: 'Earphone2HzS', see HSP data structure)
%   cfg.dyad      = number of dyad (default: 1)
%   cfg.part      = number of participant (default: 1)
%
% This function requires the fieldtrip toolbox
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, HSP_SEGMENTATION, 
% HSP_DATASTRUCTURE, FT_DATABROWSER

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
cond = ft_getopt(cfg, 'condition', 'Earphone2HzS');
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
  case 'Earphone2HzS'
    ft_databrowser(cfg, data(dyad).Earphone2HzS{part});
    windowTitle = sprintf('Earphone2HzS - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Speaker2HzS'
    ft_databrowser(cfg, data(dyad).Speaker2HzS{part});
    windowTitle = sprintf('Speaker2HzS - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Tapping2HzS'
    ft_databrowser(cfg, data(dyad).Tapping2HzS{part});
    windowTitle = sprintf('Tapping2HzS - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Dialogue2HzS'
    ft_databrowser(cfg, data(dyad).Dialogue2HzS{part});
    windowTitle = sprintf('Dialogue2HzS - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Speaker20HzS'
    ft_databrowser(cfg, data(dyad).Speaker20HzS{part});
    windowTitle = sprintf('Speaker20HzS - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Earphone20HzS'
    ft_databrowser(cfg, data(dyad).Earphone20HzS{part});
    windowTitle = sprintf('Earphone20HzS - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Speaker20HzA'
    ft_databrowser(cfg, data(dyad).Speaker20HzA{part});
    windowTitle = sprintf('Speaker20HzA - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Earphone20HzA'
    ft_databrowser(cfg, data(dyad).Earphone20HzA{part});
    windowTitle = sprintf('Earphone20HzA - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Earphone2HzA'
    ft_databrowser(cfg, data(dyad).Earphone2HzA{part});
    windowTitle = sprintf('Earphone2HzA - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Speaker2HzA'
    ft_databrowser(cfg, data(dyad).Speaker2HzA{part});
    windowTitle = sprintf('Speaker2HzA - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Earphone40HzS'
    ft_databrowser(cfg, data(dyad).Earphone40HzS{part});
    windowTitle = sprintf('Earphone40HzS - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Speaker40HzS'
    ft_databrowser(cfg, data(dyad).Speaker40HzS{part});
    windowTitle = sprintf('Speaker40HzS - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Atalks2B'
    ft_databrowser(cfg, data(dyad).Atalks2B{part});
    windowTitle = sprintf('Atalks2B - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Btalks2A'
    ft_databrowser(cfg, data(dyad).Btalks2A{part});
    windowTitle = sprintf('Btalks2A - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'Dialogue'
    ft_databrowser(cfg, data(dyad).Dialogue{part});
    windowTitle = sprintf('Dialogue - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'SilEyesOpen'
    ft_databrowser(cfg, data(dyad).SilEyesOpen{part});
    windowTitle = sprintf('SilEyesOpen - Dyad: %d - Participant %d', ...
                          dyad, part);
  case 'SilEyesClosed'
    ft_databrowser(cfg, data(dyad).SilEyesClosed{part});
    windowTitle = sprintf('SilEyesClosed - Dyad: %d - Participant %d', ...
                          dyad, part);
end

h = gcf;
h.Name = (windowTitle);

end