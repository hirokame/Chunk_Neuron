function SpikeFormfigSave20200129
%SpikeForm��Fig�ۑ��p
% ScNumbers�͑S�זE���H4�זE�̏ꍇ��3�D
% CellNumbers�͍זE�ԍ��A1,2,3,4...�A�������A0������B�ǂ̍זE�ɂ��Y�����Ȃ��L�^�i�H�j
% DataPoints��1�����ڂ�32�_�̓d�ʁA2�����ڂ̓e�g���[�h�̃`���l���A3�����ڂ͂��ꂼ��̃X�p�C�N�iModeArray�Ŏw�肵�����́j
clear all;close all;

Filename='G:\CheetahWRLV20200121\78\2018-6-29_16-24-28 7801-51\Sc1.ntt';
SessionName=['2018-6-29_16-24-28 7801-51'];
tetName=['Sc1'];


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
    tet4width=[];
    tet4PtoT=[];
    SpikeFig=figure;
    for m=1:4
        findpeaks(MeanSpikeForm(:,m).','Annotate','extents')
        [pks,locs,widths,proms] = findpeaks(MeanSpikeForm(:,m).');
        tet4width=[tet4width widths];
        [maxvalue MaxIndex]=max(MeanSpikeForm(:,m).');
        [minvalue MinIndex]=min(MeanSpikeForm(MaxIndex:end,m).');
        PtoT=abs(MinIndex);
        tet4PtoT=[tet4PtoT PtoT];
        subplot(4,1,m)
        plot(MeanSpikeForm(:,m));%hold on
        %plot([1:1:32],ones(1,32)*Half(m),'k');
    end
        Meanwidth=mean(tet4width);
        MeanPtoT=mean(tet4PtoT);
        
        FigName=[SessionName,tetName,'-',num2str(n),'.bmp'];
        Old=cd;
        cd('C:\Users\C238\Desktop\terashita\figure2');
        saveas(SpikeFig,FigName);
        cd(Old);
 end

