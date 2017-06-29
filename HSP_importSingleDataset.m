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
eventvalues = { 'S21','S149'; ...                                           % 2 Hz earphones synchronous  
                'S22','S150'; ...                                           % 2 Hz speaker synchronous
                'S24','S152'; ...                                           % finger tapping in 2 Hz plus 2 Hz speaker synchronous
                'S25','S153'; ...                                           % dialogue plus 2 Hz speaker synchronous
                'S26','S154'; ...                                           % 20 Hz speaker synchronous
                'S27','S155'; ...                                           % 20 Hz earphones synchronous
                'S28','S156'; ...                                           % 20 Hz speaker asynchronous
                'S29','S157'; ...                                           % 20 Hz earphones asynchronous
                'S31','S159'; ...                                           % 2 Hz earphones asynchronous  
                'S32','S160'; ...                                           % 2 Hz speaker asynchronous
                'S41','S169'; ...                                           % 40 Hz earphones
                'S42','S170'; ...                                           % 40 Hz speaker  
                'S51','S179'; ...                                           % A talks to B  
                'S52','S180'; ...                                           % B talks to A  
                'S53','S181'; ...                                           % dialogue
                'S10','S138'; ...                                           % silence, eyes open  
                'S100','S228'; ...                                          % silence, eyes closed  
                };

events = ft_read_event( headerfile );                                       % Get all occured events from marker file              
events = squeeze(struct2cell(events));                                      % transform struct to cell matrix
events = events(2,:);                                                       % extract events value line
emptyCells = cellfun('isempty', events);                                    % detect empty cells
events(emptyCells) = [];                                                    % remove empty cells
events = unique(events);                                                    % remove multiple numbers                                                        

% -------------------------------------------------------------------------
% Data import
% -------------------------------------------------------------------------
% basis configuration for data import
cfgOrg                       = [];
cfgOrg.dataset               = headerfile;
cfgOrg.trialfun              = 'ft_trialfun_general';
cfgOrg.trialdef.eventtype    = 'Stimulus';
cfgOrg.trialdef.prestim      = 0;
cfgOrg.trialdef.poststim     = 180;
cfgOrg.showcallinfo          = 'no';
cfgOrg.feedback              = 'error';

