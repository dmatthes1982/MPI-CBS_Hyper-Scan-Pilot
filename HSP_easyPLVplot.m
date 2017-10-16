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
%   cfg.elecPart1 = number of electrode of participant 1 (default: 'Cz')
%   cfg.elecPart2 = number of electrode of participant 2 (default: 'Cz')
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
elecPart1 = ft_getopt(cfg, 'elecPart1', 'Cz');
elecPart2 = ft_getopt(cfg, 'elecPart2', 'Cz');

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

if isnumeric(elecPart1)                                                     % check cfg.electrode definition
  if elecPart1 < 1 || elecPart1 > 32
    error('cfg.elecPart1 hast to be a number between 1 and 32 or a existing label like ''Cz''.');
  end
else
  elecPart1 = find(strcmp(label, elecPart1));                            
  if isempty(elecPart1)
    error('cfg.elecPart1 hast to be a existing label like ''Cz''or a number between 1 and 32.');
  end
end

if isnumeric(elecPart2)                                                     % check cfg.electrode definition
  if elecPart2 < 1 || elecPart2 > 32
    error('cfg.elecPart2 hast to be a number between 1 and 32 or a existing label like ''Cz''.');
  end
else
  elecPart2 = find(strcmp(label, elecPart2));
  if isempty(elecPart2)
    error('cfg.elecPart2 hast to be a existing label like ''Cz''or a number between 1 and 32.');
  end
end

% -------------------------------------------------------------------------
% Plot PLV course
% -------------------------------------------------------------------------
plot(data(dyad).dyad.time{trl}, data(dyad).dyad.PLV{trl}{elecPart1,elecPart2}(:));
title(sprintf('Dyad: %d - Cond.: %d - Elec.: %s - %s', dyad, cond, ...
               strrep(data(dyad).dyad.label{elecPart1}, '_', '\_'), ...
               strrep(data(dyad).dyad.label{elecPart2}, '_', '\_')));    

xlabel('time in seconds');
ylabel('phase locking value');

end
