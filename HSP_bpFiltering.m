function [ data ] = HSP_bpFiltering( cfg, data) 
% HSP_BPFILTERING applies a specific bandpass filter to every channel in
% the HSP_DATASTRUCTURE
%
% Use as
%     [ data ] = HSP_bpFiltering( cfg, data)
%
% where the input data have to be the result from HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION 
%
% The configuration options are
%   cfg.bpfreq      = passband range [begin end] (default: [1.9 2.1])
%   cfg.fixorder    = use a bandpass with a fixed order (default: true)
%
% This function is configured with a fixed filter order, to generate
% comparable filter charakteristics for every operating point.
%
% This function requires the fieldtrip toolbox
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, HSP_SEGMENTATION, 
% HSP_DATASTRUCTURE, FT_PREPROCESSING

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
bpfreq    = ft_getopt(cfg, 'bpfreq', [1.9 2.1]);
fixorder  = ft_getopt(cfg, 'fixorder', true);

numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
data_out(numOfPart) = struct;

cfg                 = [];
cfg.trials          = 'all';                                                % apply bandpass to all trials
cfg.channel         = 'all';                                                % apply bandpass to every channel
cfg.bpfilter        = 'yes';
cfg.bpfilttype      = 'fir';                                                % use a simple fir
cfg.bpfreq          = bpfreq;                                               % define bandwith
cfg.feedback        = 'no';                                                 % suppress feedback output
cfg.showcallinfo    = 'no';                                                 % suppress function call output

if fixorder == true
  cfg.bpfiltord     = fix(90/(bpfreq(2) - bpfreq(1)));                      % filter order depends on the bandwith
end

centerFreq = (bpfreq(2) + bpfreq(1))/2;

% -------------------------------------------------------------------------
% Preprocessing
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Apply bandpass to set Earphone40Hz of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).Earphone40Hz{1})
    data_out(i).Earphone40Hz{1}      = ft_preprocessing(cfg, ...
                                        data(i).Earphone40Hz{1});
    data_out(i).Earphone40Hz{2}      = ft_preprocessing(cfg, ...
                                        data(i).Earphone40Hz{2});
  else
    data_out(i).Earphone40Hz{2}      = [];
  end
  
  fprintf('Apply bandpass to set Speaker40Hz of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).Speaker40Hz{1})
    data_out(i).Speaker40Hz{1}       = ft_preprocessing(cfg, ...
                                        data(i).Speaker40Hz{1});
    data_out(i).Speaker40Hz{2}       = ft_preprocessing(cfg, ...
                                        data(i).Speaker40Hz{2});
  else
    data_out(i).Speaker40Hz{2}       = [];
  end
  
  fprintf('Apply bandpass to set Earphone2Hz of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).Earphone2Hz{1})
    data_out(i).Earphone2Hz{1}       = ft_preprocessing(cfg, ...
                                        data(i).Earphone2Hz{1});
    data_out(i).Earphone2Hz{2}       = ft_preprocessing(cfg, ...
                                        data(i).Earphone2Hz{2});
  else
    data_out(i).Earphone2Hz{2}       = [];
  end
  
  fprintf('Apply bandpass to set Speaker2Hz of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).Speaker2Hz{1})
    data_out(i).Speaker2Hz{1}        = ft_preprocessing(cfg, ...
                                        data(i).Speaker2Hz{1});
    data_out(i).Speaker2Hz{2}        = ft_preprocessing(cfg, ...
                                        data(i).Speaker2Hz{2});
  else
    data_out(i).Speaker2Hz{2}        = [];
  end
  
  fprintf('Apply bandpass to set Silence of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).Silence{1})
    data_out(i).Silence{1}           = ft_preprocessing(cfg, ...
                                        data(i).Silence{1});
    data_out(i).Silence{2}           = ft_preprocessing(cfg, ...
                                        data(i).Silence{2});
  else
    data_out(i).Silence{2}           = [];
  end
  
  fprintf('Apply bandpass to set SilEyesClosed of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).SilEyesClosed{1})
    data_out(i).SilEyesClosed{1}     = ft_preprocessing(cfg, ...
                                        data(i).SilEyesClosed{1});
    data_out(i).SilEyesClosed{2}     = ft_preprocessing(cfg, ...
                                        data(i).SilEyesClosed{2});
  else
    data_out(i).SilEyesClosed{2}     = [];
  end
  
  fprintf('Apply bandpass to set MixNoiseEarphones of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).MixNoiseEarphones{1})
    data_out(i).MixNoiseEarphones{1} = ft_preprocessing(cfg, ...
                                        data(i).MixNoiseEarphones{1});
    data_out(i).MixNoiseEarphones{2} = ft_preprocessing(cfg, ...
                                        data(i).MixNoiseEarphones{2});
  else
    data_out(i).MixNoiseEarphones{2} = [];
  end
  
  fprintf('Apply bandpass to set MixNoiseSpeaker of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).MixNoiseSpeaker{1})
    data_out(i).MixNoiseSpeaker{1}   = ft_preprocessing(cfg, ...
                                        data(i).MixNoiseSpeaker{1});
    data_out(i).MixNoiseSpeaker{2}   = ft_preprocessing(cfg, ...
                                        data(i).MixNoiseSpeaker{2});
  else
    data_out(i).MixNoiseSpeaker{2}   = [];
  end
  
  fprintf('Apply bandpass to set Tapping of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).Tapping{1})
    data_out(i).Tapping{1}           = ft_preprocessing(cfg, ...
                                        data(i).Tapping{1});
    data_out(i).Tapping{2}           = ft_preprocessing(cfg, ...
                                        data(i).Tapping{2});
  else
    data_out(i).Tapping{2}           = [];
  end
  
  fprintf('Apply bandpass to set DialoguePlus2Hz of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).DialoguePlus2Hz{1})
    data_out(i).DialoguePlus2Hz{1}   = ft_preprocessing(cfg, ...
                                        data(i).DialoguePlus2Hz{1});
    data_out(i).DialoguePlus2Hz{2}   = ft_preprocessing(cfg, ...
                                        data(i).DialoguePlus2Hz{2});
  else
    data_out(i).DialoguePlus2Hz{2}   = [];
  end
    
  fprintf('Apply bandpass to set AreadsB of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).AreadsB{1})
    data_out(i).AreadsB{1}           = ft_preprocessing(cfg, ...
                                        data(i).AreadsB{1});
    data_out(i).AreadsB{2}           = ft_preprocessing(cfg, ...
                                        data(i).AreadsB{2});
  else
    data_out(i).AreadsB {2}          = [];
  end
  
  fprintf('Apply bandpass to set BreadsA of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).BreadsA{1})
    data_out(i).BreadsA{1}           = ft_preprocessing(cfg, ...
                                        data(i).BreadsA{1});
    data_out(i).BreadsA {2}          = ft_preprocessing(cfg, ...
                                        data(i).BreadsA{2});
  else
    data_out(i).BreadsA{2}           = [];
  end
  
  fprintf('Apply bandpass to set Dialogue of dyad %d with a center frequency of %d Hz...\n', ...
          i, centerFreq);
  if ~isempty(data(i).Dialogue{1})
    data_out(i).Dialogue{1}          = ft_preprocessing(cfg, ...
                                        data(i).Dialogue{1});
    data_out(i).Dialogue{2}          = ft_preprocessing(cfg, ...
                                        data(i).Dialogue{2});
  else
    data_out(i).Dialogue{2}          = [];
  end
end

data = data_out;

end

