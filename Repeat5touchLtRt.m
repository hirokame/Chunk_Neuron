function Repeat5touchLtRt
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 pegpatternum TouchCountW12345 SpikeFR_5Touch_Bin RLRLRcount LRLRLcount...
    Spike1FR_5Touch_Bin Spike2FR_5Touch_Bin Spike3FR_5Touch_Bin Spike4FR_5Touch_Bin tTouchCount1 tTouchCount2 tTouchCount3 tTouchCount4


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

fig1=figure;
subplot(2,2,[1,2]);
plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
hold on
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

plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);
axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RpegTouchallWon
% LpegTouchallWon


% クロスコリオグラムからピークを検出
subplot(2,2,3);
% findpeaks(CCresultLtouchWon,'MinPeakDistance',20);
[Lpks,Llocs,Lwidth,Lproms]=findpeaks(CCresultLtouchWon,'MinPeakDistance',25);
findpeaks(CCresultLtouchWon,'MinPeakDistance',25);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>=0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(LlocsInterval2,'descend');
subplot(2,2,4);
% findpeaks(CCresultRtouchWon,'MinPeakDistance',20);
[Rpks,Rlocs,Rwidth,Rproms]=findpeaks(CCresultRtouchWon,'MinPeakDistance',25);
findpeaks(CCresultRtouchWon,'MinPeakDistance',25);
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>=0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(RlocsInterval2,'descend');
% 
if length(Linterval1)>3 && length(Linterval2)>3 && length(Rinterval1)>3 && length(Rinterval2)>3;  

LWindowS0=Linterval2(3)*10-50;
LWindowE0=Linterval2(3)*10+50;
LWindowS1=Linterval2(2)*10-50;
LWindowE1=Linterval2(2)*10+50;
LWindowS2=Linterval2(1)*10-50;
LWindowE2=Linterval2(1)*10+50;
LWindowS3=Linterval1(1)*10-50;
LWindowE3=Linterval1(1)*10+50;
LWindowS4=Linterval1(2)*10-50;
LWindowE4=Linterval1(2)*10+50;
LWindowS5=Linterval1(3)*10-50;
LWindowE5=Linterval1(3)*10+50;

RWindowS0=Rinterval2(3)*10-50;
RWindowE0=Rinterval2(3)*10+50;
RWindowS1=Rinterval2(2)*10-50;
RWindowE1=Rinterval2(2)*10+50;
RWindowS2=Rinterval2(1)*10-50;
RWindowE2=Rinterval2(1)*10+50;
RWindowS3=Rinterval1(1)*10-50;
RWindowE3=Rinterval1(1)*10+50;
RWindowS4=Rinterval1(2)*10-50;
RWindowE4=Rinterval1(2)*10+50;
RWindowS5=Rinterval1(3)*10-50;
RWindowE5=Rinterval1(3)*10+50;

SpikeWindowS=-20;
SpikeWindowE=20;

