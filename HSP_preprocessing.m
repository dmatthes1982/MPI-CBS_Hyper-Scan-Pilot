function [ data_out ] = HSP_preprocessing( data_in, numOfPart )
%HSP_PREPROCESSING Summary of this function goes here
%   Detailed explanation goes here

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
data_out(numOfPart).Earphone40Hz      = [];
data_out(numOfPart).Speaker40Hz       = [];
data_out(numOfPart).Earphone2Hz       = [];
data_out(numOfPart).Speaker2Hz        = [];
data_out(numOfPart).Silence           = [];
data_out(numOfPart).SilEyesClosed     = [];
data_out(numOfPart).MixNoiseEarphones = [];
data_out(numOfPart).MixNoiseSpeaker   = [];
data_out(numOfPart).Tapping           = [];
data_out(numOfPart).AreadsB           = [];
data_out(numOfPart).BreadsA           = [];
data_out(numOfPart).Dialogue          = [];

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

parfor i=1:1:numOfPart
  fprintf('Preproc set Earphone40Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).Earphone40Hz)
    data_out(i).Earphone40Hz      = ft_preprocessing(cfg, ...
                                      data_in(i).Earphone40Hz);
  else
    data_out(i).Earphone40Hz      = [];
  end
  
  fprintf('Preproc set Speaker40Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).Speaker40Hz)
    data_out(i).Speaker40Hz       = ft_preprocessing(cfg, ...
                                      data_in(i).Speaker40Hz);
  else
    data_out(i).Speaker40Hz       = [];
  end
  
  fprintf('Preproc set Earphone2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).Earphone2Hz)
    data_out(i).Earphone2Hz       = ft_preprocessing(cfg, ...
                                      data_in(i).Earphone2Hz);
  else
    data_out(i).Earphone2Hz       = [];
  end
  
  fprintf('Preproc set Speaker2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).Speaker2Hz)
    data_out(i).Speaker2Hz        = ft_preprocessing(cfg, ...
                                      data_in(i).Speaker2Hz);
  else
    data_out(i).Speaker2Hz        = [];
  end
  
  fprintf('Preproc set Silence of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).Silence)
    data_out(i).Silence           = ft_preprocessing(cfg, ...
                                      data_in(i).Silence);
  else
    data_out(i).Silence           = [];
  end
  
  fprintf('Preproc set SilEyesClosed of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).SilEyesClosed)
    data_out(i).SilEyesClosed     = ft_preprocessing(cfg, ...
                                      data_in(i).SilEyesClosed);
  else
    data_out(i).SilEyesClosed     = [];
  end
  
  fprintf('Preproc set MixNoiseEarphones of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).MixNoiseEarphones)
    data_out(i).MixNoiseEarphones = ft_preprocessing(cfg, ...
                                      data_in(i).MixNoiseEarphones);
  else
    data_out(i).MixNoiseEarphones = [];
  end
  
  fprintf('Preproc set MixNoiseSpeaker of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).MixNoiseSpeaker)
    data_out(i).MixNoiseSpeaker     = ft_preprocessing(cfg, ...
                                      data_in(i).MixNoiseSpeaker);
  else
    data_out(i).MixNoiseSpeaker   = [];
  end
  
  fprintf('Preproc set Tapping of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).Tapping)
    data_out(i).Tapping           = ft_preprocessing(cfg, ...
                                      data_in(i).Tapping);
  else
    data_out(i).Tapping           = [];
  end
  
  fprintf('Preproc set DialoguePlus2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).DialoguePlus2Hz)
    data_out(i).DialoguePlus2Hz   = ft_preprocessing(cfg, ...
                                      data_in(i).DialoguePlus2Hz);
  else
    data_out(i).DialoguePlus2Hz   = [];
  end
    
  fprintf('Preproc set AreadsB of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).AreadsB)
    data_out(i).AreadsB           = ft_preprocessing(cfg, ...
                                      data_in(i).AreadsB);
  else
    data_out(i).AreadsB           = [];
  end
  
  fprintf('Preproc set BreadsA of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).BreadsA)
    data_out(i).BreadsA           = ft_preprocessing(cfg, ...
                                      data_in(i).BreadsA);
  else
    data_out(i).BreadsA           = [];
  end
  
  fprintf('Preproc set Dialogue of dyad %d...\n', numOfPart);
  if ~isempty(data_in(i).Dialogue)
    data_out(i).Dialogue          = ft_preprocessing(cfg, ...
                                      data_in(i).Dialogue);
  else
    data_out(i).Dialogue          = [];
  end
end

