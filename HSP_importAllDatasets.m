function [data, trials] = HSP_importAllDatasets( path, numOfPart )

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
trials(numOfPart).total   = [];                                             % show how many trials are in the data file
data{numOfPart}           = [];                                             % data cell array

% -------------------------------------------------------------------------
% Import data
% -------------------------------------------------------------------------
folder      = path;                                                         % specifies the data folder
filelist    = dir([folder, '/*.vhdr']);                                     % gets the filelist of the folder
filelist    = struct2cell(filelist);
filelist    = filelist(1,:);

for i=1:1:numOfPart                                                         % import of all files of the data folder
  
  cellnumber  = find(contains(filelist, num2str(i,'%02.0f')), 1);
  
  if ~isempty(cellnumber)
    header = char(filelist(cellnumber));
    path = strcat(folder, header);

    data{i} = HSP_importSingleDataset(path);
    trials(i).total = length(data{i}.trial);
  end
  
end

end
