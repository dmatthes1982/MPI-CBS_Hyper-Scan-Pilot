function [ data ] = HSP_segmentation( data )
% HSP_SEGMENTATION segments the data of each condition into segments with a
% duration of 5 seconds
%
% Use as
%   [ data ] = HSP_segmentation(data)
%
% where the input data can be the result from HSP_IMPORTALLDATASETS or
% HSP_PREPROCESSING
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, FT_REDEFINETRIAL

% Copyright (C) 2017, Daniel Matthes, MPI CBS


% -------------------------------------------------------------------------
% Get number of participants
% -------------------------------------------------------------------------
numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
data_out(numOfPart) = struct;

% -------------------------------------------------------------------------
% Segmentation settings
% -------------------------------------------------------------------------
cfg                 = [];
cfg.feedback        = 'no';
cfg.showcallinfo    = 'no';
cfg.trials          = 'all';                                                  
cfg.length          = 5;                                                    % segmentation into 5 seconds long segments
cfg.overlap         = 0;                                                    % no overlap

% -------------------------------------------------------------------------
% Segmentation
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  ft_info off;
  fprintf('Segment set Earphone40Hz of dyad %d...\n', i);
  if ~isempty(data(i).Earphone40Hz{1})
    data_out(i).Earphone40Hz{1}      = ft_redefinetrial(cfg, ...
                                        data(i).Earphone40Hz{1});
    data_out(i).Earphone40Hz{2}      = ft_redefinetrial(cfg, ...
                                        data(i).Earphone40Hz{2});
  else
    data_out(i).Earphone40Hz{2}      = [];
  end
  
  fprintf('Segment set Speaker40Hz of dyad %d...\n', i);
  if ~isempty(data(i).Speaker40Hz{1})
    data_out(i).Speaker40Hz{1}       = ft_redefinetrial(cfg, ...
                                        data(i).Speaker40Hz{1});
    data_out(i).Speaker40Hz{2}       = ft_redefinetrial(cfg, ...
                                        data(i).Speaker40Hz{2});
  else
    data_out(i).Speaker40Hz{2}       = [];
  end
  
  fprintf('Segment set Earphone2Hz of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2Hz{1})
    data_out(i).Earphone2Hz{1}       = ft_redefinetrial(cfg, ...
                                        data(i).Earphone2Hz{1});
    data_out(i).Earphone2Hz{2}       = ft_redefinetrial(cfg, ...
                                        data(i).Earphone2Hz{2});
  else
    data_out(i).Earphone2Hz{2}       = [];
  end
  
  fprintf('Segment set Speaker2Hz of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2Hz{1})
    data_out(i).Speaker2Hz{1}        = ft_redefinetrial(cfg, ...
                                        data(i).Speaker2Hz{1});
    data_out(i).Speaker2Hz{2}        = ft_redefinetrial(cfg, ...
                                        data(i).Speaker2Hz{2});       
  else
    data_out(i).Speaker2Hz{2}        = [];
  end
  
  fprintf('Segment set Silence of dyad %d...\n', i);
  if ~isempty(data(i).Silence{1})
    data_out(i).Silence{1}           = ft_redefinetrial(cfg, ...
                                        data(i).Silence{1});
    data_out(i).Silence{2}           = ft_redefinetrial(cfg, ...
                                        data(i).Silence{2});                               
  else
    data_out(i).Silence{2}           = [];
  end
  
  fprintf('Segment set SilEyesClosed of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesClosed{1})
    data_out(i).SilEyesClosed{1}     = ft_redefinetrial(cfg, ...
                                        data(i).SilEyesClosed{1});
    data_out(i).SilEyesClosed{2}     = ft_redefinetrial(cfg, ...
                                        data(i).SilEyesClosed{2});                                
  else
    data_out(i).SilEyesClosed{2}     = [];
  end
  
  fprintf('Segment set MixNoiseEarphones of dyad %d...\n', i);
  if ~isempty(data(i).MixNoiseEarphones{1})
    data_out(i).MixNoiseEarphones{1} = ft_redefinetrial(cfg, ...
                                        data(i).MixNoiseEarphones{1});
    data_out(i).MixNoiseEarphones{2} = ft_redefinetrial(cfg, ...
                                        data(i).MixNoiseEarphones{2});                                
  else
    data_out(i).MixNoiseEarphones{2} = [];
  end
  
  fprintf('Segment set MixNoiseSpeaker of dyad %d...\n', i);
  if ~isempty(data(i).MixNoiseSpeaker{1})
    data_out(i).MixNoiseSpeaker{1}     = ft_redefinetrial(cfg, ...
                                        data(i).MixNoiseSpeaker{1});
    data_out(i).MixNoiseSpeaker{2}     = ft_redefinetrial(cfg, ...
                                        data(i).MixNoiseSpeaker{2});                                
  else
    data_out(i).MixNoiseSpeaker{2}   = [];
  end
  
  fprintf('Segment set Tapping of dyad %d...\n', i);
  if ~isempty(data(i).Tapping{1})
    data_out(i).Tapping{1}           = ft_redefinetrial(cfg, ...
                                        data(i).Tapping{1});
    data_out(i).Tapping{2}           = ft_redefinetrial(cfg, ...
                                        data(i).Tapping{2});                                
  else
    data_out(i).Tapping{2}           = [];
  end
  
  fprintf('Segment set DialoguePlus2Hz of dyad %d...\n', i);
  if ~isempty(data(i).DialoguePlus2Hz{1})
    data_out(i).DialoguePlus2Hz{1}   = ft_redefinetrial(cfg, ...
                                        data(i).DialoguePlus2Hz{1});
    data_out(i).DialoguePlus2Hz{2}   = ft_redefinetrial(cfg, ...
                                        data(i).DialoguePlus2Hz{2});                                
  else
    data_out(i).DialoguePlus2Hz{2}   = [];
  end
    
  fprintf('Segment set AreadsB of dyad %d...\n', i);
  if ~isempty(data(i).AreadsB{1})
    data_out(i).AreadsB{1}           = ft_redefinetrial(cfg, ...
                                        data(i).AreadsB{1});
    data_out(i).AreadsB{2}           = ft_redefinetrial(cfg, ...
                                        data(i).AreadsB{2});                                
  else
    data_out(i).AreadsB{2}           = [];
  end
  
  fprintf('Segment set BreadsA of dyad %d...\n', i);
  if ~isempty(data(i).BreadsA{1})
    data_out(i).BreadsA{1}           = ft_redefinetrial(cfg, ...
                                        data(i).BreadsA{1});
    data_out(i).BreadsA{2}           = ft_redefinetrial(cfg, ...
                                        data(i).BreadsA{2});                                
  else
    data_out(i).BreadsA{2}           = [];
  end
  
  fprintf('Segment set Dialogue of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue{1})
    data_out(i).Dialogue{1}          = ft_redefinetrial(cfg, ...
                                        data(i).Dialogue{1});
    data_out(i).Dialogue{2}          = ft_redefinetrial(cfg, ...
                                        data(i).Dialogue{2});                                
  else
    data_out(i).Dialogue{2}          = [];
  end
end

ft_info on;

data = data_out;

end

