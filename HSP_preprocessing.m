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
%   cfg.bpfreq      = passband range [begin end] (default: [0.1 48])
%   cfg.reref       = re-referencing: 'yes' or 'no' (default: 'yes')
%   cfg.refchannel  = re-reference channel (default: 'TP10')
%
% Currently this function applies only a bandpass filter to the data.
%
% This function requires the fieldtrip toolbox.
%
% See also HSP_IMPORTALLDATASETS, FT_PREPROCESSING, HSP_DATASTRUCTURE

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

% general filtering
cfgBP               = [];
cfgBP.bpfilter      = 'yes';                                                % use bandpass filter
cfgBP.bpfreq        = bpfreq;                                               % bandpass range  
cfgBP.bpfilttype    = 'fir';                                                % bandpass filter type = fir      
cfgBP.channel       = 'all';                                                % use all channels
cfgBP.feedback      = 'no';                                                 % feedback should not be presented
cfgBP.showcallinfo  = 'no';                                                 % prevent printing the time and memory after each function call

% re-referencing
cfgReref               = [];
cfgReref.reref         = reref;                                             % enable re-referencing
cfgReref.refchannel    = {refchannel 'REF'};                                % select linked 'TP09' 'TP10' as new reference
cfgReref.implicitref   = 'REF';                                             % add implicit channel 'REF' to the channels
cfgReref.refmethod     = 'avg';                                             % average over selected electrodes (in our case insignificant)
cfgReref.channel       = {'all', '-V1', '-V2', '-F9', '-F10'};              % use all channels except 'V1', 'V2', 'F9' and 'F10'
cfgReref.feedback      = 'no';                                              % feedback should not be presented
cfgReref.showcallinfo  = 'no';                                              % prevent printing the time and memory after each function call
cfgReref.calceogcomp   = 'yes';                                             % calculate eogh and eogv 

% -------------------------------------------------------------------------
% Preprocessing
% -------------------------------------------------------------------------

