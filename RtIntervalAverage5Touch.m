function RtIntervalAverage5Touch
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 pegpatternum RtIntervalAverageTouchCount RtIntervalAverageSpikeFR_Bin RtSpike_TouchRate

%SpikeArrayでLPegTouchAll、RpegTouchallをアラインしたクロスコリオグラム
%SpikeArrayでLPegTouchAllをアラインする
duration=5000;
CrossCoL=[];
CrossCoR=[];
%両方向
for n=1:(length(SpikeArrayWon))
        Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoL=[CrossCoL Interval];
end
CrossCoL=[-1*duration/2 CrossCoL duration/2];
CrossCoL(CrossCoL==0)=[];
bin=500;
% CCresultLtouchWonの更新に必要
CCresultLtouchWon=hist(CrossCoL,bin);
CCresultLtouchWon=CCresultLtouchWon/sum(CCresultLtouchWon);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);
%SpikeArrayでRPegTouchAllをアラインする
for n=1:(length(SpikeArrayWon))
        Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoR=[CrossCoR Interval];
end
CrossCoR=[-1*duration/2 CrossCoR duration/2];
CrossCoR(CrossCoR==0)=[];
% CCresultRtouchWonの更新に必要
CCresultRtouchWon=hist(CrossCoR,bin);
CCresultRtouchWon=CCresultRtouchWon/sum(CCresultRtouchWon);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);

% クロスコリオグラムからピークを検出
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
    RtIntervalAverageSpike_Touch=[];
    RtIntervalAverageSpike_TouchRate=[];
    RtIntervalAverageSpikeFR_Bin=[];
    if abs(Rinterval1(3))<abs(Rinterval2(3)) %Rinterval2(2),Rinterval2(1),Rinterval1(1),Rinterval1(2),Rinterval1(3)のピーク
        Interval1=Rinterval2(1)-Rinterval2(2);
        Interval2=Rinterval1(1)-Rinterval2(1);
        Interval3=Rinterval1(2)-Rinterval1(1);
        Interval4=Rinterval1(3)-Rinterval1(2);
        IntervalAverage=(Interval1+Interval2+Interval3+Interval4)/4; %intervalの平均計算
        WindowS1=(Rinterval1(1)-2*IntervalAverage)*10-90;
        WindowE1=(Rinterval1(1)-2*IntervalAverage)*10+90;
        WindowS2=(Rinterval1(1)-IntervalAverage)*10-90;
        WindowE2=(Rinterval1(1)-IntervalAverage)*10+90;
        WindowS3=Rinterval1(1)*10-90;
        WindowE3=Rinterval1(1)*10+90;
        WindowS4=(Rinterval1(1)+IntervalAverage)*10-90;
        WindowE4=(Rinterval1(1)+IntervalAverage)*10+90;
        WindowS5=(Rinterval1(1)+2*IntervalAverage)*10-90;
        WindowE5=(Rinterval1(1)+2*IntervalAverage)*10+90;
        
        WindowS0=(Rinterval1(1)-3*IntervalAverage)*10-90-IntervalAverage;
        WindowE0=(Rinterval1(1)-3*IntervalAverage)*10+90+IntervalAverage;
        WindowS6=(Rinterval1(1)+3*IntervalAverage)*10-90-IntervalAverage;
        WindowE6=(Rinterval1(1)+3*IntervalAverage)*10+90+IntervalAverage;
        
    elseif abs(Rinterval1(3))>=abs(Rinterval2(3)) %Rinterval2(3),Rinterval2(2),Rinterval2(1),Rinterval1(1),Rinterval1(2)
        Interval1=Rinterval2(2)-Rinterval2(3);
        Interval2=Rinterval2(1)-Rinterval2(2);
        Interval3=Rinterval1(1)-Rinterval2(1);
        Interval4=Rinterval1(2)-Rinterval1(1);
        IntervalAverage=(Interval1+Interval2+Interval3+Interval4)/4; %intervalの平均計算
        WindowS1=(Rinterval2(1)-2*IntervalAverage)*10-90;
        WindowE1=(Rinterval2(1)-2*IntervalAverage)*10+90;
        WindowS2=(Rinterval2(1)-IntervalAverage)*10-90;
        WindowE2=(Rinterval2(1)-IntervalAverage)*10+90;
        WindowS3=Rinterval2(1)*10-90;
        WindowE3=Rinterval2(1)*10+90;
        WindowS4=(Rinterval2(1)+IntervalAverage)*10-90;
        WindowE4=(Rinterval2(1)+IntervalAverage)*10+90;
        WindowS5=(Rinterval2(1)+2*IntervalAverage)*10-90;
        WindowE5=(Rinterval2(1)+2*IntervalAverage)*10+90;
        
        WindowS0=(Rinterval2(1)-3*IntervalAverage)*10-90-IntervalAverage;
        WindowE0=(Rinterval2(1)-3*IntervalAverage)*10+90+IntervalAverage;
        WindowS6=(Rinterval2(1)+3*IntervalAverage)*10-90-IntervalAverage;
        WindowE6=(Rinterval2(1)+3*IntervalAverage)*10+90+IntervalAverage;
        
    end
    SpikeWindowS=-20;
    SpikeWindowE=20;
    
    %ウインドウの幅180ミリ秒ずつずれていく配列用意
    MoveTouchInterval0=WindowS1-WindowE0;
    MoveTouchInterval1=WindowS2-WindowE1;
    MoveTouchInterval2=WindowS3-WindowE1;
    MoveTouchInterval3=WindowS4-WindowE1;
    MoveTouchInterval4=WindowS5-WindowE1;
    MoveTouchInterval5=WindowS6-WindowE1;
    
    MoveWindowArray_90=fix((RpegTouchallWon(end)-RpegTouchallWon(1))/10)+1;
    MoveSpikeInterval=SpikeWindowS-WindowE1;
    
    RtTouchCountW0=0;
    RtTouchCountW1=0;
    RtTouchCountW2seq=0;
    RtTouchCountW2notseq=0;
    RtTouchCountW3seq=0;
    RtTouchCountW3notseq=0;
    RtTouchCountW4seq=0;
    RtTouchCountW4notseq=0;
    RtTouchCountW5seq=0;
    RtTouchCountW2345=0;
    RtTouchCountW1345=0;
    RtTouchCountW1245=0;
    RtTouchCountW1235=0;
    RtTouchCountW1234=0;
    RtTouchCountW123=0;
    RtTouchCountW345=0;
    RtTouchCountW5only=0;
