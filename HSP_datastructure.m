% HSP_DATASTRUCTURE
%
% The data in the --- Hyperscanning Pilot Projekt --- ist structured as
% follows:
%
% Every dataset of the pipeline is a 1xN structure, where N describes the 
% number of dyads in the structure. The fields of the data structure are 
% named after the different conditions of the hyperscanning pilot project 
% study. Every single field again comprises a 1x2 cell array and each cell
% contains the data of a specific participant unter this condition.
%
% For example:
%
% data_raw
%    |                         1         2        ...        N 
%    |---- Earphone40Hz     1x2 cell  1x2 cell    ...     1x2 cell
%    |---- Speaker40Hz      1x2 cell  1x2 cell    ...     1x2 cell
%    |----    ...             ...       ...       ...       ...
%    |---- Dialogue         1x2 cell  1x2 cell    ...     1x2 cell
%
% Many functions, especially the plot functions, need a definition of the 
% specific condition, which should be used. Currently the following 
% conditions are existent:
%
% - Earphone40Hz      - S41
% - Speaker40Hz       - S42
% - Earphone2Hz       - S21
% - Speaker2Hz        - S22
% - Silence           - S10
% - SilEyesClosed     - S100
% - MixNoiseEarphones - S31
% - MixNoiseSpeaker   - S32
% - Tapping           - S24
% - DialoguePlus2Hz   - S25
% - AreadsB           - S51
% - BreadsA           - S52
% - Dialogue          - S53
%
% The defintion of the condition is done by setting the cfg.condition
% option with the string of the specific condition.