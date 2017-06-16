function HSP_easyPlot( cfg, data )
% HSP_EASYPLOT is a function which makes it easier to plot a specific trial 
% of a particular condition from the HSP-data-structure.
%
% Use as
%   HSP_easyPlot(cfg, data)
%
% where the input data can be the results from HSP_IMPORTALLDATASETS or
% HSP_PREPROCESSING
%
% The configuration options are
%   cfg.condition = condition (default: 'Earphone40Hz', see HSP data structure)
%   cfg.dyad      = number of dyad (default: 1)
%   cfg.electrode = number of electrode (default: 8 (Cz_1), 1...64)
%   cfg.trial     = number of trial (default: 1)
%
% This function requires the fieldtrip toolbox.
%
% See also PLOT

% Copyright (C) 2017, Daniel Matthes, MPI CBS

cond = ft_getopt(cfg, 'condition', 'Earphone40Hz');
dyad = ft_getopt(cfg, 'dyad', 1);
elec = ft_getopt(cfg, 'electrode', 8);
trl  = ft_getopt(cfg, 'trial', 1);

switch cond
  case 'Earphone40Hz'
    plot(data.Earphone40Hz{dyad}.time{trl}, data.Earphone40Hz{dyad}.trial{trl}(elec,:));
  case 'Speaker40Hz'
    plot(data.Speaker40Hz{dyad}.time{trl}, data.Speaker40Hz{dyad}.trial{trl}(elec,:));
  case 'Earphone2Hz'
    plot(data.Earphone2Hz{dyad}.time{trl}, data.Earphone2Hz{dyad}.trial{trl}(elec,:));
  case 'Speaker2Hz'
    plot(data.Speaker2Hz{dyad}.time{trl}, data.Speaker2Hz{dyad}.trial{trl}(elec,:));
  case 'Silence'
    plot(data.Silence{dyad}.time{trl}, data.Silence{dyad}.trial{trl}(elec,:));
  case 'SilEyesClosed'
    plot(data.SilEyesClosed{dyad}.time{trl}, data.SilEyesClosed{dyad}.trial{trl}(elec,:));
  case 'MixNoiseEarphones'
    plot(data.MixNoiseEarphones{dyad}.time{trl}, data.MixNoiseEarphones{dyad}.trial{trl}(elec,:));
  case 'MixNoiseSpeaker'
    plot(data.MixNoiseSpeaker{dyad}.time{trl}, data.MixNoiseSpeaker{dyad}.trial{trl}(elec,:));
  case 'Tapping'
    plot(data.Tapping{dyad}.time{trl}, data.Tapping{dyad}.trial{trl}(elec,:));
  case 'DialoguePlus2Hz'
    plot(data.DialoguePlus2Hz{dyad}.time{trl}, data.DialoguePlus2Hz{dyad}.trial{trl}(elec,:));
  case 'AreadsB'
    plot(data.AreadsB{dyad}.time{trl}, data.AreadsB{dyad}.trial{trl}(elec,:));
  case 'BreadsA'
    plot(data.BreadsA{dyad}.time{trl}, data.BreadsA{dyad}.trial{trl}(elec,:));
  case 'Dialogue'
    plot(data.Dialogue{dyad}.time{trl}, data.Dialogue{dyad}.trial{trl}(elec,:));
end

end

