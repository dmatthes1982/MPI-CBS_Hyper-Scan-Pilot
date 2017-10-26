function HSP_easyMultiTFRplot(cfg, data)
% HSP_EASYMULTITFRPLOT is a function, which makes it easier to create a 
% multi time frequency response plot of all electrodes of specific 
% condition and trial on a head model.
%
% Use as
%   HSP_easyTFRPlot(cfg, data)
%
% where the input data is a results from HSP_TIMEFREQANALYSIS.
%
% The configuration options are 
%   cfg.dyad        = number of dyad (default: 2)
%   cfg.part        = number of participant (1 or 2) (default: 1)
%   cfg.condition   = condition (default: 100 or 'SilEyesClosed', see HSP data structure)
%   cfg.trial       = number of trial (default: 1)
%   cfg.freqlimits  = [begin end] (default: [2 30])
%   cfg.timelimits  = [begin end] (default: [4 176])
%
% This function requires the fieldtrip toolbox
%
% See also FT_MULTIPLOTTFR, HSP_TIMEFREQANALYSIS

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
dyad    = ft_getopt(cfg, 'dyad', 2);
part    = ft_getopt(cfg, 'part', 1);
cond    = ft_getopt(cfg, 'condition', 100);
trl     = ft_getopt(cfg, 'trial', 1);
freqlim = ft_getopt(cfg, 'freqlimits', [2 30]);
timelim = ft_getopt(cfg, 'timelimits', [4 176]);

numOfDyads = length(data);                                                  % check cfg.dyad definition
if numOfDyads < dyad
  error('The selected dataset contains only %d dyads', numOfDyads);
end

if part < 1 || part > 2                                                     % check cfg.participant definition
  error('cfg.part has to be 1 or 2');
end

if part == 1                                                                % get trialinfo
  trialinfo = data(dyad).part1.trialinfo;
elseif part == 2
  trialinfo = data(dyad).part2.trialinfo;
end

cond    = HSP_checkCondition( cond );                                       % check cfg.condition definition    
trials  = find(trialinfo == cond);
if isempty(trials)
  error('The selected dataset contains no condition %d.', cond);
else
  numTrials = length(trials);
  if numTrials < trl                                                        % check cfg.trial definition
    error('The selected dataset contains only %d trials.', numTrials);
  else
    trlInCond = trl;
    trl = trl-1 + trials(1);
  end
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

cfg.showlabels    = 'no';
cfg.showoutline   = 'yes';
cfg.colorbar      = 'yes';

cfg.showcallinfo  = 'no';                                                   % suppress function call output

switch part
  case 1
    ft_multiplotTFR(cfg, data(dyad).part1);
    title(sprintf('Part.: %d/%d - Cond.: %d - Trial: %d', ...
          dyad, part, cond, trlInCond));      
  case 2
    ft_multiplotTFR(cfg, data(dyad).part2);
    title(sprintf('Part.: %d/%d - Cond.: %d - Trial: %d', ...
          dyad, part, cond, trlInCond));
end

ft_warning on;

end