function RepeattouchWcombination
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
subplot(4,3,1);
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
subplot(4,3,2);
findpeaks(CCresultLtouch,'MinPeakDistance',35);
[Lpks,Llocs]=findpeaks(CCresultLtouch,'MinPeakDistance',35);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(abs(LlocsInterval2),'ascend');

subplot(4,3,3);
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
if RtouchPeak1_90~=0 && RtouchPeak2_90~=0
    RWindowS1_90=RtouchPeak1_90*10-90;
    RWindowE1_90=RtouchPeak1_90*10+90;
    RWindowS2_90=RtouchPeak2_90*10-90;
    RWindowE2_90=RtouchPeak2_90*10+90;
% 左足反応cellウインドウ2個、ウインドウ12
L1_90=0;
L2_90=0;
CountL0_90W12=0;
CountL1_90W12=0;
CountL2_90W12=0;
CountL12_90W12=0;
for n=1:(length(SpikeArrayWon))
    L1_90=0;
    L2_90=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1_90&SpikeArrayWon(n)+LWindowE1_90>LpegTouchallWon(i)
                L1_90=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_90&SpikeArrayWon(n)+LWindowE2_90>LpegTouchallWon(i) 
                L2_90=1;
            end
    end
    
    if L1_90==0 & L2_90==0
       CountL0_90W12=CountL0_90W12+1;
    end
    if L1_90==1 & L2_90==0
       CountL1_90W12=CountL1_90W12+1;
    end
    if L1_90==0 & L2_90==1
       CountL2_90W12=CountL2_90W12+1;
    end
    if L1_90==1 & L2_90==1
       CountL12_90W12=CountL12_90W12+1;
    end
end
Wcom12_90=[CountL0_90W12,CountL1_90W12,CountL2_90W12,CountL12_90W12];

subplot(4,3,4);
bar(Wcom12_90)
set(gca,'xticklabel',{'no','L1','L2','L12'});
% xlabel('no  L1  L2  L1L2')
%ウインドウL1L2を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_90=linspace(0,15300,86);
TouchL1_90=0;
TouchL2_90=0;
TouchL0_90W12=0;
TouchL1_90W12=0;
TouchL2_90W12=0;
TouchL12_90W12=0;

for n=1:(length(MoveWindowArray_90))
    
    TouchL1_90=0;
    TouchL2_90=0;
    preWS1_90=MoveWindowArray_90(n);
    preWE1_90=preWS1_90+180;
    preWS2_90=preWE1_90+LWinterval1_90;
    preWE2_90=preWS2_90+180;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS1_90&preWE1_90>LpegTouchallWon(i)
                TouchL1_90=1;
            end 
            if  LpegTouchallWon(i)>preWS2_90&preWE2_90>LpegTouchallWon(i) 
                TouchL2_90=1;
            end
    end
    if TouchL1_90==0 & TouchL2_90==0
       TouchL0_90W12=TouchL0_90W12+1;
    end
    if TouchL1_90==1 & TouchL2_90==0
       TouchL1_90W12=TouchL1_90W12+1;
    end
    if TouchL1_90==0 & TouchL2_90==1
       TouchL2_90W12=TouchL2_90W12+1;
    end
    if TouchL1_90==1 & TouchL2_90==1
       TouchL12_90W12=TouchL12_90W12+1;
    end
end
TouchCountL1L2_90=[TouchL0_90W12,TouchL1_90W12,TouchL2_90W12,TouchL12_90W12];
subplot(4,3,7);
bar(TouchCountL1L2_90)
set(gca,'xticklabel',{'no','L1','L2','L12'});
% xlabel('no  L1  L2  L1L2')
% 左足反応cellウインドウ2個、右足反応cellウインドウ1個　Lウインドウ12、Rウインドウ１
WR1_90=0;
WL1_90=0;
WL2_90=0;
CountL0R0_90=0;
CountL1R0_90=0;
CountL2R0_90=0;
CountL0R1_90=0;
CountL1L2_90=0;
CountL1R1_90=0;
CountL2R1_90=0;
CountL1L2R1_90=0;
for n=1:(length(SpikeArrayWon))
    WR1_90=0;
    WL1_90=0;
    WL2_90=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1_90&SpikeArrayWon(n)+LWindowE1_90>LpegTouchallWon(i)
                WL1_90=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_90&SpikeArrayWon(n)+LWindowE2_90>LpegTouchallWon(i) 
                WL2_90=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS1_90&SpikeArrayWon(n)+RWindowE1_90>RpegTouchallWon(j)
                WR1_90=1;
        end
    end
    
    if WL1_90==0 & WL2_90==0 & WR1_90==0
       CountL0R0_90=CountL0R0_90+1;
    end
    if WL1_90==1 & WL2_90==0 & WR1_90==0
       CountL1R0_90=CountL1R0_90+1;
    end
    if WL1_90==0 & WL2_90==1 & WR1_90==0
       CountL2R0_90=CountL2R0_90+1;
    end
    if WL1_90==0 & WL2_90==0 & WR1_90==1
       CountL0R1_90=CountL0R1_90+1;
    end
    if WL1_90==1 & WL2_90==1 & WR1_90==0
       CountL1L2_90=CountL1L2_90+1;
    end
    if WL1_90==1 & WL2_90==0 & WR1_90==1
       CountL1R1_90=CountL1R1_90+1;
    end
    if WL1_90==0 & WL2_90==1 & WR1_90==1
       CountL2R1_90=CountL2R1_90+1;
    end
    if WL1_90==1 & WL2_90==1 & WR1_90==1
       CountL1L2R1_90=CountL1L2R1_90+1;
    end
