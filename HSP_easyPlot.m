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
    plot(data(dyad).Earphone40Hz.time{trl}, data(dyad).Earphone40Hz.trial{trl}(elec,:));
    title(sprintf('Earphone40Hz - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).Earphone40Hz.label{elec}, trl, dyad));
  case 'Speaker40Hz'
    plot(data(dyad).Speaker40Hz.time{trl}, data(dyad).Speaker40Hz.trial{trl}(elec,:));
    title(sprintf('Speaker40Hz - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).Speaker40Hz.label{elec}, trl, dyad));
  case 'Earphone2Hz'
    plot(data(dyad).Earphone2Hz.time{trl}, data(dyad).Earphone2Hz.trial{trl}(elec,:));
    title(sprintf('Earphone2Hz - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).Earphone2Hz.label{elec}, trl, dyad));
  case 'Speaker2Hz'
    plot(data(dyad).Speaker2Hz.time{trl}, data(dyad).Speaker2Hz.trial{trl}(elec,:));
    title(sprintf('Speaker2Hz - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).Speaker2Hz.label{elec}, trl, dyad));
  case 'Silence'
    plot(data(dyad).Silence.time{trl}, data(dyad).Silence.trial{trl}(elec,:));
    title(sprintf('Silence - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).Silence.label{elec}, trl, dyad));
  case 'SilEyesClosed'
    plot(data(dyad).SilEyesClosed.time{trl}, data(dyad).SilEyesClosed.trial{trl}(elec,:));
    title(sprintf('SilEyesClosed - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).SilEyesClosed.label{elec}, trl, dyad));
  case 'MixNoiseEarphones'
    plot(data(dyad).MixNoiseEarphones.time{trl}, data(dyad).MixNoiseEarphones.trial{trl}(elec,:));
    title(sprintf('MixNoiseEarphones - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).MixNoiseEarphones.label{elec}, trl, dyad));
  case 'MixNoiseSpeaker'
    plot(data(dyad).MixNoiseSpeaker.time{trl}, data(dyad).MixNoiseSpeaker.trial{trl}(elec,:));
    title(sprintf('MixNoiseSpeaker - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).MixNoiseSpeaker.label{elec}, trl, dyad));
  case 'Tapping'
    plot(data(dyad).Tapping.time{trl}, data(dyad).Tapping.trial{trl}(elec,:));
    title(sprintf('Tapping - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).Tapping.label{elec}, trl, dyad));
  case 'DialoguePlus2Hz'
    plot(data(dyad).DialoguePlus2Hz.time{trl}, data(dyad).DialoguePlus2Hz.trial{trl}(elec,:));
    title(sprintf('DialoguePlus2Hz - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).DialoguePlus2Hz.label{elec}, trl, dyad));
  case 'AreadsB'
    plot(data(dyad).AreadsB.time{trl}, data(dyad).AreadsB.trial{trl}(elec,:));
    title(sprintf('AreadsB - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).AreadsB.label{elec}, trl, dyad));
  case 'BreadsA'
    plot(data(dyad).BreadsA.time{trl}, data(dyad).BreadsA.trial{trl}(elec,:));
    title(sprintf('BreadsA - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).BreadsA.label{elec}, trl, dyad));
  case 'Dialogue'
    plot(data(dyad).Dialogue.time{trl}, data(dyad).Dialogue.trial{trl}(elec,:));
    title(sprintf('Dialogue - Electrode: %s - Trial: %d - Dyad: %d', data(dyad).Dialogue.label{elec}, trl, dyad));
end

xlabel('time in seconds');
ylabel('voltage in \muV');

end

