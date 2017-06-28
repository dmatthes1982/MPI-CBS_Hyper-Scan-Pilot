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
%   cfg.bpfreq      = passband range [begin end] (default: [0.3 48])
%   cfg.reref       = re-referencing: 'yes' or 'no' (default: 'yes')
%   cfg.refchannel  = re-reference channel (default: 'TP10')
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
bpfreq      = ft_getopt(cfg, 'bpfreq', [0.1 48]);
reref       = ft_getopt(cfg, 'reref', 'yes');
refchannel  = ft_getopt(cfg, 'refchannel', 'TP10');

numOfPart = size(data, 2);

% -------------------------------------------------------------------------
% Preprocessing settings
% -------------------------------------------------------------------------
cfg{2} = [];

% general filtering
cfg{1}.bpfilter      = 'yes';                                               % use bandpass filter
cfg{1}.bpfreq        = bpfreq;                                              % bandpass range  
cfg{1}.bpfilttype    = 'fir';                                               % bandpass filter type = fir      
cfg{1}.channel       = 'all';                                               % use all channels
cfg{1}.feedback      = 'no';                                                % feedback should not be presented
cfg{1}.showcallinfo  = 'no';                                                % prevent printing the time and memory after each function call

% re-referencing
cfg{2}.reref         = reref;                                               % enable re-referencing
cfg{2}.refchannel    = {refchannel 'REF'};                                  % select linked 'TP09' 'TP10' as new reference
cfg{2}.implicitref   = 'REF';                                               % add implicit channel 'REF' to the channels
cfg{2}.refmethod     = 'avg';                                               % average over selected electrodes (in our case insignificant)
cfg{2}.channel       = {'all', '-V1', '-V2', '-F9', '-F10'};                % use all channels except 'V1', 'V2', 'F9' and 'F10'
cfg{2}.feedback      = 'no';                                                % feedback should not be presented
cfg{2}.showcallinfo  = 'no';                                                % prevent printing the time and memory after each function call
cfg{2}.calceogcomp   = 'yes';                                               % calculate eogh and eogv 

% -------------------------------------------------------------------------
% Preprocessing
% -------------------------------------------------------------------------