end
WcomL12R1_90=[CountL0R0_90,CountL1R0_90,CountL2R0_90,CountL0R1_90,CountL1L2_90,CountL1R1_90,CountL2R1_90,CountL1L2R1_90];
subplot(4,3,10);
bar(WcomL12R1_90)
set(gca,'xticklabel',{'no','L1','L2','R1','L1','L2','L1R1','L2R1','L12R1'});
% xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
% 左足反応cellウインドウ2個、ウインドウ23
L3_90=0;
L4_90=0;
CountL0_90W23=0;
CountL1_90W23=0;
CountL2_90W23=0;
CountL12_90W23=0;
for n=1:(length(SpikeArrayWon))
    L3_90=0;
    L4_90=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_90&SpikeArrayWon(n)+LWindowE2_90>LpegTouchallWon(i)
                L3_90=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_90&SpikeArrayWon(n)+LWindowE3_90>LpegTouchallWon(i) 
                L4_90=1;
            end
    end
    
    if L3_90==0 & L4_90==0
       CountL0_90W23=CountL0_90W23+1;
    end
    if L3_90==1 & L4_90==0
       CountL1_90W23=CountL1_90W23+1;
    end
    if L3_90==0 & L4_90==1
       CountL2_90W23=CountL2_90W23+1;
    end
    if L3_90==1 & L4_90==1
       CountL12_90W23=CountL12_90W23+1;
    end
end

Wcom23_90=[CountL0_90W23,CountL1_90W23,CountL2_90W23,CountL12_90W23];

subplot(4,3,5);
bar(Wcom23_90)
set(gca,'xticklabel',{'no','L2','L3','L23'});
% xlabel('no  L2  L3  L2L3')
%ウインドウL2L3を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_90=linspace(0,15300,86);
TouchL3_90=0;
TouchL4_90=0;
TouchL0_90W23=0;
TouchL1_90W23=0;
TouchL2_90W23=0;
TouchL12_90W23=0;

for n=1:(length(MoveWindowArray_90))
    
    TouchL3_90=0;
    TouchL4_90=0;
    preWS3_90=MoveWindowArray_90(n);
    preWE3_90=preWS3_90+180;
    preWS4_90=preWE3_90+LWinterval2_90;
    preWE4_90=preWS4_90+180;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS3_90&preWE3_90>LpegTouchallWon(i)
                TouchL3_90=1;
            end 
            if  LpegTouchallWon(i)>preWS4_90&preWE4_90>LpegTouchallWon(i) 
                TouchL4_90=1;
            end
    end
    if TouchL3_90==0 & TouchL4_90==0
       TouchL0_90W23=TouchL0_90W23+1;
    end
    if TouchL3_90==1 & TouchL4_90==0
       TouchL1_90W23=TouchL1_90W23+1;
    end
    if TouchL3_90==0 & TouchL4_90==1
       TouchL2_90W23=TouchL2_90W23+1;
    end
    if TouchL3_90==1 & TouchL4_90==1
       TouchL12_90W23=TouchL12_90W23+1;
    end
end
TouchCountL2L3_90=[TouchL0_90W23,TouchL1_90W23,TouchL2_90W23,TouchL12_90W23];
subplot(4,3,8);
bar(TouchCountL2L3_90)
set(gca,'xticklabel',{'no','L2','L3','L23'});
% xlabel('no  L2  L3  L2L3')
% 左足反応cellウインドウ2個、右足反応cellウインドウ1個　Lウインドウ23、Rウインドウ１
WR3_90=0;
WL3_90=0;
WL4_90=0;
CountL0R0_90L23R2=0;
CountL1R0_90L23R2=0;
CountL2R0_90L23R2=0;
CountL0R1_90L23R2=0;
CountL1L2_90L23R2=0;
CountL1R1_90L23R2=0;
CountL2R1_90L23R2=0;
CountL1L2R1_90L23R2=0;
for n=1:(length(SpikeArrayWon))
    WR3_90=0;
    WL3_90=0;
    WL4_90=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_90&SpikeArrayWon(n)+LWindowE2_90>LpegTouchallWon(i)
                WL3_90=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_90&SpikeArrayWon(n)+LWindowE3_90>LpegTouchallWon(i) 
                WL4_90=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS2_90&SpikeArrayWon(n)+RWindowE2_90>RpegTouchallWon(j)
                WR3_90=1;
        end
    end
    
    if WL3_90==0 & WL4_90==0 & WR3_90==0
       CountL0R0_90L23R2=CountL0R0_90L23R2+1;
    end
    if WL3_90==1 & WL4_90==0 & WR3_90==0
       CountL1R0_90L23R2=CountL1R0_90L23R2+1;
    end
    if WL3_90==0 & WL4_90==1 & WR3_90==0
       CountL2R0_90L23R2=CountL2R0_90L23R2+1;
    end
    if WL3_90==0 & WL4_90==0 & WR3_90==1
       CountL0R1_90L23R2=CountL0R1_90L23R2+1;
    end
    if WL3_90==1 & WL4_90==1 & WR3_90==0
       CountL1L2_90L23R2=CountL1L2_90L23R2+1;
    end
    if WL3_90==1 & WL4_90==0 & WR3_90==1
       CountL1R1_90L23R2=CountL1R1_90L23R2+1;
    end
    if WL3_90==0 & WL4_90==1 & WR3_90==1
       CountL2R1_90L23R2=CountL2R1_90L23R2+1;
    end
    if WL3_90==1 & WL4_90==1 & WR3_90==1
       CountL1L2R1_90L23R2=CountL1L2R1_90L23R2+1;
    end
