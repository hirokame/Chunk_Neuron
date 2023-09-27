function Ltseq5Touch
%�s�[�N�Ԃ�4�̃C���^�[�o���̕��ς��Ƃ��āA3�ڂ̃E�C���h�E����ɂ��ĕ��ς̃C���^�[�o���ŃE�C���h�E��ݒ肷��
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2   pegpatternum LtFR_Array

%SpikeArray��LPegTouchAll�ARpegTouchall���A���C�������N���X�R���I�O����
%SpikeArray��LPegTouchAll���A���C������
duration=5000;
CrossCoL=[];
CrossCoR=[];
%������
for n=1:(length(SpikeArrayWon))
        Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoL=[CrossCoL Interval];
end
CrossCoL=[-1*duration/2 CrossCoL duration/2];
CrossCoL(CrossCoL==0)=[];
bin=500;
% CCresultLtouchWon�̍X�V�ɕK�v
CCresultLtouchWon=hist(CrossCoL,bin);
CCresultLtouchWon=CCresultLtouchWon/sum(CCresultLtouchWon);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);
%SpikeArray��RPegTouchAll���A���C������
for n=1:(length(SpikeArrayWon))
        Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoR=[CrossCoR Interval];
end
CrossCoR=[-1*duration/2 CrossCoR duration/2];
CrossCoR(CrossCoR==0)=[];
% CCresultRtouchWon�̍X�V�ɕK�v
CCresultRtouchWon=hist(CrossCoR,bin);
CCresultRtouchWon=CCresultRtouchWon/sum(CCresultRtouchWon);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);

% �N���X�R���I�O��������s�[�N�����o
% findpeaks(CCresultLtouchWon,'MinPeakDistance',20);
[Lpks,Llocs,Lwidth,Lproms]=findpeaks(CCresultLtouchWon,'MinPeakDistance',25);
findpeaks(CCresultLtouchWon,'MinPeakDistance',25);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>=0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(LlocsInterval2,'descend');
% findpeaks(CCresultRtouchWon,'MinPeakDistance',20);
[Rpks,Rlocs,Rwidth,Rproms]=findpeaks(CCresultRtouchWon,'MinPeakDistance',25);
findpeaks(CCresultRtouchWon,'MinPeakDistance',25);
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>=0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(RlocsInterval2,'descend');
TouchArray=[LlocsInterval,RlocsInterval];
TouchArray1=sort(abs(TouchArray),'ascend');
if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  
    
    seq5timeArray=[];
    seqonly5timeArray=[];
    seq7timeArray=[];
    seqonly7timeArray=[];
    seq9timeArray=[];
    seqonly9timeArray=[];
    SpikeCountArray_5seq=[];
    SpikeCountArray_5only=[];
    SpikeCountArray_7seq=[];
    SpikeCountArray_7only=[];
    SpikeCountArray_9seq=[];
    SpikeCountArray_9only=[];
    if abs(Linterval1(3))<abs(Linterval2(3)) %Linterval2(2),Linterval2(1),Linterval1(1),Linterval1(2),Linterval1(3)�̃s�[�N
        Interval1=Linterval2(1)-Linterval2(2);
        Interval2=Linterval1(1)-Linterval2(1);
        Interval3=Linterval1(2)-Linterval1(1);
        Interval4=Linterval1(3)-Linterval1(2);
        IntervalAverage=(Interval1+Interval2+Interval3+Interval4)/4; %interval�̕��όv�Z
        Spike_PeakInterval=Linterval1(1);
    elseif abs(Linterval1(3))>=abs(Linterval2(3)) %Linterval2(3),Linterval2(2),Linterval2(1),Linterval1(1),Linterval1(2)
        Interval1=Linterval2(2)-Linterval2(3);
        Interval2=Linterval2(1)-Linterval2(2);
        Interval3=Linterval1(1)-Linterval2(1);
        Interval4=Linterval1(2)-Linterval1(1);
        IntervalAverage=(Interval1+Interval2+Interval3+Interval4)/4; %interval�̕��όv
        Spike_PeakInterval=Linterval2(1);
    end
    for n=6:length(LpegTouchallWon)-5
        W0=0;
        W1=0;
        W2=0;
        W3=0;
        W4=0;
        W5=0;
        W6=0;
        W7=0;
        W8=0;
        W9=0;
       if  LpegTouchallWon(n)-IntervalAverage*10-90<LpegTouchallWon(n-1) && LpegTouchallWon(n-1)<LpegTouchallWon(n)-IntervalAverage*10+90
           W4=1;
           if LpegTouchallWon(n-1)-IntervalAverage*10-90<LpegTouchallWon(n-2) && LpegTouchallWon(n-2)<LpegTouchallWon(n-1)-IntervalAverage*10+90
               W3=1;
               if LpegTouchallWon(n-2)-IntervalAverage*10-90<LpegTouchallWon(n-3) && LpegTouchallWon(n-3)<LpegTouchallWon(n-2)-IntervalAverage*10+90
                   W2=1;
                   if LpegTouchallWon(n-3)-IntervalAverage*10-90<LpegTouchallWon(n-4) && LpegTouchallWon(n-4)<LpegTouchallWon(n-3)-IntervalAverage*10+90
                       W1=1;
                       if LpegTouchallWon(n-4)-IntervalAverage*10-90<LpegTouchallWon(n-5) && LpegTouchallWon(n-5)<LpegTouchallWon(n-4)-IntervalAverage*10+90
                           W0=1;
                       end
                   end
                       
               end
           end
       end
       if LpegTouchallWon(n)+IntervalAverage*10-90<LpegTouchallWon(n+1) && LpegTouchallWon(n+1)<LpegTouchallWon(n)+IntervalAverage*10+90
           W5=1;
           if LpegTouchallWon(n+1)+IntervalAverage*10-90<LpegTouchallWon(n+2) && LpegTouchallWon(n+2)<LpegTouchallWon(n+1)+IntervalAverage*10+90
               W6=1;
               if LpegTouchallWon(n+2)+IntervalAverage*10-90<LpegTouchallWon(n+3) && LpegTouchallWon(n+3)<LpegTouchallWon(n+2)+IntervalAverage*10+90
                   W7=1;
                   if LpegTouchallWon(n+3)+IntervalAverage*10-90<LpegTouchallWon(n+4) && LpegTouchallWon(n+4)<LpegTouchallWon(n+3)+IntervalAverage*10+90
                       W8=1;
                       if LpegTouchallWon(n+4)+IntervalAverage*10-90<LpegTouchallWon(n+5) && LpegTouchallWon(n+5)<LpegTouchallWon(n+4)+IntervalAverage*10+90
                           W9=1;
                       end
                   end
               end
           end
       end
       if W3==1 && W4==1 && W5==1 && W6==1 %�E�C���h�E5�A���œ��Ă͂܂��Ă���
           seq5time=[LpegTouchallWon(n-2),LpegTouchallWon(n-1),LpegTouchallWon(n),LpegTouchallWon(n+1),LpegTouchallWon(n+2)];
           seq5timeArray=[seq5timeArray;seq5time];
       end
       if W3==1 && W4==1 && W5==1 && W6==1 && W2==0 && W7==0 %�E�C���h�E5�A���œ��Ă͂܂��Ă��āA���ׂ͓��Ă͂܂��Ă��Ȃ�
           seqonly5time=[LpegTouchallWon(n-2),LpegTouchallWon(n-1),LpegTouchallWon(n),LpegTouchallWon(n+1),LpegTouchallWon(n+2)];
           seqonly5timeArray=[seqonly5timeArray;seqonly5time];
       end
       if W2==1 && W3==1 && W4==1 && W5==1 && W6==1 && W7==1%�E�C���h�E7�A���œ��Ă͂܂��Ă���
           seq7time=[LpegTouchallWon(n-3),LpegTouchallWon(n-2),LpegTouchallWon(n-1),LpegTouchallWon(n),LpegTouchallWon(n+1),LpegTouchallWon(n+2),LpegTouchallWon(n+3)];
           seq7timeArray=[seq7timeArray;seq7time];
       end
       if W2==1 && W3==1 && W4==1 && W5==1 && W6==1 && W7==1 && W1==0 && W8==0 %�E�C���h�E7�A���œ��Ă͂܂��Ă��āA���ד��Ă͂܂��Ă��Ȃ�
           seqonly7time=[LpegTouchallWon(n-3),LpegTouchallWon(n-2),LpegTouchallWon(n-1),LpegTouchallWon(n),LpegTouchallWon(n+1),LpegTouchallWon(n+2),LpegTouchallWon(n+3)];
           seqonly7timeArray=[seqonly7timeArray;seqonly7time];
       end
       if W1==1 && W2==1 && W3==1 && W4==1 && W5==1 && W6==1 && W7==1 && W8==1 %�E�C���h�E9�A���œ��Ă͂܂��Ă���
           seq9time=[LpegTouchallWon(n-4),LpegTouchallWon(n-3),LpegTouchallWon(n-2),LpegTouchallWon(n-1),LpegTouchallWon(n),LpegTouchallWon(n+1),LpegTouchallWon(n+2),LpegTouchallWon(n+3),LpegTouchallWon(n+4)];
           seq9timeArray=[seq9timeArray;seq9time];
       end
       if W1==1 && W2==1 && W3==1 && W4==1 && W5==1 && W6==1 && W7==1 && W8==1 && W0==0 && W9==0 %�E�C���h�E9�A���œ��Ă͂܂��Ă��āA���ד��Ă͂܂��Ă��Ȃ�
           seqonly9time=[LpegTouchallWon(n-4),LpegTouchallWon(n-3),LpegTouchallWon(n-2),LpegTouchallWon(n-1),LpegTouchallWon(n),LpegTouchallWon(n+1),LpegTouchallWon(n+2),LpegTouchallWon(n+3),LpegTouchallWon(n+4)];
           seqonly9timeArray=[seqonly9timeArray;seqonly9time];
       end
    end
    %�E�C���h�E5�A���œ��Ă͂܂��Ă���
    if ~isempty(seq5timeArray)
        for a=1:length(seq5timeArray(:,3))
            SpikeCount_5seq=0;
            SpikeWindowStart_5seq=seq5timeArray(a,3)-Spike_PeakInterval*10-20;
            SpikeWindowEnd_5seq=seq5timeArray(a,3)-Spike_PeakInterval*10+20;
            for n=1:length(SpikeArrayWon)
                if SpikeWindowStart_5seq<SpikeArrayWon(n) && SpikeArrayWon(n)<SpikeWindowEnd_5seq
                    SpikeCount_5seq=SpikeCount_5seq+1;
                end
            end
            SpikeCountArray_5seq=[SpikeCountArray_5seq;SpikeCount_5seq];
        end
        sumSpikeCount_5seq=sum(SpikeCountArray_5seq);%�X�p�C�N�E�C���h�E���Ă͂܂������X�p�C�N��
        seq5time_SpikeCountArray=[seq5timeArray,SpikeCountArray_5seq];%�^�b�`�̎��Ԃ��L�^�����s��ɉ�����
        seq5time_FR=(sumSpikeCount_5seq/(length(seq5timeArray(:,3))*40))*1000;%���Εp�x���v�Z
    else
        seq5time_FR=0;
    end
    %�E�C���h�E5�A���œ��Ă͂܂��Ă��āA���ׂ͓��Ă͂܂��Ă��Ȃ�
    if ~isempty(seqonly5timeArray)
        for a=1:length(seqonly5timeArray(:,3))
            SpikeCount_5only=0;
            SpikeWindowStart_5only=seqonly5timeArray(a,3)-Spike_PeakInterval*10-20;
            SpikeWindowEnd_5only=seqonly5timeArray(a,3)-Spike_PeakInterval*10+20;
            for n=1:length(SpikeArrayWon)
                if SpikeWindowStart_5only<SpikeArrayWon(n) && SpikeArrayWon(n)<SpikeWindowEnd_5only
                    SpikeCount_5only=SpikeCount_5only+1;
                end
            end
            SpikeCountArray_5only=[SpikeCountArray_5only;SpikeCount_5only];
        end
        sumSpikeCount_5only=sum(SpikeCountArray_5only);%�X�p�C�N�E�C���h�E���Ă͂܂������X�p�C�N��
        seqonly5time_SpikeCountArray=[seqonly5timeArray,SpikeCountArray_5only];%�^�b�`�̎��Ԃ��L�^�����s��ɉ�����
        seqonly5time_FR=(sumSpikeCount_5only/(length(seqonly5timeArray(:,3))*40))*1000;%���Εp�x���v�Z
    else
        seqonly5time_FR=0;
    end
    %�E�C���h�E7�A���œ��Ă͂܂��Ă���
    if ~isempty(seq7timeArray)
        for a=1:length(seq7timeArray(:,4))
            SpikeCount_7seq=0;
            SpikeWindowStart_7seq=seq7timeArray(a,4)-Spike_PeakInterval*10-20;
            SpikeWindowEnd_7seq=seq7timeArray(a,4)-Spike_PeakInterval*10+20;
            for n=1:length(SpikeArrayWon)
                if SpikeWindowStart_7seq<SpikeArrayWon(n) && SpikeArrayWon(n)<SpikeWindowEnd_7seq
                    SpikeCount_7seq=SpikeCount_7seq+1;
                end
            end
            SpikeCountArray_7seq=[SpikeCountArray_7seq;SpikeCount_7seq];
        end
        sumSpikeCount_7seq=sum(SpikeCountArray_7seq);%�X�p�C�N�E�C���h�E���Ă͂܂������X�p�C�N��
        seq7time_SpikeCountArray=[seq7timeArray,SpikeCountArray_7seq];%�^�b�`�̎��Ԃ��L�^�����s��ɉ�����
        seq7time_FR=(sumSpikeCount_7seq/(length(seq7timeArray(:,4))*40))*1000;%���Εp�x���v�Z
    else
        seq7time_FR=0;
    end
    %�E�C���h�E7�A���œ��Ă͂܂��Ă��āA���ד��Ă͂܂��Ă��Ȃ�
    if ~isempty(seqonly7timeArray)
        for a=1:length(seqonly7timeArray(:,4))
            SpikeCount_7only=0;
            SpikeWindowStart_7only=seqonly7timeArray(a,4)-Spike_PeakInterval*10-20;
            SpikeWindowEnd_7only=seqonly7timeArray(a,4)-Spike_PeakInterval*10+20;
            for n=1:length(SpikeArrayWon)
                if SpikeWindowStart_7only<SpikeArrayWon(n) && SpikeArrayWon(n)<SpikeWindowEnd_7only
                    SpikeCount_7only=SpikeCount_7only+1;
                end
            end
            SpikeCountArray_7only=[SpikeCountArray_7only;SpikeCount_7only];
        end
        sumSpikeCount_7only=sum(SpikeCountArray_7only);%�X�p�C�N�E�C���h�E���Ă͂܂������X�p�C�N��
        seqonly7time_SpikeCountArray=[seqonly7timeArray,SpikeCountArray_7only];%�^�b�`�̎��Ԃ��L�^�����s��ɉ�����
        seqonly7time_FR=(sumSpikeCount_7only/(length(seqonly7timeArray(:,4))*40))*1000;%���Εp�x���v�Z
    else
        seqonly7time_FR=0;
    end
    %�E�C���h�E9�A���œ��Ă͂܂��Ă���
    if ~isempty(seq9timeArray)
        for a=1:length(seq9timeArray(:,5))
            SpikeCount_9seq=0;
            SpikeWindowStart_9seq=seq9timeArray(a,5)-Spike_PeakInterval*10-20;
            SpikeWindowEnd_9seq=seq9timeArray(a,5)-Spike_PeakInterval*10+20;
            for n=1:length(SpikeArrayWon)
                if SpikeWindowStart_9seq<SpikeArrayWon(n) && SpikeArrayWon(n)<SpikeWindowEnd_9seq
                    SpikeCount_9seq=SpikeCount_9seq+1;
                end
            end
            SpikeCountArray_9seq=[SpikeCountArray_9seq;SpikeCount_9seq];
        end
        sumSpikeCount_9seq=sum(SpikeCountArray_9seq);%�X�p�C�N�E�C���h�E���Ă͂܂������X�p�C�N��
        seq9time_SpikeCountArray=[seq9timeArray,SpikeCountArray_9seq];%�^�b�`�̎��Ԃ��L�^�����s��ɉ�����
        seq9time_FR=(sumSpikeCount_9seq/(length(seq9timeArray(:,5))*40))*1000;%���Εp�x���v�Z
    else
        seq9time_FR=0;
    end
    %�E�C���h�E9�A���œ��Ă͂܂��Ă��āA���ד��Ă͂܂��Ă��Ȃ�
    if ~isempty(seqonly9timeArray)
        for a=1:length(seqonly9timeArray(:,5))
            SpikeCount_9only=0;
            SpikeWindowStart_9only=seqonly9timeArray(a,5)-Spike_PeakInterval*10-20;
            SpikeWindowEnd_9only=seqonly9timeArray(a,5)-Spike_PeakInterval*10+20;
            for n=1:length(SpikeArrayWon)
                if SpikeWindowStart_9only<SpikeArrayWon(n) && SpikeArrayWon(n)<SpikeWindowEnd_9only
                    SpikeCount_9only=SpikeCount_9only+1;
                end
            end
            SpikeCountArray_9only=[SpikeCountArray_9only;SpikeCount_9only];
        end
        sumSpikeCount_9only=sum(SpikeCountArray_9only);%�X�p�C�N�E�C���h�E���Ă͂܂������X�p�C�N��
        seqonly9time_SpikeCountArray=[seqonly9timeArray,SpikeCountArray_9only];%�^�b�`�̎��Ԃ��L�^�����s��ɉ�����
        seqonly9time_FR=(sumSpikeCount_9only/(length(seqonly9timeArray(:,5))*40))*1000;%���Εp�x���v�Z
    else
        seqonly9time_FR=0;
    end
    
    LtFR_Array=[seq5time_FR,seqonly5time_FR,seq7time_FR,seqonly7time_FR,seq9time_FR,seqonly9time_FR];
    fig1=figure;
    bar(LtFR_Array);
    set(gca,'xticklabel',{'5seq','5only','7seq','7only','9seq','9only'});
    trimtfile=strtrim(tfile);
    figname=['LtseqFR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig1,figname);
    close(fig1); 
    
end
   