function [ cfgAllArt ] = HSP_manArtifact( cfg, data )
% HSP_MANARTIFACT - this function could be use to is verify the automatic 
% detected artifacts remove some of them or add additional ones if
% required.
%
% Use as
%   [ cfgAllArt ] = HSP_manArtifact(cfg, data)
%
% where data has to be a result of HSP_SEGMENTATION
%
% The configuration options are
%   cfg.artifact  = output of HSP_autoArtifact (see file HSP_05_autoArt_xxx.mat)
%   cfg.numOfPart = numbers of participants, i.e. [1:1:6] or [1,3,5] (default: [])
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_SEGMENTATION, HSP_DATABROWSER

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------

artifact  = ft_getopt(cfg, 'artifact', []);
numOfPart = ft_getopt(cfg, 'numOfPart', []);

if isempty(numOfPart)                                                       % get numOfPart
  numOfSources = size(data, 2);
  notEmpty = zeros(1, numOfSources);
  for i=1:1:numOfSources
      notEmpty(i) = (~isempty(data(i).part1));
  end
  numOfPart = find(notEmpty);  
end

% -------------------------------------------------------------------------
% Initialize settings, build output structure
% -------------------------------------------------------------------------
cfg           = [];

cfgAllArt(max(numOfPart)).part1 = [];                                       
cfgAllArt(max(numOfPart)).part2 = [];

% -------------------------------------------------------------------------
% Check Data
% -------------------------------------------------------------------------
for i = numOfPart
  cfg.dyad = i;
  
  fprintf('\nSearch for artifacts with part 1 of dyad %d\n', i);
  cfg.part = 1;
  cfg.artifact = artifact(i).part1.artfctdef.threshold.artifact;
  cfgAllArt(i).part1 = HSP_databrowser(cfg, data);
  cfgAllArt(i).part1    = keepfields(cfgAllArt(i).part1, ...
                                      {'artfctdef', 'showcallinfo'});
  
  fprintf('\nSearch for artifacts with part 2 of dyad %d\n', i);
  cfg.part = 2;
  cfg.artifact = artifact(i).part2.artfctdef.threshold.artifact;
  cfgAllArt(i).part2 = HSP_databrowser(cfg, data);
  cfgAllArt(i).part2    = keepfields(cfgAllArt(i).part2, ...
                                      {'artfctdef', 'showcallinfo'});
  
  if(i < max(numOfPart))
    selection = false;
    while selection == false
      fprintf('\nProceed with the next dyad?\n');
      x = input('\nSelect [y/n]: ','s');
      if strcmp('y', x)
        selection = true;
      elseif strcmp('n', x)
        return;
      else
        selection = false;
      end
    end
  end
end

fprintf('\n');

end

