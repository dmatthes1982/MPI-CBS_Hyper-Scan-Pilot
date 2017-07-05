% HSP_DATASTRUCTURE
%
% The data in the --- Hyperscanning Pilot Projekt --- ist structured as
% follows:
%
% Every dataset of the pipeline is a 1xN structure, where N describes the 
% number of dyads in the structure. The two fields of the data structure 
% are named part1 and part2. Every field again comprises a 1x1 struct with 
% the complete data of a specific participant. The different conditions in 
% this data struct are separated through trials and the field trialinfo 
% contains the condition markers of each trials. In case of subsegmented 
% data the structure contains more than one trial for each condition. If no 
% trial was rejected during the preprocessing, there should be 36 trials 
% per condition in the data structure. The information about the order of 
% the trials in of one condition is available through the relating time 
% elements. 
%
% For example:
%
% data_raw
%    |                  1           2          ...        N 
%    |---- part1     1x1 struct  1x1 struct    ...     1x1 struct
%    |---- part2     1x1 struct  1x1 struct    ...     1x1 struct
%   
%
% Many functions especially the plot functions need a definition of the 
% specific condition, which should be selected. Currently the following 
% conditions are existent:
%
% - Earphone2HzS      - 21
% - Speaker2HzS       - 22
% - Tapping2HzS       - 24
% - Dialogue2HzS      - 25
% - Speaker20HzS      - 26
% - Earphone20HzS     - 27
% - Speaker20HzA      - 28
% - Earphone20HzA     - 29
% - Earphone2HzA      - 31
% - Speaker2HzA       - 32
% - Earphone40HzS     - 41
% - Speaker40HzS      - 42
% - Atalks2B          - 51
% - Btalks2A          - 52
% - Dialogue          - 53
% - SilEyesOpen       - 10
% - SilEyesClosed     - 100
%
% The defintion of the condition is done by setting the cfg.condition
% option with the string or the number of the specific condition.

% Copyright (C) 2017, Daniel Matthes, MPI CBS