function [ data ] = HSP_mergeDataset( cfg, dataNew, dataOld )
% HSP_MERGEDATASET merges two datasets. Elements of dataOld which are also
% in dataNew will be overwritten.
%
% Use as
%   [ data ] = HSP_mergeDataset( cfg, dataNew, dataOld )
%
% The configuration options are
%    cfg.numOfNewPart = numbers of new participants (i.e. [4,5,6])
%
% This function requires the fieldtrip toolbox.

% Copyright (C) 2017, Daniel Matthes, MPI CBS

numOfNewPart  = ft_getopt(cfg, 'numOfNewPart', []);

if isempty(numOfNewPart)
  error('Please define numOfNewPart!');
end

data = dataOld;

for i = numOfNewPart
  data(i) = dataNew(i);
end

end

