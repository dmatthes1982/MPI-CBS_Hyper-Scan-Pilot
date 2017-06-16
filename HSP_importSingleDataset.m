function [ data ] = HSP_importSingleDataset( headerfile )

% -------------------------------------------------------------------------
% General definitions
% -------------------------------------------------------------------------
% definition of all possible stimuli, two for each condition, the first on 
% is the original one and the second one is a result of the'video trigger
% bug'
eventvalues = { 'S41','S169'; ...                                           % 40 Hz earphones
                'S42','S170'; ...                                           % 40 Hz speaker  
                'S21','S149'; ...                                           % 2 Hz earphones  
                'S22','S150'; ...                                           % 2 Hz speaker  
                'S10','S138'; ...                                           % silence  
                'S100','S228'; ...                                          % silence, eyes closed  
                'S31','S159'; ...                                           % mixed noise earphones 
                'S32','S160'; ...                                           % mixed noise speaker  
                'S24','S152'; ...                                           % synch finger tapping in 2 Hz, while being entrained in 2 Hz  
                'S25','S153'; ...                                           % dialogue plus 2 Hz entrainment
                'S51','S179'; ...                                           % A reads to B  
                'S52','S180'; ...                                           % B reads to A  
                'S53','S181'; ...                                           % dialogue
                };

events = ft_read_event( headerfile );                                       % Get all occured events from marker file              
events = squeeze(struct2cell(events));                                      % transform struct to cell matrix
events = events(2,:);                                                       % extract events value line
emptyCells = cellfun('isempty', events);                                    % detect empty cells
events(emptyCells) = [];                                                    % remove empty cells
events = unique(events);                                                    % remove multiple numbers                                                        

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
  
  else
    dataTmp = [];
  end
  
  switch i                                                                  % allocate data to substructures and correct false stimulus numbers
    case 1
      data.Earphone40Hz = dataTmp;
      if data.Earphone40Hz.trialinfo == 169
        data.Earphone40Hz.trialinfo = 41;
      end
    case 2
      data.Speaker40Hz = dataTmp;
      if data.Speaker40Hz.trialinfo == 170
        data.Speaker40Hz.trialinfo = 42;
      end
    case 3
      data.Earphone2Hz = dataTmp;
      if data.Earphone2Hz.trialinfo == 149
        data.Earphone2Hz.trialinfo = 21;
      end
    case 4
      data.Speaker2Hz = dataTmp;
      if data.Speaker2Hz.trialinfo == 150
        data.Speaker2Hz.trialinfo = 22;
      end
    case 5
      data.Silence = dataTmp;
      if data.Silence.trialinfo == 138
        data.Silence.trialinfo = 10;
      end
    case 6
      data.SilEyesClosed = dataTmp;
      if data.SilEyesClosed.trialinfo == 228
        data.SilEyesClosed.trialinfo = 100;
      end
    case 7
      data.MixNoiseEarphones = dataTmp;
      if data.MixNoiseEarphones.trialinfo == 159
        data.MixNoiseEarphones.trialinfo = 31;
      end
    case 8
      data.MixNoiseSpeaker = dataTmp;
      if data.MixNoiseSpeaker.trialinfo == 160
        data.MixNoiseSpeaker.trialinfo = 32;
      end
    case 9
      data.Tapping = dataTmp;
      if data.Tapping.trialinfo == 152
        data.Tapping.trialinfo = 24;
      end
    case 10
      data.DialoguePlus2Hz = dataTmp;
      if ~isempty(dataTmp)
        if data.DialoguePlus2Hz.trialinfo == 153
          data.DialoguePlus2Hz.trialinfo = 25;
        end
      end
    case 11
      data.AreadsB = dataTmp;
      if data.AreadsB.trialinfo == 179
        data.AreadsB.trialinfo = 51;
      end
    case 12
      data.BreadsA = dataTmp;
      if data.BreadsA.trialinfo == 180
        data.BreadsA.trialinfo = 52;
      end
    case 13
      data.Dialogue = dataTmp;
      if data.Dialogue.trialinfo == 181
        data.Dialogue.trialinfo = 53;
      end
  end
end

end
