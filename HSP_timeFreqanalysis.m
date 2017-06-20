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
% Time-Frequency Response (Analysis)
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Calc TFR of set Earphone40Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Earphone40Hz)
    data_out(i).Earphone40Hz      = HSP_calcTFR(cfg,...
                                      data(i).Earphone40Hz);
  else
    data_out(i).Earphone40Hz      = [];
  end
  
  fprintf('Calc TFR of set Speaker40Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Speaker40Hz)
    data_out(i).Speaker40Hz       = HSP_calcTFR(cfg,...
                                      data(i).Speaker40Hz);
  else
    data_out(i).Speaker40Hz       = [];
  end
  
  fprintf('Calc TFR of set Earphone2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Earphone2Hz)
    data_out(i).Earphone2Hz       = HSP_calcTFR(cfg,...
                                      data(i).Earphone2Hz);
  else
    data_out(i).Earphone2Hz       = [];
  end
  
  fprintf('Calc TFR of set Speaker2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Speaker2Hz)
    data_out(i).Speaker2Hz        = HSP_calcTFR(cfg,...
                                      data(i).Speaker2Hz);
  else
    data_out(i).Speaker2Hz        = [];
  end
  
  fprintf('Calc TFR of set Silence of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Silence)
    data_out(i).Silence           = HSP_calcTFR(cfg,...
                                      data(i).Silence);
  else
    data_out(i).Silence           = [];
  end
  
  fprintf('Calc TFR of set SilEyesClosed of dyad %d...\n', numOfPart);
  if ~isempty(data(i).SilEyesClosed)
    data_out(i).SilEyesClosed     = HSP_calcTFR(cfg,...
                                      data(i).SilEyesClosed);
  else
    data_out(i).SilEyesClosed     = [];
  end
  
  fprintf('Calc TFR of set MixNoiseEarphones of dyad %d...\n', numOfPart);
  if ~isempty(data(i).MixNoiseEarphones)
    data_out(i).MixNoiseEarphones = HSP_calcTFR(cfg,...
                                      data(i).MixNoiseEarphones);
  else
    data_out(i).MixNoiseEarphones = [];
  end
  
  fprintf('Calc TFR of set MixNoiseSpeaker of dyad %d...\n', numOfPart);
  if ~isempty(data(i).MixNoiseSpeaker)
    data_out(i).MixNoiseSpeaker     = HSP_calcTFR(cfg,...
                                      data(i).MixNoiseSpeaker);
  else
    data_out(i).MixNoiseSpeaker   = [];
  end
  
  fprintf('Calc TFR of set Tapping of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Tapping)
    data_out(i).Tapping           = HSP_calcTFR(cfg,...
                                      data(i).Tapping);
  else
    data_out(i).Tapping           = [];
  end
  
  fprintf('Calc TFR of set DialoguePlus2Hz of dyad %d...\n', numOfPart);
  if ~isempty(data(i).DialoguePlus2Hz)
    data_out(i).DialoguePlus2Hz   = HSP_calcTFR(cfg,...
                                      data(i).DialoguePlus2Hz);
  else
    data_out(i).DialoguePlus2Hz   = [];
  end
    
  fprintf('Calc TFR of set AreadsB of dyad %d...\n', numOfPart);
  if ~isempty(data(i).AreadsB)
    data_out(i).AreadsB           = HSP_calcTFR(cfg,...
                                      data(i).AreadsB);
  else
    data_out(i).AreadsB           = [];
  end
  
  fprintf('Calc TFR of set BreadsA of dyad %d...\n', numOfPart);
  if ~isempty(data(i).BreadsA)
    data_out(i).BreadsA           = HSP_calcTFR(cfg,...
                                      data(i).BreadsA);
  else
    data_out(i).BreadsA           = [];
  end
  
  fprintf('Calc TFR of set Dialogue of dyad %d...\n', numOfPart);
  if ~isempty(data(i).Dialogue)
    data_out(i).Dialogue          = HSP_calcTFR(cfg,...
                                      data(i).Dialogue);
  else
    data_out(i).Dialogue          = [];
  end
end

data = data_out;

end

