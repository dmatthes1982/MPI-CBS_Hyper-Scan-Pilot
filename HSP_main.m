path_raw          = '../../data/HyperScanPilot/raw_data/';
numOfPart_raw     = 1;

[data_raw, trials_raw] = HSP_importAllDatasets( path_raw, ...
                                 numOfPart_raw );
                               
clear path_generic numOfPart_generic path_raw numOfPart_raw                              