for i=1:1:size(eventvalues, 1)
  cfg = cfgOrg;                                                             % reset configuration
  cfg.trialdef.eventvalue = eventvalues(i,:);
  
  if any(strcmp(events, eventvalues(i,1))) || ...                           % if event is in the data
     any(strcmp(events, eventvalues(i,2)))
  
    cfgSeg = ft_definetrial(cfg);                                           % generate config for segmentation
    if size(cfgSeg.trl,1) > 1                                               % check cfgSeg.trl for multiple inputs
      cfgSeg.trl = cfgSeg.trl(end,:);                                       % choose the last entry
    end
    dataTmp = ft_preprocessing(cfgSeg);                                     % import stim specific data
    
    dataTmpPart1 = dataTmp;                                                 % split dataset into two datasets, one for each participant
    dataTmpPart1.label = strrep(dataTmp.label(1:32), '_1', '');
    dataTmpPart1.trial{:} = dataTmp.trial{:}(1:32,:);
  
    dataTmpPart2 = dataTmp;
    dataTmpPart2.label = strrep(dataTmp.label(33:64), '_2', '');
    dataTmpPart2.trial{:} = dataTmp.trial{:}(33:64,:);
  else
    dataTmpPart1 = [];
    dataTmpPart2 = [];
  end
    
  switch i                                                                  % allocate data to substructures and correct false stimulus numbers
    case 1
      data.Earphone2HzS{1} = dataTmpPart1;
      data.Earphone2HzS{2} = dataTmpPart2;
      if data.Earphone2HzS{1}.trialinfo == 149
        data.Earphone2HzS{1}.trialinfo = 21;
        data.Earphone2HzS{2}.trialinfo = 21;
      end
    case 2
      data.Speaker2HzS{1} = dataTmpPart1;
      data.Speaker2HzS{2} = dataTmpPart2;
      if data.Speaker2HzS{1}.trialinfo == 150
        data.Speaker2HzS{1}.trialinfo = 22;
        data.Speaker2HzS{2}.trialinfo = 22;
      end
    case 3
      data.Tapping2HzS{1} = dataTmpPart1;
      data.Tapping2HzS{2} = dataTmpPart2;
      if data.Tapping2HzS{1}.trialinfo == 152
        data.Tapping2HzS{1}.trialinfo = 24;
        data.Tapping2HzS{2}.trialinfo = 24;
      end
    case 4
      data.Dialogue2HzS{1} = dataTmpPart1;
      data.Dialogue2HzS{2} = dataTmpPart2;
      if ~isempty(dataTmpPart1)
        if data.Dialogue2HzS{1}.trialinfo == 153
          data.Dialogue2HzS{1}.trialinfo = 25;
          data.Dialogue2HzS{2}.trialinfo = 25;
        end
      end
    case 5
      data.Speaker20HzS{1} = dataTmpPart1;
      data.Speaker20HzS{2} = dataTmpPart2;
      if ~isempty(dataTmpPart1)
        if data.Speaker20HzS{1}.trialinfo == 154
          data.Speaker20HzS{1}.trialinfo = 26;
          data.Speaker20HzS{2}.trialinfo = 26;
        end
      end
    case 6
      data.Earphone20HzS{1} = dataTmpPart1;
      data.Earphone20HzS{2} = dataTmpPart2;
      if ~isempty(dataTmpPart1)
        if data.Earphone20HzS{1}.trialinfo == 155
          data.Earphone20HzS{1}.trialinfo = 27;
          data.Earphone20HzS{2}.trialinfo = 27;
        end
      end
    case 7
      data.Speaker20HzA{1} = dataTmpPart1;
      data.Speaker20HzA{2} = dataTmpPart2;
      if ~isempty(dataTmpPart1)
        if data.Speaker20HzA{1}.trialinfo == 156
          data.Speaker20HzA{1}.trialinfo = 28;
          data.Speaker20HzA{2}.trialinfo = 28;
        end
      end
    case 8
      data.Earphone20HzA{1} = dataTmpPart1;
      data.Earphone20HzA{2} = dataTmpPart2;
      if ~isempty(dataTmpPart1)
        if data.Earphone20HzA{1}.trialinfo == 157
          data.Earphone20HzA{1}.trialinfo = 29;
          data.Earphone20HzA{2}.trialinfo = 29;
        end
      end
    case 9
      data.Earphone2HzA{1} = dataTmpPart1;
      data.Earphone2HzA{2} = dataTmpPart2;
      if data.Earphone2HzA{1}.trialinfo == 159
        data.Earphone2HzA{1}.trialinfo = 31;
        data.Earphone2HzA{2}.trialinfo = 31;
      end
    case 10
      data.Speaker2HzA{1} = dataTmpPart1;
      data.Speaker2HzA{2} = dataTmpPart2;
      if data.Speaker2HzA{1}.trialinfo == 160
        data.Speaker2HzA{1}.trialinfo = 32;
        data.Speaker2HzA{2}.trialinfo = 32;
      end
    case 11
      data.Earphone40HzS{1} = dataTmpPart1;
      data.Earphone40HzS{2} = dataTmpPart2;
      if data.Earphone40HzS{1}.trialinfo == 169
        data.Earphone40HzS{1}.trialinfo = 41;
        data.Earphone40HzS{2}.trialinfo = 41;
      end
    case 12
      data.Speaker40HzS{1} = dataTmpPart1;
      data.Speaker40HzS{2} = dataTmpPart2;
      if data.Speaker40HzS{1}.trialinfo == 170
        data.Speaker40HzS{1}.trialinfo = 42;
        data.Speaker40HzS{2}.trialinfo = 42;
      end
    case 13
      data.Atalks2B{1} = dataTmpPart1;
      data.Atalks2B{2} = dataTmpPart2;
      if data.Atalks2B{1}.trialinfo == 179
        data.Atalks2B{1}.trialinfo = 51;
        data.Atalks2B{2}.trialinfo = 51;
      end
    case 14
      data.Btalks2A{1} = dataTmpPart1;
      data.Btalks2A{2} = dataTmpPart2;
      if data.Btalks2A{1}.trialinfo == 180
        data.Btalks2A{1}.trialinfo = 52;
        data.Btalks2A{2}.trialinfo = 52;
      end
    case 15
      data.Dialogue{1} = dataTmpPart1;
      data.Dialogue{2} = dataTmpPart2;
      if data.Dialogue{1}.trialinfo == 181
        data.Dialogue{1}.trialinfo = 53;
        data.Dialogue{2}.trialinfo = 53;
      end
    case 16
      data.SilEyesOpen{1} = dataTmpPart1;
      data.SilEyesOpen{2} = dataTmpPart2;
      if data.SilEyesOpen{1}.trialinfo == 138
        data.SilEyesOpen{1}.trialinfo = 10;
        data.SilEyesOpen{2}.trialinfo = 10;
      end
    case 17
      data.SilEyesClosed{1} = dataTmpPart1;
      data.SilEyesClosed{2} = dataTmpPart2;
      if data.SilEyesClosed{1}.trialinfo == 228
        data.SilEyesClosed{1}.trialinfo = 100;
        data.SilEyesClosed{2}.trialinfo = 100;
      end
  end
end

end
