function [ data_out ] = HSP_preprocessing( data_in, numOfPart )
%HSP_PREPROCESSING Summary of this function goes here
%   Detailed explanation goes here

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
data_out.Earphone40Hz{numOfPart}      = [];
data_out.Speaker40Hz{numOfPart}       = [];
data_out.Earphone2Hz{numOfPart}       = [];
data_out.Speaker2Hz{numOfPart}        = [];
data_out.Silence{numOfPart}           = [];
data_out.SilEyesClosed{numOfPart}     = [];
data_out.MixNoiseEarphones{numOfPart} = [];
data_out.MixNoiseSpeaker{numOfPart}   = [];
data_out.Tapping{numOfPart}           = [];
data_out.AreadsB{numOfPart}           = [];
data_out.BreadsA{numOfPart}           = [];
data_out.Dialogue{numOfPart}          = [];

% -------------------------------------------------------------------------
% Preprocessing settings
% -------------------------------------------------------------------------
cfg               = [];
cfg.feedback      = 'no';
cfg.showcallinfo  = 'no';
cfg.bpfilter      = 'yes';
cfg.bpfreq        = [0.3 48];
cfg.bpfilttype    = 'fir';

% -------------------------------------------------------------------------
% Preprocessing
% -------------------------------------------------------------------------

for i=1:1:numOfPart
  fprintf('Preproc set Earphone40Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in.Earphone40Hz{i})
    data_out.Earphone40Hz{i}      = ft_preprocessing(cfg, ...
                                      data_in.Earphone40Hz{i});
  else
    data_out.Earphone40Hz{i}      = [];
  end
  
  fprintf('Preproc set Speaker40Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in.Speaker40Hz{i})
    data_out.Speaker40Hz{i}       = ft_preprocessing(cfg, ...
                                      data_in.Speaker40Hz{i});
  else
    data_out.Speaker40Hz{i}       = [];
  end
  
  fprintf('Preproc set Earphone2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in.Earphone2Hz{i})
    data_out.Earphone2Hz{i}       = ft_preprocessing(cfg, ...
                                      data_in.Earphone2Hz{i});
  else
    data_out.Earphone2Hz{i}       = [];
  end
  
  fprintf('Preproc set Speaker2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in.Speaker2Hz{i})
    data_out.Speaker2Hz{i}        = ft_preprocessing(cfg, ...
                                      data_in.Speaker2Hz{i});
  else
    data_out.Speaker2Hz{i}        = [];
  end
  
  fprintf('Preproc set Silence of dyad %d...\n', numOfPart);
  if ~isempty(data_in.Silence{i})
    data_out.Silence{i}           = ft_preprocessing(cfg, ...
                                      data_in.Silence{i});
  else
    data_out.Silence{i}           = [];
  end
  
  fprintf('Preproc set SilEyesClosed of dyad %d...\n', numOfPart);
  if ~isempty(data_in.SilEyesClosed{i})
    data_out.SilEyesClosed{i}     = ft_preprocessing(cfg, ...
                                      data_in.SilEyesClosed{i});
  else
    data_out.SilEyesClosed{i}     = [];
  end
  
  fprintf('Preproc set MixNoiseEarphones of dyad %d...\n', numOfPart);
  if ~isempty(data_in.MixNoiseEarphones{i})
    data_out.MixNoiseEarphones{i} = ft_preprocessing(cfg, ...
                                      data_in.MixNoiseEarphones{i});
  else
    data_out.MixNoiseEarphones{i} = [];
  end
  
  fprintf('Preproc set MixNoiseSpeaker of dyad %d...\n', numOfPart);
  if ~isempty(data_in.MixNoiseSpeaker{i})
  data_out.MixNoiseSpeaker{i}     = ft_preprocessing(cfg, ...
                                      data_in.MixNoiseSpeaker{i});
  else
    data_out.MixNoiseSpeaker{i}   = [];
  end
  
  fprintf('Preproc set Tapping of dyad %d...\n', numOfPart);
  if ~isempty(data_in.Tapping{i})
    data_out.Tapping{i}           = ft_preprocessing(cfg, ...
                                      data_in.Tapping{i});
  else
    data_out.Tapping{i}           = [];
  end
  
  fprintf('Preproc set DialoguePlus2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in.DialoguePlus2Hz{i})
    data_out.DialoguePlus2Hz{i}   = ft_preprocessing(cfg, ...
                                      data_in.DialoguePlus2Hz{i});
  else
    data_out.DialoguePlus2Hz{i}   = [];
  end
    
  fprintf('Preproc set AreadsB of dyad %d...\n', numOfPart);
  if ~isempty(data_in.AreadsB{i})
    data_out.AreadsB{i}           = ft_preprocessing(cfg, ...
                                      data_in.AreadsB{i});
  else
    data_out.AreadsB{i}           = [];
  end
  
  fprintf('Preproc set BreadsA of dyad %d...\n', numOfPart);
  if ~isempty(data_in.BreadsA{i})
    data_out.BreadsA{i}           = ft_preprocessing(cfg, ...
                                      data_in.BreadsA{i});
  else
    data_out.BreadsA{i}           = [];
  end
  
  fprintf('Preproc set Dialogue of dyad %d...\n', numOfPart);
  if ~isempty(data_in.Dialogue{i})
    data_out.Dialogue{i}          = ft_preprocessing(cfg, ...
                                      data_in.Dialogue{i});
  else
    data_out.Dialogue{i}          = [];
  end
end