for i=1:1:numOfPart
  fprintf('Preproc set Earphone40Hz of dyad %d...\n', i);
  if ~isempty(data(i).Earphone40Hz{1})
    for j=1:1:2
      data(i).Earphone40Hz{j}       = bpfilter(cfg{1}, ...
                                            data(i).Earphone40Hz{j});
      data(i).Earphone40Hz{j}       = rereference(cfg{2}, ...
                                            data(i).Earphone40Hz{j});                                    
    end
  else
    data(i).Earphone40Hz{2}         = [];
  end
  
  fprintf('Preproc set Speaker40Hz of dyad %d...\n', i);
  if ~isempty(data(i).Speaker40Hz{1})
    for j=1:1:2
        data(i).Speaker40Hz{j}      = bpfilter(cfg{1}, ...
                                            data(i).Speaker40Hz{j});
        data(i).Speaker40Hz{j}      = rereference(cfg{2}, ...
                                            data(i).Speaker40Hz{j});
    end
  else
    data(i).Speaker40Hz{2}          = [];
  end
  
  fprintf('Preproc set Earphone2Hz of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2Hz{1})
    for j=1:1:2
        data(i).Earphone2Hz{j}      = bpfilter(cfg{1}, ...
                                            data(i).Earphone2Hz{j});
        data(i).Earphone2Hz{j}      = rereference(cfg{2}, ...
                                            data(i).Earphone2Hz{j});
    end
  else
    data(i).Earphone2Hz{2}          = [];
  end
  
  fprintf('Preproc set Speaker2Hz of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2Hz{1})
    for j=1:1:2
      data(i).Speaker2Hz{j}         = bpfilter(cfg{1}, ...
                                            data(i).Speaker2Hz{j});
      data(i).Speaker2Hz{j}         = rereference(cfg{2}, ...
                                            data(i).Speaker2Hz{j});
    end                                  
  else
    data(i).Speaker2Hz{2}           = [];
  end
  
  fprintf('Preproc set Silence of dyad %d...\n', i);
  if ~isempty(data(i).Silence{1})
    for j=1:1:2
      data(i).Silence{j}            = bpfilter(cfg{1}, ...
                                            data(i).Silence{j});
      data(i).Silence{j}            = rereference(cfg{2}, ...
                                            data(i).Silence{j});
    end                                  
  else
    data(i).Silence{2}              = [];
  end
  
  fprintf('Preproc set SilEyesClosed of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesClosed{1})
    for j=1:1:2
      data(i).SilEyesClosed{j}      = bpfilter(cfg{1}, ...
                                            data(i).SilEyesClosed{j});
      data(i).SilEyesClosed{j}      = rereference(cfg{2}, ...
                                            data(i).SilEyesClosed{j});                                    
    end                                  
  else
    data(i).SilEyesClosed{2}        = [];
  end
  
  fprintf('Preproc set MixNoiseEarphones of dyad %d...\n', i);
  if ~isempty(data(i).MixNoiseEarphones{1})
    for j=1:1:2
      data(i).MixNoiseEarphones{j}  = bpfilter(cfg{1}, ...
                                            data(i).MixNoiseEarphones{j});
      data(i).MixNoiseEarphones{j}  = rereference(cfg{2}, ...
                                            data(i).MixNoiseEarphones{j});
    end                                  
  else
    data(i).MixNoiseEarphones{2}    = [];
  end
  
  fprintf('Preproc set MixNoiseSpeaker of dyad %d...\n', i);
  if ~isempty(data(i).MixNoiseSpeaker{1})
    for j=1:1:2
      data(i).MixNoiseSpeaker{j}    = bpfilter(cfg{1}, ...
                                            data(i).MixNoiseSpeaker{j});
      data(i).MixNoiseSpeaker{j}    = rereference(cfg{2}, ...
                                            data(i).MixNoiseSpeaker{j});
    end                                  
  else
    data(i).MixNoiseSpeaker{2}      = [];
  end
  
  fprintf('Preproc set Tapping of dyad %d...\n', i);
  if ~isempty(data(i).Tapping{1})
    for j=1:1:2
      data(i).Tapping{j}            = bpfilter(cfg{1}, ...
                                            data(i).Tapping{j});
      data(i).Tapping{j}            = rereference(cfg{2}, ...
                                            data(i).Tapping{j});
    end                                  
  else
    data(i).Tapping{2}              = [];
  end
  
  fprintf('Preproc set DialoguePlus2Hz of dyad %d...\n', i);
  if ~isempty(data(i).DialoguePlus2Hz{1})
    for j=1:1:2
      data(i).DialoguePlus2Hz{j}    = bpfilter(cfg{1}, ...
                                            data(i).DialoguePlus2Hz{j});
      data(i).DialoguePlus2Hz{j}    = rereference(cfg{2}, ...
                                            data(i).DialoguePlus2Hz{j});
    end                                  
  else
    data(i).DialoguePlus2Hz{2}      = [];
  end
    
  fprintf('Preproc set AreadsB of dyad %d...\n', i);
  if ~isempty(data(i).AreadsB{1})
    for j=1:1:2
      data(i).AreadsB{j}            = bpfilter(cfg{1}, ...
                                            data(i).AreadsB{j});
      data(i).AreadsB{j}            = rereference(cfg{2}, ...
                                            data(i).AreadsB{j});
    end                                  
  else
    data(i).AreadsB {2}             = [];
  end
  
  fprintf('Preproc set BreadsA of dyad %d...\n', i);
  if ~isempty(data(i).BreadsA{1})
    for j=1:1:2
      data(i).BreadsA{j}            = bpfilter(cfg{1}, ...
                                            data(i).BreadsA{j});
      data(i).BreadsA{j}            = rereference(cfg{2}, ...
                                            data(i).BreadsA{j});
    end                                  
  else
    data(i).BreadsA{2}              = [];
  end
  
  fprintf('Preproc set Dialogue of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue{1})
    for j=1:1:2
      data(i).Dialogue{j}           = bpfilter(cfg{1}, ...
                                            data(i).Dialogue{j});
      data(i).Dialogue{j}           = rereference(cfg{2}, ...
                                            data(i).Dialogue{j});
    end                                  
  else
    data(i).Dialogue{2}             = [];
  end
end

end

function [ data_out ] = bpfilter( cfgBP, data_in )
  
data_out = ft_preprocessing(cfgBP, data_in);
  
end

function [ data_out ] = rereference( cfgReref, data_in )

calcceogcomp = cfgReref.calceogcomp;

if strcmp(calcceogcomp, 'yes')
  cfgtmp              = [];
  cfgtmp.channel      = {'F9', 'F10'};
  cfgtmp.reref        = 'yes';
  cfgtmp.refchannel   = 'F9';
  cfgtmp.showcallinfo = 'no';
  cfgtmp.feedback     = 'no';
  
  eogh                = ft_preprocessing(cfgtmp, data_in);
  eogh.label{2}       = 'EOGH';
  
  cfgtmp              = [];
  cfgtmp.channel      = 'EOGH';
  cfgtmp.showcallinfo = 'no';
  
  eogh                = ft_selectdata(cfgtmp, eogh); 
  
  cfgtmp              = [];
  cfgtmp.channel      = {'V1', 'V2'};
  cfgtmp.reref        = 'yes';
  cfgtmp.refchannel   = 'V1';
  cfgtmp.showcallinfo = 'no';
  cfgtmp.feedback     = 'no';
  
  eogv                = ft_preprocessing(cfgtmp, data_in);
  eogv.label{2}       = 'EOGV';
  
  cfgtmp              = [];
  cfgtmp.channel      = 'EOGV';
  cfgtmp.showcallinfo = 'no';
  
  eogv                = ft_selectdata(cfgtmp, eogv);
else
  cfgtmp              = [];
  cfgtmp.channel      = {'V1', 'V2', 'F9', 'F10'};
  cfgtmp.showcallinfo = 'no';
  eogOrg              = ft_selectdata(cfgtmp, data_in);
end

cfgReref = removefields(cfgReref, {'calcceogcomp'});
data_out = ft_preprocessing(cfgReref, data_in);

if strcmp(calcceogcomp, 'yes')
  cfgtmp              = [];
  cfgtmp.showcallinfo = 'no';
  data_out            = ft_appenddata(cfgtmp, data_out, eogv, eogh);
else
  cfgtmp              = [];
  cfgtmp.showcallinfo = 'no';
  data_out            = ft_appenddata(cfgtmp, data_out, eogOrg);
end

end