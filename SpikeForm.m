function SpikeForm
% ScNumbers�͑S�זE���H4�זE�̏ꍇ��3�D
% CellNumbers�͍זE�ԍ��A1,2,3,4...�A�������A0������B�ǂ̍זE�ɂ��Y�����Ȃ��L�^�i�H�j
% DataPoints��1�����ڂ�32�_�̓d�ʁA2�����ڂ̓e�g���[�h�̃`���l���A3�����ڂ͂��ꂼ��̃X�p�C�N�iModeArray�Ŏw�肵�����́j
clear all;close all;

Filename='G:\CheetahWRLV20200121\70\2018-8-28_17-38-23 7001-61\Sc8.ntt';

FieldSelection(1) = 1;
FieldSelection(2) = 1;
FieldSelection(3) = 1;
FieldSelection(4) = 1;
FieldSelection(5) = 1;

ExtractHeader = 0;%1�ɂ���Ƃ��܂������Ȃ��B���Ԃ�AHeader���Ȃ��ꍇ������B

ExtractMode = 3;%�L�^���ꂽ�_�̂�Extract.�܂�A臒l�𒴂����_�̂݁B

ModeArray=[1:100000];%�L�^���ꂽ�_�̐��B�s���Ȃ̂ŁA��ߗʂ�100000�����Ă���BError���\������邪�v�Z���Ă����B

 [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints] = ...
     Nlx2MatSpike( Filename, FieldSelection, ExtractHeader, ExtractMode, ModeArray );

 for n=1:max(CellNumbers)
    SpikeForm=DataPoints(:,:,CellNumbers==n);%����̍זE�̃X�p�C�N�g�`�𔲂��o���B
    MeanSpikeForm=mean(SpikeForm,3);
    Max=max(MeanSpikeForm);Min=min(MeanSpikeForm);
    Dif=Max-Min;
    Half=Max-Dif./2;
%     find(Dif==max(Dif));
    
    figure
    for m=1:4
        subplot(4,1,m)
        plot(MeanSpikeForm(:,m));hold on
        plot([1:1:32],ones(1,32)*Half(m),'k');
    end

 end



 