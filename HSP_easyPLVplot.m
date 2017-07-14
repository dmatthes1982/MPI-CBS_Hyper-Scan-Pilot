function HSP_easyPLVplot( cfg, data )
% HSP_EASYPLVPLOT is a function, which makes it easier to plot the PLV 
% values of a specific condition from the HSP-data-structure.
%
% Use as
%   HSP_easyPLVplot( cfg, data )
%
% where the input data has to be the result of HSP_PHASELOCKVAL
%
% The configuration options are
%   cfg.dyad      = number of dyad (default: 1)
%   cfg.condition = condition (default: 21 or 'Earphone2HzS', see HSP data structure)
%   cfg.electrode = number of electrode (default: 'Cz')
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_DATASTRUCTURE, PLOT, HSP_PHASELOCKVAL

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
dyad = ft_getopt(cfg, 'dyad', 1);
cond = ft_getopt(cfg, 'condition', 21);
elec = ft_getopt(cfg, 'electrode', 'Cz');

numOfDyads = length(data);                                                  % check cfg.dyad definition
if numOfDyads < dyad
  error('The selected dataset contains only %d dyads', numOfDyads);
end

trialinfo = data(dyad).dyad.trialinfo;                                      % get trialinfo

cond = HSP_checkCondition( cond );                                          % check cfg.condition definition and translate it into trl number    
trl  = find(trialinfo == cond);
if isempty(trl)
  error('The selected dataset contains no condition %d.', cond);
end

label = data(dyad).dyad.label;                                              % get labels

if isnumeric(elec)                                                          % check cfg.electrode definition
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
% Plot PLV course
% -------------------------------------------------------------------------
plot(data(dyad).dyad.time{trl}, data(dyad).dyad.PLV{trl}(elec,:));
title(sprintf('Dyad: %d - Cond.: %d - Elec.: %s', dyad, cond, ...
              strrep(data(dyad).dyad.label{elec}, '_', '\_')));      

xlabel('time in seconds');
ylabel('phase locking value');

end
