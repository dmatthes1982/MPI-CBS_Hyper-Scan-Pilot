function [data] = HSP_importAllDatasets( path, numOfPart )

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
data.Earphone40Hz{numOfPart}       = [];
data.Speaker40Hz{numOfPart}        = [];
data.Earphone2Hz{numOfPart}        = [];
data.Speaker2Hz{numOfPart}         = [];
data.Silence{numOfPart}            = [];
data.SilEyesClosed{numOfPart}      = [];
data.MixNoiseEarphones{numOfPart}  = [];
data.MixNoiseSpeaker{numOfPart}    = [];
data.Tapping{numOfPart}            = [];
data.AreadsB{numOfPart}            = [];
data.BreadsA{numOfPart}            = [];
data.Dialogue{numOfPart}           = [];

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

    dataImport = HSP_importSingleDataset(path);
    
    data.Earphone40Hz{numOfPart}       = dataImport.Earphone40Hz;
    data.Speaker40Hz{numOfPart}        = dataImport.Speaker40Hz;
    data.Earphone2Hz{numOfPart}        = dataImport.Earphone2Hz;
    data.Speaker2Hz{numOfPart}         = dataImport.Speaker2Hz;
    data.Silence{numOfPart}            = dataImport.Silence;
    data.SilEyesClosed{numOfPart}      = dataImport.SilEyesClosed;
    data.MixNoiseEarphones{numOfPart}  = dataImport.MixNoiseEarphones;
    data.MixNoiseSpeaker{numOfPart}    = dataImport.MixNoiseSpeaker;
    data.Tapping{numOfPart}            = dataImport.Tapping;
    data.AreadsB{numOfPart}            = dataImport.AreadsB;
    data.BreadsA{numOfPart}            = dataImport.BreadsA;
    data.Dialogue{numOfPart}           = dataImport.Dialogue;
  end
  
end

end