end
WcomL23R1_90=[CountL0R0_90L23R2,CountL1R0_90L23R2,CountL2R0_90L23R2,CountL0R1_90L23R2,CountL1L2_90L23R2,CountL1R1_90L23R2,CountL2R1_90L23R2,CountL1L2R1_90L23R2];
subplot(4,3,11);
bar(WcomL23R1_90)
set(gca,'xticklabel',{'no','L1','L2','R1','L12','L1R1','L2R1','L12R1'});
% xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
% 左足反応cellウインドウ2個、ウインドウ34
L5_90=0;
L6_90=0;
CountL0_90W34=0;
CountL1_90W34=0;
CountL2_90W34=0;
CountL12_90W34=0;
for n=1:(length(SpikeArrayWon))
    L5_90=0;
    L6_90=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_90&SpikeArrayWon(n)+LWindowE3_90>LpegTouchallWon(i)
                L5_90=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS4_90&SpikeArrayWon(n)+LWindowE4_90>LpegTouchallWon(i) 
                L6_90=1;
            end
    end
    
    if L5_90==0 & L6_90==0
       CountL0_90W34=CountL0_90W34+1;
    end
    if L5_90==1 & L6_90==0
       CountL1_90W34=CountL1_90W34+1;
    end
    if L5_90==0 & L6_90==1
       CountL2_90W34=CountL2_90W34+1;
    end
    if L5_90==1 & L6_90==1
       CountL12_90W34=CountL12_90W34+1;
    end
end

Wcom34_90=[CountL0_90W34,CountL1_90W34,CountL2_90W34,CountL12_90W34];

subplot(4,3,6);
bar(Wcom34_90)
set(gca,'xticklabel',{'no','L3','L4','L34'});
% xlabel('no  L3  L4  L3L4')
%ウインドウL3L4を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_90=linspace(0,15300,86);
TouchL5_90=0;
TouchL6_90=0;
TouchL0_90W34=0;
TouchL1_90W34=0;
TouchL2_90W34=0;
TouchL12_90W34=0;

for n=1:(length(MoveWindowArray_90))
    
    TouchL5_90=0;
    TouchL6_90=0;
    preWS5_90=MoveWindowArray_90(n);
    preWE5_90=preWS5_90+180;
    preWS6_90=preWE5_90+LWinterval3_90;
    preWE6_90=preWS6_90+180;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS5_90&preWE5_90>LpegTouchallWon(i)
                TouchL5_90=1;
            end 
            if  LpegTouchallWon(i)>preWS6_90&preWE6_90>LpegTouchallWon(i) 
                TouchL6_90=1;
            end
    end
    if TouchL5_90==0 & TouchL6_90==0
       TouchL0_90W34=TouchL0_90W34+1;
    end
    if TouchL5_90==1 & TouchL6_90==0
       TouchL1_90W34=TouchL1_90W34+1;
    end
    if TouchL5_90==0 & TouchL6_90==1
       TouchL2_90W34=TouchL2_90W34+1;
    end
    if TouchL5_90==1 & TouchL6_90==1
       TouchL12_90W34=TouchL12_90W34+1;
    end
end
TouchCountL3L4_90=[TouchL0_90W34,TouchL1_90W34,TouchL2_90W34,TouchL12_90W34];
subplot(4,3,9);
bar(TouchCountL3L4_90)
set(gca,'xticklabel',{'no','L3','L4','L34'});
% xlabel('no  L3  L4  L3L4')

trimtfile=strtrim(tfile);
figname=['RepeatL2R1combinationWidth180',trimFolder2,trimtfile,pegpatternname,'.bmp'];
saveas(fig1,figname);
end
% close(fig1);
% close(fig2);
% close(fig3);
% end

% % 前後100ms
fig2=figure;
subplot(4,3,1);
plot(linspace(1,5000,bin),CCresultLtouch,'color','r','LineWidth',1);
axis([0 5000 0 max(CCresultLtouch)*1.1]);
hold on
plot(linspace(1,5000,bin),CCresultRtouch,'color','g','LineWidth',1);
axis([0 5000 0 max(CCresultLtouch)*1.1]);
hold off

subplot(4,3,2);
findpeaks(CCresultLtouch,'MinPeakDistance',35);
subplot(4,3,3);
findpeaks(CCresultRtouch,'MinPeakDistance',35);

LWindowS1_100=-Linterval2(2)*10-100;
LWindowE1_100=-Linterval2(2)*10+100;

