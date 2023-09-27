function SpikeForm20191122
%CheetahWRLV20180729Part1に保存されているすべてのtfileの細胞のデータに対してHalfPeakwidthとPeaktoTroughを計算してプロット
% ScNumbersは全細胞数？4細胞の場合は3．
% CellNumbersは細胞番号、1,2,3,4...、ただし、0もある。どの細胞にも該当しない記録（？）
% DataPointsの1次元目は32点の電位、2次元目はテトロードのチャネル、3次元目はそれぞれのスパイク（ModeArrayで指定したもの）
clear all;close all;
path=['G:\CheetahWRLV20200121'];
cd(path)
LS1=ls;
AllCellwidth=[];
AllCellPtoT=[];
SumCell=0;
for i=1:length(LS1(:,1))
    trimFolder1=strtrim(LS1(i,:));
    if  ~strcmp(trimFolder1,'.') && ~strcmp(trimFolder1,'..') && isempty(strfind(trimFolder1,'.mat')) && isempty(strfind(trimFolder1,'.bmp'))...
            && isempty(strfind(trimFolder1,'CCSfigure')) && isempty(strfind(trimFolder1,''));
        cd([path,'\',trimFolder1]);
        LS2=ls;
        for j=1:length(LS2(:,1))
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4;
               dpath3=[path,'\',trimFolder1,'\',trimFolder2];
               cd(dpath3)
               
               
               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%↑フォルダの選択↑%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename='C:\Users\C238\Desktop\CheetahData\2019-10-16_14-2-34 17901-04\Sc7.ntt';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%nttファイルの選択％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％
LS3=ls;

for k=1:length(LS3(:,1))
    trimFolder3=strtrim(LS3(k,:));
    if length(trimFolder3)>5 & strcmp(trimFolder3(end-3:end),'.ntt');
       Filename=[dpath3,'\',trimFolder3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%     figure
    for m=1:4
        [pks,locs,widths,proms] = findpeaks(MeanSpikeForm(:,m).');
        tet4width=[tet4width widths];
        [maxvalue MaxIndex]=max(MeanSpikeForm(:,m).');
        [minvalue MinIndex]=min(MeanSpikeForm(:,m).');
        PtoT=abs(MaxIndex-MinIndex);
        tet4PtoT=[tet4PtoT PtoT];
%         subplot(4,1,m)
%         plot(MeanSpikeForm(:,m));hold on
%         plot([1:1:32],ones(1,32)*Half(m),'k');
    end
    meanwidth=mean(tet4width);%tet4width:1つの細胞の4チャンネル分のHalfPeakwidthのビン数
    AllCellwidth=[AllCellwidth meanwidth];
    meanPtoT=mean(tet4PtoT);%tet4ptoT:1つの細胞の4チャンネル分のPeaktoTroughのビン数
    AllCellPtoT=[AllCellPtoT meanPtoT];
%     SumCell=SumCell+max(CellNumbers);
 end 
MeanSpikeForm
SumCell=SumCell+max(CellNumbers);
    end
end
            end

        end

    end

end
 AllCellwidth
AllCellPtoT
SumCell


figure
scatter(AllCellwidth,AllCellPtoT);