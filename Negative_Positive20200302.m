function Negative_Positive20200302

global RtouchSpikeOffUnit  LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu...
    RtouchSpikeOnUnit LtouchSpikeOnUnit  LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu ...
    RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu pegpatternum pegpatternname... 
    LtPositiveFiringRate LtNegativeFiringRate RtPositiveFiringRate RtNegativeFiringRate LtPositiveSpikeOnKaisuu LtNegativeSpikeOnKaisuu RtPositiveSpikeOnKaisuu RtNegativeSpikeOnKaisuu...
    LtPositiveHistogramXaxis LtNegativeHistogramXaxis RtPositiveHistogramXaxis RtNegativeHistogramXaxis





LtouchUnit=[LtouchSpikeOnUnit;[zeros(length(LtouchSpikeOffUnit(:,1),1)) LtouchSpikeOffUnit]]; %%%% SpikeOffUnit�̑O��ɔ��ΐ����ǉ�����SpikeOnUnit�ƘA���BSpikeOff���̔��ΐ����[���ɐݒ�

RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1),1)) RtouchSpikeOffUnit]];