LWindowS2_100=-Linterval2(1)*10-100;
LWindowE2_100=-Linterval2(1)*10+100;

LWindowS3_100=Linterval1(1)*10-100;
LWindowE3_100=Linterval1(1)*10+100;

LWindowS4_100=Linterval1(2)*10-100;
LWindowE4_100=Linterval1(2)*10+100;

LWinterval1_100=LWindowS2_100-LWindowE1_100;
LWinterval2_100=LWindowS3_100-LWindowE2_100;
LWinterval3_100=LWindowS4_100-LWindowE3_100;
RtouchPeak1_100=0;
RtouchPeak2_100=0;
for p=1:(length(RlocsInterval))
        if RlocsInterval(p)>=-Linterval2(1) && Linterval1(1)>=RlocsInterval(p)
           RtouchPeak2_100=RlocsInterval(p);
        end
        if RlocsInterval(p)>=-Linterval2(2) && -Linterval2(1)>=RlocsInterval(p)
           RtouchPeak1_100=RlocsInterval(p);
        end
end

if  RtouchPeak1_100~=0 && RtouchPeak2_100~=0
    RWindowS1_100=RtouchPeak1_100*10-100;
    RWindowE1_100=RtouchPeak1_100*10+100;
    RWindowS2_100=RtouchPeak2_100*10-100;
    RWindowE2_100=RtouchPeak2_100*10+100;
% 左足反応cellウインドウ2個、ウインドウ12
L1_100=0;
L2_100=0;
CountL0_100W12=0;
CountL1_100W12=0;
CountL2_100W12=0;
CountL12_100W12=0;
for n=1:(length(SpikeArrayWon))
    L1_100=0;
    L2_100=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1_100&SpikeArrayWon(n)+LWindowE1_100>LpegTouchallWon(i)
                L1_100=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_100&SpikeArrayWon(n)+LWindowE2_100>LpegTouchallWon(i) 
                L2_100=1;
            end
    end
    
    if L1_100==0 & L2_100==0
       CountL0_100W12=CountL0_100W12+1;
    end
    if L1_100==1 & L2_100==0
       CountL1_100W12=CountL1_100W12+1;
    end
    if L1_100==0 & L2_100==1
       CountL2_100W12=CountL2_100W12+1;
    end
    if L1_100==1 & L2_100==1
       CountL12_100W12=CountL12_100W12+1;
    end
end


Wcom12_100=[CountL0_100W12,CountL1_100W12,CountL2_100W12,CountL12_100W12];

subplot(4,3,4);
bar(Wcom12_100)
set(gca,'xticklabel',{'no','L1','L2','L12'});
% xlabel('no  L1  L2  L1L2')
%ウインドウL1L2を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_100=linspace(0,15400,78);
TouchL1_100=0;
TouchL2_100=0;
TouchL0_100W12=0;
TouchL1_100W12=0;
TouchL2_100W12=0;
TouchL12_100W12=0;

for n=1:(length(MoveWindowArray_100))
    
    TouchL1_100=0;
    TouchL2_100=0;
    preWS1_100=MoveWindowArray_100(n);
    preWE1_100=preWS1_100+200;
    preWS2_100=preWE1_100+LWinterval1_100;
    preWE2_100=preWS2_100+200;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS1_100&preWE1_100>LpegTouchallWon(i)
                TouchL1_100=1;
            end 
            if  LpegTouchallWon(i)>preWS2_100&preWE2_100>LpegTouchallWon(i) 
                TouchL2_100=1;
            end
    end
    if TouchL1_100==0 & TouchL2_100==0
       TouchL0_100W12=TouchL0_100W12+1;
    end
    if TouchL1_100==1 & TouchL2_100==0
       TouchL1_100W12=TouchL1_100W12+1;
    end
    if TouchL1_100==0 & TouchL2_100==1
       TouchL2_100W12=TouchL2_100W12+1;
    end
    if TouchL1_100==1 & TouchL2_100==1
       TouchL12_100W12=TouchL12_100W12+1;
    end
end
TouchCountL1L2_100=[TouchL0_100W12,TouchL1_100W12,TouchL2_100W12,TouchL12_100W12];
subplot(4,3,7);
bar(TouchCountL1L2_100)
set(gca,'xticklabel',{'no','L1','L2','L12'});
% xlabel('no  L1  L2  L1L2')
% 左足反応cellウインドウ2個、右足反応cellウインドウ1個　Lウインドウ12、Rウインドウ１
WR1_100=0;
WL1_100=0;
WL2_100=0;
CountL0R0_100=0;
CountL1R0_100=0;
CountL2R0_100=0;
CountL0R1_100=0;
CountL1L2_100=0;
CountL1R1_100=0;
CountL2R1_100=0;
CountL1L2R1_100=0;
for n=1:(length(SpikeArrayWon))
    WR1_100=0;
    WL1_100=0;
    WL2_100=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1_100&SpikeArrayWon(n)+LWindowE1_100>LpegTouchallWon(i)
                WL1_100=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_100&SpikeArrayWon(n)+LWindowE2_100>LpegTouchallWon(i) 
                WL2_100=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS1_100&SpikeArrayWon(n)+RWindowE1_100>RpegTouchallWon(j)
                WR1_100=1;
        end
    end
    
    if WL1_100==0 & WL2_100==0 & WR1_100==0
       CountL0R0_100=CountL0R0_100+1;
    end
    if WL1_100==1 & WL2_100==0 & WR1_100==0
       CountL1R0_100=CountL1R0_100+1;
    end
    if WL1_100==0 & WL2_100==1 & WR1_100==0
       CountL2R0_100=CountL2R0_100+1;
    end
    if WL1_100==0 & WL2_100==0 & WR1_100==1
       CountL0R1_100=CountL0R1_100+1;
    end
    if WL1_100==1 & WL2_100==1 & WR1_100==0
       CountL1L2_100=CountL1L2_100+1;
    end
    if WL1_100==1 & WL2_100==0 & WR1_100==1
       CountL1R1_100=CountL1R1_100+1;
    end
    if WL1_100==0 & WL2_100==1 & WR1_100==1
       CountL2R1_100=CountL2R1_100+1;
    end
    if WL1_100==1 & WL2_100==1 & WR1_100==1
       CountL1L2R1_100=CountL1L2R1_100+1;
    end
