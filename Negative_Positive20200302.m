function Negative_Positive20200302

global RtouchSpikeOffUnit  LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu...
    RtouchSpikeOnUnit LtouchSpikeOnUnit  LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu ...
    RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu pegpatternum pegpatternname... 
    LtPositiveFiringRate LtNegativeFiringRate RtPositiveFiringRate RtNegativeFiringRate LtPositiveSpikeOnKaisuu LtNegativeSpikeOnKaisuu RtPositiveSpikeOnKaisuu RtNegativeSpikeOnKaisuu...
    LtPositiveHistogramXaxis LtNegativeHistogramXaxis RtPositiveHistogramXaxis RtNegativeHistogramXaxis





LtouchUnit=[LtouchSpikeOnUnit;[zeros(length(LtouchSpikeOffUnit(:,1),1)) LtouchSpikeOffUnit]]; %%%% SpikeOffUnitの前列に発火数列を追加してSpikeOnUnitと連結。SpikeOff時の発火数をゼロに設定

RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1),1)) RtouchSpikeOffUnit]];

