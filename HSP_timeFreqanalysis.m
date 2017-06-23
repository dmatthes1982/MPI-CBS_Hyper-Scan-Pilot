function [ data ] = HSP_timeFreqanalysis( cfg, data )
% HSP_TIMEFREQANALYSIS performs a time frequency analysis on the whole
% hyperscanning pilot project dataset.
%
% Use as
%   [ data ] = HSP_timeFreqanalysis(cfg, data)
%
% where the input data have to be the result from HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION
%
% The configuration options are
%   config.foi = frequency of interest - begin:resolution:end (default: 2:1:50)
%   config.toi = time of interest - begin:resolution:end (default: 4:0.5:176)
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, HSP_SEGMENTATION, HSP_CALCTFR

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
cfg.foi = ft_getopt(cfg, 'foi', 2:1:50);
cfg.toi = ft_getopt(cfg, 'toi', 4:0.5:176);

numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
data_out(numOfPart) = struct;

% -------------------------------------------------------------------------
% Time-Frequency Response (Analysis)
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Calc TFR of set Earphone40Hz of dyad %d...\n', i);
  if ~isempty(data(i).Earphone40Hz{1})
    data_out(i).Earphone40Hz{1}      = HSP_calcTFR(cfg,...
                                        data(i).Earphone40Hz{1});
    data_out(i).Earphone40Hz{2}      = HSP_calcTFR(cfg,...
                                        data(i).Earphone40Hz{2});                                  
  else
    data_out(i).Earphone40Hz{2}      = [];
  end
  
  fprintf('Calc TFR of set Speaker40Hz of dyad %d...\n', i);
  if ~isempty(data(i).Speaker40Hz{1})
    data_out(i).Speaker40Hz{1}       = HSP_calcTFR(cfg,...
                                        data(i).Speaker40Hz{1});
    data_out(i).Speaker40Hz{2}       = HSP_calcTFR(cfg,...
                                        data(i).Speaker40Hz{2});                                  
  else
    data_out(i).Speaker40Hz{2}       = [];
  end
  
  fprintf('Calc TFR of set Earphone2Hz of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2Hz{1})
    data_out(i).Earphone2Hz{1}       = HSP_calcTFR(cfg,...
                                        data(i).Earphone2Hz{1});
    data_out(i).Earphone2Hz{2}       = HSP_calcTFR(cfg,...
                                        data(i).Earphone2Hz{2});                                  
  else
    data_out(i).Earphone2Hz{2}       = [];
  end
  
  fprintf('Calc TFR of set Speaker2Hz of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2Hz{1})
    data_out(i).Speaker2Hz{1}        = HSP_calcTFR(cfg,...
                                        data(i).Speaker2Hz{1});
    data_out(i).Speaker2Hz{2}        = HSP_calcTFR(cfg,...
                                        data(i).Speaker2Hz{2});                                  
  else
    data_out(i).Speaker2Hz{2}        = [];
  end
  
  fprintf('Calc TFR of set Silence of dyad %d...\n', i);
  if ~isempty(data(i).Silence{1})
    data_out(i).Silence{1}           = HSP_calcTFR(cfg,...
                                        data(i).Silence{1});
    data_out(i).Silence{2}           = HSP_calcTFR(cfg,...
                                        data(i).Silence{2});                                  
  else
    data_out(i).Silence{2}           = [];
  end
  
  fprintf('Calc TFR of set SilEyesClosed of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesClosed{1})
    data_out(i).SilEyesClosed{1}     = HSP_calcTFR(cfg,...
                                        data(i).SilEyesClosed{1});
    data_out(i).SilEyesClosed{2}     = HSP_calcTFR(cfg,...
                                        data(i).SilEyesClosed{2});                                  
  else
    data_out(i).SilEyesClosed{2}     = [];
  end
  
  fprintf('Calc TFR of set MixNoiseEarphones of dyad %d...\n', i);
  if ~isempty(data(i).MixNoiseEarphones{1})
    data_out(i).MixNoiseEarphones{1} = HSP_calcTFR(cfg,...
                                        data(i).MixNoiseEarphones{1});
    data_out(i).MixNoiseEarphones{2} = HSP_calcTFR(cfg,...
                                        data(i).MixNoiseEarphones{2});                                  
  else
    data_out(i).MixNoiseEarphones{2} = [];
  end
  
  fprintf('Calc TFR of set MixNoiseSpeaker of dyad %d...\n', i);
  if ~isempty(data(i).MixNoiseSpeaker{1})
    data_out(i).MixNoiseSpeaker{1}     = HSP_calcTFR(cfg,...
                                        data(i).MixNoiseSpeaker{1});
    data_out(i).MixNoiseSpeaker{2}     = HSP_calcTFR(cfg,...
                                        data(i).MixNoiseSpeaker{2});                                  
  else
    data_out(i).MixNoiseSpeaker{2}   = [];
  end
  
  fprintf('Calc TFR of set Tapping of dyad %d...\n', i);
  if ~isempty(data(i).Tapping{1})
    data_out(i).Tapping{1}           = HSP_calcTFR(cfg,...
                                        data(i).Tapping{1});
    data_out(i).Tapping{2}           = HSP_calcTFR(cfg,...
                                        data(i).Tapping{2});                                  
  else
    data_out(i).Tapping{2}           = [];
  end
  
  fprintf('Calc TFR of set DialoguePlus2Hz of dyad %d...\n', i);
  if ~isempty(data(i).DialoguePlus2Hz{1})
    data_out(i).DialoguePlus2Hz{1}   = HSP_calcTFR(cfg,...
                                        data(i).DialoguePlus2Hz{1});
    data_out(i).DialoguePlus2Hz{2}   = HSP_calcTFR(cfg,...
                                        data(i).DialoguePlus2Hz{2});                                  
  else
    data_out(i).DialoguePlus2Hz{2}   = [];
  end
    
  fprintf('Calc TFR of set AreadsB of dyad %d...\n', i);
  if ~isempty(data(i).AreadsB{1})
    data_out(i).AreadsB{1}           = HSP_calcTFR(cfg,...
                                        data(i).AreadsB{1});
    data_out(i).AreadsB{2}           = HSP_calcTFR(cfg,...
                                        data(i).AreadsB{2});                                  
  else
    data_out(i).AreadsB{2}           = [];
  end
  
  fprintf('Calc TFR of set BreadsA of dyad %d...\n', i);
  if ~isempty(data(i).BreadsA{1})
    data_out(i).BreadsA{1}           = HSP_calcTFR(cfg,...
                                        data(i).BreadsA{1});
    data_out(i).BreadsA{2}           = HSP_calcTFR(cfg,...
                                        data(i).BreadsA{2});                                  
  else
    data_out(i).BreadsA{2}           = [];
  end
  
  fprintf('Calc TFR of set Dialogue of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue{1})
    data_out(i).Dialogue{1}          = HSP_calcTFR(cfg,...
                                        data(i).Dialogue{1});
    data_out(i).Dialogue{2}          = HSP_calcTFR(cfg,...
                                        data(i).Dialogue{2});                                  
  else
    data_out(i).Dialogue{2}          = [];
  end
end

data = data_out;

end

