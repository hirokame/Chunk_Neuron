function WindowApplySpikeOff20210107

global RtouchSpikeOffUnit LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu

%%%%%%%%LtouchSpikeffUnit�̏ꍇ����
LtPositiveSpikeOffKaisuu=zeros(1,2);
LtPositiveHistogramXaxis=zeros(1,2);  %%%%% Positive�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j�Q�v�f�i�A���Q�ȉ��A�A��3�ȏ�j

%%%%%%%Positive
LtouchPositive5windowPoint=LtouchSpikeOffUnit(:,(1:5));%%%% Positive���������o��
for i=1:length(LtouchPositive5windowPoint(:,1))
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,1]);                                    %%%%�T�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveSpikeOffKaisuu(2)=LtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,1]) | all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,0]) ;%%%%4�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       
       LtPositiveSpikeOffKaisuu(2)=LtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,1]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,0])...
            | all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,0]);                           %%%% 3�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,0,0,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,0,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,0])...
            | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,1]);                           %%%% 2�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,0,0,0,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,1,0,0,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,0,0])...
            | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,1]);    %%%% �P�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,0]);                         %%%�P�x�����Ă͂܂�Ȃ����̔��ΐ����ǂ�ǂ񂽂��Ă���
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
end


%%%%%% Rtouch %%%%%%%%%%
RtPositiveSpikeOffKaisuu=zeros(1,2);  %%%%% Positive�q�X�g�O�������쐬����ۂ̔��Εp�x�i�����l�[���j2�v�f�i�A���Q�ȉ��A�A��3�ȏ�j

%%%%%%%Positive
RtouchPositive5windowPoint=RtouchSpikeOffUnit(:,(1:5));%%%% ���ΐ���POsitive���������o��
for i=1:length(RtouchPositive5windowPoint(:,1))
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,1]);                           %%%%�T�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveSpikeOffKaisuu(2)=RtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,1]) | all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,0]) ;%%%%4�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveSpikeOffKaisuu(2)=RtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,1]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,0]);                           %%%% 3�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,1]);                           %%%% 2�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,0,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,0,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,1]);    %%%% �P�A���œ��Ă͂܂������̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,0]);                                  %%%�P�x�����Ă͂܂�Ȃ����̔��ΐ����ǂ�ǂ񂽂��Ă���
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
end