end
WcomL12R1_100=[CountL0R0_100,CountL1R0_100,CountL2R0_100,CountL0R1_100,CountL1L2_100,CountL1R1_100,CountL2R1_100,CountL1L2R1_100];
subplot(4,3,10);
bar(WcomL12R1_100)
set(gca,'xticklabel',{'no','L1','L2','R1','L12','L1R1','L2R1','L12R1'});
% xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
% 左足反応cellウインドウ2個、ウインドウ23
L3_100=0;
L4_100=0;
CountL0_100W23=0;
CountL1_100W23=0;
CountL2_100W23=0;
CountL12_100W23=0;
for n=1:(length(SpikeArrayWon))
    L3_100=0;
    L4_100=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_100&SpikeArrayWon(n)+LWindowE2_100>LpegTouchallWon(i)
                L3_100=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_100&SpikeArrayWon(n)+LWindowE3_100>LpegTouchallWon(i) 
                L4_100=1;
            end
    end
    
    if L3_100==0 & L4_100==0
       CountL0_100W23=CountL0_100W23+1;
    end
    if L3_100==1 & L4_100==0
       CountL1_100W23=CountL1_100W23+1;
    end
    if L3_100==0 & L4_100==1
       CountL2_100W23=CountL2_100W23+1;
    end
    if L3_100==1 & L4_100==1
       CountL12_100W23=CountL12_100W23+1;
    end
end

Wcom23_100=[CountL0_100W23,CountL1_100W23,CountL2_100W23,CountL12_100W23];
subplot(4,3,5);
bar(Wcom23_100)
set(gca,'xticklabel',{'no','L2','L3','L23'});
% xlabel('no  L2  L3  L2L3')
%ウインドウL2L3を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_100=linspace(0,15400,78);
TouchL3_100=0;
TouchL4_100=0;
TouchL0_100W23=0;
TouchL1_100W23=0;
TouchL2_100W23=0;
TouchL12_100W23=0;

for n=1:(length(MoveWindowArray_100))
    
    TouchL3_100=0;
    TouchL4_100=0;
    preWS3_100=MoveWindowArray_100(n);
    preWE3_100=preWS3_100+200;
    preWS4_100=preWE3_100+LWinterval2_100;
    preWE4_100=preWS4_100+200;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS3_100&preWE3_100>LpegTouchallWon(i)
                TouchL3_100=1;
            end 
            if  LpegTouchallWon(i)>preWS4_100&preWE4_100>LpegTouchallWon(i) 
                TouchL4_100=1;
            end
    end
    if TouchL3_100==0 & TouchL4_100==0
       TouchL0_100W23=TouchL0_100W23+1;
    end
    if TouchL3_100==1 & TouchL4_100==0
       TouchL1_100W23=TouchL1_100W23+1;
    end
    if TouchL3_100==0 & TouchL4_100==1
       TouchL2_100W23=TouchL2_100W23+1;
    end
    if TouchL3_100==1 & TouchL4_100==1
       TouchL12_100W23=TouchL12_100W23+1;
    end
