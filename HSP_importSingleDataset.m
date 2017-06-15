function [ data ] = HSP_importSingleDataset( headerfile )

cfg                       = [];
cfg.dataset               = headerfile;
cfg.trialfun              = 'ft_trialfun_general';
cfg.trialdef.eventtype    = 'Stimulus';
cfg.trialdef.eventvalue   = {'S160', 'S150', 'S152', 'S149', 'S228', 'S179', 'S138', 'S159', 'S180', 'S169', 'S170', 'S181'};
%cfg.trialdef.eventvalue   = {'S32', 'S22', 'S24', 'S21', 'S100', 'S51', 'S10', 'S31', 'S52', 'S41', 'S42', 'S53'};
cfg.trialdef.prestim      = 0;
cfg.trialdef.poststim     = 180;
cfg.showcallinfo          = 'no';

cfg_seg = ft_definetrial(cfg);
falseTrig = [];

for i=1:1:size(cfg_seg.trl,1)-1
  if cfg_seg.trl(i,4) == cfg_seg.trl(i+1,4)
    falseTrig = [falseTrig, i];
  end
end

if ~isempty(falseTrig)
  for j=fliplr(falseTrig)
    cfg_seg.trl(j, :) = [];
  end
end

data    = ft_preprocessing(cfg_seg);

end
