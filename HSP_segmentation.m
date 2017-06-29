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
% See also HSP_IMPORTALLDATASETS, HSP_PREPROCESSING, FT_REDEFINETRIAL,
% HSP_DATASTRUCTURE

% Copyright (C) 2017, Daniel Matthes, MPI CBS


% -------------------------------------------------------------------------
% Get number of participants
% -------------------------------------------------------------------------
numOfPart = size(data, 2);

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
  fprintf('Segment set Earphone2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2HzS{1})
    for j=1:1:2
      data(i).Earphone2HzS{j}   = ft_redefinetrial(cfg, ...
                                       data(i).Earphone2HzS{j});
    end
  else
    data(i).Earphone2HzS{2}     = [];
  end
  
  fprintf('Segment set Speaker2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2HzS{1})
    for j=1:1:2
        data(i).Speaker2HzS{j}  = ft_redefinetrial(cfg, ...
                                       data(i).Speaker2HzS{j});
    end
  else
    data(i).Speaker2HzS{2}      = [];
  end
  
  fprintf('Segment set Tapping2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Tapping2HzS{1})
    for j=1:1:2
        data(i).Tapping2HzS{j}  = ft_redefinetrial(cfg, ...
                                       data(i).Tapping2HzS{j});
    end
  else
    data(i).Tapping2HzS{2}      = [];
  end
  
  fprintf('Segment set Dialogue2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue2HzS{1})
    for j=1:1:2
      data(i).Dialogue2HzS{j}   = ft_redefinetrial(cfg, ...
                                       data(i).Dialogue2HzS{j});
    end                                  
  else
    data(i).Dialogue2HzS{2}     = [];
  end
  
  fprintf('Segment set Speaker20HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker20HzS{1})
    for j=1:1:2
      data(i).Speaker20HzS{j}   = ft_redefinetrial(cfg, ...
                                       data(i).Speaker20HzS{j});
    end                                  
  else
    data(i).Speaker20HzS{2}     = [];
  end
  
  fprintf('Segment set Earphone20HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone20HzS{1})
    for j=1:1:2
      data(i).Earphone20HzS{j}  = ft_redefinetrial(cfg, ...
                                       data(i).Earphone20HzS{j});
    end                                 
  else
    data(i).Earphone20HzS{2}    = [];
  end
  
  fprintf('Segment set Speaker20HzA of dyad %d...\n', i);
  if ~isempty(data(i).Speaker20HzA{1})
    for j=1:1:2
      data(i).Speaker20HzA{j}   = ft_redefinetrial(cfg, ...
                                       data(i).Speaker20HzA{j});
    end                                  
  else
    data(i).Speaker20HzA{2}     = [];
  end
  
  fprintf('Segment set Earphone20HzA of dyad %d...\n', i);
  if ~isempty(data(i).Earphone20HzA{1})
    for j=1:1:2
      data(i).Earphone20HzA{j}  = ft_redefinetrial(cfg, ...
                                       data(i).Earphone20HzA{j});
    end                                  
  else
    data(i).Earphone20HzA{2}    = [];
  end
  
  fprintf('Segment set Earphone2HzA of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2HzA{1})
    for j=1:1:2
      data(i).Earphone2HzA{j}   = ft_redefinetrial(cfg, ...
                                       data(i).Earphone2HzA{j});
    end                                  
  else
    data(i).Earphone2HzA{2}     = [];
  end
  
  fprintf('Segment set Speaker2HzA of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2HzA{1})
    for j=1:1:2
      data(i).Speaker2HzA{j}    = ft_redefinetrial(cfg, ...
                                       data(i).Speaker2HzA{j});
    end                                  
  else
    data(i).Speaker2HzA{2}      = [];
  end
    
  fprintf('Segment set Earphone40HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone40HzS{1})
    for j=1:1:2
      data(i).Earphone40HzS{j}  = ft_redefinetrial(cfg, ...
                                       data(i).Earphone40HzS{j});
    end                                  
  else
    data(i).Earphone40HzS {2}   = [];
  end
  
  fprintf('Segment set Speaker40HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker40HzS{1})
    for j=1:1:2
      data(i).Speaker40HzS{j}   = ft_redefinetrial(cfg, ...
                                       data(i).Speaker40HzS{j});
    end                                  
  else
    data(i).Speaker40HzS{2}     = [];
  end
  
  fprintf('Segment set Atalks2B of dyad %d...\n', i);
  if ~isempty(data(i).Atalks2B{1})
    for j=1:1:2
      data(i).Atalks2B{j}       = ft_redefinetrial(cfg, ...
                                       data(i).Atalks2B{j});
    end                                  
  else
    data(i).Atalks2B{2}         = [];
  end
  
  fprintf('Segment set Btalks2A of dyad %d...\n', i);
  if ~isempty(data(i).Btalks2A{1})
    for j=1:1:2
      data(i).Btalks2A{j}       = ft_redefinetrial(cfg, ...
                                       data(i).Btalks2A{j});
    end                                  
  else
    data(i).Btalks2A{2}         = [];
  end
  
  fprintf('Segment set Dialogue of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue{1})
    for j=1:1:2
      data(i).Dialogue{j}       = ft_redefinetrial(cfg, ...
                                       data(i).Dialogue{j});
    end                                  
  else
    data(i).Dialogue{2}         = [];
  end
  
  fprintf('Segment set SilEyesOpen of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesOpen{1})
    for j=1:1:2
      data(i).SilEyesOpen{j}    = ft_redefinetrial(cfg, ...
                                       data(i).SilEyesOpen{j});
    end                                  
  else
    data(i).SilEyesOpen{2}      = [];
  end
  
  fprintf('Segment set SilEyesClosed of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesClosed{1})
    for j=1:1:2
      data(i).SilEyesClosed{j}  = ft_redefinetrial(cfg, ...
                                       data(i).SilEyesClosed{j});
    end                                  
  else
    data(i).SilEyesClosed{2}    = [];
  end 
end

end