%     RtSpikeCountW0=0;
%     RtSpikeCountW1=0;
%     RtSpikeCountW2seq=0;
%     RtSpikeCountW2notseq=0;
%     RtSpikeCountW3seq=0;
%     RtSpikeCountW3notseq=0;
%     RtSpikeCountW4seq=0;
%     RtSpikeCountW4notseq=0;
%     RtSpikeCountW5seq=0;
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
    %全てのタッチ見て、用意した5つのウインドウにどれだけ当てはまっているか調べる
    WaterBreakTime=[];
    WaterRestartTime=[];
    for n=1:length(RpegTouchallWon)-1
        RpegTouchWonInterval1=RpegTouchallWon(n+1)-RpegTouchallWon(n);
        if RpegTouchWonInterval1>1000
            WaterBreakTime=[WaterBreakTime;RpegTouchallWon(n)];
            WaterRestartTime=[WaterRestartTime;RpegTouchallWon(n+1)];
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
            for j=1:(length(RpegTouchallWon))
                if RpegTouchallWon(j)>MoveWindow1Start && MoveWindow1End>RpegTouchallWon(j)
                    MoveWindow1=1;
                end 
                if RpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>RpegTouchallWon(j)
                    MoveWindow2=1;
                end 
                if RpegTouchallWon(j)>MoveWindow3Start && MoveWindow3End>RpegTouchallWon(j)
                    MoveWindow3=1;
                end 
                if RpegTouchallWon(j)>MoveWindow4Start && MoveWindow4End>RpegTouchallWon(j)
                    MoveWindow4=1;
                end 
                if RpegTouchallWon(j)>MoveWindow5Start && MoveWindow5End>RpegTouchallWon(j)
                    MoveWindow5=1;
                end 
                if RpegTouchallWon(j)>MoveWindow0Start && MoveWindow0End>RpegTouchallWon(j)
                    MoveWindow0=1;
                end 
                if RpegTouchallWon(j)>MoveWindow6Start && MoveWindow6End>RpegTouchallWon(j)
                    MoveWindow6=1;
                end 
            end
            %MoveWindowSpike=1だったとき、各ウインドウ当てはまったときの発火回数
            if MoveWindowSpike==1
                for k=1:(length(SpikeArrayWon))
                   if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                       %ウインドウどれもあてはまらない
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W0=Spike_W0+1;
                        end
                        %ウインドウいずれか一つだけ
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
                        %ウインドウ連続で2個当てはまる
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
                        %ウインドウ連続でないもので2個
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
                        %ウインドウ連続で3個当てはまる
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                            Spike_W3seq=Spike_W3seq+1;
                            Spike_W123=Spike_W123+1;%ウインドウ45に当てはまらない。スパイクよりも前のウインドウ3つ
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W3seq=Spike_W3seq+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W3seq=Spike_W3seq+1;
                            Spike_W345=Spike_W345+1;%ウインドウ12に当てはまらない。スパイクよりも後のウインドウ3つ
                        end
                        %ウインドウ連続でないもので3個
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
                        %ウインドウ連続で4個当てはまる
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                            Spike_W4seq=Spike_W4seq+1;
                            Spike_W1234=Spike_W1234+1;%ウインドウ5だけ当てはまらない
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W4seq=Spike_W4seq+1;
                            Spike_W2345=Spike_W2345+1;%ウインドウ1だけ当てはまらない
                        end
                        %ウインドウ連続でないもので4個
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W4notseq=Spike_W4notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W4notseq=Spike_W4notseq+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W4notseq=Spike_W4notseq+1;
                        end
                        %ウインドウ連続で5個当てはまる
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W5seq=Spike_W5seq+1;
                        end
                        %ウインドウ2だけ当てはまらない
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W1345=Spike_W1345+1;
                        end
                        %ウインドウ3だけ当てはまらない
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                            Spike_W1245=Spike_W1245+1;
                        end
                        %ウインドウ4だけ当てはまらない
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                            Spike_W1235=Spike_W1235+1;
                        end
                        %ウインドウ連続で5個当てはまるが、その両隣は当てはまらない
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            Spike_W5only=Spike_W5only+1;
                        end
                   end
                end
            end
            
            
            %ウインドウどれもあてはまらない
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                RtTouchCountW0=RtTouchCountW0+1;
            end
            %ウインドウいずれか一つだけ
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                RtTouchCountW1=RtTouchCountW1+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                RtTouchCountW1=RtTouchCountW1+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                RtTouchCountW1=RtTouchCountW1+1;
            end 
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                RtTouchCountW1=RtTouchCountW1+1;
            end 
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW1=RtTouchCountW1+1;
            end 
            %ウインドウ連続で2個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0
                RtTouchCountW2seq=RtTouchCountW2seq+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                RtTouchCountW2seq=RtTouchCountW2seq+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                RtTouchCountW2seq=RtTouchCountW2seq+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW2seq=RtTouchCountW2seq+1;
            end
            %ウインドウ連続でないもので2個
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
            end
            %ウインドウ連続で3個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0
                RtTouchCountW3seq=RtTouchCountW3seq+1;
                RtTouchCountW123=RtTouchCountW123+1;%ウインドウ45に当てはまらない。スパイクよりも前のウインドウ3つ
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                RtTouchCountW3seq=RtTouchCountW3seq+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW3seq=RtTouchCountW3seq+1;
                RtTouchCountW345=RtTouchCountW345+1;%ウインドウ12に当てはまらない。スパイクよりも後のウインドウ3つ
            end
            %ウインドウ連続でないもので3個
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
            end
            %ウインドウ連続で4個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0
                RtTouchCountW4seq=RtTouchCountW4seq+1;
                RtTouchCountW1234=RtTouchCountW1234+1;%ウインドウ5だけ当てはまらない
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW4seq=RtTouchCountW4seq+1;
                RtTouchCountW2345=RtTouchCountW2345+1;%ウインドウ１だけ当てはまらない
            end
            %ウインドウ連続でないもので4個
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW4notseq=RtTouchCountW4notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW4notseq=RtTouchCountW4notseq+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW4notseq=RtTouchCountW4notseq+1;
            end
            %ウインドウ連続で5個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW5seq=RtTouchCountW5seq+1;
            end
            %ウインドウ2だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW1345=RtTouchCountW1345+1;
            end
            %ウインドウ3だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1
                RtTouchCountW1245=RtTouchCountW1245+1;
            end
            %ウインドウ4だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1
                RtTouchCountW1235=RtTouchCountW1235+1;
            end
            %ウインドウ連続で5個当てはまるが、その両隣は当てはまらない
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                RtTouchCountW5only=RtTouchCountW5only+1;
            end
