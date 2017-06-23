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
data_out(numOfPart) = struct;

% -------------------------------------------------------------------------
% Preprocessing settings
% -------------------------------------------------------------------------
cfg               = [];
cfg.feedback      = 'no';                                                   % feedback should not be presented
cfg.showcallinfo  = 'no';                                                   % prevent printing the time and memory after each function call

% re-referencing to TP10
cfg.reref         = 'yes';                                                  % enable re-referencing
cfg.refchannel    = {'TP10'};                                               % select 'TP10' as new reference  
cfg.refmethod     = 'avg';                                                  % average over selected electrodes (in our case insignificant)

% general filtering
cfg.bpfilter      = 'yes';                                                  % use bandpass filter
cfg.bpfreq        = bpfreq;                                                 % bandpass range  
cfg.bpfilttype    = 'fir';                                                  % bandpass filter type = fir      

% -------------------------------------------------------------------------
% Preprocessing
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Preproc set Earphone40Hz of dyad %d...\n', i);
  if ~isempty(data(i).Earphone40Hz{1})
    data_out(i).Earphone40Hz{1}      = ft_preprocessing(cfg, ...
                                        data(i).Earphone40Hz{1});
    data_out(i).Earphone40Hz{2}      = ft_preprocessing(cfg, ...
                                        data(i).Earphone40Hz{2});
  else
    data_out(i).Earphone40Hz{2}      = [];
  end
  
  fprintf('Preproc set Speaker40Hz of dyad %d...\n', i);
  if ~isempty(data(i).Speaker40Hz{1})
    data_out(i).Speaker40Hz{1}       = ft_preprocessing(cfg, ...
                                        data(i).Speaker40Hz{1});
    data_out(i).Speaker40Hz{2}       = ft_preprocessing(cfg, ...
                                        data(i).Speaker40Hz{2});
  else
    data_out(i).Speaker40Hz{2}       = [];
  end
  
  fprintf('Preproc set Earphone2Hz of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2Hz{1})
    data_out(i).Earphone2Hz{1}       = ft_preprocessing(cfg, ...
                                        data(i).Earphone2Hz{1});
    data_out(i).Earphone2Hz{2}       = ft_preprocessing(cfg, ...
                                        data(i).Earphone2Hz{2});
  else
    data_out(i).Earphone2Hz{2}       = [];
  end
  
  fprintf('Preproc set Speaker2Hz of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2Hz{1})
    data_out(i).Speaker2Hz{1}        = ft_preprocessing(cfg, ...
                                        data(i).Speaker2Hz{1});
    data_out(i).Speaker2Hz{2}        = ft_preprocessing(cfg, ...
                                        data(i).Speaker2Hz{2});
  else
    data_out(i).Speaker2Hz{2}        = [];
  end
  
  fprintf('Preproc set Silence of dyad %d...\n', i);
  if ~isempty(data(i).Silence{1})
    data_out(i).Silence{1}           = ft_preprocessing(cfg, ...
                                        data(i).Silence{1});
    data_out(i).Silence{2}           = ft_preprocessing(cfg, ...
                                        data(i).Silence{2});
  else
    data_out(i).Silence{2}           = [];
  end
  
  fprintf('Preproc set SilEyesClosed of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesClosed{1})
    data_out(i).SilEyesClosed{1}     = ft_preprocessing(cfg, ...
                                        data(i).SilEyesClosed{1});
    data_out(i).SilEyesClosed{2}     = ft_preprocessing(cfg, ...
                                        data(i).SilEyesClosed{2});
  else
    data_out(i).SilEyesClosed{2}     = [];
  end
  
  fprintf('Preproc set MixNoiseEarphones of dyad %d...\n', i);
  if ~isempty(data(i).MixNoiseEarphones{1})
    data_out(i).MixNoiseEarphones{1} = ft_preprocessing(cfg, ...
                                        data(i).MixNoiseEarphones{1});
    data_out(i).MixNoiseEarphones{2} = ft_preprocessing(cfg, ...
                                        data(i).MixNoiseEarphones{2});
  else
    data_out(i).MixNoiseEarphones{2} = [];
  end
  
  fprintf('Preproc set MixNoiseSpeaker of dyad %d...\n', i);
  if ~isempty(data(i).MixNoiseSpeaker{1})
    data_out(i).MixNoiseSpeaker{1}   = ft_preprocessing(cfg, ...
                                        data(i).MixNoiseSpeaker{1});
    data_out(i).MixNoiseSpeaker{2}   = ft_preprocessing(cfg, ...
                                        data(i).MixNoiseSpeaker{2});
  else
    data_out(i).MixNoiseSpeaker{2}   = [];
  end
  
  fprintf('Preproc set Tapping of dyad %d...\n', i);
  if ~isempty(data(i).Tapping{1})
    data_out(i).Tapping{1}           = ft_preprocessing(cfg, ...
                                        data(i).Tapping{1});
    data_out(i).Tapping{2}           = ft_preprocessing(cfg, ...
                                        data(i).Tapping{2});
  else
    data_out(i).Tapping{2}           = [];
  end
  
  fprintf('Preproc set DialoguePlus2Hz of dyad %d...\n', i);
  if ~isempty(data(i).DialoguePlus2Hz{1})
    data_out(i).DialoguePlus2Hz{1}   = ft_preprocessing(cfg, ...
                                        data(i).DialoguePlus2Hz{1});
    data_out(i).DialoguePlus2Hz{2}   = ft_preprocessing(cfg, ...
                                        data(i).DialoguePlus2Hz{2});
  else
    data_out(i).DialoguePlus2Hz{2}   = [];
  end
    
  fprintf('Preproc set AreadsB of dyad %d...\n', i);
  if ~isempty(data(i).AreadsB{1})
    data_out(i).AreadsB{1}           = ft_preprocessing(cfg, ...
                                        data(i).AreadsB{1});
    data_out(i).AreadsB{2}           = ft_preprocessing(cfg, ...
                                        data(i).AreadsB{2});
  else
    data_out(i).AreadsB {2}          = [];
  end
  
  fprintf('Preproc set BreadsA of dyad %d...\n', i);
  if ~isempty(data(i).BreadsA{1})
    data_out(i).BreadsA{1}           = ft_preprocessing(cfg, ...
                                        data(i).BreadsA{1});
    data_out(i).BreadsA {2}          = ft_preprocessing(cfg, ...
                                        data(i).BreadsA{2});
  else
    data_out(i).BreadsA{2}           = [];
  end
  
  fprintf('Preproc set Dialogue of dyad %d...\n', i);
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
