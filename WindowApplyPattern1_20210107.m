function WindowApplyPattern1_20210107

global RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit LtPositiveSpikeOnKaisuuP1 RtPositiveSpikeOnKaisuuP1...
    LtPositiveHistogramXaxisP1 RtPositiveHistogramXaxisP1 LtPositiveFiringRateP1 RtPositiveFiringRateP1

LtPositiveSpikeOnKaisuuP1=zeros(1,2);%%%%%%%�E�B���h�E�ɉ��񓖂Ă͂܂�����
LtPositiveHistogramXaxisP1=zeros(1,2);  %%%%% Positive�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j�Q�v�f�i2�ȉ��A3�ȏ�j
%%%%%%Ltouch
%%%%%positive
LtouchPositive5windowPointSpikeOnP1=LtouchSpikeOnUnit(:,(1:6));%%%% ���ΐ���POsitive���������o��
for i=1:length(LtouchPositive5windowPointSpikeOnP1(:,1))
    IndexSpikeOnPositive=find(LtouchPositive5windowPointSpikeOnP1(i,(2:6))==1);
    
    
    if length(IndexSpikeOnPositive)==5;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�5��̏ꍇ
        LtPositiveSpikeOnKaisuuP1(2)=LtPositiveSpikeOnKaisuuP1(2)+1;
        LtPositiveHistogramXaxisP1(2)=LtPositiveHistogramXaxisP1(2)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==4;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�4��̏ꍇ
        LtPositiveSpikeOnKaisuuP1(2)=LtPositiveSpikeOnKaisuuP1(2)+1;
        LtPositiveHistogramXaxisP1(2)=LtPositiveHistogramXaxisP1(2)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==3;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�3��̏ꍇ
        LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
        LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==2;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�2��̏ꍇ
        LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
        LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==1;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�1��̏ꍇ
        LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
        LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==0;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�0��̏ꍇ
        LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
        LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
end

LtPositiveSpikeOffKaisuuP1=zeros(1,2);
%%%%%%%Positive  Spikeoff
LtouchPositive5windowPointSpikeOffP1=LtouchSpikeOffUnit(:,(1:5));%%%% Positive���������o��
for i=1:length(LtouchPositive5windowPointSpikeOffP1(:,1))
    IndexSpikeOffPositive=find(LtouchPositive5windowPointSpikeOffP1(i,(1:5))==1);
    
    if length(IndexSpikeOffPositive)==5;   %%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�5��̏ꍇ
       LtPositiveSpikeOffKaisuuP1(2)=LtPositiveSpikeOffKaisuuP1(2)+1;
    end
    
    if  length(IndexSpikeOffPositive)==4;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�4��̏ꍇ
        LtPositiveSpikeOffKaisuuP1(2)=LtPositiveSpikeOffKaisuuP1(2)+1;
    end
    
    if length(IndexSpikeOffPositive)==3;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�3��̏ꍇ 
       LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==2;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�2��̏ꍇ 
       LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==1;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�1��̏ꍇ 
       LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==0;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�0��̏ꍇ 
       LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
    end
end

RtPositiveSpikeOnKaisuuP1=zeros(1,2);%%%%%%%�E�B���h�E�ɉ��񓖂Ă͂܂�����
RtPositiveHistogramXaxisP1=zeros(1,2);  %%%%% Positive�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j�U�v�f�i0�A1�A2�A3�A4�A5�j
%%%%%%Rtouch
%%%%%positive
RtouchPositive5windowPointSpikeOnP1=RtouchSpikeOnUnit(:,(1:6));%%%% ���ΐ���POsitive���������o��
for i=1:length(RtouchPositive5windowPointSpikeOnP1(:,1))
    IndexSpikeOnPositive=find(RtouchPositive5windowPointSpikeOnP1(i,(2:6))==1);
    if length(IndexSpikeOnPositive)==5;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�5��̏ꍇ
        RtPositiveSpikeOnKaisuuP1(2)=RtPositiveSpikeOnKaisuuP1(2)+1;
        RtPositiveHistogramXaxisP1(2)=RtPositiveHistogramXaxisP1(2)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==4;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�4��̏ꍇ
        RtPositiveSpikeOnKaisuuP1(2)=RtPositiveSpikeOnKaisuuP1(2)+1;
        RtPositiveHistogramXaxisP1(2)=RtPositiveHistogramXaxisP1(2)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==3;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�3��̏ꍇ
        RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
        RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==2;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�2��̏ꍇ
        RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
        RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==1;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�1��̏ꍇ
        RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
        RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==0;  %%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�0��̏ꍇ
        RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
        RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
end

RtPositiveSpikeOffKaisuuP1=zeros(1,2);
%%%%%%%Positive  Spikeoff
RtouchPositive5windowPointSpikeOffP1=RtouchSpikeOffUnit(:,(1:5));%%%% POsitive���������o��
for i=1:length(RtouchPositive5windowPointSpikeOffP1(:,1))
    IndexSpikeOffPositive=find(RtouchPositive5windowPointSpikeOffP1(i,(1:5))==1);
    
    if length(IndexSpikeOffPositive)==5;   %%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�5��̏ꍇ
       RtPositiveSpikeOffKaisuuP1(2)=RtPositiveSpikeOffKaisuuP1(2)+1;
    end
    
    if  length(IndexSpikeOffPositive)==4;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�4��̏ꍇ
        RtPositiveSpikeOffKaisuuP1(2)=RtPositiveSpikeOffKaisuuP1(2)+1;
    end
    
    if length(IndexSpikeOffPositive)==3;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�3��̏ꍇ 
       RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==2;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�2��̏ꍇ 
       RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==1;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�1��̏ꍇ 
       RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==0;%%%%�E�B���h�E�ɓ��Ă͂܂����񐔂�0��̏ꍇ 
       RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
    end
end

LtPositiveFiringRateP1=LtPositiveHistogramXaxisP1./((LtPositiveSpikeOnKaisuuP1+LtPositiveSpikeOffKaisuuP1)*10);
RtPositiveFiringRateP1=RtPositiveHistogramXaxisP1./((RtPositiveSpikeOnKaisuuP1+RtPositiveSpikeOffKaisuuP1)*10);
