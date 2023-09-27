function RtPeakTouch
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 pegpatternum RtTouchCount RtSpikeFR_Bin RtSpike_TouchRate...
    RtTouchCount1 RtTouchCount2 RtTouchCount3 RtTouchCount4 RtSpike1FR_Bin RtSpike2FR_Bin RtSpike3FR_Bin RtSpike4FR_Bin


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
    RtSpike_Touch=[];
    RtSpike_TouchRate=[];
    RtSpikeFR_Bin=[];
    RtSpike1FR_Bin=[];
    RtSpike2FR_Bin=[];
    RtSpike3FR_Bin=[];
    RtSpike4FR_Bin=[];
    if abs(Rinterval1(3))<abs(Rinterval2(3)) %Rinterval2(2),Rinterval2(1),Rinterval1(1),Rinterval1(2),Rinterval1(3)のピーク
        WindowS1=Rinterval2(2)*10-90;
        WindowE1=Rinterval2(2)*10+90;
        WindowS2=Rinterval2(1)*10-90;
        WindowE2=Rinterval2(1)*10+90;
        WindowS3=Rinterval1(1)*10-90;
        WindowE3=Rinterval1(1)*10+90;
        WindowS4=Rinterval1(2)*10-90;
        WindowE4=Rinterval1(2)*10+90;
        WindowS5=Rinterval1(3)*10-90;
        WindowE5=Rinterval1(3)*10+90;
    elseif abs(Rinterval1(3))>=abs(Rinterval2(3)) %Rinterval2(3),Rinterval2(2),Rinterval2(1),Rinterval1(1),Rinterval1(2)
        WindowS1=Rinterval2(3)*10-90;
        WindowE1=Rinterval2(3)*10+90;
        WindowS2=Rinterval2(2)*10-90;
        WindowE2=Rinterval2(2)*10+90;
        WindowS3=Rinterval2(1)*10-90;
        WindowE3=Rinterval2(1)*10+90;
        WindowS4=Rinterval1(1)*10-90;
        WindowE4=Rinterval1(1)*10+90;
        WindowS5=Rinterval1(2)*10-90;
        WindowE5=Rinterval1(2)*10+90;
    end
    SpikeWindowS=-20;
    SpikeWindowE=20;
    
    %ウインドウの幅180ミリ秒ずつずれていく配列用意
    MoveTouchInterval1=WindowS2-WindowE1;
    MoveTouchInterval2=WindowS3-WindowE1;
    MoveTouchInterval3=WindowS4-WindowE1;
    MoveTouchInterval4=WindowS5-WindowE1;
    MoveTouchIntervalAverage=(MoveTouchInterval1+MoveTouchInterval2+MoveTouchInterval3+MoveTouchInterval4)/4; %インターバルの平均を出す。
    
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
    RtTouchCountW3only=0;
    RtTouchCountW2seqonly=0;
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
    Spike_W3only=0;
    Spike_W2seqonly=0;
    Spike_W5only=0;
    
    W1=0;
    W2=0;
    W3=0;
    W4=0;
    W5=0;
    W12=0;
    W23=0;
    W34=0;
    W45=0;
    W13=0;
    W14=0;
    W15=0;
    W24=0;
    W25=0;
    W35=0;
    W123=0;
    W234=0;
    W345=0;
    W125=0;
    W124=0;
    W134=0;
    W135=0;
    W145=0;
    W235=0;
    W245=0;
    W1234=0;
    W1235=0;
    W1245=0;
    W1345=0;
    W2345=0;
    W12345=0;
    RtW1=0;
    RtW2=0;
    RtW3=0;
    RtW4=0;
    RtW5=0;
    RtW12=0;
    RtW23=0;
    RtW34=0;
    RtW45=0;
    RtW13=0;
    RtW14=0;
    RtW15=0;
    RtW24=0;
    RtW25=0;
    RtW35=0;
    RtW123=0;
    RtW234=0;
    RtW345=0;
    RtW125=0;
    RtW124=0;
    RtW134=0;
    RtW135=0;
    RtW145=0;
    RtW235=0;
    RtW245=0;
    RtW1234=0;
    RtW1235=0;
    RtW1245=0;
    RtW1345=0;
    RtW2345=0;
    RtW12345=0;

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
        MoveWindow1=0;
        MoveWindow2=0;
        MoveWindow3=0;
        MoveWindow4=0;
        MoveWindow5=0;
        MoveWindow0=0;
        MoveWindow6=0;
        MoveWindowSpike=0;
        MoveWindow1Start=RpegTouchallWon(1)+(n-1)*10;
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
        MoveWindow6Start=MoveWindow5Start+MoveTouchIntervalAverage;
        MoveWindow6End=MoveWindow5End+MoveTouchIntervalAverage;
        MoveWindow0Start=MoveWindow1Start-MoveTouchIntervalAverage;
        MoveWindow0End=MoveWindow1End-MoveTouchIntervalAverage;
        
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
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W0=Spike_W0+1;
                        end
                        %ウインドウいずれか一つだけ
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W1=Spike_W1+1;
                            W1=W1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W1=Spike_W1+1;
                            W2=W2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W1=Spike_W1+1;
                            Spike_W3only=Spike_W3only+1;
                            W3=W3+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W1=Spike_W1+1;
                            W4=W4+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W1=Spike_W1+1;
                            W5=W5+1;
                        end 
                        %ウインドウ連続で2個当てはまる
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2seq=Spike_W2seq+1;
                            W12=W12+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2seq=Spike_W2seq+1;
                            Spike_W2seqonly=Spike_W2seqonly+1;
                            W23=W23+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2seq=Spike_W2seq+1;
                            Spike_W2seqonly=Spike_W2seqonly+1;
                            W34=W34+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2seq=Spike_W2seq+1;
                            W45=W45+1;
                        end
                        %ウインドウ連続でないもので2個
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2notseq=Spike_W2notseq+1;
                            W13=W13+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2notseq=Spike_W2notseq+1;
                            W14=W14+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2notseq=Spike_W2notseq+1;
                            W15=W15+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2notseq=Spike_W2notseq+1;
                            W24=W24+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2notseq=Spike_W2notseq+1;
                            W25=W25+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W2notseq=Spike_W2notseq+1;
                            W35=W35+1;
                        end
                        %ウインドウ連続で3個当てはまる
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3seq=Spike_W3seq+1;
                            Spike_W123=Spike_W123+1;%ウインドウ45に当てはまらない。スパイクよりも前のウインドウ3つ
                            W123=W123+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3seq=Spike_W3seq+1;
                            W234=W234+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3seq=Spike_W3seq+1;
                            Spike_W345=Spike_W345+1;%ウインドウ12に当てはまらない。スパイクよりも後のウインドウ3つ
                            W345=W345+1;
                        end
                        %ウインドウ連続でないもので3個
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3notseq=Spike_W3notseq+1;
                            W124=W124+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3notseq=Spike_W3notseq+1;
                            W125=W125+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3notseq=Spike_W3notseq+1;
                            W134=W134+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3notseq=Spike_W3notseq+1;
                            W145=W145+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3notseq=Spike_W3notseq+1;
                            W135=W135+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3notseq=Spike_W3notseq+1;
                            W235=W235+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W3notseq=Spike_W3notseq+1;
                            W245=W245+1;
                        end
                        %ウインドウ連続で4個当てはまる
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W4seq=Spike_W4seq+1;
                            Spike_W1234=Spike_W1234+1;%ウインドウ5だけ当てはまらない
                            W1234=W1234+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W4seq=Spike_W4seq+1;
                            Spike_W2345=Spike_W2345+1;%ウインドウ1だけ当てはまらない
                            W2345=W2345+1;
                        end
                        %ウインドウ連続でないもので4個
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W4notseq=Spike_W4notseq+1;
                            W1235=W1235+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W4notseq=Spike_W4notseq+1;
                            W1245=W1245+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W4notseq=Spike_W4notseq+1;
                            W1345=W1345+1;
                        end
                        %ウインドウ連続で5個当てはまる
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W5seq=Spike_W5seq+1;
                            W12345=W12345+1;
                        end
                        %ウインドウ2だけ当てはまらない
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W1345=Spike_W1345+1;
                            
                        end
                        %ウインドウ3だけ当てはまらない
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W1245=Spike_W1245+1;
                            
                        end
                        %ウインドウ4だけ当てはまらない
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            Spike_W1235=Spike_W1235+1;
                            
                        end
                        %ウインドウ連続で5個当てはまり、その両隣には当てはまらない
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            Spike_W5only=Spike_W5only+1;
                            
                        end
                   end
                end
            end
            
            
            %ウインドウどれもあてはまらない
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW0=RtTouchCountW0+1;
            end
            %ウインドウいずれか一つだけ
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW1=RtTouchCountW1+1;
                RtW1=RtW1+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW1=RtTouchCountW1+1;
                RtW2=RtW2+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW1=RtTouchCountW1+1;
                RtTouchCountW3only=RtTouchCountW3only+1;
                RtW3=RtW3+1;
            end 
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW1=RtTouchCountW1+1;
                RtW4=RtW4+1;
            end 
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW1=RtTouchCountW1+1;
                RtW5=RtW5+1;
            end 
            %ウインドウ連続で2個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2seq=RtTouchCountW2seq+1;
                RtW12=RtW12+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2seq=RtTouchCountW2seq+1;
                RtTouchCountW2seqonly=RtTouchCountW2seqonly+1;
                RtW23=RtW23+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2seq=RtTouchCountW2seq+1;
                RtTouchCountW2seqonly=RtTouchCountW2seqonly+1;
                RtW34=RtW34+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2seq=RtTouchCountW2seq+1;
                RtW45=RtW45+1;
            end
            %ウインドウ連続でないもので2個
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
                RtW13=RtW13+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
                RtW14=RtW14+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
                RtW15=RtW15+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
                RtW24=RtW24+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
                RtW25=RtW25+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW2notseq=RtTouchCountW2notseq+1;
                RtW35=RtW35+1;
            end
            %ウインドウ連続で3個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3seq=RtTouchCountW3seq+1;
                RtTouchCountW123=RtTouchCountW123+1;%ウインドウ45に当てはまらない。スパイクよりも前のウインドウ3つ
                RtW123=RtW123+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3seq=RtTouchCountW3seq+1;
                RtW234=RtW234+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3seq=RtTouchCountW3seq+1;
                RtTouchCountW345=RtTouchCountW345+1;%ウインドウ12に当てはまらない。スパイクよりも後のウインドウ3つ
                RtW345=RtW345+1;
            end
            %ウインドウ連続でないもので3個
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
                RtW124=RtW124+1;
            end
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
                RtW125=RtW125+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
                RtW134=RtW134+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
                RtW145=RtW145+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
                RtW135=RtW135+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
                RtW235=RtW235+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW3notseq=RtTouchCountW3notseq+1;
                RtW245=RtW245+1;
            end
            %ウインドウ連続で4個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW4seq=RtTouchCountW4seq+1;
                RtTouchCountW1234=RtTouchCountW1234+1;%ウインドウ5だけ当てはまらない
                RtW1234=RtW1234+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW4seq=RtTouchCountW4seq+1;
                RtTouchCountW2345=RtTouchCountW2345+1;%ウインドウ１だけ当てはまらない
                RtW2345=RtW2345+1;
            end
            %ウインドウ連続でないもので4個
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW4notseq=RtTouchCountW4notseq+1;
                RtW1235=RtW1235+1;
            end
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW4notseq=RtTouchCountW4notseq+1;
                RtW1245=RtW1245+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW4notseq=RtTouchCountW4notseq+1;
                RtW1345=RtW1345+1;
            end
            %ウインドウ連続で5個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW5seq=RtTouchCountW5seq+1;
                RtW12345=RtW12345+1;
            end
            %ウインドウ2だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW1345=RtTouchCountW1345+1;
                
            end
            %ウインドウ3だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                RtTouchCountW1245=RtTouchCountW1245+1;
                
            end
            %ウインドウ4だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
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
    RtSpike1=[W1,W2,W3,W4,W5];
    RtSpike2=[W12,W23,W34,W45,W13,W14,W15,W24,W25,W35];
    RtSpike3=[W123,W234,W345,W124,W125,W134,W135,W145,W235,W245];
    RtSpike4=[W1234,W2345,W1235,W1245,W1345];
    RtSpike=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W1245,Spike_W3only,Spike_W2seqonly,Spike_W5only];
    
    RtTouchCount1=[RtW1,RtW2,RtW3,RtW4,RtW5];
    RtTouchCount2=[RtW12,RtW23,RtW34,RtW45,RtW13,RtW14,RtW15,RtW24,RtW25,RtW35];
    RtTouchCount3=[RtW123,RtW234,RtW345,RtW124,RtW125,RtW134,RtW135,RtW145,RtW235,RtW245];
    RtTouchCount4=[RtW1234,RtW2345,RtW1235,RtW1245,RtW1345];
    RtTouchCount=[RtTouchCountW0,RtTouchCountW1,RtTouchCountW2seq,RtTouchCountW3seq,RtTouchCountW4seq,RtTouchCountW5seq,RtTouchCountW1245,RtTouchCountW3only,RtTouchCountW2seqonly,RtTouchCountW5only];
