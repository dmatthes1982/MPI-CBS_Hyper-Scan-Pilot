function [ data ] = HSP_importSingleDataset(cfg)
% HSP_IMPORTSINGLEDATASET imports one specific dataset recorded with a
% device from brain vision.
%
% Use as
%   [ data ] = HSP_importSingleDataset(cfg)
%
% The configuration options are
%   cfg.dataset = 'path to header file' (i.e. '/data/pt_01821/DualEEG_AD_auditory_rawData/DualEEG_AD_auditory_01.vhdr')
%
% You can use relativ path specifications (i.e. '/home/user/
% Dual_EEG_AD_test_dyad_01.vhdr') or absolute path specifications like in 
% the example. Please be aware that you have to mask space signs of the 
% path names under linux with a backslash char 
% (i.e. '/home/user/test\ data.vhdr')
%
% This function requires the fieldtrip toolbox.
%
% See also FT_PREPROCESSING, HSP_DATASTRUCTURE

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% -------------------------------------------------------------------------
headerfile = ft_getopt(cfg, 'dataset', []);

if isempty(headerfile)
  error('No headerfile specified!');
end

% -------------------------------------------------------------------------
% General definitions
% -------------------------------------------------------------------------
% definition of all possible stimuli, two for each condition, the first on 
% is the original one and the second one handles the 'video trigger bug'
eventvalues = { 'S21','S149', ...                                           % 2 Hz earphones synchronous  
                'S22','S150', ...                                           % 2 Hz speaker synchronous
                'S24','S152', ...                                           % finger tapping in 2 Hz plus 2 Hz speaker synchronous
                'S25','S153', ...                                           % dialogue plus 2 Hz speaker synchronous
                'S26','S154', ...                                           % 20 Hz speaker synchronous
                'S27','S155', ...                                           % 20 Hz earphones synchronous
                'S28','S156', ...                                           % 20 Hz speaker asynchronous
                'S29','S157', ...                                           % 20 Hz earphones asynchronous
                'S31','S159', ...                                           % 2 Hz earphones asynchronous  
                'S32','S160', ...                                           % 2 Hz speaker asynchronous
                'S41','S169', ...                                           % 40 Hz earphones
                'S42','S170', ...                                           % 40 Hz speaker  
                'S51','S179', ...                                           % A talks to B  
                'S52','S180', ...                                           % B talks to A  
                'S53','S181', ...                                           % dialogue
                'S10','S138', ...                                           % silence, eyes open  
                'S100','S228', ...                                          % silence, eyes closed  
                };

% -------------------------------------------------------------------------
% Data import
% -------------------------------------------------------------------------
% basis configuration for data import
cfg                     = [];
cfg.dataset             = headerfile;
cfg.trialfun            = 'ft_trialfun_general';
cfg.trialdef.eventtype  = 'Stimulus';
cfg.trialdef.prestim    = 0;
cfg.trialdef.poststim   = 180;
cfg.showcallinfo        = 'no';
cfg.feedback            = 'error';
cfg.trialdef.eventvalue = eventvalues;

cfg = ft_definetrial(cfg);                                                  % generate config for segmentation

for i = size(cfg.trl):-1:2                                                  % reject duplicates
  if cfg.trl(i,4) == cfg.trl(i-1,4)
    cfg.trl(i-1,:) = [];
  end
end

for i = 1:1:size(cfg.trl)                                                   % correct false stimulus numbers
  switch cfg.trl(i,4)
    case 149
      cfg.trl(i,4) = 21;
    case 150
      cfg.trl(i,4) = 22;
    case 152
      cfg.trl(i,4) = 24;
    case 153
      cfg.trl(i,4) = 25;
    case 154
      cfg.trl(i,4) = 26;
    case 155
      cfg.trl(i,4) = 27;
    case 156
      cfg.trl(i,4) = 28;
    case 157
      cfg.trl(i,4) = 29;
    case 159
      cfg.trl(i,4) = 31;
    case 160
      cfg.trl(i,4) = 32;
    case 169
      cfg.trl(i,4) = 41;
    case 170
      cfg.trl(i,4) = 42;
    case 179
      cfg.trl(i,4) = 51;
    case 180
      cfg.trl(i,4) = 52;
    case 181
      cfg.trl(i,4) = 53;
    case 138
      cfg.trl(i,4) = 10;
    case 228
      cfg.trl(i,4) = 100;
  end
end

dataTmp = ft_preprocessing(cfg);                                            % import data

data.part1 = dataTmp;                                                       % split dataset into two datasets, one for each participant
data.part1.label = strrep(dataTmp.label(1:32), '_1', '');
for i=1:1:length(dataTmp.trial)
  data.part1.trial{i} = dataTmp.trial{i}(1:32,:);
end

data.part2 = dataTmp;
data.part2.label = strrep(dataTmp.label(33:64), '_2', '');
for i=1:1:length(dataTmp.trial)
  data.part2.trial{i} = dataTmp.trial{i}(33:64,:);
end

end
