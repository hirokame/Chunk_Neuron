function SpikeDataAnalysis
clear all;
close all;
% SpikeDayMatrix//���t�ABgra�ۑ�ԍ��A89or89�ۑ�ԍ��AC�ۑ�ԍ��A�e�g���[�hx8�i>Ratio�ARcell���j

%�@AllSpikeData�̗�@���蓖��

TargetDirectory='C:\Users\B133_2\Desktop\CheetahWRLV\119';

cd(TargetDirectory);

% cd('C:\Users\B133_2\Desktop\CheetahWRLV\119');
load AllSpikeData

% AllSpikeData
%���זE��
%14.�E���^�b�`�����L���A4�{
%15.�����^�b�`�����L���A4�{
%16.���E�ǂ��炩�ł��^�b�`����
%17.�l���~Modulation�L���A2�{
%18.�l���~Modulation�L���A2.5�{
%19.�l���~Modulation�L���A3�{

%���ɂ�
%���̓��̑S�זE��
%Bgra, 98or89, C+��3�킪�����Ă��邩
%�E���^�b�`�����זE��
%�����^�b�`�����זE��
%���ǂ��炩�^�b�`�����זE��
Line=0;
Mouse=0;
Date=0;
Pattern=0;
SpikeDataMatrix=zeros(300,11,7);
for n=1:length(AllSpikeData(:,1))
    MouseA=AllSpikeData(n,1);
    DateA=AllSpikeData(n,2);
    PatternA=AllSpikeData(n,3);
    if Mouse==MouseA && Date==DateA && Pattern==PatternA
    else
        Line=Line+1;
        SpikeDataMatrix(Line,1,:)=MouseA;
        Mouse=MouseA;
        SpikeDataMatrix(Line,2,:)=DateA;
        Date=DateA;
        SpikeDataMatrix(Line,3,:)=PatternA;
        Pattern=PatternA;
    end
    if AllSpikeData(n,5)>=0.5%0.5Hz�ȏ�̎��ɍזE�J�E���g
%         Line
        SpikeDataMatrix(Line,3+AllSpikeData(n,4),1)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),1)+1;%�זE��
    
        if AllSpikeData(n,6)>=4%�E��
            SpikeDataMatrix(Line,3+AllSpikeData(n,4),2)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),2)+1;
        end
        if AllSpikeData(n,7)>=4%����
            SpikeDataMatrix(Line,3+AllSpikeData(n,4),3)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),3)+1;
        end
        if AllSpikeData(n,6)>=4 || AllSpikeData(n,7)>=4%�ǂ��炩�̑�
            SpikeDataMatrix(Line,3+AllSpikeData(n,4),4)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),4)+1;
        
            if AllSpikeData(n,8)>=2 %Ratio x2
                SpikeDataMatrix(Line,3+AllSpikeData(n,4),5)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),5)+1;
            end
            if AllSpikeData(n,8)>=2.5 %Ratio x2
                SpikeDataMatrix(Line,3+AllSpikeData(n,4),6)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),6)+1;
            end
            if AllSpikeData(n,8)>=3 %Ratio x2
                SpikeDataMatrix(Line,3+AllSpikeData(n,4),7)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),7)+1;
            end
        end
    end
end
SpikeDataMatrix(Line+1:300,:,:)=[];
a=SpikeDataMatrix(:,:,7)

