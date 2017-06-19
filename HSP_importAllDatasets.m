function [data] = HSP_importAllDatasets( path, numOfPart )

% -------------------------------------------------------------------------
% General definitions & Allocating memory
% -------------------------------------------------------------------------
data(numOfPart).Earphone40Hz       = [];
data(numOfPart).Speaker40Hz        = [];
data(numOfPart).Earphone2Hz        = [];
data(numOfPart).Speaker2Hz         = [];
data(numOfPart).Silence            = [];
data(numOfPart).SilEyesClosed      = [];
data(numOfPart).MixNoiseEarphones  = [];
data(numOfPart).MixNoiseSpeaker    = [];
data(numOfPart).Tapping            = [];
data(numOfPart).DialoguePlus2Hz    = [];
data(numOfPart).AreadsB            = [];
data(numOfPart).BreadsA            = [];
data(numOfPart).Dialogue           = [];

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
    
    data(numOfPart).Earphone40Hz        = dataImport.Earphone40Hz;
    data(numOfPart).Speaker40Hz         = dataImport.Speaker40Hz;
    data(numOfPart).Earphone2Hz         = dataImport.Earphone2Hz;
    data(numOfPart).Speaker2Hz          = dataImport.Speaker2Hz;
    data(numOfPart).Silence             = dataImport.Silence;
    data(numOfPart).SilEyesClosed       = dataImport.SilEyesClosed;
    data(numOfPart).MixNoiseEarphones   = dataImport.MixNoiseEarphones;
    data(numOfPart).MixNoiseSpeaker     = dataImport.MixNoiseSpeaker;
    data(numOfPart).Tapping             = dataImport.Tapping;
    data(numOfPart).DialoguePlus2Hz     = dataImport.DialoguePlus2Hz;
    data(numOfPart).AreadsB             = dataImport.AreadsB;
    data(numOfPart).BreadsA             = dataImport.BreadsA;
    data(numOfPart).Dialogue            = dataImport.Dialogue;
  end
  
end

end
