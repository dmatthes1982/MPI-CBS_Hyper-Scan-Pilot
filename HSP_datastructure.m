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
%    |---- Earphone2HzS     1x2 cell  1x2 cell    ...     1x2 cell
%    |---- Speaker2HzS      1x2 cell  1x2 cell    ...     1x2 cell
%    |----    ...             ...       ...       ...       ...
%    |---- SilEyesClosed    1x2 cell  1x2 cell    ...     1x2 cell
%
% Many functions, especially the plot functions, need a definition of the 
% specific condition, which should be used. Currently the following 
% conditions are existent:
%
% - Earphone2HzS      - S21
% - Speaker2HzS       - S22
% - Tapping2HzS       - S24
% - Dialogue2HzS      - S25
% - Speaker20HzS      - S26
% - Earphone20HzS     - S27
% - Speaker20HzA      - S28
% - Earphone20HzA     - S29
% - Earphone2HzA      - S31
% - Speaker2HzA       - S32
% - Earphone40HzS     - S41
% - Speaker40HzS      - S42
% - Atalks2B          - S51
% - Btalks2A          - S52
% - Dialogue          - S53
% - SilEyesOpen       - S10
% - SilEyesClosed     - S100
%
% The defintion of the condition is done by setting the cfg.condition
% option with the string of the specific condition.