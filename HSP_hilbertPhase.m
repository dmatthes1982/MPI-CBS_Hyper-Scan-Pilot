function [ data ] = HSP_hilbertPhase( data )
% HSP_HILBERTPHASE estimates the Hilbert phase of every channel in every 
% trial in the HSP_DATASTRUCTURE
%
% Use as
%   [ data ] = HSP_hilbertPhase( data )
%
% where the input data have to be the result from HSP_BPFILTERING
%
% This functions calculates also the Hilbert average ratio as described in
% the Paper of M. Chavez (2005). This value could be used to check the
% compilance of the narrow band condition. (hilbert_avRatio > 50)
%
% This function requires the fieldtrip toolbox
%
% Reference:
%   [Chavez2005]    "Towards a proper extimation of phase synchronization
%                   from time series"
%
% See also HSP_DATASTRUCTURE, HSP_BPFILTERING, FT_PREPROCESSING

% Copyright (C) 2017, Daniel Matthes, MPI CBS

% -------------------------------------------------------------------------
% Get number of participants
% -------------------------------------------------------------------------
numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% General Hilbert transform settings
% -------------------------------------------------------------------------
cfg                 = [];
cfg.channel         = 'all';
cfg.feedback        = 'no';
cfg.showcallinfo    = 'no';

% -------------------------------------------------------------------------
% Get center frequency of fildered input signal
% -------------------------------------------------------------------------
centerFreq = (  data(1).Earphone2HzS{1}.cfg.bpfreq(1) + ...
                data(1).Earphone2HzS{1}.cfg.bpfreq(2)  ) ./ 2;

