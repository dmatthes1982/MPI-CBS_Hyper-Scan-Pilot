function HSP_easyPlot( cfg, data )
% HSP_EASYPLOT is a function, which makes it easier to plot a specific 
% trial of a particular condition from the HSP-data-structure.
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
%   cfg.part      = number of participant (default: 1)
%   cfg.electrode = number of electrode (default: 'Cz' or 8)
%   cfg.trial     = number of trial (default: 1)
%
% This function requires the fieldtrip toolbox.
%
% See also PLOT

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
default_label = {'Fz'; 'F3'; 'F7'; 'F9'; 'FT7'; 'FC3'; 'FC1'; 'Cz'; ...
                 'C3'; 'T7'; 'CP3'; 'Pz'; 'P3'; 'P7'; 'PO9'; 'O1'; ...
                 'O2'; 'PO10'; 'P8'; 'P4'; 'CP4'; 'TP10'; 'T8'; 'C4'; ...
                 'FT8'; 'FC4'; 'FC2'; 'F4'; 'F8'; 'F10'; 'V1'; 'V2'};

cond = ft_getopt(cfg, 'condition', 'Earphone40Hz');
dyad = ft_getopt(cfg, 'dyad', 1);
part = ft_getopt(cfg, 'part', 1);
elec = ft_getopt(cfg, 'electrode', 8);
trl  = ft_getopt(cfg, 'trial', 1);

if part < 1 || part > 2
  error('cfg.part has to be 1 or 2');
end

if isnumeric(elec)
  if elec < 1 || elec > 32
    error('cfg.elec hast to be a number between 1 and 32 or a existing label like ''Cz''.');
  end
else
  elec = find(strcmp(default_label, elec));
  if isempty(elec)
    error('cfg.elec hast to be a existing label like ''Cz''or a number between 1 and 32.');
  end
end

% -------------------------------------------------------------------------
% Plot timeline
% -------------------------------------------------------------------------
switch cond
  case 'Earphone40Hz'
    plot( data(dyad).Earphone40Hz{part}.time{trl}, ...
          data(dyad).Earphone40Hz{part}.trial{trl}(elec,:));
    title(sprintf('Earphone40Hz - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).Earphone40Hz{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'Speaker40Hz'
    plot( data(dyad).Speaker40Hz{part}.time{trl}, ...
          data(dyad).Speaker40Hz{part}.trial{trl}(elec,:));
    title(sprintf('Speaker40Hz - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).Speaker40Hz{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'Earphone2Hz'
    plot( data(dyad).Earphone2Hz{part}.time{trl}, ...
          data(dyad).Earphone2Hz{part}.trial{trl}(elec,:));
    title(sprintf('Earphone2Hz - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).Earphone2Hz{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'Speaker2Hz'
    plot( data(dyad).Speaker2Hz{part}.time{trl}, ...
          data(dyad).Speaker2Hz{part}.trial{trl}(elec,:));
    title(sprintf('Speaker2Hz - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).Speaker2Hz{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'Silence'
    plot( data(dyad).Silence{part}.time{trl}, ...
          data(dyad).Silence{part}.trial{trl}(elec,:));
    title(sprintf('Silence - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).Silence{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'SilEyesClosed'
    plot( data(dyad).SilEyesClosed{part}.time{trl}, ...
          data(dyad).SilEyesClosed{part}.trial{trl}(elec,:));
    title(sprintf('SilEyesClosed - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).SilEyesClosed{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'MixNoiseEarphones'
    plot( data(dyad).MixNoiseEarphones{part}.time{trl}, ...
          data(dyad).MixNoiseEarphones{part}.trial{trl}(elec,:));
    title(sprintf('MixNoiseEarphones - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).MixNoiseEarphones{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'MixNoiseSpeaker'
    plot( data(dyad).MixNoiseSpeaker{part}.time{trl}, ...
          data(dyad).MixNoiseSpeaker{part}.trial{trl}(elec,:));
    title(sprintf('MixNoiseSpeaker - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).MixNoiseSpeaker{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'Tapping'
    plot( data(dyad).Tapping{part}.time{trl}, ...
          data(dyad).Tapping{part}.trial{trl}(elec,:));
    title(sprintf('Tapping - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).Tapping{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'DialoguePlus2Hz'
    plot( data(dyad).DialoguePlus2Hz{part}.time{trl}, ...
          data(dyad).DialoguePlus2Hz{part}.trial{trl}(elec,:));
    title(sprintf('DialoguePlus2Hz - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).DialoguePlus2Hz{part}.label{elec}, '_', '\_'),...
          trl, dyad, part));
  case 'AreadsB'
    plot( data(dyad).AreadsB{part}.time{trl}, ...
          data(dyad).AreadsB{part}.trial{trl}(elec,:));
    title(sprintf('AreadsB - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
          strrep(data(dyad).AreadsB{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
  case 'BreadsA'
    plot( data(dyad).BreadsA{part}.time{trl}, ...
          data(dyad).BreadsA{part}.trial{trl}(elec,:));
    title(sprintf('BreadsA - Electrode: %s - Trial: %d - Dyad: %d - % d', ...
      strrep(data(dyad).BreadsA{part}.label{elec}, '_', '\_'), ...
      trl, dyad, part));
  case 'Dialogue'
    plot( data(dyad).Dialogue{part}.time{trl}, ...
          data(dyad).Dialogue{part}.trial{trl}(elec,:));
    title(sprintf('Dialogue - Electrode: %s - Trial: %d - Dyad: %d - % d', ... 
          strrep(data(dyad).Dialogue{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part));
end

xlabel('time in seconds');
ylabel('voltage in \muV');

end

