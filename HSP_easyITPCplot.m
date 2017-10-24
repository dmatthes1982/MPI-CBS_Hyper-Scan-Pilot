function HSP_easyITPCplot(cfg, data)
% HSP_EASYITPCPLOT is a function, which makes it easier to plot a
% inter-trial phase coherence representation of a specific condition from 
% the HSP_DATASTRUCTURE.
%
% Use as
%   HSP_easyITCplot(cfg, data)
%
% where the input data have to be a result from HSP_INTERTRAILPHASECOH.
%
% The configuration options are 
%   cfg.dyad        = number of dyad (default: 1)
%   cfg.part        = number of participant (default: 1)
%   cfg.condition   = condition (default: 22 or 'Speaker2HzS', see HSP_DATASTRUCTURE)
%   cfg.electrode   = number of electrode (default: 'Cz')
%  
% This function requires the fieldtrip toolbox
%
% See also HSP_INTERTRAILPHASECOH, HSP_DATASTRUCTURE

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
dyad    = ft_getopt(cfg, 'dyad', 1);
part    = ft_getopt(cfg, 'part', 1);
cond    = ft_getopt(cfg, 'condition', 22);
elec    = ft_getopt(cfg, 'electrode', 'Cz');

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
if isempty(find(trialinfo == cond, 1))
  error('The selected dataset contains no condition %d.', cond);
else
  trialNum = find(ismember(trialinfo, cond));
end

if part == 1                                                                % get labels
  label = data(dyad).part1.label;                                             
elseif part == 2
  label = data(dyad).part2.label;
end

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
% inter-trial phase coherence representation
% -------------------------------------------------------------------------
switch part
  case 1
    imagesc(data(dyad).part1.time{trialNum}, data(dyad).part1.freq, ...
              squeeze(data(dyad).part1.itpc{trialNum}(elec,:,:)));
    title(sprintf('ITPC - Part.: %d/%d - Cond.: %d - Elec.: %s', ...
          dyad, part, cond, ...
          strrep(data(dyad).part1.label{elec}, '_', '\_')));
  case 2
    imagesc(data(dyad).part2.time{trialNum}, data(dyad).part2.freq, ...
              squeeze(data(dyad).part2.itpc{trialNum}(elec,:,:)));
    title(sprintf('ITPC - Part.: %d/%d - Cond.: %d - Elec.: %s', ...
          dyad, part, cond, ...
          strrep(data(dyad).part2.label{elec}, '_', '\_')));
end

axis xy;
xlabel('time in sec');                                                      % set xlabel
ylabel('frequency in Hz');                                                  % set ylabel

end