% -------------------------------------------------------------------------
% Calculate Hilbert phase
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Calc Hilbert phase of set Earphone2HzS of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone2HzS{1})
    for j=1:1:2
      data(i).Earphone2HzS{j}   = hilbertTransform(cfg, ...
                                       data(i).Earphone2HzS{j});
    end
  else
    data(i).Earphone2HzS{2}     = [];
  end
  
  fprintf('Calc Hilbert phase of set Speaker2HzS of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker2HzS{1})
    for j=1:1:2
        data(i).Speaker2HzS{j}  = hilbertTransform(cfg, ...
                                       data(i).Speaker2HzS{j});
    end
  else
    data(i).Speaker2HzS{2}      = [];
  end
  
  fprintf('Calc Hilbert phase of set Tapping2HzS of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Tapping2HzS{1})
    for j=1:1:2
        data(i).Tapping2HzS{j}  = hilbertTransform(cfg, ...
                                       data(i).Tapping2HzS{j});
    end
  else
    data(i).Tapping2HzS{2}      = [];
  end
  
  fprintf('Calc Hilbert phase of set Dialogue2HzS of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Dialogue2HzS{1})
    for j=1:1:2
      data(i).Dialogue2HzS{j}   = hilbertTransform(cfg, ...
                                       data(i).Dialogue2HzS{j});
    end                                  
  else
    data(i).Dialogue2HzS{2}     = [];
  end
  
  fprintf('Calc Hilbert phase of set Speaker20HzS of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker20HzS{1})
    for j=1:1:2
      data(i).Speaker20HzS{j}   = hilbertTransform(cfg, ...
                                       data(i).Speaker20HzS{j});
    end                                  
  else
    data(i).Speaker20HzS{2}     = [];
  end
  
  fprintf('Calc Hilbert phase of set Earphone20HzS of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone20HzS{1})
    for j=1:1:2
      data(i).Earphone20HzS{j}  = hilbertTransform(cfg, ...
                                       data(i).Earphone20HzS{j});
    end                                 
  else
    data(i).Earphone20HzS{2}    = [];
  end
  
  fprintf('Calc Hilbert phase of set Speaker20HzA of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker20HzA{1})
    for j=1:1:2
      data(i).Speaker20HzA{j}   = hilbertTransform(cfg, ...
                                       data(i).Speaker20HzA{j});
    end                                  
  else
    data(i).Speaker20HzA{2}     = [];
  end
  
  fprintf('Calc Hilbert phase of set Earphone20HzA of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone20HzA{1})
    for j=1:1:2
      data(i).Earphone20HzA{j}  = hilbertTransform(cfg, ...
                                       data(i).Earphone20HzA{j});
    end                                  
  else
    data(i).Earphone20HzA{2}    = [];
  end
  
  fprintf('Calc Hilbert phase of set Earphone2HzA of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone2HzA{1})
    for j=1:1:2
      data(i).Earphone2HzA{j}   = hilbertTransform(cfg, ...
                                       data(i).Earphone2HzA{j});
    end                                  
  else
    data(i).Earphone2HzA{2}     = [];
  end
  
  fprintf('Calc Hilbert phase of set Speaker2HzA of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker2HzA{1})
    for j=1:1:2
      data(i).Speaker2HzA{j}    = hilbertTransform(cfg, ...
                                       data(i).Speaker2HzA{j});
    end                                  
  else
    data(i).Speaker2HzA{2}      = [];
  end
    
  fprintf('Calc Hilbert phase of set Earphone40HzS of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Earphone40HzS{1})
    for j=1:1:2
      data(i).Earphone40HzS{j}  = hilbertTransform(cfg, ...
                                       data(i).Earphone40HzS{j});
    end                                  
  else
    data(i).Earphone40HzS {2}   = [];
  end
  
  fprintf('Calc Hilbert phase of set Speaker40HzS of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Speaker40HzS{1})
    for j=1:1:2
      data(i).Speaker40HzS{j}   = hilbertTransform(cfg, ...
                                       data(i).Speaker40HzS{j});
    end                                  
  else
    data(i).Speaker40HzS{2}     = [];
  end
  
  fprintf('Calc Hilbert phase of set Atalks2B of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Atalks2B{1})
    for j=1:1:2
      data(i).Atalks2B{j}       = hilbertTransform(cfg, ...
                                       data(i).Atalks2B{j});
    end                                  
  else
    data(i).Atalks2B{2}         = [];
  end
  
  fprintf('Calc Hilbert phase of set Btalks2A of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Btalks2A{1})
    for j=1:1:2
      data(i).Btalks2A{j}       = hilbertTransform(cfg, ...
                                       data(i).Btalks2A{j});
    end                                  
  else
    data(i).Btalks2A{2}         = [];
  end
  
  fprintf('Calc Hilbert phase of set Dialogue of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).Dialogue{1})
    for j=1:1:2
      data(i).Dialogue{j}       = hilbertTransform(cfg, ...
                                       data(i).Dialogue{j});
    end                                  
  else
    data(i).Dialogue{2}         = [];
  end
  
  fprintf('Calc Hilbert phase of set SilEyesOpen of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).SilEyesOpen{1})
    for j=1:1:2
      data(i).SilEyesOpen{j}    = hilbertTransform(cfg, ...
                                       data(i).SilEyesOpen{j});
    end                                  
  else
    data(i).SilEyesOpen{2}      = [];
  end
  
  fprintf('Calc Hilbert phase of set SilEyesClosed of dyad %d at %d Hz...\n', ...           
            i, centerFreq);
  if ~isempty(data(i).SilEyesClosed{1})
    for j=1:1:2
      data(i).SilEyesClosed{j}  = hilbertTransform(cfg, ...
                                       data(i).SilEyesClosed{j});
    end                                  
  else
    data(i).SilEyesClosed{2}    = [];
  end
end

end

function [ data ] = hilbertTransform( cfg, data )
% -------------------------------------------------------------------------
% Get data properties
% -------------------------------------------------------------------------
trialNum = length(data.trial);                                              % get number of trials 
trialLength = length (data.time{1});                                        % get length of one trial
trialComp = length (data.label);                                            % get number of components

% -------------------------------------------------------------------------
% Calculate instantaneous phase
% -------------------------------------------------------------------------
cfg.hilbert         = 'angle';
data_phase          = ft_preprocessing(cfg, data);

% -------------------------------------------------------------------------
% Calculate instantaenous amplitude
% -------------------------------------------------------------------------
cfg.hilbert         = 'abs';
data_amplitude      = ft_preprocessing(cfg, data);

% -------------------------------------------------------------------------
% Calculate average ratio E[phi'(t)/(A'(t)/A(t))]
% -------------------------------------------------------------------------
hilbert_avRatio = zeros(trialNum, trialComp);

for trial=1:1:trialNum
    phase_diff_abs      = abs(diff(data_phase.trial{trial} , 1, 2));
    phase_diff_abs_inv  = 2*pi - phase_diff_abs;
    phase_diff_abs      = cat(3, phase_diff_abs, phase_diff_abs_inv);
    phase_diff_abs      = min(phase_diff_abs, [], 3);
    
    amp_diff = diff(data_amplitude.trial{trial} ,1 ,2);
    amp = data_amplitude.trial{trial};
    amp(:, trialLength) =  [];
    amp_ratio_abs = abs(amp_diff ./ amp);
    ratio = (phase_diff_abs ./ amp_ratio_abs);

    hilbert_avRatio(trial, :) = (mean(ratio, 2))';
    
    Val2low = length(find(hilbert_avRatio(trial, :) < 10));
    
    if (Val2low ~= 0)
      warning('Hilbert average ratio in trial %d is %d time(s) below 10.', ...
             trial, Val2low);
    end
end

% -------------------------------------------------------------------------
% Generate the output 
% -------------------------------------------------------------------------
data = data_phase;

data.hilbert_avRatio = hilbert_avRatio;                                     % assign hilbert_avRatio to the output data structure

end






