%     RtSpikeCountArray=[RtSpikeCountW0,RtSpikeCountW1,RtSpikeCountW2seq,RtSpikeCountW3seq,RtSpikeCountW4seq,RtSpikeCountW5seq,RtSpikeCountW2notseq,RtSpikeCountW3notseq,RtSpikeCountW4notseq];
    fig1=figure;
    subplot(5,1,1);
    bar(RtTouchCount)
    set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
    subplot(5,1,2);
    bar(RtTouchCount1)
    set(gca,'xticklabel',{'1','2','3','4','5'});
    subplot(5,1,3);
    bar(RtTouchCount2)
    set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
    subplot(5,1,4);
    bar(RtTouchCount3)
    set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
    subplot(5,1,5);
    bar(RtTouchCount4)
    set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
    trimtfile=strtrim(tfile);
    figname=['RtRepeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig1,figname);
    close(fig1);  
    %
    %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
    for n=1:length(RtSpike1)
        if RtTouchCount1(n)~=0;
            RtSpike1FR_Bin=[RtSpike1FR_Bin RtSpike1(n)/(RtTouchCount1(n)*10)];
        else
            RtSpike1FR_Bin=[RtSpike1FR_Bin RtTouchCount1(n)];
        end
    end
    fig6=figure;
    bar(RtSpike1FR_Bin)
    set(gca,'xticklabel',{'1','2','3','4','5'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['RtRepeat5TouchSpike1FR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    for n=1:length(RtSpike2)
        if RtTouchCount2(n)~=0;
            RtSpike2FR_Bin=[RtSpike2FR_Bin RtSpike2(n)/(RtTouchCount2(n)*10)];
        else
            RtSpike2FR_Bin=[RtSpike2FR_Bin RtTouchCount2(n)];
        end
    end
    fig6=figure;
    bar(RtSpike2FR_Bin)
    set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['RtRepeat5TouchSpike2FR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    for n=1:length(RtSpike3)
        if RtTouchCount3(n)~=0;
            RtSpike3FR_Bin=[RtSpike3FR_Bin RtSpike3(n)/(RtTouchCount3(n)*10)];
        else
            RtSpike3FR_Bin=[RtSpike3FR_Bin RtTouchCount3(n)];
        end
    end
    fig6=figure;
    bar(RtSpike3FR_Bin)
    set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['RtRepeat5TouchSpike3FR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    for n=1:length(RtSpike4)
        if RtTouchCount4(n)~=0;
            RtSpike4FR_Bin=[RtSpike4FR_Bin RtSpike4(n)/(RtTouchCount4(n)*10)];
        else
            RtSpike4FR_Bin=[RtSpike4FR_Bin RtTouchCount4(n)];
        end
    end
    fig6=figure;
    bar(RtSpike4FR_Bin)
    set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['RtRepeat5TouchSpike4FR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    for n=1:length(RtSpike)
        if RtTouchCount(n)~=0;
            RtSpikeFR_Bin=[RtSpikeFR_Bin RtSpike(n)/(RtTouchCount(n)*10)];
        else
            RtSpikeFR_Bin=[RtSpikeFR_Bin RtTouchCount(n)];
        end
    end
    fig6=figure;
    bar(RtSpikeFR_Bin)
    set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['RtRepeat5TouchSpikeFR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    FLName=['Rt',pegpatternum,pegpatternname];
    save(FLName,'RtSpike','RtTouchCount','RtSpikeFR_Bin');
    
%     fig2=figure;
%     subplot(2,1,1);
%     %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%     for n=1:length(RtSpikeCountArray)
%         if RtTouchCount(n)~=0;
%             RtSpike_Touch=[RtSpike_Touch RtSpikeCountArray(n)/RtTouchCount(n)];
%         else
%             RtSpike_Touch=[RtSpike_Touch RtTouchCount(n)];
%         end
%     end
%     %一回ビンに当てはまった時の全体の発火回数に対する割合
%     for n=1:length(RtSpikeCountArray)
%         if RtSpike_Touch(n)~=0;
%             RtSpike_TouchRate=[RtSpike_TouchRate RtSpike_Touch(n)/sum(RtSpike_Touch)];
%         else
%             RtSpike_TouchRate=[RtSpike_TouchRate RtSpike_Touch(n)];
%         end
%     end
%     bar(RtSpike_Touch)
%     set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','2','3','4'});
%     subplot(2,1,2);
%     bar(RtSpike_TouchRate)
%     set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','2','3','4'});
%     trimtfile=strtrim(tfile);
%     figname=['RtRepeat5TouchSpikeRate',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%     saveas(fig2,figname);
%     close(fig2);
end