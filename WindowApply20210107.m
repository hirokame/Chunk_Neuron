function WindowApply20210107

global RtouchSpikeOnUnit LtouchSpikeOnUnit LtPositiveSpikeOnKaisuu RtPositiveSpikeOnKaisuu LtPositiveHistogramXaxis RtPositiveHistogramXaxis...
    LtPositiveFiringRate RtPositiveFiringRate LtPositiveSpikeOffKaisuu RtPositiveSpikeOffKaisuu


%%%%%%%%LtouchSpikeOnUnit��figure�쐬
LtPositiveSpikeOnKaisuu=zeros(1,2);
LtPositiveHistogramXaxis=zeros(1,2);  %%%%% Positive�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j2�v�f�i����ȉ��A�A���R�ȏ�j

%%%%%%%Positive
LtouchPositive5windowPoint=LtouchSpikeOnUnit(:,(1:6));%%%% ���ΐ���Positive���������o��
for i=1:length(LtouchPositive5windowPoint(:,1))
    if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,1]);
       LtPositiveHistogramXaxis(2)=LtPositiveHistogramXaxis(2)+LtouchPositive5windowPoint(i,1); %%%%�T�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveSpikeOnKaisuu(2)=LtPositiveSpikeOnKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,1]) | all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,0]) ;%%%%4�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveHistogramXaxis(2)=LtPositiveHistogramXaxis(2)+LtouchPositive5windowPoint(i,1); 
       LtPositiveSpikeOnKaisuu(2)=LtPositiveSpikeOnKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,1])| all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,0])...
            | all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,0]);                           %%%% 3�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); 
       LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,0,0,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,0,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,0])...
            | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,1]);                           %%%% 2�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); 
       LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[1,0,0,0,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,1,0,0,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,0,0])...
            | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,1]);    %%%% �P�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); 
       LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,0]);
       LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); %%%�P�x�����Ă͂܂�Ȃ����̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
    end
end

%%%%%% Rtouch %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%RtouchSpikeOnUnit��figure�쐬
RtPositiveSpikeOnKaisuu=zeros(1,2);
RtPositiveHistogramXaxis=zeros(1,2);  %%%%% Positive�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j�Q�v�f�i�A���Q�ȉ��B�A���R�ȏ�j

%%%%%%%Positive
RtouchPositive5windowPoint=RtouchSpikeOnUnit(:,(1:6));%%%% ���ΐ���Positive���������o��
for i=1:length(RtouchPositive5windowPoint(:,1))
    if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,1]);
       RtPositiveHistogramXaxis(2)=RtPositiveHistogramXaxis(2)+RtouchPositive5windowPoint(i,1); %%%%�T�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveSpikeOnKaisuu(2)=RtPositiveSpikeOnKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,1]) | all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,0]) ;%%%%4�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveHistogramXaxis(2)=RtPositiveHistogramXaxis(2)+RtouchPositive5windowPoint(i,1); 
       RtPositiveSpikeOnKaisuu(2)=RtPositiveSpikeOnKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,1]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,0]);                           %%%% 3�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(i,1); 
       RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,0,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,1]);                           %%%% 2�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(i,1); 
       RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[1,0,0,0,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,0,0])...
            | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,1]);    %%%% �P�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(1); 
       RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,0]);
       RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(i,1); %%%�P�x�����Ă͂܂�Ȃ����̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
    end
end

WindowApplySpikeOff20210107

LtPositiveFiringRate=LtPositiveHistogramXaxis./((LtPositiveSpikeOnKaisuu+LtPositiveSpikeOffKaisuu)*10);
RtPositiveFiringRate=RtPositiveHistogramXaxis./((RtPositiveSpikeOnKaisuu+RtPositiveSpikeOffKaisuu)*10);

