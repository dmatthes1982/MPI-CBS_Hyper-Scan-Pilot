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
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, HSP_SEGMENTATION, 
% HSP_CALCTFR, HSP_DATASTRUCTURE

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
cfg.foi = ft_getopt(cfg, 'foi', 2:1:50);
cfg.toi = ft_getopt(cfg, 'toi', 4:0.5:176);

numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% Time-Frequency Response (Analysis)
% -------------------------------------------------------------------------
parfor i=1:1:numOfPart
  fprintf('Calc TFR of set Earphone2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2HzS{1})
    for j=1:1:2
      data(i).Earphone2HzS{j}   = HSP_calcTFR(cfg, ...
                                              data(i).Earphone2HzS{j});
    end
  else
    data(i).Earphone2HzS{2}     = [];
  end
  
  fprintf('Calc TFR of set Speaker2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2HzS{1})
    for j=1:1:2
        data(i).Speaker2HzS{j}  = HSP_calcTFR(cfg, ...
                                              data(i).Speaker2HzS{j});
    end
  else
    data(i).Speaker2HzS{2}      = [];
  end
  
  fprintf('Calc TFR of set Tapping2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Tapping2HzS{1})
    for j=1:1:2
        data(i).Tapping2HzS{j}  = HSP_calcTFR(cfg, ...
                                              data(i).Tapping2HzS{j});
    end
  else
    data(i).Tapping2HzS{2}      = [];
  end
  
  fprintf('Calc TFR of set Dialogue2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue2HzS{1})
    for j=1:1:2
      data(i).Dialogue2HzS{j}   = HSP_calcTFR(cfg, ...
                                              data(i).Dialogue2HzS{j});
    end                                  
  else
    data(i).Dialogue2HzS{2}     = [];
  end
  
  fprintf('Calc TFR of set Speaker20HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker20HzS{1})
    for j=1:1:2
      data(i).Speaker20HzS{j}   = HSP_calcTFR(cfg, ...
                                              data(i).Speaker20HzS{j});
    end                                  
  else
    data(i).Speaker20HzS{2}     = [];
  end
  
  fprintf('Calc TFR of set Earphone20HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone20HzS{1})
    for j=1:1:2
      data(i).Earphone20HzS{j}  = HSP_calcTFR(cfg, ...
                                              data(i).Earphone20HzS{j});
    end                                 
  else
    data(i).Earphone20HzS{2}    = [];
  end
  
  fprintf('Calc TFR of set Speaker20HzA of dyad %d...\n', i);
  if ~isempty(data(i).Speaker20HzA{1})
    for j=1:1:2
      data(i).Speaker20HzA{j}   = HSP_calcTFR(cfg, ...
                                              data(i).Speaker20HzA{j});
    end                                  
  else
    data(i).Speaker20HzA{2}     = [];
  end
  
  fprintf('Calc TFR of set Earphone20HzA of dyad %d...\n', i);
  if ~isempty(data(i).Earphone20HzA{1})
    for j=1:1:2
      data(i).Earphone20HzA{j}  = HSP_calcTFR(cfg, ...
                                              data(i).Earphone20HzA{j});
    end                                  
  else
    data(i).Earphone20HzA{2}    = [];
  end
  
  fprintf('Calc TFR of set Earphone2HzA of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2HzA{1})
    for j=1:1:2
      data(i).Earphone2HzA{j}   = HSP_calcTFR(cfg, ...
                                              data(i).Earphone2HzA{j});
    end                                  
  else
    data(i).Earphone2HzA{2}     = [];
  end
  
  fprintf('Calc TFR of set Speaker2HzA of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2HzA{1})
    for j=1:1:2
      data(i).Speaker2HzA{j}    = HSP_calcTFR(cfg, ...
                                              data(i).Speaker2HzA{j});
    end                                  
  else
    data(i).Speaker2HzA{2}      = [];
  end
    
  fprintf('Calc TFR of set Earphone40HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone40HzS{1})
    for j=1:1:2
      data(i).Earphone40HzS{j}  = HSP_calcTFR(cfg, ...
                                              data(i).Earphone40HzS{j});
    end                                  
  else
    data(i).Earphone40HzS {2}   = [];
  end
  
  fprintf('Calc TFR of set Speaker40HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker40HzS{1})
    for j=1:1:2
      data(i).Speaker40HzS{j}   = HSP_calcTFR(cfg, ...
                                              data(i).Speaker40HzS{j});
    end                                  
  else
    data(i).Speaker40HzS{2}     = [];
  end
  
  fprintf('Calc TFR of set Atalks2B of dyad %d...\n', i);
  if ~isempty(data(i).Atalks2B{1})
    for j=1:1:2
      data(i).Atalks2B{j}       = HSP_calcTFR(cfg, ...
                                              data(i).Atalks2B{j});
    end                                  
  else
    data(i).Atalks2B{2}         = [];
  end
  
  fprintf('Calc TFR of set Btalks2A of dyad %d...\n', i);
  if ~isempty(data(i).Btalks2A{1})
    for j=1:1:2
      data(i).Btalks2A{j}       = HSP_calcTFR(cfg, ...
                                              data(i).Btalks2A{j});
    end                                  
  else
    data(i).Btalks2A{2}         = [];
  end
  
  fprintf('Calc TFR of set Dialogue of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue{1})
    for j=1:1:2
      data(i).Dialogue{j}       = HSP_calcTFR(cfg, ...
                                              data(i).Dialogue{j});
    end                                  
  else
    data(i).Dialogue{2}         = [];
  end
  
  fprintf('Calc TFR of set SilEyesOpen of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesOpen{1})
    for j=1:1:2
      data(i).SilEyesOpen{j}    = HSP_calcTFR(cfg, ...
                                              data(i).SilEyesOpen{j});
    end                                  
  else
    data(i).SilEyesOpen{2}      = [];
  end
  
  fprintf('Calc TFR of set SilEyesClosed of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesClosed{1})
    for j=1:1:2
      data(i).SilEyesClosed{j}  = HSP_calcTFR(cfg, ...
                                              data(i).SilEyesClosed{j});
    end                                  
  else
    data(i).SilEyesClosed{2}    = [];
  end 
end

end