%             %ビン毎に当てはまったときのうち、どれだけ発火してるか
%             %ウインドウどれもあてはまらない
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW0=RtSpikeCountW0+1;
%             end
%             %ウインドウいずれか一つだけ
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW1=RtSpikeCountW1+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW1=RtSpikeCountW1+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW1=RtSpikeCountW1+1;
%             end 
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW1=RtSpikeCountW1+1;
%             end 
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW1=RtSpikeCountW1+1;
%             end 
%             %ウインドウ連続で2個当てはまる
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW2seq=RtSpikeCountW2seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW2seq=RtSpikeCountW2seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW2seq=RtSpikeCountW2seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW2seq=RtSpikeCountW2seq+1;
%             end
%             %ウインドウ連続でないもので2個
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW2notseq=RtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW2notseq=RtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW2notseq=RtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW2notseq=RtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW2notseq=RtSpikeCountW2notseq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW2notseq=RtSpikeCountW2notseq+1;
%             end
%             %ウインドウ連続で3個当てはまる
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW3seq=RtSpikeCountW3seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW3seq=RtSpikeCountW3seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW3seq=RtSpikeCountW3seq+1;
%             end
%             %ウインドウ連続でないもので3個
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW3notseq=RtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW3notseq=RtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW3notseq=RtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW3notseq=RtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW3notseq=RtSpikeCountW3notseq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW3notseq=RtSpikeCountW3notseq+1;
%             end
%             %ウインドウ連続で4個当てはまる
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 RtSpikeCountW4seq=RtSpikeCountW4seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW4seq=RtSpikeCountW4seq+1;
%             end
%             %ウインドウ連続でないもので4個
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW4notseq=RtSpikeCountW4notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW4notseq=RtSpikeCountW4notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW4notseq=RtSpikeCountW4notseq+1;
%             end
%             %ウインドウ連続で5個当てはまる
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 RtSpikeCountW5seq=RtSpikeCountW5seq+1;
%             end
        end
    end
    %各ビン毎にタッチ当てはまった回数
    RtIntervalAverageSpike=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W2345,Spike_W1345,Spike_W1245,Spike_W1235,Spike_W1234,Spike_W123,Spike_W345,Spike_W5only];
    RtIntervalAverageTouchCount=[RtTouchCountW0,RtTouchCountW1,RtTouchCountW2seq,RtTouchCountW3seq,RtTouchCountW4seq,RtTouchCountW5seq,RtTouchCountW2345,RtTouchCountW1345,RtTouchCountW1245,RtTouchCountW1235,RtTouchCountW1234,RtTouchCountW123,RtTouchCountW345,RtTouchCountW5only];
