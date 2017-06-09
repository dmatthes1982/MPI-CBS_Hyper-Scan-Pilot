function [ data ] = HSP_importSingleDataset( headerfile )

hdr                       = ft_read_header( headerfile);

cfg                       = [];
cfg.dataset               = headerfile;
cfg.trialfun              = 'ft_trialfun_general';
cfg.trialdef.eventtype    = 'New Segment';
cfg.showcallinfo          = 'no';

cfg_seg = ft_definetrial(cfg);

cfg_seg.trl(1:end-1, 2) = cfg_seg.trl(2:end, 1)-1;
cfg_seg.trl(end, 2) = hdr.nSamples;

data    = ft_preprocessing(cfg_seg);

end
