function HSP_easyTFRplot(cfg, data)
% HSP_EASYTFRPLOT is a function, which makes it easier to plot a
% time-frequency-spectrum of a specific trial in a particular condition 
% from the HSP-data-structure.
%
% Use as
%   HSP_easyTFRPlot(cfg, data)
%
% where the input data is a results from HSP_CALCTFR.
%
% The configuration options are 
%   cfg.condition   = condition (default: 'SilEyesClosed', see HSP data structure)
%   cfg.dyad        = number of dyad (default: 1)
%   cfg.electrode   = number of electrode (default: 8 (Cz_1), 1...64)
%   cfg.trial       = number of trial (default: 1)
%   cfg.freqlimits  = [begin end] (default: [2 50])
%   cfg.timelimits  = [begin end] (default: [4 176])
%
% This function requires the fieldtrip toolbox
%
% See also FT_SINGLEPLOTTFR, HSP_CALCTFR

% Copyright (C) 2017, Daniel Matthes, MPI CBS

cond    = ft_getopt(cfg, 'condition', 'SilEyesClosed');
dyad    = ft_getopt(cfg, 'dyad', 1);
elec    = ft_getopt(cfg, 'electrode', 8);
trl     = ft_getopt(cfg, 'trial', 1);
freqlim = ft_getopt(cfg, 'freqlimits', [2 50]);
timelim = ft_getopt(cfg, 'timelimits', [4 176]);

warning('off','all');

% -------------------------------------------------------------------------
% Create figure
% -------------------------------------------------------------------------
cfg                 = [];                                                       
cfg.maskstyle       = 'saturation';
cfg.xlim            = timelim;
cfg.ylim            = freqlim;
cfg.zlim            = 'maxmin';
cfg.trials          = trl;                                                  % select trial (or 'all' trials)
cfg.channel         = elec;
cfg.feedback        = 'no';                                                 % suppress feedback output
cfg.showcallinfo    = 'no';                                                 % suppress function call output

% figure
colormap jet;                                                               % use the older and more common colormap

switch cond
  case 'Earphone40Hz'
    ft_singleplotTFR(cfg, data(dyad).Earphone40Hz);
    title(sprintf('Earphone40Hz - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).Earphone40Hz.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'Speaker40Hz'
    ft_singleplotTFR(cfg, data(dyad).Speaker40Hz);
    title(sprintf('Speaker40Hz - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).Speaker40Hz.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'Earphone2Hz'
    ft_singleplotTFR(cfg, data(dyad).Earphone2Hz);
    title(sprintf('Earphone2Hz - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).Earphone2Hz.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'Speaker2Hz'
    ft_singleplotTFR(cfg, data(dyad).Speaker2Hz);
    title(sprintf('Speaker2Hz - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).Speaker2Hz.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'Silence'
    ft_singleplotTFR(cfg, data(dyad).Silence);
    title(sprintf('Silence - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).Silence.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'SilEyesClosed'
    ft_singleplotTFR(cfg, data(dyad).SilEyesClosed);
    title(sprintf('SilEyesClosed - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).SilEyesClosed.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'MixNoiseEarphones'
    ft_singleplotTFR(cfg, data(dyad).MixNoiseEarphones);
    title(sprintf('MixNoiseEarphones - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).MixNoiseEarphones.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'MixNoiseSpeaker'
    ft_singleplotTFR(cfg, data(dyad).MixNoiseSpeaker);
    title(sprintf('MixNoiseSpeaker - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).MixNoiseSpeaker.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'Tapping'
    ft_singleplotTFR(cfg, data(dyad).Tapping);
    title(sprintf('Tapping - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).Tapping.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'DialoguePlus2Hz'
    ft_singleplotTFR(cfg, data(dyad).DialoguePlus2Hz);
    title(sprintf('DialoguePlus2Hz - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).DialoguePlus2Hz.label{elec}, '_', '\_'),...
          trl, dyad), 'FontSize', 11);
  case 'AreadsB'
    ft_singleplotTFR(cfg, data(dyad).AreadsB);
    title(sprintf('AreadsB - Electrode: %s - Trial: %d - Dyad: %d', ...
          strrep(data(dyad).AreadsB.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
  case 'BreadsA'
    ft_singleplotTFR(cfg, data(dyad).BreadsA);
    title(sprintf('BreadsA - Electrode: %s - Trial: %d - Dyad: %d', ...
      strrep(data(dyad).BreadsA.label{elec}, '_', '\_'), ...
      trl, dyad), 'FontSize', 11);
  case 'Dialogue'
    ft_singleplotTFR(cfg, data(dyad).Dialogue);
    title(sprintf('Dialogue - Electrode: %s - Trial: %d - Dyad: %d', ... 
          strrep(data(dyad).Dialogue.label{elec}, '_', '\_'), ...
          trl, dyad), 'FontSize', 11);
end


xlabel('time in sec');                                                      % set xlabel
ylabel('frequency in Hz');                                                  % set ylabel

warning('on','all');

end