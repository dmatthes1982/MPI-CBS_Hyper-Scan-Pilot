fprintf('------------------------------------------------\n');
fprintf('<strong>Hyperscanning pilot project - data preprocessing</strong>\n');
fprintf('Version: 0.1\n');
fprintf('Copyright (C) 2017, Daniel Matthes, MPI CBS\n');
fprintf('------------------------------------------------\n');

% -------------------------------------------------------------------------
% General definitions
% -------------------------------------------------------------------------
srcPath = '/data/pt_01821/DualEEG_AD_auditory_rawData/';
desPath = '/data/pt_01821/DualEEG_AD_auditory_processedData/';

% -------------------------------------------------------------------------
% General selection of dyads
% -------------------------------------------------------------------------
selection = false;

while selection == false
  fprintf('\nPlease select one option:\n');
  fprintf('[1] - Process all available dyads\n');
  fprintf('[2] - Process all new dyads\n');
  fprintf('[3] - Process specific dyad\n');
  fprintf('[4] - Quit data processing\n\n');
  x = input('Option: ');
  
  switch x
    case 1
      selection = true;
      dyadsSpec = 'all';
    case 2
      selection = true;
      dyadsSpec = 'new';
    case 3
      selection = true;
      dyadsSpec = 'specific';
    case 4
      fprintf('\nData processing aborted.\n');
      clear selection x
      return;
    otherwise
      selection = false;
      cprintf([1,0.5,0], 'Wrong input!\n');
  end
end

% -------------------------------------------------------------------------
% General selection of preprocessing option
% -------------------------------------------------------------------------
selection = false;

while selection == false
  fprintf('\nPlease select what you want to do with the selected dyads:\n');
  fprintf('[1] - Import and basic preprocessing\n');
  fprintf('[2] - Rejection of eye artifacts (not available yet)\n');
  fprintf('[3] - Segmentation of the data\n');
  fprintf('[4] - Manual rejection of further artifacts (not available yet)\n');
  fprintf('[5] - Calculation of PLV\n');
  fprintf('[6] - Quit data processing\n\n');
  x = input('Option: ');
  
  switch x
    case 1
      state = 1;
      selection = true;
    case 2
      state = 2;
      selection = false;
      cprintf([1,0.5,0], 'This option is currently unsupported!\n');
    case 3
      state = 3;
      selection = true;
    case 4
      state = 4;
      selection = false;
      cprintf([1,0.5,0], 'This option is currently unsupported!\n');
    case 5
      state = 5;
      selection = true;
    case 6
      fprintf('\nData processing aborted.\n');
      clear selection x dyads
      return;
    otherwise
      selection = false;
      cprintf([1,0.5,0], 'Wrong input!\n');
  end
end

% -------------------------------------------------------------------------
% Specific selection of dyads
% -------------------------------------------------------------------------
sourceList    = dir([srcPath, '/*.vhdr']);
sourceList    = struct2cell(sourceList);
sourceList    = sourceList(1,:);
numOfSources  = length(sourceList);

fileNum       = zeros(1, numOfSources);

for i=1:1:numOfSources
  fileNum(i)     = sscanf(sourceList{i}, 'DualEEG_AD_auditory_%d.vhdr');
end

switch state
  case 1
    fileNamePre = [];
    fileNamePost = strcat(desPath, 'HSP_02_preproc');
  case 2
    error('This option is currently unsupported!');
  case 3
    fileNamePre = strcat(desPath, 'HSP_02_preproc');
    fileNamePost = strcat(desPath, 'HSP_04_seg1');
  case 4
    error('This option is currently unsupported!');
  case 5
    fileNamePre = strcat(desPath, 'HSP_04_seg1');
    fileNamePost = strcat(desPath, 'HSP_07a_plv2Hz');
  otherwise
    error('Something unexpected happend. state = %d is not defined' ...
          , state);
end

if isempty(fileNamePre)
  numOfPrePart = fileNum;
else
  fileListPre = dir(strcat(fileNamePre,'_*.mat'));
  if isempty(fileListPre)
    error(['Selected step [%d] can not be executed, no input data '...
           'available']);
  else
    fileNamePre = strcat(desPath, fileListPre(end).name);
    load(fileNamePre, 'dyads');
    numOfPrePart = squeeze(cell2mat(struct2cell(dyads)))';
  end
end


if strcmp(dyadsSpec, 'all')                                                 % process all participants
  numOfPart = numOfPrePart;
elseif strcmp(dyadsSpec, 'specific')                                        % process specific participants
  y = sprintf('%d ', numOfPrePart);
    
  selection = false;
    
  while selection == false
    fprintf('\nThe following participants are available: %s\n', y);
    fprintf(['Comma-seperate your selection and put it in squared ' ...
               'brackets!\n']);
    x = input('Please make your choice! (i.e. [1,2,3]): ');
      
    if ~all(ismember(x, numOfPrePart))
      cprintf([1,0.5,0], 'Wrong input!\n');
    else
      selection = true;
      numOfPart = x;
    end
  end
elseif strcmp(dyadsSpec, 'new')                                             % process only new participants
  fileListPost = dir(strcat(fileNamePost,'_*.mat'));
  if isempty(fileListPost)
    numOfPostPart = [];
  else
    fileNamePost = strcat(desPath, fileListPost(end).name);
    load(fileNamePost, 'dyads');
    numOfPostPart = squeeze(cell2mat(struct2cell(dyads)))';
  end
  
  numOfPart = numOfPrePart(~ismember(numOfPrePart, numOfPostPart));
  if isempty(numOfPart)
    cprintf([1,0.5,0], 'No new dyads available!\n');
    fprintf('Data processing aborted.\n');
    clear desPath fileNamePost fileNamePre fileNum i numOfPrePart ...
          numOfSources selection sourceList srcPath x y dyads ...
          fileListPost fileListPre numOfPostPart
    return;
  end
end

y = sprintf('%d ', numOfPart);
fprintf(['\nThe following participants will be processed ' ... 
         'in the selected state [%d]:\n'],  state);
fprintf('%s\n', y);

clear desPath fileNamePost fileNamePre fileNum i numOfPrePart ...
      numOfSources selection sourceList srcPath x y dyads fileListPost ...
      fileListPre numOfPostPart
