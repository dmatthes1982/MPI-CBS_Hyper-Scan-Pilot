function HSP_easyMPLVplot( cfg, data )
% HSP_EASYMPLVPLOT is a function, which makes it easier to plot the mean 
% PLV values from all electrodes of a specific condition from the 
% HSP_DATASTRUCTURE.
%
% Use as
%   HSP_easyPLVplot( cfg, data )
%
% where the input data has to be the result of HSP_PHASELOCKVAL
%
% The configuration options are
%   cfg.dyad      = number of dyad (default: 1)
%   cfg.condition = condition (default: 22 or 'Speaker2HzS', see HSP data structure)
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_DATASTRUCTURE, PLOT, HSP_PHASELOCKVAL, HSP_CALCMEANPLV

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
dyad = ft_getopt(cfg, 'dyad', 1);
cond = ft_getopt(cfg, 'condition', 22);

numOfDyads = length(data);                                                  % check cfg.dyad definition
if numOfDyads < dyad
  error('The selected dataset contains only %d dyads', numOfDyads);
end

trialinfo = data(dyad).dyad.trialinfo;                                            % get trialinfo

cond = HSP_checkCondition( cond );                                          % check cfg.condition definition and translate it into trl number    
trl  = find(trialinfo == cond);
if isempty(trl)
  error('The selected dataset contains no condition %d.', cond);
end

% -------------------------------------------------------------------------
% Plot mPLV representation
% -------------------------------------------------------------------------
label = data(dyad).dyad.label;
components = 1:1:length(label);

colormap jet;
imagesc(components, components, data(dyad).dyad.mPLV{trl});
set(gca, 'XTick', components,'XTickLabel', label);                          % use labels instead of numbers for the axis description
set(gca, 'YTick', components,'YTickLabel', label);
set(gca,'xaxisLocation','top');                                             % move xlabel to the top
title(sprintf(' mean Phase Locking Values (PLV) in Condition: %d', cond));   
colorbar;

end
