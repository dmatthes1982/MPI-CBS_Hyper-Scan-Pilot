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
%   cfg.part        = number of participant (default: 1)
%   cfg.electrode   = number of electrode (default: 'Cz')
%   cfg.trial       = number of trial (default: 1)
%   cfg.freqlimits  = [begin end] (default: [2 50])
%   cfg.timelimits  = [begin end] (default: [4 176])
%
% This function requires the fieldtrip toolbox
%
% See also FT_SINGLEPLOTTFR, HSP_CALCTFR

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
cond    = ft_getopt(cfg, 'condition', 'SilEyesClosed');
dyad    = ft_getopt(cfg, 'dyad', 1);
part    = ft_getopt(cfg, 'part', 1);
elec    = ft_getopt(cfg, 'electrode', 'Cz');
trl     = ft_getopt(cfg, 'trial', 1);
freqlim = ft_getopt(cfg, 'freqlimits', [2 50]);
timelim = ft_getopt(cfg, 'timelimits', [4 176]);

if part < 1 || part > 2
  error('cfg.part has to be 1 or 2');
end

label = data(dyad).Earphone2HzS{part}.label;

if isnumeric(elec)
  if elec < 1 || elec > 32
    error('cfg.elec hast to be a number between 1 and 32 or a existing label like ''Cz''.');
  end
else
  elec = find(strcmp(label, elec));
  if isempty(elec)
    error('cfg.elec hast to be a existing label like ''Cz''or a number between 1 and 32.');
  end
end

% -------------------------------------------------------------------------
% Plot time frequency spectrum
% -------------------------------------------------------------------------

ft_warning off;

cfg                 = [];                                                       
cfg.maskstyle       = 'saturation';
cfg.xlim            = timelim;
cfg.ylim            = freqlim;
cfg.zlim            = 'maxmin';
cfg.trials          = trl;                                                  % select trial (or 'all' trials)
cfg.channel         = elec;
cfg.feedback        = 'no';                                                 % suppress feedback output
cfg.showcallinfo    = 'no';                                                 % suppress function call output

colormap jet;                                                               % use the older and more common colormap

switch cond
  case 'Earphone2HzS'
    ft_singleplotTFR(cfg, data(dyad).Earphone2HzS{part});
    title(sprintf('Earphone2HzS - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Earphone2HzS{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Speaker2HzS'
    ft_singleplotTFR(cfg, data(dyad).Speaker2HzS{part});
    title(sprintf('Speaker2HzS - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Speaker2HzS{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Tapping2HzS'
    ft_singleplotTFR(cfg, data(dyad).Tapping2HzS{part});
    title(sprintf('Tapping2HzS - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Tapping2HzS{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Dialogue2HzS'
    ft_singleplotTFR(cfg, data(dyad).Dialogue2HzS{part});
    title(sprintf('Dialogue2HzS - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Dialogue2HzS{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Speaker20HzS'
    ft_singleplotTFR(cfg, data(dyad).Speaker20HzS{part});
    title(sprintf('Speaker20HzS - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Speaker20HzS{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Earphone20HzS'
    ft_singleplotTFR(cfg, data(dyad).Earphone20HzS{part});
    title(sprintf('Earphone20HzS - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Earphone20HzS{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Speaker20HzA'
    ft_singleplotTFR(cfg, data(dyad).Speaker20HzA{part});
    title(sprintf('Speaker20HzA - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Speaker20HzA{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Earphone20HzA'
    ft_singleplotTFR(cfg, data(dyad).Earphone20HzA{part});
    title(sprintf('Earphone20HzA - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Earphone20HzA{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Earphone2HzA'
    ft_singleplotTFR(cfg, data(dyad).Earphone2HzA{part});
    title(sprintf('Earphone2HzA - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Earphone2HzA{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Speaker2HzA'
    ft_singleplotTFR(cfg, data(dyad).Speaker2HzA{part});
    title(sprintf('Speaker2HzA - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Speaker2HzA{part}.label{elec}, '_', '\_'),...
          trl, dyad, part), 'FontSize', 11);
  case 'Earphone40HzS'
    ft_singleplotTFR(cfg, data(dyad).Earphone40HzS{part});
    title(sprintf('Earphone40HzS - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
          strrep(data(dyad).Earphone40HzS{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Speaker40HzS'
    ft_singleplotTFR(cfg, data(dyad).Speaker40HzS{part});
    title(sprintf('Speaker40HzS - Electrode: %s - Trial: %d - Dyad: %d - %d', ...
      strrep(data(dyad).Speaker40HzS{part}.label{elec}, '_', '\_'), ...
      trl, dyad, part), 'FontSize', 11);
  case 'Atalks2B'
    ft_singleplotTFR(cfg, data(dyad).Atalks2B{part});
    title(sprintf('Atalks2B - Electrode: %s - Trial: %d - Dyad: %d - %d', ... 
          strrep(data(dyad).Atalks2B{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Btalks2A'
    ft_singleplotTFR(cfg, data(dyad).Btalks2A{part});
    title(sprintf('Btalks2A - Electrode: %s - Trial: %d - Dyad: %d - %d', ... 
          strrep(data(dyad).Btalks2A{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);
  case 'Dialogue'
    ft_singleplotTFR(cfg, data(dyad).Dialogue{part});
    title(sprintf('Dialogue - Electrode: %s - Trial: %d - Dyad: %d - %d', ... 
          strrep(data(dyad).Dialogue{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);      
  case 'SilEyesOpen'
    ft_singleplotTFR(cfg, data(dyad).SilEyesOpen{part});
    title(sprintf('SilEyesOpen - Electrode: %s - Trial: %d - Dyad: %d - %d', ... 
          strrep(data(dyad).SilEyesOpen{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);      
  case 'SilEyesClosed'
    ft_singleplotTFR(cfg, data(dyad).SilEyesClosed{part});
    title(sprintf('SilEyesClosed - Electrode: %s - Trial: %d - Dyad: %d - %d', ... 
          strrep(data(dyad).SilEyesClosed{part}.label{elec}, '_', '\_'), ...
          trl, dyad, part), 'FontSize', 11);      
end


xlabel('time in sec');                                                      % set xlabel
ylabel('frequency in Hz');                                                  % set ylabel

ft_warning on;

end