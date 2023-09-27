function LtPeakTouch
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 W123rate TouchCount pegpatternum ...
    LtTouchCount LtSpike_TouchRate LtSpikeFR_Bin LtTouchCount1 LtTouchCount2 LtTouchCount3 LtTouchCount4 LtSpike1FR_Bin LtSpike2FR_Bin LtSpike3FR_Bin LtSpike4FR_Bin

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
    LtSpike_Touch=[];
    LtSpike_TouchRate=[];
    LtSpikeFR_Bin=[];
    LtSpike1FR_Bin=[];
    LtSpike2FR_Bin=[];
    LtSpike3FR_Bin=[];
    LtSpike4FR_Bin=[];
    
    
    if abs(Linterval1(3))<abs(Linterval2(3)) %Linterval2(2),Linterval2(1),Linterval1(1),Linterval1(2),Linterval1(3)のピーク
        WindowS1=Linterval2(2)*10-90;
        WindowE1=Linterval2(2)*10+90;
        WindowS2=Linterval2(1)*10-90;
        WindowE2=Linterval2(1)*10+90;
        WindowS3=Linterval1(1)*10-90;
        WindowE3=Linterval1(1)*10+90;
        WindowS4=Linterval1(2)*10-90;
        WindowE4=Linterval1(2)*10+90;
        WindowS5=Linterval1(3)*10-90;
        WindowE5=Linterval1(3)*10+90;
    elseif abs(Linterval1(3))>=abs(Linterval2(3)) %Linterval2(3),Linterval2(2),Linterval2(1),Linterval1(1),Linterval1(2)
        WindowS1=Linterval2(3)*10-90;
        WindowE1=Linterval2(3)*10+90;
        WindowS2=Linterval2(2)*10-90;
        WindowE2=Linterval2(2)*10+90;
        WindowS3=Linterval2(1)*10-90;
        WindowE3=Linterval2(1)*10+90;
        WindowS4=Linterval1(1)*10-90;
        WindowE4=Linterval1(1)*10+90;
        WindowS5=Linterval1(2)*10-90;
        WindowE5=Linterval1(2)*10+90;
    end
    SpikeWindowS=-20;
    SpikeWindowE=20;
    
    %ウインドウの幅180ミリ秒ずつずれていく配列用意
    MoveTouchInterval1=WindowS2-WindowE1;
    MoveTouchInterval2=WindowS3-WindowE1;
    MoveTouchInterval3=WindowS4-WindowE1;
    MoveTouchInterval4=WindowS5-WindowE1;
    MoveTouchIntervalAverage=(MoveTouchInterval1+MoveTouchInterval2+MoveTouchInterval3+MoveTouchInterval4)/4; %インターバルの平均を出す。
    
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
    LtTouchCountW3only=0;
    LtTouchCountW2seqonly=0;
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
    Spike_W2=0;
    Spike_W3=0;
    Spike_W4=0;
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
    LtW1=0;
    LtW2=0;
    LtW3=0;
    LtW4=0;
    LtW5=0;
    LtW12=0;
    LtW23=0;
    LtW34=0;
    LtW45=0;
    LtW13=0;
    LtW14=0;
    LtW15=0;
    LtW24=0;
    LtW25=0;
    LtW35=0;
    LtW123=0;
    LtW234=0;
    LtW345=0;
    LtW125=0;
    LtW124=0;
    LtW134=0;
    LtW135=0;
    LtW145=0;
    LtW235=0;
    LtW245=0;
    LtW1234=0;
    LtW1235=0;
    LtW1245=0;
    LtW1345=0;
    LtW2345=0;
    LtW12345=0;

    %全てのタッチ見て、用意した5つのウインドウにどれだけ当てはまっているか調べる
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
        MoveWindow1=0;
        MoveWindow2=0;
        MoveWindow3=0;
        MoveWindow4=0;
        MoveWindow5=0;
        MoveWindow0=0;
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
                LtTouchCountW0=LtTouchCountW0+1;
            end
            %ウインドウいずれか一つだけ
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW1=LtTouchCountW1+1;
                LtW1=LtW1+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW1=LtTouchCountW1+1;
                LtW2=LtW2+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW1=LtTouchCountW1+1;
                LtTouchCountW3only=LtTouchCountW3only+1;
                LtW3=LtW3+1;
            end 
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW1=LtTouchCountW1+1;
                LtW4=LtW4+1;
            end 
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW1=LtTouchCountW1+1;
                LtW5=LtW5+1;
            end 
            %ウインドウ連続で2個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2seq=LtTouchCountW2seq+1;
                LtW12=LtW12+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2seq=LtTouchCountW2seq+1;
                LtTouchCountW2seqonly=LtTouchCountW2seqonly+1;
                LtW23=LtW23+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2seq=LtTouchCountW2seq+1;
                LtTouchCountW2seqonly=LtTouchCountW2seqonly+1;
                LtW34=LtW34+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2seq=LtTouchCountW2seq+1;
                LtW45=LtW45+1;
            end
            %ウインドウ連続でないもので2個
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
                LtW13=LtW13+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
                LtW14=LtW14+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
                LtW15=LtW15+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
                LtW24=LtW24+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
                LtW25=LtW25+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW2notseq=LtTouchCountW2notseq+1;
                LtW35=LtW35+1;
            end
            %ウインドウ連続で3個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3seq=LtTouchCountW3seq+1;
                LtTouchCountW123=LtTouchCountW123+1;%ウインドウ45に当てはまらない。スパイクよりも前のウインドウ3つ
                LtW123=LtW123+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3seq=LtTouchCountW3seq+1;
                LtW234=LtW234+1;
            end
            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3seq=LtTouchCountW3seq+1;
                LtTouchCountW345=LtTouchCountW345+1;%ウインドウ12に当てはまらない。スパイクよりも後のウインドウ3つ
                LtW345=LtW345+1;
            end
            %ウインドウ連続でないもので3個
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
                LtW124=LtW124+1;
            end
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
                LtW125=LtW125+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
                LtW134=LtW134+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
                LtW145=LtW145+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
                LtW135=LtW135+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
                LtW235=LtW235+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW3notseq=LtTouchCountW3notseq+1;
                LtW245=LtW245+1;
            end
            %ウインドウ連続で4個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW4seq=LtTouchCountW4seq+1;
                LtTouchCountW1234=LtTouchCountW1234+1;%ウインドウ5だけ当てはまらない
                LtW1234=LtW1234+1;
            end
            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW4seq=LtTouchCountW4seq+1;
                LtTouchCountW2345=LtTouchCountW2345+1;%ウインドウ１だけ当てはまらない
                LtW2345=LtW2345+1;
            end
            %ウインドウ連続でないもので4個
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW4notseq=LtTouchCountW4notseq+1;
                LtW1235=LtW1235+1;
            end
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW4notseq=LtTouchCountW4notseq+1;
                LtW1245=LtW1245+1;
            end
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW4notseq=LtTouchCountW4notseq+1;
                LtW1345=LtW1345+1;
            end
            %ウインドウ連続で5個当てはまる
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW5seq=LtTouchCountW5seq+1;
                LtW12345=LtW12345+1;
            end
            %ウインドウ2だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW1345=LtTouchCountW1345+1;
                
            end
            %ウインドウ3だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW1245=LtTouchCountW1245+1;
                
            end
            %ウインドウ4だけ当てはまらない
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                LtTouchCountW1235=LtTouchCountW1235+1;
                
            end
            %ウインドウ連続で5個当てはまるが、その両隣は当てはまらない
            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                LtTouchCountW5only=LtTouchCountW5only+1;
            end
