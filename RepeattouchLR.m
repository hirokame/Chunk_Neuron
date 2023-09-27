function RepeattouchLR
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2

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
CCresultLtouch=hist(CrossCoL,bin);
CCresultLtouch=MovWindow(CCresultLtouch,10);

fig1=figure;
subplot(2,6,[1,2]);
plot(linspace(1,5000,bin),CCresultLtouch,'color','r','LineWidth',1);
axis([0 5000 0 max(CCresultLtouch)*1.1]);
hold on
%SpikeArrayでRPegTouchAllをアラインする
for n=1:(length(SpikeArrayWon))
        Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoR=[CrossCoR Interval];
end
    
CrossCoR=[-1*duration/2 CrossCoR duration/2];

CrossCoR(CrossCoR==0)=[];

bin=500;
CCresultRtouch=hist(CrossCoR,bin);
CCresultRtouch=MovWindow(CCresultRtouch,10);

plot(linspace(1,5000,bin),CCresultRtouch,'color','g','LineWidth',1);
axis([0 5000 0 max(CCresultLtouch)*1.1]);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RpegTouchallWon
% LpegTouchallWon

% クロスコリオグラムからピークを検出
subplot(2,6,[3,4]);
findpeaks(CCresultLtouch,'MinPeakDistance',35);
[Lpks,Llocs]=findpeaks(CCresultLtouch,'MinPeakDistance',35);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(abs(LlocsInterval2),'ascend');

subplot(2,6,[5,6]);
findpeaks(CCresultRtouch,'MinPeakDistance',35);
[Rpks,Rlocs]=findpeaks(CCresultRtouch,'MinPeakDistance',35);
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(abs(RlocsInterval2),'ascend');

if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  
% ウィンドウ設定
% 前後90ms
LWindowS1_90=-Linterval2(2)*10-90;
LWindowE1_90=-Linterval2(2)*10+90;

LWindowS2_90=-Linterval2(1)*10-90;
LWindowE2_90=-Linterval2(1)*10+90;

LWindowS3_90=Linterval1(1)*10-90;
LWindowE3_90=Linterval1(1)*10+90;

LWindowS4_90=Linterval1(2)*10-90;
LWindowE4_90=Linterval1(2)*10+90;

LWinterval1_90=LWindowS2_90-LWindowE1_90;
LWinterval2_90=LWindowS3_90-LWindowE2_90;
LWinterval3_90=LWindowS4_90-LWindowE3_90;
RtouchPeak1_90=0;
RtouchPeak2_90=0;
for p=1:(length(RlocsInterval))
        if RlocsInterval(p)>=-Linterval2(1) && Linterval1(1)>=RlocsInterval(p)
           RtouchPeak2_90=RlocsInterval(p);
        end
        if RlocsInterval(p)>=-Linterval2(2) && -Linterval2(1)>=RlocsInterval(p)
           RtouchPeak1_90=RlocsInterval(p);
        end
end
if RtouchPeak1_90~=0
if RtouchPeak2_90~=0
    
    RWindowS1_90=RtouchPeak1_90*10-90;
    RWindowE1_90=RtouchPeak1_90*10+90;
    RWindowS2_90=RtouchPeak2_90*10-90;
    RWindowE2_90=RtouchPeak2_90*10+90;
% 左足反応cellウインドウ2個or3個にして、スパイク後の
% 足取りが連続性において重要か調べる。ウインドウ123使用
WL1_90=0;
WL2_90=0;
WL3_90=0;
WR1_90=0;
WR2_90=0;
CountL0_90=0;
CountL1_90=0;
CountL2_90=0;
CountL3_90=0;
CountL1L2_90=0;
CountL1L3_90=0;
CountL2L3_90=0;
CountL1L2L3_90=0;
CountR0_90=0;
CountR1_90=0;
CountR2_90=0;
CountR1R2_90=0;
CountL1L2R1_90=0;
CountL1L2R1R2_90=0;
CountL1L2L3R1R2_90=0;

