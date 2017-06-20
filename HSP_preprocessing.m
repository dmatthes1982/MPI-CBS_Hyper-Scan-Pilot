function [ data ] = HSP_preprocessing( cfg, data )
% HSP_PREPROCESSING does the preprocessing of the raw data. This function
% will be applied to the whole hyperscanning pilot project dataset.
%
% Use as
%   [ data ] = HSP_preprocessing(cfg, data)
%
% where the input data have to be the result from HSP_IMPORTALLDATASETS
%
% The configuration options are
%   cfg.bpfreq = passband range [begin end] (default: [0.3 48])
%
% Currently this function applies only a bandpass filter to the data.
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_IMPORTALLDATASETS, FT_PREPROCESSING

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
bpfreq = ft_getopt(cfg, 'bpfreq', [0.3 48]);

numOfPart = size(data, 2);

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
cfg.bpfilter      = 'yes';                                                  % use bandpass filter
cfg.bpfreq        = bpfreq;                                                 % bandpass range  
cfg.bpfilttype    = 'fir';                                                  % bandpass filter type = fir      

% -------------------------------------------------------------------------
% Preprocessing
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Preproc set Earphone40Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Earphone40Hz)
    data_out(i).Earphone40Hz      = ft_preprocessing(cfg, ...
                                      data(i).Earphone40Hz);
  else
    data_out(i).Earphone40Hz      = [];
  end
  
  fprintf('Preproc set Speaker40Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Speaker40Hz)
    data_out(i).Speaker40Hz       = ft_preprocessing(cfg, ...
                                      data(i).Speaker40Hz);
  else
    data_out(i).Speaker40Hz       = [];
  end
  
  fprintf('Preproc set Earphone2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Earphone2Hz)
    data_out(i).Earphone2Hz       = ft_preprocessing(cfg, ...
                                      data(i).Earphone2Hz);
  else
    data_out(i).Earphone2Hz       = [];
  end
  
  fprintf('Preproc set Speaker2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Speaker2Hz)
    data_out(i).Speaker2Hz        = ft_preprocessing(cfg, ...
                                      data(i).Speaker2Hz);
  else
    data_out(i).Speaker2Hz        = [];
  end
  
  fprintf('Preproc set Silence of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Silence)
    data_out(i).Silence           = ft_preprocessing(cfg, ...
                                      data(i).Silence);
  else
    data_out(i).Silence           = [];
  end
  
  fprintf('Preproc set SilEyesClosed of dyad %d...\n', numOfPart);
  if ~isempty(data(i).SilEyesClosed)
    data_out(i).SilEyesClosed     = ft_preprocessing(cfg, ...
                                      data(i).SilEyesClosed);
  else
    data_out(i).SilEyesClosed     = [];
  end
  
  fprintf('Preproc set MixNoiseEarphones of dyad %d...\n', numOfPart);
  if ~isempty(data(i).MixNoiseEarphones)
    data_out(i).MixNoiseEarphones = ft_preprocessing(cfg, ...
                                      data(i).MixNoiseEarphones);
  else
    data_out(i).MixNoiseEarphones = [];
  end
  
  fprintf('Preproc set MixNoiseSpeaker of dyad %d...\n', numOfPart);
  if ~isempty(data(i).MixNoiseSpeaker)
    data_out(i).MixNoiseSpeaker     = ft_preprocessing(cfg, ...
                                      data(i).MixNoiseSpeaker);
  else
    data_out(i).MixNoiseSpeaker   = [];
  end
  
  fprintf('Preproc set Tapping of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Tapping)
    data_out(i).Tapping           = ft_preprocessing(cfg, ...
                                      data(i).Tapping);
  else
    data_out(i).Tapping           = [];
  end
  
  fprintf('Preproc set DialoguePlus2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).DialoguePlus2Hz)
    data_out(i).DialoguePlus2Hz   = ft_preprocessing(cfg, ...
                                      data(i).DialoguePlus2Hz);
  else
    data_out(i).DialoguePlus2Hz   = [];
  end
    
  fprintf('Preproc set AreadsB of dyad %d...\n', numOfPart);
  if ~isempty(data(i).AreadsB)
    data_out(i).AreadsB           = ft_preprocessing(cfg, ...
                                      data(i).AreadsB);
  else
    data_out(i).AreadsB           = [];
  end
  
  fprintf('Preproc set BreadsA of dyad %d...\n', numOfPart);
  if ~isempty(data(i).BreadsA)
    data_out(i).BreadsA           = ft_preprocessing(cfg, ...
                                      data(i).BreadsA);
  else
    data_out(i).BreadsA           = [];
  end
  
  fprintf('Preproc set Dialogue of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Dialogue)
    data_out(i).Dialogue          = ft_preprocessing(cfg, ...
                                      data(i).Dialogue);
  else
    data_out(i).Dialogue          = [];
  end
end

data = data_out;

end
