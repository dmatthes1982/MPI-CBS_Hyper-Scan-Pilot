function [ data ] = HSP_bpFiltering( cfg, data) 
% HSP_BPFILTERING applies a specific bandpass filter to every channel in
% the HSP_DATASTRUCTURE
%
% Use as
%   [ data ] = HSP_bpFiltering( cfg, data)
%
% where the input data have to be the result from HSP_IMPORTALLDATASETS,
% HSP_PREPROCESSING or HSP_SEGMENTATION 
%
% The configuration options are
%   cfg.bpfreq      = passband range [begin end] (default: [1.9 2.1])
%   cfg.filtorder   = define order of bandpass filter (default: 250)
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
bpfreq = ft_getopt(cfg, 'bpfreq', [1.9 2.1]);
order  = ft_getopt(cfg, 'filtorder', 250);

numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% Filtering settings
% -------------------------------------------------------------------------
cfg                 = [];
cfg.trials          = 'all';                                                % apply bandpass to all trials
cfg.channel         = {'all', '-REF', '-EOGV', '-EOGH'};                    % apply bandpass to every channel except REF, EOGV und EOGH
cfg.bpfilter        = 'yes';
cfg.bpfilttype      = 'fir';                                                % use a simple fir
cfg.bpfreq          = bpfreq;                                               % define bandwith
cfg.feedback        = 'no';                                                 % suppress feedback output
cfg.showcallinfo    = 'no';                                                 % suppress function call output
cfg.bpfiltord       = order;                                                % define filter order

centerFreq = (bpfreq(2) + bpfreq(1))/2;

% -------------------------------------------------------------------------
% Bandpass filtering
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Apply bandpass to set Earphone2HzS of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone2HzS{1})
    for j=1:1:2
      data(i).Earphone2HzS{j}   = ft_preprocessing(cfg, ...
                                       data(i).Earphone2HzS{j});
    end
  else
    data(i).Earphone2HzS{2}     = [];
  end
  
  fprintf('Apply bandpass to set Speaker2HzS of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker2HzS{1})
    for j=1:1:2
        data(i).Speaker2HzS{j}  = ft_preprocessing(cfg, ...
                                       data(i).Speaker2HzS{j});
    end
  else
    data(i).Speaker2HzS{2}      = [];
  end
  
  fprintf('Apply bandpass to set Tapping2HzS of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Tapping2HzS{1})
    for j=1:1:2
        data(i).Tapping2HzS{j}  = ft_preprocessing(cfg, ...
                                       data(i).Tapping2HzS{j});
    end
  else
    data(i).Tapping2HzS{2}      = [];
  end
  
  fprintf('Apply bandpass to set Dialogue2HzS of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Dialogue2HzS{1})
    for j=1:1:2
      data(i).Dialogue2HzS{j}   = ft_preprocessing(cfg, ...
                                       data(i).Dialogue2HzS{j});
    end                                  
  else
    data(i).Dialogue2HzS{2}     = [];
  end
  
  fprintf('Apply bandpass to set Speaker20HzS of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker20HzS{1})
    for j=1:1:2
      data(i).Speaker20HzS{j}   = ft_preprocessing(cfg, ...
                                       data(i).Speaker20HzS{j});
    end                                  
  else
    data(i).Speaker20HzS{2}     = [];
  end
  
  fprintf('Apply bandpass to set Earphone20HzS of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone20HzS{1})
    for j=1:1:2
      data(i).Earphone20HzS{j}  = ft_preprocessing(cfg, ...
                                       data(i).Earphone20HzS{j});
    end                                 
  else
    data(i).Earphone20HzS{2}    = [];
  end
  
  fprintf('Apply bandpass to set Speaker20HzA of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker20HzA{1})
    for j=1:1:2
      data(i).Speaker20HzA{j}   = ft_preprocessing(cfg, ...
                                       data(i).Speaker20HzA{j});
    end                                  
  else
    data(i).Speaker20HzA{2}     = [];
  end
  
  fprintf('Apply bandpass to set Earphone20HzA of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone20HzA{1})
    for j=1:1:2
      data(i).Earphone20HzA{j}  = ft_preprocessing(cfg, ...
                                       data(i).Earphone20HzA{j});
    end                                  
  else
    data(i).Earphone20HzA{2}    = [];
  end
  
  fprintf('Apply bandpass to set Earphone2HzA of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone2HzA{1})
    for j=1:1:2
      data(i).Earphone2HzA{j}   = ft_preprocessing(cfg, ...
                                       data(i).Earphone2HzA{j});
    end                                  
  else
    data(i).Earphone2HzA{2}     = [];
  end
  
  fprintf('Apply bandpass to set Speaker2HzA of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker2HzA{1})
    for j=1:1:2
      data(i).Speaker2HzA{j}    = ft_preprocessing(cfg, ...
                                       data(i).Speaker2HzA{j});
    end                                  
  else
    data(i).Speaker2HzA{2}      = [];
  end
    
  fprintf('Apply bandpass to set Earphone40HzS of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone40HzS{1})
    for j=1:1:2
      data(i).Earphone40HzS{j}  = ft_preprocessing(cfg, ...
                                       data(i).Earphone40HzS{j});
    end                                  
  else
    data(i).Earphone40HzS {2}   = [];
  end
  
  fprintf('Apply bandpass to set Speaker40HzS of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker40HzS{1})
    for j=1:1:2
      data(i).Speaker40HzS{j}   = ft_preprocessing(cfg, ...
                                       data(i).Speaker40HzS{j});
    end                                  
  else
    data(i).Speaker40HzS{2}     = [];
  end
  
  fprintf('Apply bandpass to set Atalks2B of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Atalks2B{1})
    for j=1:1:2
      data(i).Atalks2B{j}       = ft_preprocessing(cfg, ...
                                       data(i).Atalks2B{j});
    end                                  
  else
    data(i).Atalks2B{2}         = [];
  end
  
  fprintf('Apply bandpass to set Btalks2A of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Btalks2A{1})
    for j=1:1:2
      data(i).Btalks2A{j}       = ft_preprocessing(cfg, ...
                                       data(i).Btalks2A{j});
    end                                  
  else
    data(i).Btalks2A{2}         = [];
  end
  
  fprintf('Apply bandpass to set Dialogue of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Dialogue{1})
    for j=1:1:2
      data(i).Dialogue{j}       = ft_preprocessing(cfg, ...
                                       data(i).Dialogue{j});
    end                                  
  else
    data(i).Dialogue{2}         = [];
  end
  
  fprintf('Apply bandpass to set SilEyesOpen of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).SilEyesOpen{1})
    for j=1:1:2
      data(i).SilEyesOpen{j}    = ft_preprocessing(cfg, ...
                                       data(i).SilEyesOpen{j});
    end                                  
  else
    data(i).SilEyesOpen{2}      = [];
  end
  
  fprintf('Apply bandpass to set SilEyesClosed of dyad %d with a center frequency of %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).SilEyesClosed{1})
    for j=1:1:2
      data(i).SilEyesClosed{j}  = ft_preprocessing(cfg, ...
                                       data(i).SilEyesClosed{j});
    end                                  
  else
    data(i).SilEyesClosed{2}    = [];
  end
end

end