trimtfile=strtrim(tfile);
figname=[trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
saveas(fig1,figname);
close(fig1);
Spike1FR_5Touch_Bin=[];
Spike2FR_5Touch_Bin=[];
Spike3FR_5Touch_Bin=[];
Spike4FR_5Touch_Bin=[];
SpikeFR_5Touch_Bin=[];
RLRLRcount=0;
LRLRLcount=0;

%R2(2),L2(2),R2(1),L2(1),R1(1)の順% ウインドウRLRLRの順
    if Linterval2(3)<Rinterval2(2) && Rinterval2(2)<Linterval2(2) && Linterval2(2)<Rinterval2(1) && Rinterval2(1)<Linterval2(1) && Linterval2(1)<Rinterval1(1) && Rinterval1(1)<Linterval1(1) && abs(Linterval2(3))>abs(Rinterval1(1)) && abs(Rinterval2(2))<abs(Linterval1(1))
        RLRLRcount=1;
        windowE0=LWindowE0;
        windowS0=LWindowS0;
        windowE1=RWindowE1;
        windowS1=RWindowS1;
        windowS2=LWindowS1;
        windowS3=RWindowS2;
        windowS4=LWindowS2;
        windowS5=RWindowS3;
        windowS6=LWindowS3;
        
        MoveTouchInterval0=windowE1-windowS0;
        MoveTouchInterval1=windowS2-windowE1;
        MoveTouchInterval2=windowS3-windowE1;
        MoveTouchInterval3=windowS4-windowE1;
        MoveTouchInterval4=windowS5-windowE1;
        MoveTouchInterval5=windowS6-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1;
        
        MoveWindowArray_90=fix((RpegTouchallWon(end)-RpegTouchallWon(1))/10)+1;
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2seq=0;
        TouchCountW3seq=0;
        TouchCountW4seq=0;
        TouchCountW5seq=0;
        TouchCountW2345=0;
        TouchCountW1345=0;
        TouchCountW1245=0;
        TouchCountW1235=0;
        TouchCountW1234=0;
        TouchCountW3only=0;
        TouchCountW2seqonly=0;
       
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2seq=0;
        Spike_W3seq=0;
        Spike_W4seq=0;
        Spike_W5seq=0;
        Spike_W2345=0;
        Spike_W1345=0;
        Spike_W1245=0;
        Spike_W1235=0;
        Spike_W1234=0;
        Spike_W3only=0;
        Spike_W2seqonly=0;
        
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

        tW1=0;
        tW2=0;
        tW3=0;
        tW4=0;
        tW5=0;
        tW12=0;
        tW23=0;
        tW34=0;
        tW45=0;
        tW13=0;
        tW14=0;
        tW15=0;
        tW24=0;
        tW25=0;
        tW35=0;
        tW123=0;
        tW234=0;
        tW345=0;
        tW125=0;
        tW124=0;
        tW134=0;
        tW135=0;
        tW145=0;
        tW235=0;
        tW245=0;
        tW1234=0;
        tW1235=0;
        tW1245=0;
        tW1345=0;
        tW2345=0;
        tW12345=0;
        
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
                MoveWindow6=0;
                MoveWindow1=0;
                MoveWindow2=0;
                MoveWindow3=0;
                MoveWindow4=0;
                MoveWindow5=0;
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
                MoveWindow6Start=MoveWindow1End+MoveTouchInterval5;
                MoveWindow6End=MoveWindow6Start+180;
                MoveWindow0Start=MoveWindow1Start-MoveTouchInterval0;
                MoveWindow0End=MoveWindow0Start+180;
                
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                W4TouchTime=[];
                W5TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
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
                        for i=1:(length(RpegTouchallWon))
                            if RpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>RpegTouchallWon(i)
                                MoveWindow1=1;
                                W1TouchTime=[W1TouchTime RpegTouchallWon(i)];
                            end 
                            if RpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>RpegTouchallWon(i) 
                                MoveWindow3=1;
                                W3TouchTime=[W3TouchTime RpegTouchallWon(i)];
                            end
                            if RpegTouchallWon(i)>MoveWindow5Start && MoveWindow5End>RpegTouchallWon(i) 
                                MoveWindow5=1;
                                W5TouchTime=[W5TouchTime RpegTouchallWon(i)];
                            end
                        end
                        for j=1:(length(LpegTouchallWon))
                            if LpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>LpegTouchallWon(j)
                                MoveWindow2=1;
                                W2TouchTime=[W2TouchTime LpegTouchallWon(j)];
                            end 
                            if LpegTouchallWon(j)>MoveWindow4Start && MoveWindow4End>LpegTouchallWon(j)
                                MoveWindow4=1;
                                W4TouchTime=[W4TouchTime LpegTouchallWon(j)];
                            end
                            if LpegTouchallWon(j)>MoveWindow0Start && MoveWindow0End>LpegTouchallWon(j)
                                MoveWindow0=1;
                            end
                            if LpegTouchallWon(j)>MoveWindow6Start && MoveWindow6End>LpegTouchallWon(j)
                                MoveWindow6=1;
                            end
                        end
                        %MoveWindowSpike=1だったとき、ウインドウ内で
                        if MoveWindowSpike==1
                            for k=1:(length(SpikeArrayWon))
                               if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                                   %ウインドウどれもあてはまらない
                                   if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
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
                                        W13=W13+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W14=W14+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W15=W15+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W24=W24+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W25=W25+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W35=W35+1;
                                    end
                                   %ウインドウ連続で3個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W123=W123+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W234=W234+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W345=W345+1;
                                    end
                                    %ウインドウ連続でないもので3個
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W124=W124+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W125=W125+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W134=W134+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W145=W145+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W135=W135+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W235=W235+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
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
                                        W1235=W1235+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1245=W1245+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1345=W1345+1;
                                    end
                                    %ウインドウ連続で5個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W5seq=Spike_W5seq+1;
                                        W12345=W12345+1;
                                    end
                                    %ウインドウ2だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1345=Spike_W1345+1;
                                    end
                                    %ウインドウ3だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1245=Spike_W1245+1;
                                    end
                                    %ウインドウ4だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1235=Spike_W1235+1;
                                    end
                               end
                            end
                        end
                        %足取りだけでビン毎の当てはまった回数
                        %ウインドウどれもあてはまらない
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW0=TouchCountW0+1;
                        end
                        %ウインドウいずれか一つだけ
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW1=tW1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW2=tW2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            TouchCountW3only=TouchCountW3only+1;
                            tW3=tW3+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW4=tW4+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW5=tW5+1;
                        end 
                        %ウインドウ連続で2個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW12=tW12+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW23=tW23+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW34=tW34+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW45=tW45+1;
                            end
                        end
                        %ウインドウ連続でないもので2個
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW13=tW13+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW14=tW14+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW15=tW15+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW24=tW24+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW25=tW25+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW35=tW35+1;
                        end
                        %ウインドウ連続で3個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW123=tW123+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW234=tW234+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW345=tW345+1;
                            end
                        end
                        %ウインドウ連続でないもので3個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW124=tW124+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW125=tW125+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW134=tW134+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW145=tW145+1;
                            end
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW135=tW135+1;
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW235=tW235+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW245=tW245+1;
                            end
                        end
                        %ウインドウ連続で4個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW1234=TouchCountW1234+1;%ウインドウ5だけ当てはまらない
                                tW1234=tW1234+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1  && MoveWindow0==0 && MoveWindow6==0%ウインドウ１だけ当てはまらない
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW2345=TouchCountW2345+1;%ウインドウ１だけ当てはまらない
                                tW2345=tW2345+1;
                            end
                        end
                        %ウインドウ連続でないもので4個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1235=tW1235+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1245=tW1245+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1345=tW1345+1;
                            end
                        end
                        %ウインドウ連続で5個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW5seq=TouchCountW5seq+1;
                                tW12345=tW12345+1;
                            end
                        end
                        %ウインドウ2だけ当てはまらない
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1345=TouchCountW1345+1;
                            end
                        end
                        %ウインドウ3だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1245=TouchCountW1245+1;
                            end
                        end
                        %ウインドウ4だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1235=TouchCountW1235+1;
                            end
                        end
                    end
            end
            tSpike1=[W1,W2,W3,W4,W5];
            tSpike2=[W12,W23,W34,W45,W13,W14,W15,W24,W25,W35];
            tSpike3=[W123,W234,W345,W124,W125,W134,W135,W145,W235,W245];
            tSpike4=[W1234,W2345,W1235,W1245,W1345];
            SpikeW12345=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W2345,Spike_W1345,Spike_W1245,Spike_W1235,Spike_W1234,Spike_W3only,Spike_W2seqonly];  %各ビン毎に当てはまったMoveWindowSpikeの回数
            
            tTouchCount1=[tW1,tW2,tW3,tW4,tW5];
            tTouchCount2=[tW12,tW23,tW34,tW45,tW13,tW14,tW15,tW24,tW25,tW35];
            tTouchCount3=[tW123,tW234,tW345,tW124,tW125,tW134,tW135,tW145,tW235,tW245];
            tTouchCount4=[tW1234,tW2345,tW1235,tW1245,tW1345];
            TouchCountW12345=[TouchCountW0,TouchCountW1,TouchCountW2seq,TouchCountW3seq,TouchCountW4seq,TouchCountW5seq,TouchCountW2345,TouchCountW1345,TouchCountW1245,TouchCountW1235,TouchCountW1234,TouchCountW3only,TouchCountW2seqonly];
            fig1=figure;
            subplot(5,1,1);
            bar(TouchCountW12345)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            subplot(5,1,2);
            bar(tTouchCount1)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            subplot(5,1,3);
            bar(tTouchCount2)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            subplot(5,1,4);
            bar(tTouchCount3)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            subplot(5,1,5);
            bar(tTouchCount4)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            figname=['Repeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig1,figname);
            close(fig1);
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(tSpike1)
                if tTouchCount1(n)~=0;
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tSpike1(n)/(tTouchCount1(n)*10)];
                else
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tTouchCount1(n)];
                end
            end
            fig6=figure;
            bar(Spike1FR_5Touch_Bin)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike1FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike2)
                if tTouchCount2(n)~=0;
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tSpike2(n)/(tTouchCount2(n)*10)];
                else
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tTouchCount2(n)];
                end
            end
            fig6=figure;
            bar(Spike2FR_5Touch_Bin)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike2FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike3)
                if tTouchCount3(n)~=0;
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tSpike3(n)/(tTouchCount3(n)*10)];
                else
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tTouchCount3(n)];
                end
            end
            fig6=figure;
            bar(Spike3FR_5Touch_Bin)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike3FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike4)
                if tTouchCount4(n)~=0;
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tSpike4(n)/(tTouchCount4(n)*10)];
                else
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tTouchCount4(n)];
                end
            end
            fig6=figure;
            bar(Spike4FR_5Touch_Bin)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike4FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(SpikeW12345)
                if TouchCountW12345(n)~=0;
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin SpikeW12345(n)/(TouchCountW12345(n)*10)];
                else
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin TouchCountW12345(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_5Touch_Bin)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpikeFR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            FLName=['Repeat5Touch',pegpatternum,pegpatternname];
            save(FLName,'SpikeW12345','TouchCountW12345','SpikeFR_5Touch_Bin');
            
        %R2(2),L2(1),R2(1),L1(1),R1(1)の順
     elseif Linterval2(2)<Rinterval2(2) && Rinterval2(2)<Linterval2(1) && Linterval2(1)<Rinterval2(1) && Rinterval2(1)<Linterval1(1) && Linterval1(1)<Rinterval1(1) && Rinterval1(1)<Linterval1(2) && abs(Rinterval1(1))<abs(Linterval2(2)) && abs(Rinterval2(2))<abs(Linterval1(2))% ウインドウLRL
        RLRLRcount=1;
        
        windowE1=RWindowE1;
        windowS1=RWindowS1;
        windowS2=LWindowS2;
        windowS3=RWindowS2;
        windowS4=LWindowS3;
        windowS5=RWindowS3;
        windowE0=LWindowE1;
        windowS0=LWindowS1;
        windowE6=LWindowE4;
        windowS6=LWindowS4;
        
        MoveTouchInterval0=windowE1-windowS0;
        MoveTouchInterval1=windowS2-windowE1;
        MoveTouchInterval2=windowS3-windowE1;
        MoveTouchInterval3=windowS4-windowE1;
        MoveTouchInterval4=windowS5-windowE1;
        MoveTouchInterval5=windowS6-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1;
        
        MoveWindowArray_90=fix((RpegTouchallWon(end)-RpegTouchallWon(1))/10)+1;
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2seq=0;
        TouchCountW3seq=0;
        TouchCountW4seq=0;
        TouchCountW5seq=0;
        TouchCountW2345=0;
        TouchCountW1345=0;
        TouchCountW1245=0;
        TouchCountW1235=0;
        TouchCountW1234=0;
        TouchCountW3only=0;
        TouchCountW2seqonly=0;
       
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2seq=0;
        Spike_W3seq=0;
        Spike_W4seq=0;
        Spike_W5seq=0;
        Spike_W2345=0;
        Spike_W1345=0;
        Spike_W1245=0;
        Spike_W1235=0;
        Spike_W1234=0;
        Spike_W3only=0;
        Spike_W2seqonly=0;
        
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

        tW1=0;
        tW2=0;
        tW3=0;
        tW4=0;
        tW5=0;
        tW12=0;
        tW23=0;
        tW34=0;
        tW45=0;
        tW13=0;
        tW14=0;
        tW15=0;
        tW24=0;
        tW25=0;
        tW35=0;
        tW123=0;
        tW234=0;
        tW345=0;
        tW125=0;
        tW124=0;
        tW134=0;
        tW135=0;
        tW145=0;
        tW235=0;
        tW245=0;
        tW1234=0;
        tW1235=0;
        tW1245=0;
        tW1345=0;
        tW2345=0;
        tW12345=0;
        
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
                MoveWindow6Start=MoveWindow1End+MoveTouchInterval5;
                MoveWindow6End=MoveWindow6Start+180;
                MoveWindow0Start=MoveWindow1Start-MoveTouchInterval0;
                MoveWindow0End=MoveWindow0Start+180;
                
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                W4TouchTime=[];
                W5TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
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
                        for i=1:(length(RpegTouchallWon))
                            if RpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>RpegTouchallWon(i)
                                MoveWindow1=1;
                                W1TouchTime=[W1TouchTime RpegTouchallWon(i)];
                            end 
                            if RpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>RpegTouchallWon(i) 
                                MoveWindow3=1;
                                W3TouchTime=[W3TouchTime RpegTouchallWon(i)];
                            end
                            if RpegTouchallWon(i)>MoveWindow5Start && MoveWindow5End>RpegTouchallWon(i) 
                                MoveWindow5=1;
                                W5TouchTime=[W5TouchTime RpegTouchallWon(i)];
                            end
                        end
                        for j=1:(length(LpegTouchallWon))
                            if LpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>LpegTouchallWon(j)
                                MoveWindow2=1;
                                W2TouchTime=[W2TouchTime LpegTouchallWon(j)];
                            end 
                            if LpegTouchallWon(j)>MoveWindow4Start && MoveWindow4End>LpegTouchallWon(j)
                                MoveWindow4=1;
                                W4TouchTime=[W4TouchTime LpegTouchallWon(j)];
                            end
                            if LpegTouchallWon(j)>MoveWindow0Start && MoveWindow0End>LpegTouchallWon(j)
                                MoveWindow0=1;
                            end
                            if LpegTouchallWon(j)>MoveWindow6Start && MoveWindow6End>LpegTouchallWon(j)
                                MoveWindow6=1;
                            end
                        end
                        %MoveWindowSpike=1だったとき、ウインドウ内で
                        if MoveWindowSpike==1
                            for k=1:(length(SpikeArrayWon))
                               if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                                   %ウインドウどれもあてはまらない
                                   if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
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
                                        W13=W13+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W14=W14+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W15=W15+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W24=W24+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W25=W25+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W35=W35+1;
                                    end
                                   %ウインドウ連続で3個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W123=W123+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W234=W234+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W345=W345+1;
                                    end
                                    %ウインドウ連続でないもので3個
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W124=W124+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W125=W125+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W134=W134+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W145=W145+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W135=W135+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W235=W235+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
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
                                        W1235=W1235+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1245=W1245+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1345=W1345+1;
                                    end
                                    %ウインドウ連続で5個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W5seq=Spike_W5seq+1;
                                        W12345=W12345+1;
                                    end
                                    %ウインドウ2だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1345=Spike_W1345+1;
                                    end
                                    %ウインドウ3だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1245=Spike_W1245+1;
                                    end
                                    %ウインドウ4だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1235=Spike_W1235+1;
                                    end
                               end
                            end
                        end
                        %足取りだけでビン毎の当てはまった回数
                        %ウインドウどれもあてはまらない
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW0=TouchCountW0+1;
                        end
                        %ウインドウいずれか一つだけ
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW1=tW1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW2=tW2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            TouchCountW3only=TouchCountW3only+1;
                            tW3=tW3+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW4=tW4+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW5=tW5+1;
                        end 
                        %ウインドウ連続で2個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW12=tW12+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW23=tW23+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW34=tW34+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW45=tW45+1;
                            end
                        end
                        %ウインドウ連続でないもので2個
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW13=tW13+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW14=tW14+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW15=tW15+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW24=tW24+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW25=tW25+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW35=tW35+1;
                        end
                        %ウインドウ連続で3個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW123=tW123+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW234=tW234+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW345=tW345+1;
                            end
                        end
                        %ウインドウ連続でないもので3個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW124=tW124+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW125=tW125+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW134=tW134+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW145=tW145+1;
                            end
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW135=tW135+1;
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW235=tW235+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW245=tW245+1;
                            end
                        end
                        %ウインドウ連続で4個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW1234=TouchCountW1234+1;%ウインドウ5だけ当てはまらない
                                tW1234=tW1234+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1  && MoveWindow0==0 && MoveWindow6==0%ウインドウ１だけ当てはまらない
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW2345=TouchCountW2345+1;%ウインドウ１だけ当てはまらない
                                tW2345=tW2345+1;
                            end
                        end
                        %ウインドウ連続でないもので4個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1235=tW1235+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1245=tW1245+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1345=tW1345+1;
                            end
                        end
                        %ウインドウ連続で5個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW5seq=TouchCountW5seq+1;
                                tW12345=tW12345+1;
                            end
                        end
                        %ウインドウ2だけ当てはまらない
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1345=TouchCountW1345+1;
                            end
                        end
                        %ウインドウ3だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1245=TouchCountW1245+1;
                            end
                        end
                        %ウインドウ4だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1235=TouchCountW1235+1;
                            end
                        end
                    end
            end
            tSpike1=[W1,W2,W3,W4,W5];
            tSpike2=[W12,W23,W34,W45,W13,W14,W15,W24,W25,W35];
            tSpike3=[W123,W234,W345,W124,W125,W134,W135,W145,W235,W245];
            tSpike4=[W1234,W2345,W1235,W1245,W1345];
            SpikeW12345=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W2345,Spike_W1345,Spike_W1245,Spike_W1235,Spike_W1234,Spike_W3only,Spike_W2seqonly];  %各ビン毎に当てはまったMoveWindowSpikeの回数
            
            tTouchCount1=[tW1,tW2,tW3,tW4,tW5];
            tTouchCount2=[tW12,tW23,tW34,tW45,tW13,tW14,tW15,tW24,tW25,tW35];
            tTouchCount3=[tW123,tW234,tW345,tW124,tW125,tW134,tW135,tW145,tW235,tW245];
            tTouchCount4=[tW1234,tW2345,tW1235,tW1245,tW1345];
            TouchCountW12345=[TouchCountW0,TouchCountW1,TouchCountW2seq,TouchCountW3seq,TouchCountW4seq,TouchCountW5seq,TouchCountW2345,TouchCountW1345,TouchCountW1245,TouchCountW1235,TouchCountW1234,TouchCountW3only,TouchCountW2seqonly];
            fig1=figure;
            subplot(5,1,1);
            bar(TouchCountW12345)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            subplot(5,1,2);
            bar(tTouchCount1)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            subplot(5,1,3);
            bar(tTouchCount2)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            subplot(5,1,4);
            bar(tTouchCount3)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            subplot(5,1,5);
            bar(tTouchCount4)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            figname=['Repeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig1,figname);
            close(fig1);
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(tSpike1)
                if tTouchCount1(n)~=0;
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tSpike1(n)/(tTouchCount1(n)*10)];
                else
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tTouchCount1(n)];
                end
            end
            fig6=figure;
            bar(Spike1FR_5Touch_Bin)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike1FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike2)
                if tTouchCount2(n)~=0;
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tSpike2(n)/(tTouchCount2(n)*10)];
                else
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tTouchCount2(n)];
                end
            end
            fig6=figure;
            bar(Spike2FR_5Touch_Bin)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike2FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike3)
                if tTouchCount3(n)~=0;
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tSpike3(n)/(tTouchCount3(n)*10)];
                else
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tTouchCount3(n)];
                end
            end
            fig6=figure;
            bar(Spike3FR_5Touch_Bin)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike3FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike4)
                if tTouchCount4(n)~=0;
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tSpike4(n)/(tTouchCount4(n)*10)];
                else
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tTouchCount4(n)];
                end
            end
            fig6=figure;
            bar(Spike4FR_5Touch_Bin)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike4FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(SpikeW12345)
                if TouchCountW12345(n)~=0;
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin SpikeW12345(n)/(TouchCountW12345(n)*10)];
                else
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin TouchCountW12345(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_5Touch_Bin)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpikeFR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            FLName=['Repeat5Touch',pegpatternum,pegpatternname];
            save(FLName,'SpikeW12345','TouchCountW12345','SpikeFR_5Touch_Bin');
            %
            %R2(1),L2(1),R1(1),L1(1),R1(2)の順
    elseif Linterval2(2)<Rinterval2(1) && Rinterval2(1)<Linterval2(1) && Linterval2(1)<Rinterval1(1) && Rinterval1(1)<Linterval1(1) && Linterval1(1)<Rinterval1(2) && Rinterval1(2)<Linterval1(2) && abs(Rinterval2(1))<abs(Linterval1(2)) && abs(Rinterval1(2))<abs(Linterval2(2))
        RLRLRcount=1;
        windowE1=RWindowE2;
        windowS1=RWindowS2;
        windowS2=LWindowS2;
        windowS3=RWindowS3;
        windowS4=LWindowS3;
        windowS5=RWindowS4;
        windowE0=LWindowE1;
        windowS0=LWindowS1;
        windowE6=LWindowE4;
        windowS6=LWindowS4;
        
        MoveTouchInterval0=windowE1-windowS0;
        MoveTouchInterval1=windowS2-windowE1;
        MoveTouchInterval2=windowS3-windowE1;
        MoveTouchInterval3=windowS4-windowE1;
        MoveTouchInterval4=windowS5-windowE1;
        MoveTouchInterval5=windowS6-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1;
        
        MoveWindowArray_90=fix((RpegTouchallWon(end)-RpegTouchallWon(1))/10)+1;
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2seq=0;
        TouchCountW3seq=0;
        TouchCountW4seq=0;
        TouchCountW5seq=0;
        TouchCountW2345=0;
        TouchCountW1345=0;
        TouchCountW1245=0;
        TouchCountW1235=0;
        TouchCountW1234=0;
        TouchCountW3only=0;
        TouchCountW2seqonly=0;
       
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2seq=0;
        Spike_W3seq=0;
        Spike_W4seq=0;
        Spike_W5seq=0;
        Spike_W2345=0;
        Spike_W1345=0;
        Spike_W1245=0;
        Spike_W1235=0;
        Spike_W1234=0;
        Spike_W3only=0;
        Spike_W2seqonly=0;
        
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

        tW1=0;
        tW2=0;
        tW3=0;
        tW4=0;
        tW5=0;
        tW12=0;
        tW23=0;
        tW34=0;
        tW45=0;
        tW13=0;
        tW14=0;
        tW15=0;
        tW24=0;
        tW25=0;
        tW35=0;
        tW123=0;
        tW234=0;
        tW345=0;
        tW125=0;
        tW124=0;
        tW134=0;
        tW135=0;
        tW145=0;
        tW235=0;
        tW245=0;
        tW1234=0;
        tW1235=0;
        tW1245=0;
        tW1345=0;
        tW2345=0;
        tW12345=0;
        
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
                MoveWindow6Start=MoveWindow1End+MoveTouchInterval5;
                MoveWindow6End=MoveWindow6Start+180;
                MoveWindow0Start=MoveWindow1Start-MoveTouchInterval0;
                MoveWindow0End=MoveWindow0Start+180;
                
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                W4TouchTime=[];
                W5TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
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
                        for i=1:(length(RpegTouchallWon))
                            if RpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>RpegTouchallWon(i)
                                MoveWindow1=1;
                                W1TouchTime=[W1TouchTime RpegTouchallWon(i)];
                            end 
                            if RpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>RpegTouchallWon(i) 
                                MoveWindow3=1;
                                W3TouchTime=[W3TouchTime RpegTouchallWon(i)];
                            end
                            if RpegTouchallWon(i)>MoveWindow5Start && MoveWindow5End>RpegTouchallWon(i) 
                                MoveWindow5=1;
                                W5TouchTime=[W5TouchTime RpegTouchallWon(i)];
                            end
                        end
                        for j=1:(length(LpegTouchallWon))
                            if LpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>LpegTouchallWon(j)
                                MoveWindow2=1;
                                W2TouchTime=[W2TouchTime LpegTouchallWon(j)];
                            end 
                            if LpegTouchallWon(j)>MoveWindow4Start && MoveWindow4End>LpegTouchallWon(j)
                                MoveWindow4=1;
                                W4TouchTime=[W4TouchTime LpegTouchallWon(j)];
                            end
                            if LpegTouchallWon(j)>MoveWindow0Start && MoveWindow0End>LpegTouchallWon(j)
                                MoveWindow0=1;
                            end
                            if LpegTouchallWon(j)>MoveWindow6Start && MoveWindow6End>LpegTouchallWon(j)
                                MoveWindow6=1;
                            end
                        end
                        %MoveWindowSpike=1だったとき、ウインドウ内で
                        if MoveWindowSpike==1
                            for k=1:(length(SpikeArrayWon))
                               if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                                   %ウインドウどれもあてはまらない
                                   if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
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
                                        W13=W13+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W14=W14+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W15=W15+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W24=W24+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W25=W25+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W35=W35+1;
                                    end
                                   %ウインドウ連続で3個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W123=W123+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W234=W234+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W345=W345+1;
                                    end
                                    %ウインドウ連続でないもので3個
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W124=W124+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W125=W125+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W134=W134+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W145=W145+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W135=W135+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W235=W235+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
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
                                        W1235=W1235+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1245=W1245+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1345=W1345+1;
                                    end
                                    %ウインドウ連続で5個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W5seq=Spike_W5seq+1;
                                        W12345=W12345+1;
                                    end
                                    %ウインドウ2だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1345=Spike_W1345+1;
                                    end
                                    %ウインドウ3だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1245=Spike_W1245+1;
                                    end
                                    %ウインドウ4だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1235=Spike_W1235+1;
                                    end
                               end
                            end
                        end
                        %足取りだけでビン毎の当てはまった回数
                        %ウインドウどれもあてはまらない
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW0=TouchCountW0+1;
                        end
                        %ウインドウいずれか一つだけ
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW1=tW1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW2=tW2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            TouchCountW3only=TouchCountW3only+1;
                            tW3=tW3+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW4=tW4+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW5=tW5+1;
                        end 
                        %ウインドウ連続で2個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW12=tW12+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW23=tW23+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW34=tW34+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW45=tW45+1;
                            end
                        end
                        %ウインドウ連続でないもので2個
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            
                            tW13=tW13+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            
                            tW14=tW14+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            
                            tW15=tW15+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW24=tW24+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW25=tW25+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW35=tW35+1;
                        end
                        %ウインドウ連続で3個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW123=tW123+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW234=tW234+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW345=tW345+1;
                            end
                        end
                        %ウインドウ連続でないもので3個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW124=tW124+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW125=tW125+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW134=tW134+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW145=tW145+1;
                            end
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW135=tW135+1;
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW235=tW235+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW245=tW245+1;
                            end
                        end
                        %ウインドウ連続で4個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW1234=TouchCountW1234+1;%ウインドウ5だけ当てはまらない
                                tW1234=tW1234+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1  && MoveWindow0==0 && MoveWindow6==0%ウインドウ１だけ当てはまらない
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW2345=TouchCountW2345+1;%ウインドウ１だけ当てはまらない
                                tW2345=tW2345+1;
                            end
                        end
                        %ウインドウ連続でないもので4個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1235=tW1235+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1245=tW1245+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1345=tW1345+1;
                            end
                        end
                        %ウインドウ連続で5個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW5seq=TouchCountW5seq+1;
                                tW12345=tW12345+1;
                            end
                        end
                        %ウインドウ2だけ当てはまらない
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1345=TouchCountW1345+1;
                            end
                        end
                        %ウインドウ3だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1245=TouchCountW1245+1;
                            end
                        end
                        %ウインドウ4だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1235=TouchCountW1235+1;
                            end
                        end
                    end
            end
            tSpike1=[W1,W2,W3,W4,W5];
            tSpike2=[W12,W23,W34,W45,W13,W14,W15,W24,W25,W35];
            tSpike3=[W123,W234,W345,W124,W125,W134,W135,W145,W235,W245];
            tSpike4=[W1234,W2345,W1235,W1245,W1345];
            SpikeW12345=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W2345,Spike_W1345,Spike_W1245,Spike_W1235,Spike_W1234,Spike_W3only,Spike_W2seqonly];  %各ビン毎に当てはまったMoveWindowSpikeの回数
            
            tTouchCount1=[tW1,tW2,tW3,tW4,tW5];
            tTouchCount2=[tW12,tW23,tW34,tW45,tW13,tW14,tW15,tW24,tW25,tW35];
            tTouchCount3=[tW123,tW234,tW345,tW124,tW125,tW134,tW135,tW145,tW235,tW245];
            tTouchCount4=[tW1234,tW2345,tW1235,tW1245,tW1345];
            TouchCountW12345=[TouchCountW0,TouchCountW1,TouchCountW2seq,TouchCountW3seq,TouchCountW4seq,TouchCountW5seq,TouchCountW2345,TouchCountW1345,TouchCountW1245,TouchCountW1235,TouchCountW1234,TouchCountW3only,TouchCountW2seqonly];
            fig1=figure;
            subplot(5,1,1);
            bar(TouchCountW12345)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            subplot(5,1,2);
            bar(tTouchCount1)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            subplot(5,1,3);
            bar(tTouchCount2)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            subplot(5,1,4);
            bar(tTouchCount3)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            subplot(5,1,5);
            bar(tTouchCount4)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            figname=['Repeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig1,figname);
            close(fig1);
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(tSpike1)
                if tTouchCount1(n)~=0;
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tSpike1(n)/(tTouchCount1(n)*10)];
                else
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tTouchCount1(n)];
                end
            end
            fig6=figure;
            bar(Spike1FR_5Touch_Bin)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike1FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike2)
                if tTouchCount2(n)~=0;
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tSpike2(n)/(tTouchCount2(n)*10)];
                else
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tTouchCount2(n)];
                end
            end
            fig6=figure;
            bar(Spike2FR_5Touch_Bin)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike2FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike3)
                if tTouchCount3(n)~=0;
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tSpike3(n)/(tTouchCount3(n)*10)];
                else
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tTouchCount3(n)];
                end
            end
            fig6=figure;
            bar(Spike3FR_5Touch_Bin)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike3FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike4)
                if tTouchCount4(n)~=0;
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tSpike4(n)/(tTouchCount4(n)*10)];
                else
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tTouchCount4(n)];
                end
            end
            fig6=figure;
            bar(Spike4FR_5Touch_Bin)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike4FR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(SpikeW12345)
                if TouchCountW12345(n)~=0;
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin SpikeW12345(n)/(TouchCountW12345(n)*10)];
                else
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin TouchCountW12345(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_5Touch_Bin)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpikeFR_BinRLRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            FLName=['Repeat5Touch',pegpatternum,pegpatternname];
            save(FLName,'SpikeW12345','TouchCountW12345','SpikeFR_5Touch_Bin');
    end
