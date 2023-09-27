function SpikeForm20191122
%CheetahWRLV20180729Part1�ɕۑ�����Ă��邷�ׂĂ�tfile�̍זE�̃f�[�^�ɑ΂���HalfPeakwidth��PeaktoTrough���v�Z���ăv���b�g
% ScNumbers�͑S�זE���H4�זE�̏ꍇ��3�D
% CellNumbers�͍זE�ԍ��A1,2,3,4...�A�������A0������B�ǂ̍זE�ɂ��Y�����Ȃ��L�^�i�H�j
% DataPoints��1�����ڂ�32�_�̓d�ʁA2�����ڂ̓e�g���[�h�̃`���l���A3�����ڂ͂��ꂼ��̃X�p�C�N�iModeArray�Ŏw�肵�����́j
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
               
               
               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���t�H���_�̑I����%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filename='C:\Users\C238\Desktop\CheetahData\2019-10-16_14-2-34 17901-04\Sc7.ntt';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ntt�t�@�C���̑I����������������������������������������������������������������
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
    meanwidth=mean(tet4width);%tet4width:1�̍זE��4�`�����l������HalfPeakwidth�̃r����
    AllCellwidth=[AllCellwidth meanwidth];
    meanPtoT=mean(tet4PtoT);%tet4ptoT:1�̍זE��4�`�����l������PeaktoTrough�̃r����
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