end
TouchCountL2L3_100=[TouchL0_100W23,TouchL1_100W23,TouchL2_100W23,TouchL12_100W23];
subplot(4,3,8);
bar(TouchCountL2L3_100)
set(gca,'xticklabel',{'no','L2','L3','L23'});
% xlabel('no  L2  L3  L2L3')
% 左足反応cellウインドウ2個、右足反応cellウインドウ1個　Lウインドウ23、Rウインドウ１
WR3_100=0;
WL3_100=0;
WL4_100=0;
CountL0R0_100L23R2=0;
CountL1R0_100L23R2=0;
CountL2R0_100L23R2=0;
CountL0R1_100L23R2=0;
CountL1L2_100L23R2=0;
CountL1R1_100L23R2=0;
CountL2R1_100L23R2=0;
CountL1L2R1_100L23R2=0;
for n=1:(length(SpikeArrayWon))
    WR3_100=0;
    WL3_100=0;
    WL4_100=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_100&SpikeArrayWon(n)+LWindowE2_100>LpegTouchallWon(i)
                WL3_100=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_100&SpikeArrayWon(n)+LWindowE3_100>LpegTouchallWon(i) 
                WL4_100=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS2_100&SpikeArrayWon(n)+RWindowE2_100>RpegTouchallWon(j)
                WR3_100=1;
        end
    end
    
    if WL3_100==0 & WL4_100==0 & WR3_100==0
       CountL0R0_100L23R2=CountL0R0_100L23R2+1;
    end
    if WL3_100==1 & WL4_100==0 & WR3_100==0
       CountL1R0_100L23R2=CountL1R0_100L23R2+1;
    end
    if WL3_100==0 & WL4_100==1 & WR3_100==0
       CountL2R0_100L23R2=CountL2R0_100L23R2+1;
    end
    if WL3_100==0 & WL4_100==0 & WR3_100==1
       CountL0R1_100L23R2=CountL0R1_100L23R2+1;
    end
    if WL3_100==1 & WL4_100==1 & WR3_100==0
       CountL1L2_100L23R2=CountL1L2_100L23R2+1;
    end
    if WL3_100==1 & WL4_100==0 & WR3_100==1
       CountL1R1_100L23R2=CountL1R1_100L23R2+1;
    end
    if WL3_100==0 & WL4_100==1 & WR3_100==1
       CountL2R1_100L23R2=CountL2R1_100L23R2+1;
    end
    if WL3_100==1 & WL4_100==1 & WR3_100==1
       CountL1L2R1_100L23R2=CountL1L2R1_100L23R2+1;
    end
end
WcomL23R1_100=[CountL0R0_100L23R2,CountL1R0_100L23R2,CountL2R0_100L23R2,CountL0R1_100L23R2,CountL1L2_100L23R2,CountL1R1_100L23R2,CountL2R1_100L23R2,CountL1L2R1_100L23R2];
subplot(4,3,11);
bar(WcomL23R1_100)
set(gca,'xticklabel',{'no','L1','L2','R1','L12','L1R1','L2R1','L12R1'});
% xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
% 左足反応cellウインドウ2個、ウインドウ34
L5_100=0;
L6_100=0;
CountL0_100W34=0;
CountL1_100W34=0;
CountL2_100W34=0;
CountL12_100W34=0;
for n=1:(length(SpikeArrayWon))
    L5_100=0;
    L6_100=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_100&SpikeArrayWon(n)+LWindowE3_100>LpegTouchallWon(i)
                L5_100=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS4_100&SpikeArrayWon(n)+LWindowE4_100>LpegTouchallWon(i) 
                L6_100=1;
            end
    end
    
    if L5_100==0 & L6_100==0
       CountL0_100W34=CountL0_100W34+1;
    end
    if L5_100==1 & L6_100==0
       CountL1_100W34=CountL1_100W34+1;
    end
    if L5_100==0 & L6_100==1
       CountL2_100W34=CountL2_100W34+1;
    end
    if L5_100==1 & L6_100==1
       CountL12_100W34=CountL12_100W34+1;
    end
end

Wcom34_100=[CountL0_100W34,CountL1_100W34,CountL2_100W34,CountL12_100W34];

subplot(4,3,6);
bar(Wcom34_100)
set(gca,'xticklabel',{'no','L3','L4','L34'});
% xlabel('no  L3  L4  L3L4')
%ウインドウL3L4を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_100=linspace(0,15400,78);
TouchL5_100=0;
TouchL6_100=0;
TouchL0_100W34=0;
TouchL1_100W34=0;
TouchL2_100W34=0;
TouchL12_100W34=0;

for n=1:(length(MoveWindowArray_100))
    
    TouchL5_100=0;
    TouchL6_100=0;
    preWS5_100=MoveWindowArray_100(n);
    preWE5_100=preWS5_100+200;
    preWS6_100=preWE5_100+LWinterval3_100;
    preWE6_100=preWS6_100+200;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS5_100&preWE5_100>LpegTouchallWon(i)
                TouchL5_100=1;
            end 
            if  LpegTouchallWon(i)>preWS6_100&preWE6_100>LpegTouchallWon(i) 
                TouchL6_100=1;
            end
    end
    if TouchL5_100==0 & TouchL6_100==0
       TouchL0_100W34=TouchL0_100W34+1;
    end
    if TouchL5_100==1 & TouchL6_100==0
       TouchL1_100W34=TouchL1_100W34+1;
    end
    if TouchL5_100==0 & TouchL6_100==1
       TouchL2_100W34=TouchL2_100W34+1;
    end
    if TouchL5_100==1 & TouchL6_100==1
       TouchL12_100W34=TouchL12_100W34+1;
    end
end
TouchCountL3L4_100=[TouchL0_100W34,TouchL1_100W34,TouchL2_100W34,TouchL12_100W34];
subplot(4,3,9);
bar(TouchCountL3L4_100)
set(gca,'xticklabel',{'no','L3','L4','L34'});
% xlabel('no  L3  L4  L3L4')

