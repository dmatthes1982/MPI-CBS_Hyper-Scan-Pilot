function [ data ] = HSP_rejectArtifacts( cfg, data )
% HSP_REJECTARTIFACTS is a function which removes trials containing 
% artifacts. It returns clean data.
%
% Use as
%   [ data ] = HSP_rejectartifacts( cfg, data )
%
% where data can be a result of HSP_SEGMENTATION, HSP_BPFILTERING or
% HSP_HILBERTPHASE
%
% The configuration options are
%   cfg.artifact  = output of HSP_manArtifact or HSP_manArtifact 
%                   (see file HSP_05_autoArt_xxx.mat, HSP_06_allArt_xxx.mat)
%   cfg.type      = type of rejection, options: 'single' or 'dual' (default: 'single');
%                   'single' = trials of a certain participant will be 
%                              rejected, if they are marked as bad 
%                              for that particpant (useable for ITPC calc)
%                   'dual' = trials of a certain participant will be
%                            rejected, if they are marked as bad for
%                            that particpant or for the other participant
%                            of the dyad (useable for PLV calculation)
%   cfg.numOfPart = numbers of participants, i.e. [1:1:6] or [1,3,5] (default: [])
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_SEGMENTATION, HSP_BPFILTERING, HSP_HILBERTPHASE, 
% HSP_MANARTIFACT and HSP_AUTOARTIFACT 

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------

artifact  = ft_getopt(cfg, 'artifact', []);
numOfPart = ft_getopt(cfg, 'numOfPart', []);
type      = ft_getopt(cfg, 'type', 'single');

if isempty(numOfPart)                                                       % get numOfPart
  numOfSources = size(data, 2);
  notEmpty = zeros(1, numOfSources);
  for i=1:1:numOfSources
      notEmpty(i) = (~isempty(data(i).part1));
  end
  numOfPart = find(notEmpty);  
end

if ~strcmp(type, 'single') && ~strcmp(type, 'dual')
  error('Selected type is unknown. Choose single or dual');
end

% -------------------------------------------------------------------------
% Clean Data
% -------------------------------------------------------------------------
for i = numOfPart
  if ~isempty(artifact(i).part1) && ~isempty(artifact(i).part2)
    fprintf('\nCleaning data of part 1 of dyad %d\n', i);
    ft_warning off;
    data(i).part1 = ft_rejectartifact(artifact(i).part1, data(i).part1);
    if strcmp(type, 'dual')
      ft_warning off;
      data(i).part1 = ft_rejectartifact(artifact(i).part2, data(i).part1);
    end
  else
    fprintf('\nArtifact rejection with part 1 of dyad %d not possible.\n', i);
    fprintf('No artifact definition available.\n');
  end
  
  
  
  if ~isempty(artifact(i).part1) && ~isempty(artifact(i).part2)
    fprintf('\nCleaning data of part 2 of dyad %d\n', i);
    ft_warning off;
    data(i).part2 = ft_rejectartifact(artifact(i).part2, data(i).part2);
    if strcmp(type, 'dual')
      ft_warning off;
      data(i).part2 = ft_rejectartifact(artifact(i).part1, data(i).part2);
    end
  else
    fprintf('\nArtifact rejection with part 2 of dyad %d not possible.\n', i);
    fprintf('No artifact definition available.\n');
  end
end  

ft_warning on;

end