%     RtSpikeCountArray=[RtSpikeCountW0,RtSpikeCountW1,RtSpikeCountW2seq,RtSpikeCountW3seq,RtSpikeCountW4seq,RtSpikeCountW5seq,RtSpikeCountW2notseq,RtSpikeCountW3notseq,RtSpikeCountW4notseq];
    fig1=figure;
    bar(RtIntervalAverageTouchCount)
    set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','123','345','1-5'});
    trimtfile=strtrim(tfile);
    figname=['RtIntervalAverage5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig1,figname);
    close(fig1);  
    %
    %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
    for n=1:length(RtIntervalAverageSpike)
        if RtIntervalAverageTouchCount(n)~=0;
            RtIntervalAverageSpikeFR_Bin=[RtIntervalAverageSpikeFR_Bin RtIntervalAverageSpike(n)/(RtIntervalAverageTouchCount(n)*10)];
        else
            RtIntervalAverageSpikeFR_Bin=[RtIntervalAverageSpikeFR_Bin RtIntervalAverageTouchCount(n)];
        end
    end
    fig6=figure;
    bar(RtIntervalAverageSpikeFR_Bin)
    set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','123','345','1-5'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['RtIntervalAverage5TouchSpikeFR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    FLName=['RtIntervalAverage',pegpatternum,pegpatternname];
    save(FLName,'RtIntervalAverageSpike','RtIntervalAverageTouchCount','RtIntervalAverageSpikeFR_Bin');
end