trimtfile=strtrim(tfile);
figname=['RepeatL2R1combinationWidth200',trimFolder2,trimtfile,pegpatternname,'.bmp'];
saveas(fig2,figname);
end
% % 前後110ms
fig3=figure;
subplot(3,3,1);
plot(linspace(1,5000,bin),CCresultLtouch,'color','r','LineWidth',1);
axis([0 5000 0 max(CCresultLtouch)*1.1]);
hold on
plot(linspace(1,5000,bin),CCresultRtouch,'color','g','LineWidth',1);
axis([0 5000 0 max(CCresultLtouch)*1.1]);
hold off

subplot(3,3,2);
findpeaks(CCresultLtouch,'MinPeakDistance',35);
subplot(3,3,3);
findpeaks(CCresultRtouch,'MinPeakDistance',35);

LWindowS1_110=-Linterval2(2)*10-110;
LWindowE1_110=-Linterval2(2)*10+110;

LWindowS2_110=-Linterval2(1)*10-110;
LWindowE2_110=-Linterval2(1)*10+110;

LWindowS3_110=Linterval1(1)*10-110;
LWindowE3_110=Linterval1(1)*10+110;

LWindowS4_110=Linterval1(2)*10-110;
LWindowE4_110=Linterval1(2)*10+110;

LWinterval1_110=LWindowS2_110-LWindowE1_110;
LWinterval2_110=LWindowS3_110-LWindowE2_110;
LWinterval3_110=LWindowS4_110-LWindowE3_110;
% 左足反応cellウインドウ2個、ウインドウ12
L1_110=0;
L2_110=0;
CountL0_110W12=0;
CountL1_110W12=0;
CountL2_110W12=0;
CountL12_110W12=0;
for n=1:(length(SpikeArrayWon))
    L1_110=0;
    L2_110=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1_110&SpikeArrayWon(n)+LWindowE1_110>LpegTouchallWon(i)
                L1_110=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_110&SpikeArrayWon(n)+LWindowE2_110>LpegTouchallWon(i) 
                L2_110=1;
            end
    end
    
    if L1_110==0 & L2_110==0
       CountL0_110W12=CountL0_110W12+1;
    end
    if L1_110==1 & L2_110==0
       CountL1_110W12=CountL1_110W12+1;
    end
    if L1_110==0 & L2_110==1
       CountL2_110W12=CountL2_110W12+1;
    end
    if L1_110==1 & L2_110==1
       CountL12_110W12=CountL12_110W12+1;
    end
end


Wcom12_110=[CountL0_110W12,CountL1_110W12,CountL2_110W12,CountL12_110W12];

subplot(3,3,4);
bar(Wcom12_110)
set(gca,'xticklabel',{'no','L1','L2','L12'});
% xlabel('no  L1  L2  L1L2')
%ウインドウL1L2を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_110=linspace(0,15400,71);
TouchL1_110=0;
TouchL2_110=0;
TouchL0_110W12=0;
TouchL1_110W12=0;
TouchL2_110W12=0;
TouchL12_110W12=0;

for n=1:(length(MoveWindowArray_110))
    
    TouchL1_110=0;
    TouchL2_110=0;
    preWS1_110=MoveWindowArray_110(n);
    preWE1_110=preWS1_110+220;
    preWS2_110=preWE1_110+LWinterval1_110;
    preWE2_110=preWS2_110+220;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS1_110&preWE1_110>LpegTouchallWon(i)
                TouchL1_110=1;
            end 
            if  LpegTouchallWon(i)>preWS2_110&preWE2_110>LpegTouchallWon(i) 
                TouchL2_110=1;
            end
    end
    if TouchL1_110==0 & TouchL2_110==0
       TouchL0_110W12=TouchL0_110W12+1;
    end
    if TouchL1_110==1 & TouchL2_110==0
       TouchL1_110W12=TouchL1_110W12+1;
    end
    if TouchL1_110==0 & TouchL2_110==1
       TouchL2_110W12=TouchL2_110W12+1;
    end
    if TouchL1_110==1 & TouchL2_110==1
       TouchL12_110W12=TouchL12_110W12+1;
    end
end
TouchCountL1L2_110=[TouchL0_110W12,TouchL1_110W12,TouchL2_110W12,TouchL12_110W12];
subplot(3,3,7);
bar(TouchCountL1L2_110)
set(gca,'xticklabel',{'no','L1','L2','L12'});
% xlabel('no  L1  L2  L1L2')
% 左足反応cellウインドウ2個、ウインドウ23
L3_110=0;
L4_110=0;
CountL0_110W23=0;
CountL1_110W23=0;
CountL2_110W23=0;
CountL12_110W23=0;
for n=1:(length(SpikeArrayWon))
    L3_110=0;
    L4_110=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_110&SpikeArrayWon(n)+LWindowE2_110>LpegTouchallWon(i)
                L3_110=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_110&SpikeArrayWon(n)+LWindowE3_110>LpegTouchallWon(i) 
                L4_110=1;
            end
    end
    
    if L3_110==0 & L4_110==0
       CountL0_110W23=CountL0_110W23+1;
    end
    if L3_110==1 & L4_110==0
       CountL1_110W23=CountL1_110W23+1;
    end
    if L3_110==0 & L4_110==1
       CountL2_110W23=CountL2_110W23+1;
    end
    if L3_110==1 & L4_110==1
       CountL12_110W23=CountL12_110W23+1;
    end
end

Wcom23_110=[CountL0_110W23,CountL1_110W23,CountL2_110W23,CountL12_110W23];

