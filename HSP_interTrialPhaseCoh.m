function [ data ] = HSP_interTrialPhaseCoh(cfg, data)
% HSP_INTERTRIALPHASECOH estimates the inter-trial phase coherence (ITPC)
% of single participants for all different trials in the HSP_DATASTRUCTURE
%
% Use as
%   [ data ] = HSP_interTrialPhaseCoh( cfg, data )
%
% where the input data should be the result from HSP_SEGMENTATION
%
% The configuration options are
%   cfg.toi       = time of interest (default: 0:0.02:10)
%   cfg.foi       = frequency of interest (default: 1:0.5:48)
%   cfg.numOfPArt = numbers of participants, i.e. [1:1:6] or [1,3,5] (default: [])
%
% Theoretical Background:
% ITC is a frequency-domain measure of the partial or exact synchronization  
% of activity at a particular latency and frequency to a set of 
% experimental events to which EEG data trials are time locked. The measure
% was  introduced by Tallon-Baudry et al. (1996) and  termed a "phase 
% locking factor". The term "inter-trial coherence" refers to its inter-
% pretation as the event-related phase coherence (ITPC) or event-related 
% linear coherence (ITLC) between recorded EEG activity and an event-phase 
% indicator function.  The  most  common (and  default) version is inter-
% trial phase coherence.
%                                       n
% Equation:         ITPC(f,t) = 1/n * Sigma( F_k(f,t) / |F_k(f,t)| ) 
%                                      k=1
%
% References:
%   [Delorme2004]   "EEGLAB: an open source toolbox for analysis of 
%                    single-trial EEG dynamics including independent 
%                    component analysis."
%   http://www.fieldtriptoolbox.org/faq/itc
%
% This function requires the fieldtrip toolbox
%
% See also HSP_DATASTRUCTURE, HSP_SEGMENTATION

% Copyright (C) 2017, Daniel Matthes, MPI CBS 

% -------------------------------------------------------------------------
% Get and check config options
% Get number of participants
% -------------------------------------------------------------------------
cfgSub.toi  = ft_getopt(cfg, 'toi', 0:0.2:9.8);
cfgSub.foi  = ft_getopt(cfg, 'foi', 1:0.5:48);
numOfPart   = ft_getopt(cfg, 'numOfPart', []);

if isempty(numOfPart)
  numOfSources = size(data, 2);
  notEmpty = zeros(1, numOfSources);
  for i=1:1:numOfSources
      notEmpty(i) = (~isempty(data(i).part1));
  end
  numOfPart = find(notEmpty);  
end

% -------------------------------------------------------------------------
% Estimate inter-trial phase coherence (PLV)
% ------------------------------------------------------------------------
parfor i = numOfPart
  fprintf('Estimate ITPC for participant 1 of dyad %d...\n', i);
  data(i).part1 = interTrialPhaseCoh(cfgSub, data(i).part1);
  
  fprintf('Estimate ITPC for participant 2 of dyad %d...\n', i);
  data(i).part2 = interTrialPhaseCoh(cfgSub, data(i).part2);
end

end

function [data_out] = interTrialPhaseCoh(cfgITPC, data_in)

if max(cfgITPC.toi) > max(data_in.time{1})                                   % check if trial length is long enough
  error('toi is larger than the trial length. - Use another toi or resegment the trials.');
end

trialinfo = unique(data_in.trialinfo, 'stable');                            % extrakt trialinfo

% -------------------------------------------------------------------------
% Calculate spectrum
% -------------------------------------------------------------------------
cfgFrq              = [];
cfgFrq.method       = 'wavelet';
cfgFrq.toi          = cfgITPC.toi;
cfgFrq.output       = 'fourier';
cfgFrq.foi          = cfgITPC.foi;
cfgFrq.showcallinfo = 'no';
cfgFrq.feedback     = 'no';

ft_notice off;
for i=1:1:length(data_in.time)
  data_in.time{i} = data_in.time{1};
end
data_freq = ft_freqanalysis(cfgFrq, data_in);
ft_notice on;

% -------------------------------------------------------------------------
% Calculate Inter-Trial-Coherence
% -------------------------------------------------------------------------
% make a new FieldTrip-style data structure containing the ITC
% copy the descriptive fields over from the frequency decomposition
data_out = [];
data_out.label     = data_freq.label;
data_out.freq      = data_freq.freq;
data_out.dimord    = 'rpt_chan_freq_time';
data_out.trialinfo = trialinfo;

F = data_freq.fourierspctrm;                                                % copy the Fourier spectrum
F = F./abs(F);                                                              % divide by amplitude

data_out.itpc{1, length(trialinfo)} = [];
data_out.time{1, length(trialinfo)} = [];

for i = 1:1:length(trialinfo)
  trials = find(data_in.trialinfo == trialinfo(i));
  N = size(trials, 1);
  data_out.itpc{i} = sum(F(trials,:,:,:), 1);                               % sum angles
  data_out.itpc{i} = abs(data_out.itpc{i})/N;                               % take the absolute value and normalize
  data_out.itpc{i} = squeeze(data_out.itpc{i});                             % remove the first singleton dimension
  data_out.time{i} = data_freq.time;
end

end
