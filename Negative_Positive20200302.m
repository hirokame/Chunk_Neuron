function Negative_Positive20200302

global RtouchSpikeOffUnit  LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu...
    RtouchSpikeOnUnit LtouchSpikeOnUnit  LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu ...
    RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu pegpatternum pegpatternname... 
    LtPositiveFiringRate LtNegativeFiringRate RtPositiveFiringRate RtNegativeFiringRate LtPositiveSpikeOnKaisuu LtNegativeSpikeOnKaisuu RtPositiveSpikeOnKaisuu RtNegativeSpikeOnKaisuu...
    LtPositiveHistogramXaxis LtNegativeHistogramXaxis RtPositiveHistogramXaxis RtNegativeHistogramXaxis





LtouchUnit=[LtouchSpikeOnUnit;[zeros(length(LtouchSpikeOffUnit(:,1),1)) LtouchSpikeOffUnit]]; %%%% SpikeOffUnit‚Ì‘O—ñ‚É”­‰Î”—ñ‚ğ’Ç‰Á‚µ‚ÄSpikeOnUnit‚Æ˜AŒ‹BSpikeOff‚Ì”­‰Î”‚ğƒ[ƒ‚Éİ’è

RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1),1)) RtouchSpikeOffUnit]];

