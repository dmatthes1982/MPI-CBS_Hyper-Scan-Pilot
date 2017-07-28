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
%   cfg.bpfreq            = passband range [begin end] (default: [0.1 48])
%   cfg.bpfilttype        = bandpass filter type, 'but' or 'fir' (default: fir')
%   cfg.bpinstabilityfix  = deal with filter instability, 'no' or 'split' (default: 'no')
%   cfg.reref             = re-referencing: 'yes' or 'no' (default: 'yes')
%   cfg.refchannel        = re-reference channel (default: 'TP10')
%   cfg.numOfPart         = number of participants, i.e. [1:1:6] or [1,3,5] (default: [])
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
bpfreq            = ft_getopt(cfg, 'bpfreq', [0.1 48]);
bpfilttype        = ft_getopt(cfg, 'bpfilttype', 'fir');
bpinstabilityfix  = ft_getopt(cfg, 'bpinstabilityfix', 'no');
reref             = ft_getopt(cfg, 'reref', 'yes');
refchannel        = ft_getopt(cfg, 'refchannel', 'TP10');
numOfPart         = ft_getopt(cfg, 'numOfPart', []);

if isempty(numOfPart)
  numOfSources = size(data, 2);
  notEmpty = zeros(1, numOfSources);
  for i=1:1:numOfSources
      notEmpty(i) = (~isempty(data(i).part1));
  end
  numOfPart = find(notEmpty);  
end

% -------------------------------------------------------------------------
% Preprocessing settings
% -------------------------------------------------------------------------

% general filtering
cfgBP                   = [];
cfgBP.bpfilter          = 'yes';                                            % use bandpass filter
cfgBP.bpfreq            = bpfreq;                                           % bandpass range  
cfgBP.bpfilttype        = bpfilttype;                                       % bandpass filter type = fir      
cfgBP.bpinstabilityfix  = bpinstabilityfix;                                 % deal with filter instability
cfgBP.channel           = 'all';                                            % use all channels
cfgBP.trials            = 'all';                                            % use all trials
cfgBP.feedback          = 'no';                                             % feedback should not be presented
cfgBP.showcallinfo      = 'no';                                             % prevent printing the time and memory after each function call

% re-referencing
cfgReref               = [];
cfgReref.reref         = reref;                                             % enable re-referencing
cfgReref.refchannel    = {refchannel 'REF'};                                % select linked 'TP09' 'TP10' as new reference
cfgReref.implicitref   = 'REF';                                             % add implicit channel 'REF' to the channels
cfgReref.refmethod     = 'avg';                                             % average over selected electrodes (in our case insignificant)
cfgReref.channel       = {'all', '-V1', '-V2', '-F9', '-F10'};              % use all channels except 'V1', 'V2', 'F9' and 'F10'
cfgReref.trials        = 'all';                                             % use all trials
cfgReref.feedback      = 'no';                                              % feedback should not be presented
cfgReref.showcallinfo  = 'no';                                              % prevent printing the time and memory after each function call
cfgReref.calceogcomp   = 'yes';                                             % calculate eogh and eogv 

% downsampling
cfgDS                  = [];
cfgDS.resamplefs       = 125;
cfgDS.feedback         = 'no';                                              % feedback should not be presented
cfgDS.showcallinfo     = 'no';                                              % prevent printing the time and memory after each function call

% -------------------------------------------------------------------------
% Preprocessing
% -------------------------------------------------------------------------

parfor i = numOfPart
  fprintf('Preproc participant 1 of dyad %d...\n', i);
  data(i).part1   = bpfilter(cfgBP, data(i).part1);
  data(i).part1   = rereference(cfgReref, data(i).part1);
  data(i).part1   = downsampling(cfgDS, data(i).part1); 
  
  fprintf('Preproc participant 2 of dyad %d...\n', i);
  data(i).part2   = bpfilter(cfgBP, data(i).part2);
  data(i).part2   = rereference(cfgReref, data(i).part2);
  data(i).part2   = downsampling(cfgDS, data(i).part2);
end

end

% -------------------------------------------------------------------------
% Local functions
% -------------------------------------------------------------------------

function [ data_out ] = bpfilter( cfgB, data_in )
  
data_out = ft_preprocessing(cfgB, data_in);
  
end

function [ data_out ] = downsampling( cfgD, data_in )

ft_info off;
data_out = ft_resampledata(cfgD, data_in);
ft_info on;

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