subplot(3,3,5);
bar(Wcom23_110)
set(gca,'xticklabel',{'no','L2','L3','L23'});
% xlabel('no  L2  L3  L2L3')
%ウインドウL2L3を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_110=linspace(0,15400,71);
TouchL3_110=0;
TouchL4_110=0;
TouchL0_110W23=0;
TouchL1_110W23=0;
TouchL2_110W23=0;
TouchL12_110W23=0;

for n=1:(length(MoveWindowArray_110))
    
    TouchL3_110=0;
    TouchL4_110=0;
    preWS3_110=MoveWindowArray_110(n);
    preWE3_110=preWS3_110+220;
    preWS4_110=preWE3_110+LWinterval2_110;
    preWE4_110=preWS4_110+220;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS3_110&preWE3_110>LpegTouchallWon(i)
                TouchL3_110=1;
            end 
            if  LpegTouchallWon(i)>preWS4_110&preWE4_110>LpegTouchallWon(i) 
                TouchL4_110=1;
            end
    end
    if TouchL3_110==0 & TouchL4_110==0
       TouchL0_110W23=TouchL0_110W23+1;
    end
    if TouchL3_110==1 & TouchL4_110==0
       TouchL1_110W23=TouchL1_110W23+1;
    end
    if TouchL3_110==0 & TouchL4_110==1
       TouchL2_110W23=TouchL2_110W23+1;
    end
    if TouchL3_110==1 & TouchL4_110==1
       TouchL12_110W23=TouchL12_110W23+1;
    end
end
TouchCountL2L3_110=[TouchL0_110W23,TouchL1_110W23,TouchL2_110W23,TouchL12_110W23];
subplot(3,3,8);
bar(TouchCountL2L3_110)
set(gca,'xticklabel',{'no','L2','L3','L23'});
% xlabel('no  L2  L3  L2L3')
% 左足反応cellウインドウ2個、ウインドウ34
L5_110=0;
L6_110=0;
CountL0_110W34=0;
CountL1_110W34=0;
CountL2_110W34=0;
CountL12_110W34=0;
for n=1:(length(SpikeArrayWon))
    L5_110=0;
    L6_110=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_110&SpikeArrayWon(n)+LWindowE3_110>LpegTouchallWon(i)
                L5_110=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS4_110&SpikeArrayWon(n)+LWindowE4_110>LpegTouchallWon(i) 
                L6_110=1;
            end
    end
    
    if L5_110==0 & L6_110==0
       CountL0_110W34=CountL0_110W34+1;
    end
    if L5_110==1 & L6_110==0
       CountL1_110W34=CountL1_110W34+1;
    end
    if L5_110==0 & L6_110==1
       CountL2_110W34=CountL2_110W34+1;
    end
    if L5_110==1 & L6_110==1
       CountL12_110W34=CountL12_110W34+1;
    end
end

Wcom34_110=[CountL0_110W34,CountL1_110W34,CountL2_110W34,CountL12_110W34];

subplot(3,3,6);
bar(Wcom34_110)
set(gca,'xticklabel',{'no','L3','L4','L3L4'});
% xlabel('no  L3  L4  L3L4')
%ウインドウL3L4を動かして、足取りどれだけ当てはまったかを調べる。
MoveWindowArray_110=linspace(0,15400,71);
TouchL5_110=0;
TouchL6_110=0;
TouchL0_110W34=0;
TouchL1_110W34=0;
TouchL2_110W34=0;
TouchL12_110W34=0;

for n=1:(length(MoveWindowArray_110))
    
    TouchL5_110=0;
    TouchL6_110=0;
    preWS5_110=MoveWindowArray_110(n);
    preWE5_110=preWS5_110+220;
    preWS6_110=preWE5_110+LWinterval3_110;
    preWE6_110=preWS6_110+220;
    
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>preWS5_110&preWE5_110>LpegTouchallWon(i)
                TouchL5_110=1;
            end 
            if  LpegTouchallWon(i)>preWS6_110&preWE6_110>LpegTouchallWon(i) 
                TouchL6_110=1;
            end
    end
    if TouchL5_110==0 & TouchL6_110==0
       TouchL0_110W34=TouchL0_110W34+1;
    end
    if TouchL5_110==1 & TouchL6_110==0
       TouchL1_110W34=TouchL1_110W34+1;
    end
    if TouchL5_110==0 & TouchL6_110==1
       TouchL2_110W34=TouchL2_110W34+1;
    end
    if TouchL5_110==1 & TouchL6_110==1
       TouchL12_110W34=TouchL12_110W34+1;
    end
end
TouchCountL3L4_110=[TouchL0_110W34,TouchL1_110W34,TouchL2_110W34,TouchL12_110W34];
subplot(3,3,9);
bar(TouchCountL3L4_110)
set(gca,'xticklabel',{'no','L3','L4','L3L4'});
% xlabel('no  L3  L4  L3L4')

trimtfile=strtrim(tfile);
figname=['RepeatL2combinationWidth220',trimFolder2,trimtfile,pegpatternname,'.bmp'];
saveas(fig3,figname);
close(fig1);
close(fig2);
close(fig3);
end

% set(gca,'xticklabel',{'no  L3  L4  L3L4'});