%�ǂ��������߂邽�߂ɁB���[����ADay, Bgra, 89or98, C, tetrodex8
SizeSDM=size(SpikeDataMatrix);
SpikeDayMatrix=zeros(300,12);
Day=SpikeDataMatrix(1,2,1);
Sum=0;
SumBgra=0;
Sum98=0;
Line=1;
for n=1:length(SpikeDataMatrix(:,1,1))
SpikeDataMatrix(n,2,1)
    if SpikeDataMatrix(n,2,1)==Day
        SpikeDayMatrix(Line,1)=Day;
        SpikeDataMatrix(n,3,1)
        if SpikeDataMatrix(n,3,1)==6%Bgra
            Sum1=sum(SpikeDataMatrix(n,4:11,3));
            if Sum1>=SumBgra
                SumBgra=Sum1;
                SpikeDayMatrix(Line,2)=SpikeDataMatrix(n,1,1);%task#
                SpikeDayMatrix(Line,2)
                if Sum1>=Sum%SpikeDayMatrix(Line,2)==0
    %                 SpikeDayMatrix(Line,2)=SpikeDataMatrix(n,1,1);%task#
                    SpikeDayMatrix(Line,5:12)=SpikeDataMatrix(n,4:11,7);
                    Sum=Sum1;
%                 else
%                     Sum=Sum1;
                end
            end
        end
        if SpikeDataMatrix(n,3,1)==3 || SpikeDataMatrix(n,3,1)==4%89or98
            Sum1=sum(SpikeDataMatrix(n,4:11,3));
            if Sum1>=Sum98
                Sum98=Sum1;
                SpikeDayMatrix(Line,3)=SpikeDataMatrix(n,1,1);%task#
                if Sum1>=Sum%SpikeDayMatrix(Line,2)==0
    %                 SpikeDayMatrix(Line,3)=SpikeDataMatrix(n,1,1);%task#
                    SpikeDayMatrix(Line,5:12)=SpikeDataMatrix(n,4:11,7);
                    Sum=Sum1;
                end
            end
        end
        if SpikeDataMatrix(n,3,1)>=7 || SpikeDataMatrix(n,3,1)<=14%complex
            SpikeDayMatrix(Line,4)=SpikeDataMatrix(n,1,1);%task#
        end
    else
        Day=SpikeDataMatrix(n,2,1);
        Line=Line+1;
        Sum=0;
        SumBgra=0;
        Sum98=0;
        SpikeDayMatrix(Line,1)=Day;
        SpikeDataMatrix(n,3,1)
        if SpikeDataMatrix(n,3,1)==6%Bgra
            Sum1=sum(SpikeDataMatrix(n,4:11,3));
            if Sum1>=SumBgra
                SumBgra=Sum1;
                SpikeDayMatrix(Line,2)=SpikeDataMatrix(n,1,1);%task#
                SpikeDayMatrix(Line,2)
                if Sum1>=Sum%SpikeDayMatrix(Line,2)==0
    %                 SpikeDayMatrix(Line,2)=SpikeDataMatrix(n,1,1);%task#
                    SpikeDayMatrix(Line,5:12)=SpikeDataMatrix(n,4:11,7);
                    Sum=Sum1;
%                 else
%                     Sum=Sum1;
                end
            end
        end
        if SpikeDataMatrix(n,3,1)==3 || SpikeDataMatrix(n,3,1)==4%89or98
            Sum1=sum(SpikeDataMatrix(n,4:11,3));
            if Sum1>=Sum98
                Sum98=Sum1;
                SpikeDayMatrix(Line,3)=SpikeDataMatrix(n,1,1);%task#
                if Sum1>=Sum%SpikeDayMatrix(Line,2)==0
    %                 SpikeDayMatrix(Line,3)=SpikeDataMatrix(n,1,1);%task#
                    SpikeDayMatrix(Line,5:12)=SpikeDataMatrix(n,4:11,7);
                    Sum=Sum1;
                end
            end
        end
        if SpikeDataMatrix(n,3,1)>=7 || SpikeDataMatrix(n,3,1)<=14%complex
            SpikeDayMatrix(Line,4)=SpikeDataMatrix(n,1,1);%task#
        end
    end
end
SpikeDayMatrix(Line+1:300,:)=[];,
% SpikeDayMatrix//���t�ABgra�ۑ�ԍ��A89or89�ۑ�ԍ��AC�ۑ�ԍ��A�e�g���[�hx8�i>Ratio�ARcell���j

%Tetrode���Ƃɂ킯��

S4=AllSpikeData(:,4);
for n=1:max(AllSpikeData(:,4))
%     eval(['Spike',int2str(n),'=[];']);
    idx=find(S4==n);
    SpikeData{n}=AllSpikeData(idx,:);
%     eval(['SpikeData',int2str(n),'=AllSpikeData(idx,:);']);
end
SpikeData
a=SpikeData{1}
b=SpikeData{2}