for n=1:(length(SpikeArrayWon))
    WL1_90=0;
    WL2_90=0;
    WL3_90=0;
    WR1_90=0;
    WR2_90=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1_90&SpikeArrayWon(n)+LWindowE1_90>LpegTouchallWon(i)
                WL1_90=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_90&SpikeArrayWon(n)+LWindowE2_90>LpegTouchallWon(i) 
                WL2_90=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_90&SpikeArrayWon(n)+LWindowE3_90>LpegTouchallWon(i) 
                WL3_90=1;
                
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS1_90&SpikeArrayWon(n)+RWindowE1_90>RpegTouchallWon(j)
                WR1_90=1;
        end
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS2_90&SpikeArrayWon(n)+RWindowE2_90>RpegTouchallWon(j)
                WR2_90=1;
        end
    end
    
    if WL1_90==0 & WL2_90==0 & WL3_90==0
       CountL0_90=CountL0_90+1;
    end
    if WL1_90==1 & WL2_90==0 & WL3_90==0
       CountL1_90=CountL1_90+1;
    end
    if WL1_90==0 & WL2_90==1 & WL3_90==0
       CountL2_90=CountL2_90+1;
    end
    if WL1_90==0 & WL2_90==0 & WL3_90==1
       CountL3_90=CountL3_90+1;
    end
    if WL1_90==1 & WL2_90==1 & WL3_90==0
       CountL1L2_90=CountL1L2_90+1;
    end
    if WL1_90==1 & WL2_90==0 & WL3_90==1
       CountL1L3_90=CountL1L3_90+1;
    end
    if WL1_90==0 & WL2_90==1 & WL3_90==1
       CountL2L3_90=CountL2L3_90+1;
    end
    if WL1_90==1 & WL2_90==1 & WL3_90==1
       CountL1L2L3_90=CountL1L2L3_90+1;
    end
    if WR1_90==0 & WR2_90==0
       CountR0_90=CountR0_90+1;
    end
    if WR1_90==1 & WR2_90==0
       CountR1_90=CountR1_90+1;
    end
    if WR1_90==0 & WR2_90==1
       CountR2_90=CountR2_90+1;
    end
    if WR1_90==1 & WR2_90==1
       CountR1R2_90=CountR1R2_90+1;
    end
    if WL1_90==1 & WL2_90==1 & WR1_90==1 & WR2_90==0 & WL3_90==0
       CountL1L2R1_90=CountL1L2R1_90+1;
    end
    if WL1_90==1 & WL2_90==1 & WR1_90==1 & WR2_90==1 & WL3_90==0
       CountL1L2R1R2_90=CountL1L2R1R2_90+1;
    end
    if WL1_90==1 & WL2_90==1 & WR1_90==1 & WR2_90==1 & WL3_90==1
       CountL1L2L3R1R2_90=CountL1L2L3R1R2_90+1;
    end
end
WcomL123_90=[CountL0_90,CountL1_90,CountL2_90,CountL3_90,CountL1L2_90,CountL1L3_90,CountL2L3_90,CountL1L2L3_90];
subplot(2,6,[7,8]);
bar(WcomL123_90)
set(gca,'xticklabel',{'no','L1','L2','L3','L12','L13','L23','L123',});

WcomR12_90=[CountR0_90,CountR1_90,CountR2_90,CountR1R2_90];
subplot(2,6,[9,10]);
bar(WcomR12_90)
set(gca,'xticklabel',{'no','R1','R2','R12'});

WcomL123R12_90=[CountL1L2R1_90,CountL1L2R1R2_90,CountL1L2L3R1R2_90];
subplot(2,6,[11,12]);
bar(WcomL123R12_90)
set(gca,'xticklabel',{'L12R1','L12R12','L123R12',});
trimtfile=strtrim(tfile);
figname=['RepeatL123R12Width180',trimFolder2,trimtfile,pegpatternname,'.bmp'];
saveas(fig1,figname);
end
end
end
close(fig1);