parfor i=1:1:numOfPart
  fprintf('Preproc set Earphone2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2HzS{1})
    for j=1:1:2
      data(i).Earphone2HzS{j}   = bpfilter(cfgBP, ...
                                           data(i).Earphone2HzS{j});
      data(i).Earphone2HzS{j}   = rereference(cfgReref, ...
                                              data(i).Earphone2HzS{j});
    end
  else
    data(i).Earphone2HzS{2}     = [];
  end
  
  fprintf('Preproc set Speaker2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2HzS{1})
    for j=1:1:2
        data(i).Speaker2HzS{j}  = bpfilter(cfgBP, ...
                                           data(i).Speaker2HzS{j});
        data(i).Speaker2HzS{j}  = rereference(cfgReref, ...
                                              data(i).Speaker2HzS{j});
    end
  else
    data(i).Speaker2HzS{2}      = [];
  end
  
  fprintf('Preproc set Tapping2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Tapping2HzS{1})
    for j=1:1:2
        data(i).Tapping2HzS{j}  = bpfilter(cfgBP, ...
                                           data(i).Tapping2HzS{j});
        data(i).Tapping2HzS{j}  = rereference(cfgReref, ...
                                              data(i).Tapping2HzS{j});
    end
  else
    data(i).Tapping2HzS{2}      = [];
  end
  
  fprintf('Preproc set Dialogue2HzS of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue2HzS{1})
    for j=1:1:2
      data(i).Dialogue2HzS{j}   = bpfilter(cfgBP, ...
                                           data(i).Dialogue2HzS{j});
      data(i).Dialogue2HzS{j}   = rereference(cfgReref, ...
                                              data(i).Dialogue2HzS{j});
    end                                  
  else
    data(i).Dialogue2HzS{2}     = [];
  end
  
  fprintf('Preproc set Speaker20HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker20HzS{1})
    for j=1:1:2
      data(i).Speaker20HzS{j}   = bpfilter(cfgBP, ...
                                           data(i).Speaker20HzS{j});
      data(i).Speaker20HzS{j}   = rereference(cfgReref, ...
                                              data(i).Speaker20HzS{j});
    end                                  
  else
    data(i).Speaker20HzS{2}     = [];
  end
  
  fprintf('Preproc set Earphone20HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone20HzS{1})
    for j=1:1:2
      data(i).Earphone20HzS{j}  = bpfilter(cfgBP, ...
                                           data(i).Earphone20HzS{j});
      data(i).Earphone20HzS{j}  = rereference(cfgReref, ...
                                              data(i).Earphone20HzS{j});
    end                                 
  else
    data(i).Earphone20HzS{2}    = [];
  end
  
  fprintf('Preproc set Speaker20HzA of dyad %d...\n', i);
  if ~isempty(data(i).Speaker20HzA{1})
    for j=1:1:2
      data(i).Speaker20HzA{j}   = bpfilter(cfgBP, ...
                                           data(i).Speaker20HzA{j});
      data(i).Speaker20HzA{j}   = rereference(cfgReref, ...
                                              data(i).Speaker20HzA{j});
    end                                  
  else
    data(i).Speaker20HzA{2}     = [];
  end
  
  fprintf('Preproc set Earphone20HzA of dyad %d...\n', i);
  if ~isempty(data(i).Earphone20HzA{1})
    for j=1:1:2
      data(i).Earphone20HzA{j}  = bpfilter(cfgBP, ...
                                           data(i).Earphone20HzA{j});
      data(i).Earphone20HzA{j}  = rereference(cfgReref, ...
                                             data(i).Earphone20HzA{j});
    end                                  
  else
    data(i).Earphone20HzA{2}    = [];
  end
  
  fprintf('Preproc set Earphone2HzA of dyad %d...\n', i);
  if ~isempty(data(i).Earphone2HzA{1})
    for j=1:1:2
      data(i).Earphone2HzA{j}   = bpfilter(cfgBP, ...
                                           data(i).Earphone2HzA{j});
      data(i).Earphone2HzA{j}   = rereference(cfgReref, ...
                                              data(i).Earphone2HzA{j});
    end                                  
  else
    data(i).Earphone2HzA{2}     = [];
  end
  
  fprintf('Preproc set Speaker2HzA of dyad %d...\n', i);
  if ~isempty(data(i).Speaker2HzA{1})
    for j=1:1:2
      data(i).Speaker2HzA{j}    = bpfilter(cfgBP, ...
                                           data(i).Speaker2HzA{j});
      data(i).Speaker2HzA{j}    = rereference(cfgReref, ...
                                              data(i).Speaker2HzA{j});
    end                                  
  else
    data(i).Speaker2HzA{2}      = [];
  end
    
  fprintf('Preproc set Earphone40HzS of dyad %d...\n', i);
  if ~isempty(data(i).Earphone40HzS{1})
    for j=1:1:2
      data(i).Earphone40HzS{j}  = bpfilter(cfgBP, ...
                                           data(i).Earphone40HzS{j});
      data(i).Earphone40HzS{j}  = rereference(cfgReref, ...
                                              data(i).Earphone40HzS{j});
    end                                  
  else
    data(i).Earphone40HzS {2}   = [];
  end
  
  fprintf('Preproc set Speaker40HzS of dyad %d...\n', i);
  if ~isempty(data(i).Speaker40HzS{1})
    for j=1:1:2
      data(i).Speaker40HzS{j}   = bpfilter(cfgBP, ...
                                           data(i).Speaker40HzS{j});
      data(i).Speaker40HzS{j}   = rereference(cfgReref, ...
                                              data(i).Speaker40HzS{j});
    end                                  
  else
    data(i).Speaker40HzS{2}     = [];
  end
  
  fprintf('Preproc set Atalks2B of dyad %d...\n', i);
  if ~isempty(data(i).Atalks2B{1})
    for j=1:1:2
      data(i).Atalks2B{j}       = bpfilter(cfgBP, ...
                                           data(i).Atalks2B{j});
      data(i).Atalks2B{j}       = rereference(cfgReref, ...
                                              data(i).Atalks2B{j});
    end                                  
  else
    data(i).Atalks2B{2}         = [];
  end
  
  fprintf('Preproc set Btalks2A of dyad %d...\n', i);
  if ~isempty(data(i).Btalks2A{1})
    for j=1:1:2
      data(i).Btalks2A{j}       = bpfilter(cfgBP, ...
                                           data(i).Btalks2A{j});
      data(i).Btalks2A{j}       = rereference(cfgReref, ...
                                              data(i).Btalks2A{j});
    end                                  
  else
    data(i).Btalks2A{2}         = [];
  end
  
  fprintf('Preproc set Dialogue of dyad %d...\n', i);
  if ~isempty(data(i).Dialogue{1})
    for j=1:1:2
      data(i).Dialogue{j}       = bpfilter(cfgBP, ...
                                           data(i).Dialogue{j});
      data(i).Dialogue{j}       = rereference(cfgReref, ...
                                              data(i).Dialogue{j});
    end                                  
  else
    data(i).Dialogue{2}         = [];
  end
  
  fprintf('Preproc set SilEyesOpen of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesOpen{1})
    for j=1:1:2
      data(i).SilEyesOpen{j}    = bpfilter(cfgBP, ...
                                           data(i).SilEyesOpen{j});
      data(i).SilEyesOpen{j}    = rereference(cfgReref, ...
                                              data(i).SilEyesOpen{j});
    end                                  
  else
    data(i).SilEyesOpen{2}      = [];
  end
  
  fprintf('Preproc set SilEyesClosed of dyad %d...\n', i);
  if ~isempty(data(i).SilEyesClosed{1})
    for j=1:1:2
      data(i).SilEyesClosed{j}  = bpfilter(cfgBP, ...
                                           data(i).SilEyesClosed{j});
      data(i).SilEyesClosed{j}  = rereference(cfgReref, ...
                                              data(i).SilEyesClosed{j});
    end                                  
  else
    data(i).SilEyesClosed{2}    = [];
  end
end

end

function [ data_out ] = bpfilter( cfgB, data_in )
  
data_out = ft_preprocessing(cfgB, data_in);
  
end

function [ data_out ] = rereference( cfgR, data_in )

calcceogcomp = cfgR.calceogcomp;

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

cfgR = removefields(cfgR, {'calcceogcomp'});
data_out = ft_preprocessing(cfgR, data_in);

if strcmp(calcceogcomp, 'yes')
  cfgtmp              = [];
  cfgtmp.showcallinfo = 'no';
  ft_info off;
  data_out            = ft_appenddata(cfgtmp, data_out, eogv, eogh);
  ft_info on;
else
  cfgtmp              = [];
  cfgtmp.showcallinfo = 'no';
  ft_info off;
  data_out            = ft_appenddata(cfgtmp, data_out, eogOrg);
  ft_info on;
end

end