function SpikeFormfigSave20200129
%SpikeFormのFig保存用
% ScNumbersは全細胞数？4細胞の場合は3．
% CellNumbersは細胞番号、1,2,3,4...、ただし、0もある。どの細胞にも該当しない記録（？）
% DataPointsの1次元目は32点の電位、2次元目はテトロードのチャネル、3次元目はそれぞれのスパイク（ModeArrayで指定したもの）
clear all;close all;

Filename='G:\CheetahWRLV20200121\78\2018-6-29_16-24-28 7801-51\Sc1.ntt';
SessionName=['2018-6-29_16-24-28 7801-51'];
tetName=['Sc1'];


FieldSelection(1) = 1;
FieldSelection(2) = 1;
FieldSelection(3) = 1;
FieldSelection(4) = 1;
FieldSelection(5) = 1;

ExtractHeader = 0;%1にするとうまくいかない。たぶん、Headerがない場合がある。

ExtractMode = 3;%記録された点のみExtract.つまり、閾値を超えた点のみ。

ModeArray=[1:100000];%記録された点の数。不明なので、大過量の100000を入れてある。Errorが表示されるが計算してくれる。

 [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints] = ...
     Nlx2MatSpike( Filename, FieldSelection, ExtractHeader, ExtractMode, ModeArray );

 for n=1:max(CellNumbers)
    SpikeForm=DataPoints(:,:,CellNumbers==n);%特定の細胞のスパイク波形を抜き出す。
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