%     %L2(2),R2(2),L2(1),R2(1),L1(1)の順% ウインドウLRLRLの順
    if Rinterval2(3)<Linterval2(2) && Linterval2(2)<Rinterval2(2) && Rinterval2(2)<Linterval2(1) && Linterval2(1)<Rinterval2(1) && Rinterval2(1)<Linterval1(1) && Linterval1(1)<Rinterval1(1) && abs(Linterval2(2))<abs(Rinterval1(1)) && abs(Linterval1(1))<abs(Rinterval2(3))
       
        LRLRLcount=1; 
        windowE1=LWindowE1;
        windowS1=LWindowS1;
        windowS2=RWindowS1;
        windowS3=LWindowS2;
        windowS4=RWindowS2;
        windowS5=LWindowS3;
        windowE0=RWindowE0;
        windowS0=RWindowS0;
        windowE6=RWindowE3;
        windowS6=RWindowS3;
        
        MoveTouchInterval0=windowE1-windowS0;
        MoveTouchInterval1=windowS2-windowE1;
        MoveTouchInterval2=windowS3-windowE1;
        MoveTouchInterval3=windowS4-windowE1;
        MoveTouchInterval4=windowS5-windowE1;
        MoveTouchInterval5=windowS6-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1;
        
        MoveWindowArray_90=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2seq=0;
        TouchCountW3seq=0;
        TouchCountW4seq=0;
        TouchCountW5seq=0;
        TouchCountW2345=0;
        TouchCountW1345=0;
        TouchCountW1245=0;
        TouchCountW1235=0;
        TouchCountW1234=0;
        TouchCountW3only=0;
        TouchCountW2seqonly=0;
       
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2seq=0;
        Spike_W3seq=0;
        Spike_W4seq=0;
        Spike_W5seq=0;
        Spike_W2345=0;
        Spike_W1345=0;
        Spike_W1245=0;
        Spike_W1235=0;
        Spike_W1234=0;
        Spike_W3only=0;
        Spike_W2seqonly=0;
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

        tW1=0;
        tW2=0;
        tW3=0;
        tW4=0;
        tW5=0;
        tW12=0;
        tW23=0;
        tW34=0;
        tW45=0;
        tW13=0;
        tW14=0;
        tW15=0;
        tW24=0;
        tW25=0;
        tW35=0;
        tW123=0;
        tW234=0;
        tW345=0;
        tW125=0;
        tW124=0;
        tW134=0;
        tW135=0;
        tW145=0;
        tW235=0;
        tW245=0;
        tW1234=0;
        tW1235=0;
        tW1245=0;
        tW1345=0;
        tW2345=0;
        tW12345=0;
        
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
                MoveWindow6Start=MoveWindow1End+MoveTouchInterval5;
                MoveWindow6End=MoveWindow6Start+180;
                MoveWindow0Start=MoveWindow1Start-MoveTouchInterval0;
                MoveWindow0End=MoveWindow0Start+180;
                
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                W4TouchTime=[];
                W5TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
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
                        for i=1:(length(LpegTouchallWon))
                            if LpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>LpegTouchallWon(i)
                                MoveWindow1=1;
                                W1TouchTime=[W1TouchTime LpegTouchallWon(i)];
                            end 
                            if LpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>LpegTouchallWon(i) 
                                MoveWindow3=1;
                                W3TouchTime=[W3TouchTime LpegTouchallWon(i)];
                            end
                            if LpegTouchallWon(i)>MoveWindow5Start && MoveWindow5End>LpegTouchallWon(i) 
                                MoveWindow5=1;
                                W5TouchTime=[W5TouchTime LpegTouchallWon(i)];
                            end
                        end
                        for j=1:(length(RpegTouchallWon))
                            if RpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>RpegTouchallWon(j)
                                MoveWindow2=1;
                                W2TouchTime=[W2TouchTime RpegTouchallWon(j)];
                            end 
                            if RpegTouchallWon(j)>MoveWindow4Start && MoveWindow4End>RpegTouchallWon(j)
                                MoveWindow4=1;
                                W4TouchTime=[W4TouchTime RpegTouchallWon(j)];
                            end
                            if RpegTouchallWon(j)>MoveWindow0Start && MoveWindow0End>RpegTouchallWon(j)
                                MoveWindow0=1;
                            end
                            if RpegTouchallWon(j)>MoveWindow6Start && MoveWindow6End>RpegTouchallWon(j)
                                MoveWindow6=1;
                            end
                        end
                        %MoveWindowSpike=1だったとき、ウインドウ内で
                        if MoveWindowSpike==1
                            for k=1:(length(SpikeArrayWon))
                               if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                                   %ウインドウどれもあてはまらない
                                   if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
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
                                        W13=W13+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W14=W14+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W15=W15+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W24=W24+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W25=W25+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W35=W35+1;
                                    end
                                   %ウインドウ連続で3個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W123=W123+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W234=W234+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W345=W345+1;
                                    end
                                    %ウインドウ連続でないもので3個
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W124=W124+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W125=W125+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W134=W134+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W145=W145+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W135=W135+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W235=W235+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
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
                                        W1235=W1235+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1245=W1245+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1345=W1345+1;
                                    end
                                    %ウインドウ連続で5個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W5seq=Spike_W5seq+1;
                                        W12345=W12345+1;
                                    end
                                    %ウインドウ2だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1345=Spike_W1345+1;
                                    end
                                    %ウインドウ3だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1245=Spike_W1245+1;
                                    end
                                    %ウインドウ4だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1235=Spike_W1235+1;
                                    end
                               end
                            end
                        end
                        %足取りだけでビン毎の当てはまった回数
                        %ウインドウどれもあてはまらない
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW0=TouchCountW0+1;
                        end
                        %ウインドウいずれか一つだけ
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW1=tW1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW2=tW2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            TouchCountW3only=TouchCountW3only+1;
                            tW3=tW3+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW4=tW4+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW5=tW5+1;
                        end 
                        %ウインドウ連続で2個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW12=tW12+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW23=tW23+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW34=tW34+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW45=tW45+1;
                            end
                        end
                        %ウインドウ連続でないもので2個
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW13=tW13+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW14=tW14+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW15=tW15+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW24=tW24+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW25=tW25+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW35=tW35+1;
                        end
                        %ウインドウ連続で3個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW123=tW123+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW234=tW234+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW345=tW345+1;
                            end
                        end
                        %ウインドウ連続でないもので3個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW124=tW124+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW125=tW125+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW134=tW134+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW145=tW145+1;
                            end
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW135=tW135+1;
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW235=tW235+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                TouchCountW3notseq=TouchCountW3notseq+1;
                                tW245=tW245+1;
                            end
                        end
                        %ウインドウ連続で4個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW1234=TouchCountW1234+1;%ウインドウ5だけ当てはまらない
                                tW1234=tW1234+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1  && MoveWindow0==0 && MoveWindow6==0%ウインドウ１だけ当てはまらない
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW2345=TouchCountW2345+1;%ウインドウ１だけ当てはまらない
                                tW2345=tW2345+1;
                            end
                        end
                        %ウインドウ連続でないもので4個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1235=tW1235+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1245=tW1245+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1345=tW1345+1;
                            end
                        end
                        %ウインドウ連続で5個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW5seq=TouchCountW5seq+1;
                                tW12345=tW12345+1;
                            end
                        end
                        %ウインドウ2だけ当てはまらない
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1345=TouchCountW1345+1;
                            end
                        end
                        %ウインドウ3だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1245=TouchCountW1245+1;
                            end
                        end
                        %ウインドウ4だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1235=TouchCountW1235+1;
                            end
                        end
                    end
            end
            tSpike1=[W1,W2,W3,W4,W5];
            tSpike2=[W12,W23,W34,W45,W13,W14,W15,W24,W25,W35];
            tSpike3=[W123,W234,W345,W124,W125,W134,W135,W145,W235,W245];
            tSpike4=[W1234,W2345,W1235,W1245,W1345];
            SpikeW12345=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W2345,Spike_W1345,Spike_W1245,Spike_W1235,Spike_W1234,Spike_W3only,Spike_W2seqonly];  %各ビン毎に当てはまったMoveWindowSpikeの回数
            
            tTouchCount1=[tW1,tW2,tW3,tW4,tW5];
            tTouchCount2=[tW12,tW23,tW34,tW45,tW13,tW14,tW15,tW24,tW25,tW35];
            tTouchCount3=[tW123,tW234,tW345,tW124,tW125,tW134,tW135,tW145,tW235,tW245];
            tTouchCount4=[tW1234,tW2345,tW1235,tW1245,tW1345];
            TouchCountW12345=[TouchCountW0,TouchCountW1,TouchCountW2seq,TouchCountW3seq,TouchCountW4seq,TouchCountW5seq,TouchCountW2345,TouchCountW1345,TouchCountW1245,TouchCountW1235,TouchCountW1234,TouchCountW3only,TouchCountW2seqonly];
            fig1=figure;
            subplot(5,1,1);
            bar(TouchCountW12345)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            subplot(5,1,2);
            bar(tTouchCount1)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            subplot(5,1,3);
            bar(tTouchCount2)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            subplot(5,1,4);
            bar(tTouchCount3)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            subplot(5,1,5);
            bar(tTouchCount4)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            figname=['Repeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig1,figname);
            close(fig1);
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(tSpike1)
                if tTouchCount1(n)~=0;
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tSpike1(n)/(tTouchCount1(n)*10)];
                else
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tTouchCount1(n)];
                end
            end
            fig6=figure;
            bar(Spike1FR_5Touch_Bin)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike1FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike2)
                if tTouchCount2(n)~=0;
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tSpike2(n)/(tTouchCount2(n)*10)];
                else
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tTouchCount2(n)];
                end
            end
            fig6=figure;
            bar(Spike2FR_5Touch_Bin)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike2FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike3)
                if tTouchCount3(n)~=0;
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tSpike3(n)/(tTouchCount3(n)*10)];
                else
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tTouchCount3(n)];
                end
            end
            fig6=figure;
            bar(Spike3FR_5Touch_Bin)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike3FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike4)
                if tTouchCount4(n)~=0;
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tSpike4(n)/(tTouchCount4(n)*10)];
                else
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tTouchCount4(n)];
                end
            end
            fig6=figure;
            bar(Spike4FR_5Touch_Bin)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike4FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(SpikeW12345)
                if TouchCountW12345(n)~=0;
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin SpikeW12345(n)/(TouchCountW12345(n)*10)];
                else
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin TouchCountW12345(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_5Touch_Bin)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpikeFR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            FLName=['Repeat5Touch',pegpatternum,pegpatternname];
            save(FLName,'SpikeW12345','TouchCountW12345','SpikeFR_5Touch_Bin');
       %L2(2),R2(1),L2(1),R1(1),L1(1)の順
     elseif Rinterval2(2)<Linterval2(2) && Linterval2(2)<Rinterval2(1) && Rinterval2(1)<Linterval2(1) && Linterval2(1)<Rinterval1(1) && Rinterval1(1)<Linterval1(1) && Linterval1(1)<Rinterval1(2) && abs(Linterval2(2))<abs(Rinterval1(2)) && abs(Linterval1(1))<abs(Rinterval2(2)) % ウインドウLRL
        LRLRLcount=1; 
        windowE1=LWindowE1;
        windowS1=LWindowS1;
        windowS2=RWindowS2;
        windowS3=LWindowS2;
        windowS4=RWindowS3;
        windowS5=LWindowS3;
        windowE0=RWindowE1;
        windowS0=RWindowS1;
        windowE6=RWindowE4;
        windowS6=RWindowS4;
        
        MoveTouchInterval0=windowE1-windowS0;
        MoveTouchInterval1=windowS2-windowE1;
        MoveTouchInterval2=windowS3-windowE1;
        MoveTouchInterval3=windowS4-windowE1;
        MoveTouchInterval4=windowS5-windowE1;
        MoveTouchInterval5=windowS6-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1;
        
        MoveWindowArray_90=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2seq=0;
        TouchCountW3seq=0;
        TouchCountW4seq=0;
        TouchCountW5seq=0;
        TouchCountW2345=0;
        TouchCountW1345=0;
        TouchCountW1245=0;
        TouchCountW1235=0;
        TouchCountW1234=0;
        TouchCountW3only=0;
        TouchCountW2seqonly=0;
       
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2seq=0;
        Spike_W3seq=0;
        Spike_W4seq=0;
        Spike_W5seq=0;
        Spike_W2345=0;
        Spike_W1345=0;
        Spike_W1245=0;
        Spike_W1235=0;
        Spike_W1234=0;
        Spike_W3only=0;
        Spike_W2seqonly=0;
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

        tW1=0;
        tW2=0;
        tW3=0;
        tW4=0;
        tW5=0;
        tW12=0;
        tW23=0;
        tW34=0;
        tW45=0;
        tW13=0;
        tW14=0;
        tW15=0;
        tW24=0;
        tW25=0;
        tW35=0;
        tW123=0;
        tW234=0;
        tW345=0;
        tW125=0;
        tW124=0;
        tW134=0;
        tW135=0;
        tW145=0;
        tW235=0;
        tW245=0;
        tW1234=0;
        tW1235=0;
        tW1245=0;
        tW1345=0;
        tW2345=0;
        tW12345=0;
        
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
                MoveWindow6Start=MoveWindow1End+MoveTouchInterval5;
                MoveWindow6End=MoveWindow6Start+180;
                MoveWindow0Start=MoveWindow1Start-MoveTouchInterval0;
                MoveWindow0End=MoveWindow0Start+180;
                
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                W4TouchTime=[];
                W5TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
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
                        for i=1:(length(LpegTouchallWon))
                            if LpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>LpegTouchallWon(i)
                                MoveWindow1=1;
                                W1TouchTime=[W1TouchTime LpegTouchallWon(i)];
                            end 
                            if LpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>LpegTouchallWon(i) 
                                MoveWindow3=1;
                                W3TouchTime=[W3TouchTime LpegTouchallWon(i)];
                            end
                            if LpegTouchallWon(i)>MoveWindow5Start && MoveWindow5End>LpegTouchallWon(i) 
                                MoveWindow5=1;
                                W5TouchTime=[W5TouchTime LpegTouchallWon(i)];
                            end
                        end
                        for j=1:(length(RpegTouchallWon))
                            if RpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>RpegTouchallWon(j)
                                MoveWindow2=1;
                                W2TouchTime=[W2TouchTime RpegTouchallWon(j)];
                            end 
                            if RpegTouchallWon(j)>MoveWindow4Start && MoveWindow4End>RpegTouchallWon(j)
                                MoveWindow4=1;
                                W4TouchTime=[W4TouchTime RpegTouchallWon(j)];
                            end
                            if RpegTouchallWon(j)>MoveWindow0Start && MoveWindow0End>RpegTouchallWon(j)
                                MoveWindow0=1;
                            end
                            if RpegTouchallWon(j)>MoveWindow6Start && MoveWindow6End>RpegTouchallWon(j)
                                MoveWindow6=1;
                            end
                        end
                        %MoveWindowSpike=1だったとき、ウインドウ内で
                        if MoveWindowSpike==1
                            for k=1:(length(SpikeArrayWon))
                               if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                                   %ウインドウどれもあてはまらない
                                   if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
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
                                        W13=W13+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W14=W14+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W15=W15+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W24=W24+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W25=W25+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W35=W35+1;
                                    end
                                   %ウインドウ連続で3個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W123=W123+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W234=W234+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W345=W345+1;
                                    end
                                    %ウインドウ連続でないもので3個
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W124=W124+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W125=W125+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W134=W134+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W145=W145+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W135=W135+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W235=W235+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
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
                                        W1235=W1235+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1245=W1245+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1345=W1345+1;
                                    end
                                    %ウインドウ連続で5個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W5seq=Spike_W5seq+1;
                                        W12345=W12345+1;
                                    end
                                    %ウインドウ2だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1345=Spike_W1345+1;
                                    end
                                    %ウインドウ3だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1245=Spike_W1245+1;
                                    end
                                    %ウインドウ4だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1235=Spike_W1235+1;
                                    end
                               end
                            end
                        end
                        %足取りだけでビン毎の当てはまった回数
                        %ウインドウどれもあてはまらない
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW0=TouchCountW0+1;
                        end
                        %ウインドウいずれか一つだけ
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW1=tW1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW2=tW2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            TouchCountW3only=TouchCountW3only+1;
                            tW3=tW3+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW4=tW4+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW5=tW5+1;
                        end 
                        %ウインドウ連続で2個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW12=tW12+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW23=tW23+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW34=tW34+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW45=tW45+1;
                            end
                        end
                        %ウインドウ連続でないもので2個
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW13=tW13+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW14=tW14+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW15=tW15+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW24=tW24+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW25=tW25+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW35=tW35+1;
                        end
                        %ウインドウ連続で3個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW123=tW123+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW234=tW234+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW345=tW345+1;
                            end
                        end
                        %ウインドウ連続でないもので3個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW124=tW124+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW125=tW125+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW134=tW134+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW145=tW145+1;
                            end
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW135=tW135+1;
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW235=tW235+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW245=tW245+1;
                            end
                        end
                        %ウインドウ連続で4個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW1234=TouchCountW1234+1;%ウインドウ5だけ当てはまらない
                                tW1234=tW1234+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1  && MoveWindow0==0 && MoveWindow6==0%ウインドウ１だけ当てはまらない
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW2345=TouchCountW2345+1;%ウインドウ１だけ当てはまらない
                                tW2345=tW2345+1;
                            end
                        end
                        %ウインドウ連続でないもので4個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1235=tW1235+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1245=tW1245+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1345=tW1345+1;
                            end
                        end
                        %ウインドウ連続で5個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW5seq=TouchCountW5seq+1;
                                tW12345=tW12345+1;
                            end
                        end
                        %ウインドウ2だけ当てはまらない
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1345=TouchCountW1345+1;
                            end
                        end
                        %ウインドウ3だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1245=TouchCountW1245+1;
                            end
                        end
                        %ウインドウ4だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1235=TouchCountW1235+1;
                            end
                        end
                    end
            end
            tSpike1=[W1,W2,W3,W4,W5];
            tSpike2=[W12,W23,W34,W45,W13,W14,W15,W24,W25,W35];
            tSpike3=[W123,W234,W345,W124,W125,W134,W135,W145,W235,W245];
            tSpike4=[W1234,W2345,W1235,W1245,W1345];
            SpikeW12345=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W2345,Spike_W1345,Spike_W1245,Spike_W1235,Spike_W1234,Spike_W3only,Spike_W2seqonly];  %各ビン毎に当てはまったMoveWindowSpikeの回数
            
            tTouchCount1=[tW1,tW2,tW3,tW4,tW5];
            tTouchCount2=[tW12,tW23,tW34,tW45,tW13,tW14,tW15,tW24,tW25,tW35];
            tTouchCount3=[tW123,tW234,tW345,tW124,tW125,tW134,tW135,tW145,tW235,tW245];
            tTouchCount4=[tW1234,tW2345,tW1235,tW1245,tW1345];
            TouchCountW12345=[TouchCountW0,TouchCountW1,TouchCountW2seq,TouchCountW3seq,TouchCountW4seq,TouchCountW5seq,TouchCountW2345,TouchCountW1345,TouchCountW1245,TouchCountW1235,TouchCountW1234,TouchCountW3only,TouchCountW2seqonly];
            fig1=figure;
            subplot(5,1,1);
            bar(TouchCountW12345)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            subplot(5,1,2);
            bar(tTouchCount1)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            subplot(5,1,3);
            bar(tTouchCount2)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            subplot(5,1,4);
            bar(tTouchCount3)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            subplot(5,1,5);
            bar(tTouchCount4)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            figname=['Repeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig1,figname);
            close(fig1);
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(tSpike1)
                if tTouchCount1(n)~=0;
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tSpike1(n)/(tTouchCount1(n)*10)];
                else
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tTouchCount1(n)];
                end
            end
            fig6=figure;
            bar(Spike1FR_5Touch_Bin)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike1FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike2)
                if tTouchCount2(n)~=0;
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tSpike2(n)/(tTouchCount2(n)*10)];
                else
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tTouchCount2(n)];
                end
            end
            fig6=figure;
            bar(Spike2FR_5Touch_Bin)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike2FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike3)
                if tTouchCount3(n)~=0;
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tSpike3(n)/(tTouchCount3(n)*10)];
                else
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tTouchCount3(n)];
                end
            end
            fig6=figure;
            bar(Spike3FR_5Touch_Bin)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike3FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike4)
                if tTouchCount4(n)~=0;
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tSpike4(n)/(tTouchCount4(n)*10)];
                else
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tTouchCount4(n)];
                end
            end
            fig6=figure;
            bar(Spike4FR_5Touch_Bin)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike4FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(SpikeW12345)
                if TouchCountW12345(n)~=0;
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin SpikeW12345(n)/(TouchCountW12345(n)*10)];
                else
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin TouchCountW12345(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_5Touch_Bin)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpikeFR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            FLName=['Repeat5Touch',pegpatternum,pegpatternname];
            save(FLName,'SpikeW12345','TouchCountW12345','SpikeFR_5Touch_Bin');
            %L2(1),R2(1),L1(1),R1(1),L1(2)の順
    elseif Rinterval2(2)<Linterval2(1) && Linterval2(1)<Rinterval2(1) && Rinterval2(1)<Linterval1(1) && Linterval1(1)<Rinterval1(1) && Rinterval1(1)<Linterval1(2) && Linterval1(2)<Rinterval1(2) && abs(Linterval2(1))<abs(Rinterval1(2)) && abs(Linterval1(2))<abs(Rinterval2(2)) % ウインドウLRLの順
        LRLRLcount=1; 
        windowE1=LWindowE2;
        windowS1=LWindowS2;
        windowS2=RWindowS2;
        windowS3=LWindowS3;
        windowS4=RWindowS3;
        windowS5=LWindowS4;
        windowE0=RWindowE1;
        windowS0=RWindowS1;
        windowE6=RWindowE4;
        windowS6=RWindowS4;
        
        MoveTouchInterval0=windowE1-windowS0;
        MoveTouchInterval1=windowS2-windowE1;
        MoveTouchInterval2=windowS3-windowE1;
        MoveTouchInterval3=windowS4-windowE1;
        MoveTouchInterval4=windowS5-windowE1;
        MoveTouchInterval5=windowS6-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1;
        
        MoveWindowArray_90=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2seq=0;
        TouchCountW3seq=0;
        TouchCountW4seq=0;
        TouchCountW5seq=0;
        TouchCountW2345=0;
        TouchCountW1345=0;
        TouchCountW1245=0;
        TouchCountW1235=0;
        TouchCountW1234=0;
        TouchCountW3only=0;
        TouchCountW2seqonly=0;
       
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2seq=0;
        Spike_W3seq=0;
        Spike_W4seq=0;
        Spike_W5seq=0;
        Spike_W2345=0;
        Spike_W1345=0;
        Spike_W1245=0;
        Spike_W1235=0;
        Spike_W1234=0;
        Spike_W3only=0;
        Spike_W2seqonly=0;
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

        tW1=0;
        tW2=0;
        tW3=0;
        tW4=0;
        tW5=0;
        tW12=0;
        tW23=0;
        tW34=0;
        tW45=0;
        tW13=0;
        tW14=0;
        tW15=0;
        tW24=0;
        tW25=0;
        tW35=0;
        tW123=0;
        tW234=0;
        tW345=0;
        tW125=0;
        tW124=0;
        tW134=0;
        tW135=0;
        tW145=0;
        tW235=0;
        tW245=0;
        tW1234=0;
        tW1235=0;
        tW1245=0;
        tW1345=0;
        tW2345=0;
        tW12345=0;
        
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
                MoveWindow6Start=MoveWindow1End+MoveTouchInterval5;
                MoveWindow6End=MoveWindow6Start+180;
                MoveWindow0Start=MoveWindow1Start-MoveTouchInterval0;
                MoveWindow0End=MoveWindow0Start+180;
                
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                W4TouchTime=[];
                W5TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
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
                        for i=1:(length(LpegTouchallWon))
                            if LpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>LpegTouchallWon(i)
                                MoveWindow1=1;
                                W1TouchTime=[W1TouchTime LpegTouchallWon(i)];
                            end 
                            if LpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>LpegTouchallWon(i) 
                                MoveWindow3=1;
                                W3TouchTime=[W3TouchTime LpegTouchallWon(i)];
                            end
                            if LpegTouchallWon(i)>MoveWindow5Start && MoveWindow5End>LpegTouchallWon(i) 
                                MoveWindow5=1;
                                W5TouchTime=[W5TouchTime LpegTouchallWon(i)];
                            end
                        end
                        for j=1:(length(RpegTouchallWon))
                            if RpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>RpegTouchallWon(j)
                                MoveWindow2=1;
                                W2TouchTime=[W2TouchTime RpegTouchallWon(j)];
                            end 
                            if RpegTouchallWon(j)>MoveWindow4Start && MoveWindow4End>RpegTouchallWon(j)
                                MoveWindow4=1;
                                W4TouchTime=[W4TouchTime RpegTouchallWon(j)];
                            end
                            if RpegTouchallWon(j)>MoveWindow0Start && MoveWindow0End>RpegTouchallWon(j)
                                MoveWindow0=1;
                            end
                            if RpegTouchallWon(j)>MoveWindow6Start && MoveWindow6End>RpegTouchallWon(j)
                                MoveWindow6=1;
                            end
                        end
                        %MoveWindowSpike=1だったとき、ウインドウ内で
                        if MoveWindowSpike==1
                            for k=1:(length(SpikeArrayWon))
                               if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                                   %ウインドウどれもあてはまらない
                                   if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
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
                                        W13=W13+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W14=W14+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W15=W15+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W24=W24+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W25=W25+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W35=W35+1;
                                    end
                                   %ウインドウ連続で3個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W123=W123+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W234=W234+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        Spike_W3seq=Spike_W3seq+1;
                                        W345=W345+1;
                                    end
                                    %ウインドウ連続でないもので3個
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W124=W124+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W125=W125+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                        W134=W134+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W145=W145+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W135=W135+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W235=W235+1;
                                    end
                                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
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
                                        W1235=W1235+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1245=W1245+1;
                                    end
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                        W1345=W1345+1;
                                    end
                                    %ウインドウ連続で5個当てはまる
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W5seq=Spike_W5seq+1;
                                        W12345=W12345+1;
                                    end
                                    %ウインドウ2だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1345=Spike_W1345+1;
                                    end
                                    %ウインドウ3だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1245=Spike_W1245+1;
                                    end
                                    %ウインドウ4だけ当てはまらない
                                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                        Spike_W1235=Spike_W1235+1;
                                    end
                               end
                            end
                        end
                        %足取りだけでビン毎の当てはまった回数
                        %ウインドウどれもあてはまらない
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW0=TouchCountW0+1;
                        end
                        %ウインドウいずれか一つだけ
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW1=tW1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW2=tW2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            TouchCountW3only=TouchCountW3only+1;
                            tW3=tW3+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW4=tW4+1;
                        end 
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                            TouchCountW1=TouchCountW1+1;
                            tW5=tW5+1;
                        end 
                        %ウインドウ連続で2個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW12=tW12+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW23=tW23+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                TouchCountW2seqonly=TouchCountW2seqonly+1;
                                tW34=tW34+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW2seq=TouchCountW2seq+1;
                                tW45=tW45+1;
                            end
                        end
                        %ウインドウ連続でないもので2個
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW13=tW13+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW14=tW14+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW15=tW15+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                            tW24=tW24+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW25=tW25+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW35=tW35+1;
                        end
                        %ウインドウ連続で3個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW123=tW123+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW234=tW234+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW3seq=TouchCountW3seq+1;
                                tW345=tW345+1;
                            end
                        end
                        %ウインドウ連続でないもので3個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW124=tW124+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW125=tW125+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0  && MoveWindow6==0
                                tW134=tW134+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW145=tW145+1;
                            end
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                            tW135=tW135+1;
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW235=tW235+1;
                            end
                        end
                        if length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW245=tW245+1;
                            end
                        end
                        %ウインドウ連続で4個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==0 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW1234=TouchCountW1234+1;%ウインドウ5だけ当てはまらない
                                tW1234=tW1234+1;
                            end
                        end
                        if length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1  && MoveWindow0==0 && MoveWindow6==0%ウインドウ１だけ当てはまらない
                                TouchCountW4seq=TouchCountW4seq+1;
                                TouchCountW2345=TouchCountW2345+1;%ウインドウ１だけ当てはまらない
                                tW2345=tW2345+1;
                            end
                        end
                        %ウインドウ連続でないもので4個
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1235=tW1235+1;
                            end
                        end
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1245=tW1245+1;
                            end
                        end
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0  && MoveWindow6==0
                                tW1345=tW1345+1;
                            end
                        end
                        %ウインドウ連続で5個当てはまる
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1) && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW5seq=TouchCountW5seq+1;
                                tW12345=tW12345+1;
                            end
                        end
                        %ウインドウ2だけ当てはまらない
                        if length(W3TouchTime)==1 && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W3TouchTime(1)<W4TouchTime(1) && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1345=TouchCountW1345+1;
                            end
                        end
                        %ウインドウ3だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && length(W4TouchTime)==1 && length(W5TouchTime)==1 && W4TouchTime(1)<W5TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindow4==1 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1245=TouchCountW1245+1;
                            end
                        end
                        %ウインドウ4だけ当てはまらない
                        if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                            if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindow4==0 && MoveWindow5==1 && MoveWindow0==0 && MoveWindow6==0
                                TouchCountW1235=TouchCountW1235+1;
                            end
                        end
                    end
            end
            tSpike1=[W1,W2,W3,W4,W5];
            tSpike2=[W12,W23,W34,W45,W13,W14,W15,W24,W25,W35];
            tSpike3=[W123,W234,W345,W124,W125,W134,W135,W145,W235,W245];
            tSpike4=[W1234,W2345,W1235,W1245,W1345];
            SpikeW12345=[Spike_W0,Spike_W1,Spike_W2seq,Spike_W3seq,Spike_W4seq,Spike_W5seq,Spike_W2345,Spike_W1345,Spike_W1245,Spike_W1235,Spike_W1234,Spike_W3only,Spike_W2seqonly];  %各ビン毎に当てはまったMoveWindowSpikeの回数
            
            tTouchCount1=[tW1,tW2,tW3,tW4,tW5];
            tTouchCount2=[tW12,tW23,tW34,tW45,tW13,tW14,tW15,tW24,tW25,tW35];
            tTouchCount3=[tW123,tW234,tW345,tW124,tW125,tW134,tW135,tW145,tW235,tW245];
            tTouchCount4=[tW1234,tW2345,tW1235,tW1245,tW1345];
            TouchCountW12345=[TouchCountW0,TouchCountW1,TouchCountW2seq,TouchCountW3seq,TouchCountW4seq,TouchCountW5seq,TouchCountW2345,TouchCountW1345,TouchCountW1245,TouchCountW1235,TouchCountW1234,TouchCountW3only,TouchCountW2seqonly];
            fig1=figure;
            subplot(5,1,1);
            bar(TouchCountW12345)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            subplot(5,1,2);
            bar(tTouchCount1)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            subplot(5,1,3);
            bar(tTouchCount2)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            subplot(5,1,4);
            bar(tTouchCount3)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            subplot(5,1,5);
            bar(tTouchCount4)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            figname=['Repeat5TouchCount',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig1,figname);
            close(fig1);
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(tSpike1)
                if tTouchCount1(n)~=0;
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tSpike1(n)/(tTouchCount1(n)*10)];
                else
                    Spike1FR_5Touch_Bin=[Spike1FR_5Touch_Bin tTouchCount1(n)];
                end
            end
            fig6=figure;
            bar(Spike1FR_5Touch_Bin)
            set(gca,'xticklabel',{'1','2','3','4','5'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike1FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike2)
                if tTouchCount2(n)~=0;
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tSpike2(n)/(tTouchCount2(n)*10)];
                else
                    Spike2FR_5Touch_Bin=[Spike2FR_5Touch_Bin tTouchCount2(n)];
                end
            end
            fig6=figure;
            bar(Spike2FR_5Touch_Bin)
            set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike2FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike3)
                if tTouchCount3(n)~=0;
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tSpike3(n)/(tTouchCount3(n)*10)];
                else
                    Spike3FR_5Touch_Bin=[Spike3FR_5Touch_Bin tTouchCount3(n)];
                end
            end
            fig6=figure;
            bar(Spike3FR_5Touch_Bin)
            set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike3FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(tSpike4)
                if tTouchCount4(n)~=0;
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tSpike4(n)/(tTouchCount4(n)*10)];
                else
                    Spike4FR_5Touch_Bin=[Spike4FR_5Touch_Bin tTouchCount4(n)];
                end
            end
            fig6=figure;
            bar(Spike4FR_5Touch_Bin)
            set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpike4FR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            for n=1:length(SpikeW12345)
                if TouchCountW12345(n)~=0;
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin SpikeW12345(n)/(TouchCountW12345(n)*10)];
                else
                    SpikeFR_5Touch_Bin=[SpikeFR_5Touch_Bin TouchCountW12345(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_5Touch_Bin)
            set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat5TouchSpikeFR_BinLRLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            FLName=['Repeat5Touch',pegpatternum,pegpatternname];
            save(FLName,'SpikeW12345','TouchCountW12345','SpikeFR_5Touch_Bin');
    end
end