%             %ビン毎に当てはまったときのうち、どれだけ発火してるか
%             %ウインドウどれもあてはまらない
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW0=LtSpikeCountW0+1;
%             end
%             %ウインドウいずれか一つだけ
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
%             %ウインドウ連続で2個当てはまる
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
%             %ウインドウ連続でないもので2個
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
%             %ウインドウ連続で3個当てはまる
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW3seq=LtSpikeCountW3seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW3seq=LtSpikeCountW3seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW3seq=LtSpikeCountW3seq+1;
%             end
%             %ウインドウ連続でないもので3個
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
%             %ウインドウ連続で4個当てはまる
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindowSpike==1
%                 LtSpikeCountW4seq=LtSpikeCountW4seq+1;
%             end
%             if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW4seq=LtSpikeCountW4seq+1;
%             end
%             %ウインドウ連続でないもので4個
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW4notseq=LtSpikeCountW4notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW4notseq=LtSpikeCountW4notseq+1;
%             end
%             if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW4notseq=LtSpikeCountW4notseq+1;
%             end
%             %ウインドウ連続で5個当てはまる
%             if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindowSpike==1
%                 LtSpikeCountW5seq=LtSpikeCountW5seq+1;
%             end
        end
    end
    
    %各ビン毎にタッチ当てはまった回数
    LtSpike1=[W1,W2,W3,W4,W5];
    LtSpike2=[W12,W23,W34,W45,W13,W14,W15,W24,W25,W35];
    LtSpike3=[W123,W234,W345,W124,W125,W134,W135,W145,W235,W245];
    LtSpike4=[W1234,W2345,W1235,W1245,W1345];
    LtSpike=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W1245,Spike_W3only,Spike_W2seqonly,Spike_W5only];
    
    LtTouchCount1=[LtW1,LtW2,LtW3,LtW4,LtW5];
    LtTouchCount2=[LtW12,LtW23,LtW34,LtW45,LtW13,LtW14,LtW15,LtW24,LtW25,LtW35];
    LtTouchCount3=[LtW123,LtW234,LtW345,LtW124,LtW125,LtW134,LtW135,LtW145,LtW235,LtW245];
    LtTouchCount4=[LtW1234,LtW2345,LtW1235,LtW1245,LtW1345];
    LtTouchCount=[LtTouchCountW0,LtTouchCountW1,LtTouchCountW2seq,LtTouchCountW3seq,LtTouchCountW4seq,LtTouchCountW5seq,LtTouchCountW1245,LtTouchCountW3only,LtTouchCountW2seqonly,LtTouchCountW5only];
