function cfgArtifacts = HSP_databrowser( cfg, data )
% HSP_DATABROWSER displays a certain hyperscanning pilot project dataset 
% using a appropriate scaling.
%
% Use as
%   HSP_databrowser( data )
%
% where the input can be the result of HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION
%
% The configuration options are
%   cfg.dyad      = number of dyad (default: 1)
%   cfg.part      = number of participant (default: 1)
%   cfg.artifact  = Nx2 matrix with artifact segments (default: [])
%
% This function requires the fieldtrip toolbox
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, HSP_SEGMENTATION, 
% HSP_DATASTRUCTURE, FT_DATABROWSER

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
dyad      = ft_getopt(cfg, 'dyad', 1);
part      = ft_getopt(cfg, 'part', 1);
artifact  = ft_getopt(cfg, 'artifact', []);

numOfDyads = length(data);                                                  % check cfg.dyad definition
if numOfDyads < dyad
  error('The selected dataset contains only %d dyads', numOfDyads);
end

if part < 1 || part > 2                                                     % check cfg.participant definition
  error('cfg.part has to be 1 or 2');
end

% -------------------------------------------------------------------------
% Configure and start databrowser
% -------------------------------------------------------------------------
cfg                               = [];
cfg.ylim                          = [-80 80];
cfg.viewmode                      = 'vertical';
cfg.artfctdef.threshold.artifact  = artifact;
cfg.continuous                    = 'no';
cfg.channel                       = 'all';
cfg.showcallinfo                  = 'no';

fprintf('Databrowser - Participant: %d/%d\n', dyad, part);

switch part
  case 1
    cfgArtifacts = ft_databrowser(cfg, data(dyad).part1);
  case 2
    cfgArtifacts = ft_databrowser(cfg, data(dyad).part2);
end

end
