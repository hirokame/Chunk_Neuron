function LtIntervalAverage5Touch
%�s�[�N�Ԃ�4�̃C���^�[�o���̕��ς��Ƃ��āA3�ڂ̃E�C���h�E����ɂ��ĕ��ς̃C���^�[�o���ŃE�C���h�E��ݒ肷��
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 W123rate TouchCount pegpatternum LtIntervalAverageTouchCount LtSpike_TouchRate LtIntervalAverageSpikeFR_Bin

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
    LtIntervalAverageSpike_Touch=[];
    LtIntervalAverageSpike_TouchRate=[];
    LtIntervalAverageSpikeFR_Bin=[];
    if abs(Linterval1(3))<abs(Linterval2(3)) %Linterval2(2),Linterval2(1),Linterval1(1),Linterval1(2),Linterval1(3)�̃s�[�N
        
        Interval1=Linterval2(1)-Linterval2(2);
        Interval2=Linterval1(1)-Linterval2(1);
        Interval3=Linterval1(2)-Linterval1(1);
        Interval4=Linterval1(3)-Linterval1(2);
        
        IntervalAverage=(Interval1+Interval2+Interval3+Interval4)/4; %interval�̕��όv�Z
        WindowS1=(Linterval1(1)-2*IntervalAverage)*10-90;
        WindowE1=(Linterval1(1)-2*IntervalAverage)*10+90;
        WindowS2=(Linterval1(1)-IntervalAverage)*10-90;
        WindowE2=(Linterval1(1)-IntervalAverage)*10+90;
        WindowS3=Linterval1(1)*10-90;
        WindowE3=Linterval1(1)*10+90;
        WindowS4=(Linterval1(1)+IntervalAverage)*10-90;
        WindowE4=(Linterval1(1)+IntervalAverage)*10+90;
        WindowS5=(Linterval1(1)+2*IntervalAverage)*10-90;
        WindowE5=(Linterval1(1)+2*IntervalAverage)*10+90;
        
        WindowS0=(Linterval1(1)-3*IntervalAverage)*10-90-IntervalAverage;
        WindowE0=(Linterval1(1)-3*IntervalAverage)*10+90+IntervalAverage;
        WindowS6=(Linterval1(1)+3*IntervalAverage)*10-90-IntervalAverage;
        WindowE6=(Linterval1(1)+3*IntervalAverage)*10+90+IntervalAverage;
        
    elseif abs(Linterval1(3))>=abs(Linterval2(3)) %Linterval2(3),Linterval2(2),Linterval2(1),Linterval1(1),Linterval1(2)
        Interval1=Linterval2(2)-Linterval2(3);
        Interval2=Linterval2(1)-Linterval2(2);
        Interval3=Linterval1(1)-Linterval2(1);
        Interval4=Linterval1(2)-Linterval1(1);
        IntervalAverage=(Interval1+Interval2+Interval3+Interval4)/4; %interval�̕��όv�Z
        
        WindowS1=(Linterval2(1)-2*IntervalAverage)*10-90;
        WindowE1=(Linterval2(1)-2*IntervalAverage)*10+90;
        WindowS2=(Linterval2(1)-IntervalAverage)*10-90;
        WindowE2=(Linterval2(1)-IntervalAverage)*10+90;
        WindowS3=Linterval2(1)*10-90;
        WindowE3=Linterval2(1)*10+90;
        WindowS4=(Linterval2(1)+IntervalAverage)*10-90;
        WindowE4=(Linterval2(1)+IntervalAverage)*10+90;
        WindowS5=(Linterval2(1)+2*IntervalAverage)*10-90;
        WindowE5=(Linterval2(1)+2*IntervalAverage)*10+90;
        
        WindowS0=(Linterval2(1)-3*IntervalAverage)*10-90-IntervalAverage;
        WindowE0=(Linterval2(1)-3*IntervalAverage)*10+90+IntervalAverage;
        WindowS6=(Linterval2(1)+3*IntervalAverage)*10-90-IntervalAverage;
        WindowE6=(Linterval2(1)+3*IntervalAverage)*10+90+IntervalAverage;
    end
    SpikeWindowS=-20;
    SpikeWindowE=20;
    
    %�E�C���h�E�̕�180�~���b������Ă����z��p��
    MoveTouchInterval0=WindowS1-WindowE0;
    MoveTouchInterval1=WindowS2-WindowE1;
    MoveTouchInterval2=WindowS3-WindowE1;
    MoveTouchInterval3=WindowS4-WindowE1;
    MoveTouchInterval4=WindowS5-WindowE1;
    MoveTouchInterval5=WindowS6-WindowE1;
    
    MoveWindowArray_90=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;
    MoveSpikeInterval=SpikeWindowS-WindowE1;
    
    LtTouchCountW0=0;
    LtTouchCountW1=0;
    LtTouchCountW2seq=0;
    LtTouchCountW2notseq=0;
    LtTouchCountW3seq=0;
    LtTouchCountW3notseq=0;
    LtTouchCountW4seq=0;
    LtTouchCountW4notseq=0;
    LtTouchCountW5seq=0;
    LtTouchCountW2345=0;
    LtTouchCountW1345=0;
    LtTouchCountW1245=0;
    LtTouchCountW1235=0;
    LtTouchCountW1234=0;
    LtTouchCountW123=0;
    LtTouchCountW345=0;
    LtTouchCountW5only=0;
    
%     LtSpikeCountW0=0;
%     LtSpikeCountW1=0;
%     LtSpikeCountW2seq=0;
%     LtSpikeCountW2notseq=0;
%     LtSpikeCountW3seq=0;
%     LtSpikeCountW3notseq=0;
%     LtSpikeCountW4seq=0;
%     LtSpikeCountW4notseq=0;
%     LtSpikeCountW5seq=0;
    Spike_W0=0;
    Spike_W1=0;
    Spike_W2seq=0;
    Spike_W3seq=0;
    Spike_W4seq=0;
    Spike_W5seq=0;
    Spike_W2notseq=0;
    Spike_W3notseq=0;
    Spike_W4notseq=0;
    Spike_W2345=0;
    Spike_W1345=0;
    Spike_W1245=0;
    Spike_W1235=0;
    Spike_W1234=0;
    Spike_W123=0;
    Spike_W345=0;
    Spike_W5only=0;

    %�S�Ẵ^�b�`���āA�p�ӂ���5�̃E�C���h�E�ɂǂꂾ�����Ă͂܂��Ă��邩���ׂ�
    WaterBreakTime=[];
    WaterRestartTime=[];
    for n=1:length(LpegTouchallWon)-1
        LpegTouchWonInterval1=LpegTouchallWon(n+1)-LpegTouchallWon(n);
        if LpegTouchWonInterval1>1000
            WaterBreakTime=[WaterBreakTime;LpegTouchallWon(n)];
            WaterRestartTime=[WaterRestartTime;LpegTouchallWon(n+1)];
        end
    end
    WaterBreakRestartArray=[WaterBreakTime,WaterRestartTime];
    for n=1:MoveWindowArray_90
        MoveWindow0=0;
        MoveWindow1=0;
        MoveWindow2=0;
        MoveWindow3=0;
        MoveWindow4=0;
        MoveWindow5=0;
        MoveWindow6=0;
        MoveWindowSpike=0;
        MoveWindow1Start=LpegTouchallWon(1)+(n-1)*10;
        MoveWindow1End=MoveWindow1Start+180;
        MoveWindow2Start=MoveWindow1End+MoveTouchInterval1;
        MoveWindow2End=MoveWindow2Start+180;  
        MoveWindow3Start=MoveWindow1End+MoveTouchInterval2;
        MoveWindow3End=MoveWindow3Start+180;
        MoveWindow4Start=MoveWindow1End+MoveTouchInterval3;
        MoveWindow4End=MoveWindow4Start+180;
        MoveWindow5Start=MoveWindow1End+MoveTouchInterval4;
        MoveWindow5End=MoveWindow5Start+180;
        MoveWindowSpikeStart=MoveWindow1End+MoveSpikeInterval;
        MoveWindowSpikeEnd=MoveWindowSpikeStart+40;
        MoveWindow0End=MoveWindow1Start-MoveTouchInterval0+IntervalAverage;
        MoveWindow0Start=MoveWindow0End-IntervalAverage-180-IntervalAverage;
        MoveWindow6Start=MoveWindow1End+MoveTouchInterval5-IntervalAverage;
        MoveWindow6End=MoveWindow6Start+180+IntervalAverage+IntervalAverage;
        
        a=0;
        if ~isempty(WaterBreakRestartArray) 
            for k=1:length(WaterBreakRestartArray(:,1))
                if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow5End<WaterBreakRestartArray(k,2)
                    a=1;
                end
            end
        end
        if a==0
            for k=1:(length(SpikeArrayWon))
                if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                    MoveWindowSpike=1;
                end
            end
            for j=1:(length(LpegTouchallWon))
                if LpegTouchallWon(j)>MoveWindow1Start && MoveWindow1End>LpegTouchallWon(j)
                    MoveWindow1=1;
                end 
                if LpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>LpegTouchallWon(j)
                    MoveWindow2=1;
                end 
                if LpegTouchallWon(j)>MoveWindow3Start && MoveWindow3End>LpegTouchallWon(j)
                    MoveWindow3=1;
                end 
                if LpegTouchallWon(j)>MoveWindow4Start && MoveWindow4End>LpegTouchallWon(j)
                    MoveWindow4=1;
                end 
                if LpegTouchallWon(j)>MoveWindow5Start && MoveWindow5End>LpegTouchallWon(j)
                    MoveWindow5=1;
                end 
                if LpegTouchallWon(j)>MoveWindow0Start && MoveWindow0End>LpegTouchallWon(j)
                    MoveWindow0=1;
                end 
                if LpegTouchallWon(j)>MoveWindow6Start && MoveWindow6End>LpegTouchallWon(j)
                    MoveWindow6=1;
                end 
            end
            %MoveWindowSpike=1�������Ƃ��A�e�E�C���h�E���Ă͂܂����Ƃ��̔��Ή�
            if MoveWindowSpike==1
                for k=1:(length(SpikeArrayWon))
                   if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                       %�E�C���h�E�ǂ�����Ă͂܂�Ȃ�
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W0=Spike_W0+1;
                        end
                        %�E�C���h�E�����ꂩ�����
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W1=Spike_W1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W1=Spike_W1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W1=Spike_W1+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W1=Spike_W1+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W1=Spike_W1+1;
                        end 
                        %�E�C���h�E�A����2���Ă͂܂�
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W2seq=Spike_W2seq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W2seq=Spike_W2seq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W2seq=Spike_W2seq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W2seq=Spike_W2seq+1;
                        end
                        %�E�C���h�E�A���łȂ����̂�2��
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W2notseq=Spike_W2notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W2notseq=Spike_W2notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W2notseq=Spike_W2notseq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W2notseq=Spike_W2notseq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W2notseq=Spike_W2notseq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W2notseq=Spike_W2notseq+1;
                        end
                        %�E�C���h�E�A����3���Ă͂܂�
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W3seq=Spike_W3seq+1;
                            Spike_W123=Spike_W123+1;%�E�C���h�E45�ɓ��Ă͂܂�Ȃ��B�X�p�C�N�����O�̃E�C���h�E3��
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W3seq=Spike_W3seq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W3seq=Spike_W3seq+1;
                            Spike_W345=Spike_W345+1;%�E�C���h�E12�ɓ��Ă͂܂�Ȃ��B�X�p�C�N������̃E�C���h�E3��
                        end
                        %�E�C���h�E�A���łȂ����̂�3��
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W3notseq=Spike_W3notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W3notseq=Spike_W3notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W3notseq=Spike_W3notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W3notseq=Spike_W3notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W3notseq=Spike_W3notseq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W3notseq=Spike_W3notseq+1;
                        end
                        %�E�C���h�E�A����4���Ă͂܂�
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W4seq=Spike_W4seq+1;
                            Spike_W1234=Spike_W1234+1;%�E�C���h�E5�������Ă͂܂�Ȃ�
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W4seq=Spike_W4seq+1;
                            Spike_W2345=Spike_W2345+1;%�E�C���h�E1�������Ă͂܂�Ȃ�
                        end
                        %�E�C���h�E�A���łȂ����̂�4��
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W4notseq=Spike_W4notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W4notseq=Spike_W4notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W4notseq=Spike_W4notseq+1;
                        end
                        %�E�C���h�E�A����5���Ă͂܂�
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W5seq=Spike_W5seq+1;
                        end
                        %�E�C���h�E2�������Ă͂܂�Ȃ�
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W1345=Spike_W1345+1;
                        end
                        %�E�C���h�E3�������Ă͂܂�Ȃ�
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W1245=Spike_W1245+1;
                        end
                        %�E�C���h�E4�������Ă͂܂�Ȃ�
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W1235=Spike_W1235+1;
                        end
                        %�E�C���h�E�A����5���Ă͂܂邪�A���̗��ׂ͓��Ă͂܂�Ȃ�
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            Spike_W5only=Spike_W5only+1;
                        end
                   end
                end
            end
            
            
            %�E�C���h�E�ǂ�����Ă͂܂�Ȃ�
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                LtTouchCountW0=LtTouchCountW0+1;
            end
            %�E�C���h�E�����ꂩ�����
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                LtTouchCountW1=LtTouchCountW1+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                LtTouchCountW1=LtTouchCountW1+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                LtTouchCountW1=LtTouchCountW1+1;
            end 
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                LtTouchCountW1=LtTouchCountW1+1;
            end 
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW1=LtTouchCountW1+1;
            end 
            %�E�C���h�E�A����2���Ă͂܂�
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                LtTouchCountW2seq=LtTouchCountW2seq+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                LtTouchCountW2seq=LtTouchCountW2seq+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                LtTouchCountW2seq=LtTouchCountW2seq+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW2seq=LtTouchCountW2seq+1;
            end
            %�E�C���h�E�A���łȂ����̂�2��
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
            end
            %�E�C���h�E�A����3���Ă͂܂�
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                LtTouchCountW3seq=LtTouchCountW3seq+1;
                LtTouchCountW123=LtTouchCountW123+1;%�E�C���h�E45�ɓ��Ă͂܂�Ȃ��B�X�p�C�N�����O�̃E�C���h�E3��
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                LtTouchCountW3seq=LtTouchCountW3seq+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW3seq=LtTouchCountW3seq+1;
                LtTouchCountW345=LtTouchCountW345+1;%�E�C���h�E12�ɓ��Ă͂܂�Ȃ��B�X�p�C�N������̃E�C���h�E3��
            end
            %�E�C���h�E�A���łȂ����̂�3��
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
            end
            %�E�C���h�E�A����4���Ă͂܂�
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                LtTouchCountW4seq=LtTouchCountW4seq+1;
                LtTouchCountW1234=LtTouchCountW1234+1;%�E�C���h�E5�������Ă͂܂�Ȃ�
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW4seq=LtTouchCountW4seq+1;
                LtTouchCountW2345=LtTouchCountW2345+1;%�E�C���h�E�P�������Ă͂܂�Ȃ�
            end
            %�E�C���h�E�A���łȂ����̂�4��
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW4notseq=LtTouchCountW4notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW4notseq=LtTouchCountW4notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW4notseq=LtTouchCountW4notseq+1;
            end
            %�E�C���h�E�A����5���Ă͂܂�
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW5seq=LtTouchCountW5seq+1;
            end
            %�E�C���h�E2�������Ă͂܂�Ȃ�
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW1345=LtTouchCountW1345+1;
            end
            %�E�C���h�E3�������Ă͂܂�Ȃ�
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                LtTouchCountW1245=LtTouchCountW1245+1;
            end
            %�E�C���h�E4�������Ă͂܂�Ȃ�
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                LtTouchCountW1235=LtTouchCountW1235+1;
            end
            %�E�C���h�E�A����5���Ă͂܂邪�A���̗��ׂ͓��Ă͂܂�Ȃ�
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                LtTouchCountW5only=LtTouchCountW5only+1;
            end
%             %�r�����ɓ��Ă͂܂����Ƃ��̂����A�ǂꂾ�����΂��Ă邩
%             %�E�C���h�E�ǂ�����Ă͂܂�Ȃ�
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW0=LtSpikeCountW0+1;
%             end
%             %�E�C���h�E�����ꂩ�����
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW1=LtSpikeCountW1+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW1=LtSpikeCountW1+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW1=LtSpikeCountW1+1;
%             end 
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW1=LtSpikeCountW1+1;
%             end 
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW1=LtSpikeCountW1+1;
%             end 
%             %�E�C���h�E�A����2���Ă͂܂�
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW2seq=LtSpikeCountW2seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW2seq=LtSpikeCountW2seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW2seq=LtSpikeCountW2seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW2seq=LtSpikeCountW2seq+1;
%             end
%             %�E�C���h�E�A���łȂ����̂�2��
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW2notseq=LtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW2notseq=LtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW2notseq=LtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW2notseq=LtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW2notseq=LtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW2notseq=LtSpikeCountW2notseq+1;
%             end
%             %�E�C���h�E�A����3���Ă͂܂�
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW3seq=LtSpikeCountW3seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW3seq=LtSpikeCountW3seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW3seq=LtSpikeCountW3seq+1;
%             end
%             %�E�C���h�E�A���łȂ����̂�3��
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW3notseq=LtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW3notseq=LtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW3notseq=LtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW3notseq=LtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW3notseq=LtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW3notseq=LtSpikeCountW3notseq+1;
%             end
%             %�E�C���h�E�A����4���Ă͂܂�
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW4seq=LtSpikeCountW4seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW4seq=LtSpikeCountW4seq+1;
%             end
%             %�E�C���h�E�A���łȂ����̂�4��
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW4notseq=LtSpikeCountW4notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW4notseq=LtSpikeCountW4notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW4notseq=LtSpikeCountW4notseq+1;
%             end
%             %�E�C���h�E�A����5���Ă͂܂�
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW5seq=LtSpikeCountW5seq+1;
%             end
        end
    end
    %�e�r�����Ƀ^�b�`���Ă͂܂�����
    LtIntervalAverageSpike=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W2345,Spike_W1345,Spike_W1245,Spike_W1235,Spike_W1234,Spike_W123,Spike_W345,Spike_W5only];
    LtIntervalAverageTouchCount=[LtTouchCountW0,LtTouchCountW1,LtTouchCountW2seq,LtTouchCountW3seq,LtTouchCountW4seq,LtTouchCountW5seq,LtTouchCountW2345,LtTouchCountW1345,LtTouchCountW1245,LtTouchCountW1235,LtTouchCountW1234,LtTouchCountW123,LtTouchCountW345,LtTouchCountW5only];
%     LtSpikeCountArray=[LtSpikeCountW0,LtSpikeCountW1,LtSpikeCountW2seq,LtSpikeCountW3seq,LtSpikeCountW4seq,LtSpikeCountW5seq,LtTouchCountW2345,LtTouchCountW1345,LtTouchCountW1245,LtTouchCountW1235,LtTouchCountW1234];
    fig1=figure;
    bar(LtIntervalAverageTouchCount)
    set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','123','345','1-5'});
    trimtfile=strtrim(tfile);
    figname=['LtIntervalAverage5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig1,figname);
    close(fig1);  
    %
    %���Εp�x���o���B�e�r�����ɁA�X�p�C�N�̑��񐔂��A�g�[�^������(����蓖�Ă͂܂����񐔁~10ms)�Ŋ���B
    for n=1:length(LtIntervalAverageSpike)
        if LtIntervalAverageTouchCount(n)~=0;
            LtIntervalAverageSpikeFR_Bin=[LtIntervalAverageSpikeFR_Bin LtIntervalAverageSpike(n)/(LtIntervalAverageTouchCount(n)*10)];
        else
            LtIntervalAverageSpikeFR_Bin=[LtIntervalAverageSpikeFR_Bin LtIntervalAverageTouchCount(n)];
        end
    end
    fig6=figure;
    bar(LtIntervalAverageSpikeFR_Bin)
    set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','123','345','1-5'});
    trimtfile=strtrim(tfile);
    %�E�C���h�E�ɂǂꂾ���^�b�`���Ă͂܂������̖_�O���t
    figname=['LtIntervalAverage5TouchSpikeFR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    FLName=['LtIntervalAverage',pegpatternum,pegpatternname];
    save(FLName,'LtIntervalAverageSpike','LtIntervalAverageTouchCount','LtIntervalAverageSpikeFR_Bin');

end