%     LtSpikeCountArray=[LtSpikeCountW0,LtSpikeCountW1,LtSpikeCountW2seq,LtSpikeCountW3seq,LtSpikeCountW4seq,LtSpikeCountW5seq,LtTouchCountW2345,LtTouchCountW1345,LtTouchCountW1245,LtTouchCountW1235,LtTouchCountW1234];
    fig1=figure;
    subplot(5,1,1);
    bar(LtTouchCount)
    set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
    subplot(5,1,2);
    bar(LtTouchCount1)
    set(gca,'xticklabel',{'1','2','3','4','5'});
    subplot(5,1,3);
    bar(LtTouchCount2)
    set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
    subplot(5,1,4);
    bar(LtTouchCount3)
    set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
    subplot(5,1,5);
    bar(LtTouchCount4)
    set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
    trimtfile=strtrim(tfile);
    figname=['LtRepeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig1,figname);
    close(fig1);  
    %
    %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
    for n=1:length(LtSpike1)
        if LtTouchCount1(n)~=0;
            LtSpike1FR_Bin=[LtSpike1FR_Bin LtSpike1(n)/(LtTouchCount1(n)*10)];
        else
            LtSpike1FR_Bin=[LtSpike1FR_Bin LtTouchCount1(n)];
        end
    end
    fig6=figure;
    bar(LtSpike1FR_Bin)
    set(gca,'xticklabel',{'1','2','3','4','5'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['LtRepeat5TouchSpike1FR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    for n=1:length(LtSpike2)
        if LtTouchCount2(n)~=0;
            LtSpike2FR_Bin=[LtSpike2FR_Bin LtSpike2(n)/(LtTouchCount2(n)*10)];
        else
            LtSpike2FR_Bin=[LtSpike2FR_Bin LtTouchCount2(n)];
        end
    end
    fig6=figure;
    bar(LtSpike2FR_Bin)
    set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['LtRepeat5TouchSpike2FR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    for n=1:length(LtSpike3)
        if LtTouchCount3(n)~=0;
            LtSpike3FR_Bin=[LtSpike3FR_Bin LtSpike3(n)/(LtTouchCount3(n)*10)];
        else
            LtSpike3FR_Bin=[LtSpike3FR_Bin LtTouchCount3(n)];
        end
    end
    fig6=figure;
    bar(LtSpike3FR_Bin)
    set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['LtRepeat5TouchSpike3FR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    for n=1:length(LtSpike4)
        if LtTouchCount4(n)~=0;
            LtSpike4FR_Bin=[LtSpike4FR_Bin LtSpike4(n)/(LtTouchCount4(n)*10)];
        else
            LtSpike4FR_Bin=[LtSpike4FR_Bin LtTouchCount4(n)];
        end
    end
    fig6=figure;
    bar(LtSpike4FR_Bin)
    set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['LtRepeat5TouchSpike4FR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    for n=1:length(LtSpike)
        if LtTouchCount(n)~=0;
            LtSpikeFR_Bin=[LtSpikeFR_Bin LtSpike(n)/(LtTouchCount(n)*10)];
        else
            LtSpikeFR_Bin=[LtSpikeFR_Bin LtTouchCount(n)];
        end
    end
    fig6=figure;
    bar(LtSpikeFR_Bin)
    set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
    trimtfile=strtrim(tfile);
    %ウインドウにどれだけタッチ当てはまったかの棒グラフ
    figname=['LtRepeat5TouchSpikeFR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
    saveas(fig6,figname);
    close(fig6);
    FLName=['Lt',pegpatternum,pegpatternname];
    save(FLName,'LtSpike','LtTouchCount','LtSpikeFR_Bin');
%     fig2=figure;
%     subplot(2,1,1);
%     %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%     for n=1:length(LtSpikeCountArray)
%         if LtTouchCount(n)~=0;
%             LtSpike_Touch=[LtSpike_Touch LtSpikeCountArray(n)/LtTouchCount(n)];
%         else
%             LtSpike_Touch=[LtSpike_Touch LtTouchCount(n)];
%         end
%     end
%     %一回ビンに当てはまった時の全体の発火回数に対する割合
%     for n=1:length(LtSpikeCountArray)
%         if LtSpike_Touch(n)~=0;
%             LtSpike_TouchRate=[LtSpike_TouchRate LtSpike_Touch(n)/sum(LtSpike_Touch)];
%         else
%             LtSpike_TouchRate=[LtSpike_TouchRate LtSpike_Touch(n)];
%         end
%     end
%     bar(LtSpike_Touch)
%     set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','2','3','4'});
%     subplot(2,1,2);
%     bar(LtSpike_TouchRate)
%     set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','2','3','4'});
%     trimtfile=strtrim(tfile);
%     figname=['LtRepeat5TouchSpikeRate',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%     saveas(fig2,figname);
%     close(fig2);
end
%     
%     LtSpikeCountW0=0;
%     LtSpikeCountW1=0;
%     LtSpikeCountW2=0;
%     LtSpikeCountW3=0;
%     LtSpikeCountW4=0;
%     LtSpikeCountW5=0;
%     LtSpikeCountW12=0;
%     LtSpikeCountW123=0;
%     LtSpikeCountW1234=0;
%     LtSpikeCountW12345=0;
%     LtSpikeCountW23=0;
%     LtSpikeCountW234=0;
%     LtSpikeCountW2345=0;
%     for n=1:length(SpikeArrayWon)
%         W1=0;
%         W2=0;
%         W3=0;
%         W4=0;
%         W5=0;
%         for i=1:(length(LpegTouchallWon))
%             if  LpegTouchallWon(i)>SpikeArrayWon(n)+WindowS1&SpikeArrayWon(n)+WindowE1>LpegTouchallWon(i)
%                 W1=1;
%             end
%             if  LpegTouchallWon(i)>SpikeArrayWon(n)+WindowS2&SpikeArrayWon(n)+WindowE2>LpegTouchallWon(i) 
%                 W2=1;
%             end
%             if  LpegTouchallWon(i)>SpikeArrayWon(n)+WindowS3&SpikeArrayWon(n)+WindowE3>LpegTouchallWon(i) 
%                 W3=1;
%             end
%             if  LpegTouchallWon(i)>SpikeArrayWon(n)+WindowS4&SpikeArrayWon(n)+WindowE4>LpegTouchallWon(i) 
%                 W4=1;
%             end
%             if  LpegTouchallWon(i)>SpikeArrayWon(n)+WindowS5&SpikeArrayWon(n)+WindowE5>LpegTouchallWon(i) 
%                 W5=1;
%             end
%         end
%         if W1==0 && W2==0 && W3==0 && W4==0 && W5==0
%             LtSpikeCountW0=LtSpikeCountW0+1;
%         end
%         if W1==1 && W2==0 && W3==0 && W4==0 && W5==0
%             LtSpikeCountW1=LtSpikeCountW1+1;
%         end
%         if W1==0 && W2==1 && W3==0 && W4==0 && W5==0
%             LtSpikeCountW2=LtSpikeCountW2+1;
%         end
%         if W1==0 && W2==0 && W3==1 && W4==0 && W5==0
%             LtSpikeCountW3=LtSpikeCountW3+1;
%         end
%         if W1==0 && W2==0 && W3==0 && W4==1 && W5==0
%             LtSpikeCountW4=LtSpikeCountW4+1;
%         end
%         if W1==0 && W2==0 && W3==0 && W4==0 && W5==1
%             LtSpikeCountW5=LtSpikeCountW5+1;
%         end
%         if W1==1 && W2==1 && W3==0 && W4==0 && W5==0
%             LtSpikeCountW12=LtSpikeCountW12+1;
%         end
%         if W1==1 && W2==1 && W3==1 && W4==0 && W5==0
%             LtSpikeCountW123=LtSpikeCountW123+1;
%         end
%         if W1==1 && W2==1 && W3==1 && W4==1 && W5==0
%             LtSpikeCountW1234=LtSpikeCountW1234+1;
%         end
%         if W1==1 && W2==1 && W3==1 && W4==1 && W5==1
%             LtSpikeCountW12345=LtSpikeCountW12345+1;
%         end
%         if W1==0 && W2==1 && W3==1 && W4==0 && W5==0
%             LtSpikeCountW23=LtSpikeCountW23+1;
%         end
%         if W1==0 && W2==1 && W3==1 && W4==1 && W5==0
%             LtSpikeCountW234=LtSpikeCountW234+1;
%         end
%         if W1==0 && W2==1 && W3==1 && W4==1 && W5==1
%             LtSpikeCountW2345=LtSpikeCountW2345+1;
%         end
%     end
%     fig1=figure;
%     LtTouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW4,TouchCountW5,TouchCountW12,TouchCountW123,TouchCountW23,TouchCountW234,TouchCountW1234,TouchCountW2345,TouchCountW12345];
%     bar(LtTouchCount)
%     set(gca,'xticklabel',{'no','1','2','3','4','5','12','123','23','234','1234','2345','12345'});
%     trimtfile=strtrim(tfile);
% %     ウインドウにどれだけタッチ当てはまったかの棒グラフ
%     figname=['LtRepeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%     saveas(fig1,figname);
%     close(fig1);  
%     
%     fig2=figure;
%     subplot(2,1,1);
%     LtSpikeCountArray=[LtSpikeCountW0,LtSpikeCountW1,LtSpikeCountW2,LtSpikeCountW3,LtSpikeCountW4,LtSpikeCountW5,LtSpikeCountW12,LtSpikeCountW123,LtSpikeCountW23,LtSpikeCountW234,LtSpikeCountW1234,LtSpikeCountW2345,LtSpikeCountW12345]; %ウインドウ設定したときの発火回数
%     %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%         for n=1:length(LtSpikeCountArray)
%             if LtTouchCount(n)~=0;
%                 LtSpike_Touch=[LtSpike_Touch LtSpikeCountArray(n)/LtTouchCount(n)];
%             else
%                 LtSpike_Touch=[LtSpike_Touch LtTouchCount(n)];
%             end
%         end
%     %一回ビンに当てはまった時の全体の発火回数に対する割合
%         for n=1:length(LtTouchCount)
%             if LtSpike_Touch(n)~=0;
%                 LtSpike_TouchRate=[LtSpike_TouchRate LtSpike_Touch(n)/sum(LtSpike_Touch)];
%             else
%                 LtSpike_TouchRate=[LtSpike_TouchRate LtSpike_Touch(n)];
%             end
%         end
%     bar(LtSpike_Touch)
%     set(gca,'xticklabel',{'no','1','2','3','4','5','12','123','23','234','1234','2345','12345'});
%     subplot(2,1,2);
%     bar(LtSpike_TouchRate)
%     set(gca,'xticklabel',{'no','1','2','3','4','5','12','123','23','234','1234','2345','12345'});
%     trimtfile=strtrim(tfile);
%     figname=['LtRepeat5TouchSpikeRate',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%     saveas(fig2,figname);
%     close(fig2);  
