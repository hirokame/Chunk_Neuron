function RepeattouchWdecision
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
subplot(2,2,[1,2]);
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
TouchInterval=[];
subplot(2,2,3);
findpeaks(CCresultLtouch,'MinPeakDistance',35);
[Lpks,Llocs]=findpeaks(CCresultLtouch,'MinPeakDistance',35);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(abs(LlocsInterval2),'ascend');

subplot(2,2,4);
findpeaks(CCresultRtouch,'MinPeakDistance',35);
[Rpks,Rlocs]=findpeaks(CCresultRtouch,'MinPeakDistance',35);
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(abs(RlocsInterval2),'ascend');

TouchInterval=[LlocsInterval RlocsInterval];
TouchInterval=sort(abs(TouchInterval),'ascend');


trimtfile=strtrim(tfile);
figname=[trimFolder2,trimtfile,pegpatternname,'.bmp'];
saveas(fig1,figname);
if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  

% ウィンドウ設定
% 前後50ms
LWindowS150=Linterval1(1)*10-50;
LWindowE150=Linterval1(1)*10+50;

LWindowS250=-Linterval2(1)*10-50;
LWindowE250=-Linterval2(1)*10+50;

RWindowS150=Rinterval1(1)*10-50;
RWindowE150=Rinterval1(1)*10+50;

RWindowS250=-Rinterval2(1)*10-50;
RWindowE250=-Rinterval2(1)*10+50;
% 左足反応cellウインドウ2個
L150=0;
L250=0;
CountL050=0;
CountL150=0;
CountL250=0;
CountL1250=0;
for n=1:(length(SpikeArrayWon))
    L150=0;
    L250=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS150&SpikeArrayWon(n)+LWindowE150>LpegTouchallWon(i)
                L150=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS250&SpikeArrayWon(n)+LWindowE250>LpegTouchallWon(i) 
                L250=1;
            end
    end
    
    if L150==0 & L250==0
       CountL050=CountL050+1;
    end
    if L150==1 & L250==0
       CountL150=CountL150+1;
    end
    if L150==0 & L250==1
       CountL250=CountL250+1;
    end
    if L150==1 & L250==1
       CountL1250=CountL1250+1;
    end
end


y1=[CountL050,CountL150,CountL250,CountL1250];
c=categorical({'notL12','L1only','L2only','L12'});

fig2=figure;
subplot(2,2,1);
bar(y1)

% 右足反応cellウインドウ2個
R150=0;
R250=0;
CountR050=0;
CountR150=0;
CountR250=0;
CountR1250=0;
for n=1:(length(SpikeArrayWon))
    R150=0;
    R250=0;
    for i=1:(length(RpegTouchallWon))
            
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS150&SpikeArrayWon(n)+RWindowE150>RpegTouchallWon(i)
                R150=1;
            end
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS250&SpikeArrayWon(n)+RWindowE250>RpegTouchallWon(i) 
                R250=1;
            end
    end
    
    if R150==0 & R250==0
       CountR050=CountR050+1;
    end
    if R150==1 & R250==0
       CountR150=CountR150+1;
    end
    if R150==0 & R250==1
       CountR250=CountR250+1;
    end
    if R150==1 & R250==1
       CountR1250=CountR1250+1;
    end
end


y2=[CountR050,CountR150,CountR250,CountR1250];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,2);
bar(y2)

% 右足ウインドウ1個、左足ウインドウ2個
WR150=0;
WL150=0;
WL250=0;
CountL0R050=0;
CountL1R050=0;
CountL2R050=0;
CountL0R150=0;
CountL1L250=0;
CountL1R150=0;
CountL2R150=0;
CountL1L2R150=0;
for n=1:(length(SpikeArrayWon))
    WR150=0;
    WL150=0;
    WL250=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS150&SpikeArrayWon(n)+LWindowE150>LpegTouchallWon(i)
                WL150=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS250&SpikeArrayWon(n)+LWindowE250>LpegTouchallWon(i) 
                WL250=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS150&SpikeArrayWon(n)+RWindowE150>RpegTouchallWon(j)
                WR150=1;
        end
    end
    
    if WL150==0 & WL250==0 & WR150==0
       CountL0R050=CountL0R050+1;
    end
    if WL150==1 & WL250==0 & WR150==0
       CountL1R050=CountL1R050+1;
    end
    if WL150==0 & WL250==1 & WR150==0
       CountL2R050=CountL2R050+1;
    end
    if WL150==0 & WL250==0 & WR150==1
       CountL0R150=CountL0R150+1;
    end
    if WL150==1 & WL250==1 & WR150==0
       CountL1L250=CountL1L250+1;
    end
    if WL150==1 & WL250==0 & WR150==1
       CountL1R150=CountL1R150+1;
    end
    if WL150==0 & WL250==1 & WR150==1
       CountL2R150=CountL2R150+1;
    end
    if WL150==1 & WL250==1 & WR150==1
       CountL1L2R150=CountL1L2R150+1;
    end
end

y3=[CountL0R050,CountL1R050,CountL2R050,CountL0R150,CountL1L250,CountL1R150,CountL2R150,CountL1L2R150];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,[3,4]);
bar(y3)
figname=['RepeattouchL2,R2,L2R1,50ms',trimtfile,pegpatternname,'.bmp'];
saveas(fig2,figname);

% 前後70ms
LWindowS3=Linterval1(1)*10-70;
LWindowE3=Linterval1(1)*10+70;

LWindowS4=-Linterval2(1)*10-70;
LWindowE4=-Linterval2(1)*10+70;

RWindowS3=Rinterval1(1)*10-70;
RWindowE3=Rinterval1(1)*10+70;

RWindowS4=-Rinterval2(1)*10-70;
RWindowE4=-Rinterval2(1)*10+70;
% 左足反応cellウインドウ2個
L170=0;
L270=0;
CountL070=0;
CountL170=0;
CountL270=0;
CountL1270=0;
for n=1:(length(SpikeArrayWon))
    L170=0;
    L270=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3&SpikeArrayWon(n)+LWindowE3>LpegTouchallWon(i)
                L170=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS4&SpikeArrayWon(n)+LWindowE4>LpegTouchallWon(i) 
                L270=1;
            end
    end
    
    if L170==0 & L270==0
       CountL070=CountL070+1;
    end
    if L170==1 & L270==0
       CountL170=CountL170+1;
    end
    if L170==0 & L270==1
       CountL270=CountL270+1;
    end
    if L170==1 & L270==1
       CountL1270=CountL1270+1;
    end
end


y4=[CountL070,CountL170,CountL270,CountL1270];
c=categorical({'notL12','L1only','L2only','L12'});

fig3=figure;
subplot(2,2,1);
bar(y4)

% 右足反応cellウインドウ2個
R170=0;
R270=0;
CountR070=0;
CountR170=0;
CountR270=0;
CountR1270=0;
for n=1:(length(SpikeArrayWon))
    R170=0;
    R270=0;
    for i=1:(length(RpegTouchallWon))
            
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS3&SpikeArrayWon(n)+RWindowE3>RpegTouchallWon(i)
                R170=1;
            end
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS4&SpikeArrayWon(n)+RWindowE4>RpegTouchallWon(i) 
                R270=1;
            end
    end
    
    if R170==0 & R270==0
       CountR070=CountR070+1;
    end
    if R170==1 & R270==0
       CountR170=CountR170+1;
    end
    if R170==0 & R270==1
       CountR270=CountR270+1;
    end
    if R170==1 & R270==1
       CountR1270=CountR1270+1;
    end
end


y5=[CountR070,CountR170,CountR270,CountR1270];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,2);
bar(y5)

% 右足ウインドウ1個、左足ウインドウ2個

WR170=0;
WL170=0;
WL270=0;
CountL0R070=0;
CountL1R070=0;
CountL2R070=0;
CountL0R170=0;
CountL1L270=0;
CountL1R170=0;
CountL2R170=0;
CountL1L2R170=0;
for n=1:(length(SpikeArrayWon))
    WR170=0;
    WL170=0;
    WL270=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3&SpikeArrayWon(n)+LWindowE3>LpegTouchallWon(i)
                WL170=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS4&SpikeArrayWon(n)+LWindowE4>LpegTouchallWon(i) 
                WL270=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS3&SpikeArrayWon(n)+RWindowE3>RpegTouchallWon(j)
                WR170=1;
        end
    end
    
    if WL170==0 & WL270==0 & WR170==0
       CountL0R070=CountL0R070+1;
    end
    if WL170==1 & WL270==0 & WR170==0
       CountL1R070=CountL1R070+1;
    end
    if WL170==0 & WL270==1 & WR170==0
       CountL2R070=CountL2R070+1;
    end
    if WL170==0 & WL270==0 & WR170==1
       CountL0R170=CountL0R170+1;
    end
    if WL170==1 & WL270==1 & WR170==0
       CountL1L270=CountL1L270+1;
    end
    if WL170==1 & WL270==0 & WR170==1
       CountL1R170=CountL1R170+1;
    end
    if WL170==0 & WL270==1 & WR170==1
       CountL2R170=CountL2R170+1;
    end
    if WL170==1 & WL270==1 & WR170==1
       CountL1L2R170=CountL1L2R170+1;
    end
end

y6=[CountL0R070,CountL1R070,CountL2R070,CountL0R170,CountL1L270,CountL1R170,CountL2R170,CountL1L2R170];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,[3,4]);
bar(y6)
trimtfile=strtrim(tfile);
figname=['RepeattouchL2,R2,L2R1,70ms',trimtfile,pegpatternname,'.bmp'];
saveas(fig3,figname);

% 前後90ms
LWindowS5=Linterval1(1)*10-90;
LWindowE5=Linterval1(1)*10+90;

LWindowS6=-Linterval2(1)*10-90;
LWindowE6=-Linterval2(1)*10+90;

RWindowS5=Rinterval1(1)*10-90;
RWindowE5=Rinterval1(1)*10+90;

RWindowS6=-Rinterval2(1)*10-90;
RWindowE6=-Rinterval2(1)*10+90;
% 左足反応cellウインドウ2個
L190=0;
L290=0;
CountL090=0;
CountL190=0;
CountL290=0;
CountL1290=0;
for n=1:(length(SpikeArrayWon))
    L190=0;
    L290=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS5&SpikeArrayWon(n)+LWindowE5>LpegTouchallWon(i)
                L190=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS6&SpikeArrayWon(n)+LWindowE6>LpegTouchallWon(i) 
                L290=1;
            end
    end
    
    if L190==0 & L290==0
       CountL090=CountL090+1;
    end
    if L190==1 & L290==0
       CountL190=CountL190+1;
    end
    if L190==0 & L290==1
       CountL290=CountL290+1;
    end
    if L190==1 & L290==1
       CountL1290=CountL1290+1;
    end
end


y7=[CountL090,CountL190,CountL290,CountL1290];
c=categorical({'notL12','L1only','L2only','L12'});

fig4=figure;
subplot(2,2,1);
bar(y7)

% 右足反応cellウインドウ2個
R190=0;
R290=0;
CountR090=0;
CountR190=0;
CountR290=0;
CountR1290=0;
for n=1:(length(SpikeArrayWon))
    R190=0;
    R290=0;
    for i=1:(length(RpegTouchallWon))
            
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS5&SpikeArrayWon(n)+RWindowE5>RpegTouchallWon(i)
                R190=1;
            end
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS6&SpikeArrayWon(n)+RWindowE6>RpegTouchallWon(i) 
                R290=1;
            end
    end
    
    if R190==0 & R290==0
       CountR090=CountR090+1;
    end
    if R190==1 & R290==0
       CountR190=CountR190+1;
    end
    if R190==0 & R290==1
       CountR290=CountR290+1;
    end
    if R190==1 & R290==1
       CountR1290=CountR1290+1;
    end
end


y8=[CountR090,CountR190,CountR290,CountR1290];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,2);
bar(y8)

% 右足ウインドウ1個、左足ウインドウ2個

WR190=0;
WL190=0;
WL290=0;
CountL0R090=0;
CountL1R090=0;
CountL2R090=0;
CountL0R190=0;
CountL1L290=0;
CountL1R190=0;
CountL2R190=0;
CountL1L2R190=0;
for n=1:(length(SpikeArrayWon))
    WR190=0;
    WL190=0;
    WL290=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS5&SpikeArrayWon(n)+LWindowE5>LpegTouchallWon(i)
                WL190=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS6&SpikeArrayWon(n)+LWindowE6>LpegTouchallWon(i) 
                WL290=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS5&SpikeArrayWon(n)+RWindowE5>RpegTouchallWon(j)
                WR190=1;
        end
    end
    
    if WL190==0 & WL290==0 & WR190==0
       CountL0R090=CountL0R090+1;
    end
    if WL190==1 & WL290==0 & WR190==0
       CountL1R090=CountL1R090+1;
    end
    if WL190==0 & WL290==1 & WR190==0
       CountL2R090=CountL2R090+1;
    end
    if WL190==0 & WL290==0 & WR190==1
       CountL0R190=CountL0R190+1;
    end
    if WL190==1 & WL290==1 & WR190==0
       CountL1L290=CountL1L290+1;
    end
    if WL190==1 & WL290==0 & WR190==1
       CountL1R190=CountL1R190+1;
    end
    if WL190==0 & WL290==1 & WR190==1
       CountL2R190=CountL2R190+1;
    end
    if WL190==1 & WL290==1 & WR190==1
       CountL1L2R190=CountL1L2R190+1;
    end
end

y9=[CountL0R090,CountL1R090,CountL2R090,CountL0R190,CountL1L290,CountL1R190,CountL2R190,CountL1L2R190];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,[3,4]);
bar(y9)
trimtfile=strtrim(tfile);
figname=['RepeattouchL2,R2,L2R1,90ms',trimtfile,pegpatternname,'.bmp'];
saveas(fig4,figname);

% 前後110ms
LWindowS7=Linterval1(1)*10-110;
LWindowE7=Linterval1(1)*10+110;

LWindowS8=-Linterval2(1)*10-110;
LWindowE8=-Linterval2(1)*10+110;

RWindowS7=Rinterval1(1)*10-110;
RWindowE7=Rinterval1(1)*10+110;

RWindowS8=-Rinterval2(1)*10-110;
RWindowE8=-Rinterval2(1)*10+110;
% 左足反応cellウインドウ2個
L1110=0;
L2110=0;
CountL0110=0;
CountL1110=0;
CountL2110=0;
CountL12110=0;
for n=1:(length(SpikeArrayWon))
    L1110=0;
    L2110=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS7&SpikeArrayWon(n)+LWindowE7>LpegTouchallWon(i)
                L1110=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS8&SpikeArrayWon(n)+LWindowE8>LpegTouchallWon(i) 
                L2110=1;
            end
    end
    
    if L1110==0 & L2110==0
       CountL0110=CountL0110+1;
    end
    if L1110==1 & L2110==0
       CountL1110=CountL1110+1;
    end
    if L1110==0 & L2110==1
       CountL2110=CountL2110+1;
    end
    if L1110==1 & L2110==1
       CountL12110=CountL12110+1;
    end
end


y10=[CountL0110,CountL1110,CountL2110,CountL12110];
c=categorical({'notL12','L1only','L2only','L12'});

fig5=figure;
subplot(2,2,1);
bar(y10)

% 右足反応cellウインドウ2個
R1110=0;
R2110=0;
CountR0110=0;
CountR1110=0;
CountR2110=0;
CountR12110=0;
for n=1:(length(SpikeArrayWon))
    R1110=0;
    R2110=0;
    for i=1:(length(RpegTouchallWon))
            
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS7&SpikeArrayWon(n)+RWindowE7>RpegTouchallWon(i)
                R1110=1;
            end
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS8&SpikeArrayWon(n)+RWindowE8>RpegTouchallWon(i) 
                R2110=1;
            end
    end
    
    if R1110==0 & R2110==0
       CountR0110=CountR0110+1;
    end
    if R1110==1 & R2110==0
       CountR1110=CountR1110+1;
    end
    if R1110==0 & R2110==1
       CountR2110=CountR2110+1;
    end
    if R1110==1 & R2110==1
       CountR12110=CountR12110+1;
    end
end


y11=[CountR0110,CountR1110,CountR2110,CountR12110];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,2);
bar(y11)

% 右足ウインドウ1個、左足ウインドウ2個

WR1110=0;
WL1110=0;
WL2110=0;
CountL0R0110=0;
CountL1R0110=0;
CountL2R0110=0;
CountL0R1110=0;
CountL1L2110=0;
CountL1R1110=0;
CountL2R1110=0;
CountL1L2R1110=0;
for n=1:(length(SpikeArrayWon))
    WR1110=0;
    WL1110=0;
    WL2110=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS7&SpikeArrayWon(n)+LWindowE7>LpegTouchallWon(i)
                WL1110=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS8&SpikeArrayWon(n)+LWindowE8>LpegTouchallWon(i) 
                WL2110=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS7&SpikeArrayWon(n)+RWindowE7>RpegTouchallWon(j)
                WR1110=1;
        end
    end
    
    if WL1110==0 & WL2110==0 & WR1110==0
       CountL0R0110=CountL0R0110+1;
    end
    if WL1110==1 & WL2110==0 & WR1110==0
       CountL1R0110=CountL1R0110+1;
    end
    if WL1110==0 & WL2110==1 & WR1110==0
       CountL2R0110=CountL2R0110+1;
    end
    if WL1110==0 & WL2110==0 & WR1110==1
       CountL0R1110=CountL0R1110+1;
    end
    if WL1110==1 & WL2110==1 & WR1110==0
       CountL1L2110=CountL1L2110+1;
    end
    if WL1110==1 & WL2110==0 & WR1110==1
       CountL1R1110=CountL1R1110+1;
    end
    if WL1110==0 & WL2110==1 & WR1110==1
       CountL2R1110=CountL2R1110+1;
    end
    if WL1110==1 & WL2110==1 & WR1110==1
       CountL1L2R1110=CountL1L2R1110+1;
    end
end

y12=[CountL0R0110,CountL1R0110,CountL2R0110,CountL0R1110,CountL1L2110,CountL1R1110,CountL2R1110,CountL1L2R1110];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,[3,4]);
bar(y12)
trimtfile=strtrim(tfile);
figname=['RepeattouchL2,R2,L2R1,110ms',trimtfile,pegpatternname,'.bmp'];
saveas(fig5,figname);

% 前後130ms
LWindowS9=Linterval1(1)*10-130;
LWindowE9=Linterval1(1)*10+130;

LWindowS0=-Linterval2(1)*10-130;
LWindowE0=-Linterval2(1)*10+130;

RWindowS9=Rinterval1(1)*10-130;
RWindowE9=Rinterval1(1)*10+130;

RWindowS0=-Rinterval2(1)*10-130;
RWindowE0=-Rinterval2(1)*10+130;
% 左足反応cellウインドウ2個
L1130=0;
L2130=0;
CountL0130=0;
CountL1130=0;
CountL2130=0;
CountL12130=0;
for n=1:(length(SpikeArrayWon))
    L1130=0;
    L2130=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS9&SpikeArrayWon(n)+LWindowE9>LpegTouchallWon(i)
                L1130=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS0&SpikeArrayWon(n)+LWindowE0>LpegTouchallWon(i) 
                L2130=1;
            end
    end
    
    if L1130==0 & L2130==0
       CountL0130=CountL0130+1;
    end
    if L1130==1 & L2130==0
       CountL1130=CountL1130+1;
    end
    if L1130==0 & L2130==1
       CountL2130=CountL2130+1;
    end
    if L1130==1 & L2130==1
       CountL12130=CountL12130+1;
    end
end


y13=[CountL0130,CountL1130,CountL2130,CountL12130];
c=categorical({'notL12','L1only','L2only','L12'});

fig6=figure;
subplot(2,2,1);
bar(y13)

% 右足反応cellウインドウ2個
R1130=0;
R2130=0;
CountR0130=0;
CountR1130=0;
CountR2130=0;
CountR12130=0;
for n=1:(length(SpikeArrayWon))
    R1130=0;
    R2130=0;
    for i=1:(length(RpegTouchallWon))
            
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS9&SpikeArrayWon(n)+RWindowE9>RpegTouchallWon(i)
                R1130=1;
            end
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS0&SpikeArrayWon(n)+RWindowE0>RpegTouchallWon(i) 
                R2130=1;
            end
    end
    
    if R1130==0 & R2130==0
       CountR0130=CountR0130+1;
    end
    if R1130==1 & R2130==0
       CountR1130=CountR1130+1;
    end
    if R1130==0 & R2130==1
       CountR2130=CountR2130+1;
    end
    if R1130==1 & R2130==1
       CountR12130=CountR12130+1;
    end
end


y14=[CountR0130,CountR1130,CountR2130,CountR12130];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,2);
bar(y14)

% 右足ウインドウ1個、左足ウインドウ2個
WR1130=0;
WL1130=0;
WL2130=0;
CountL0R0130=0;
CountL1R0130=0;
CountL2R0130=0;
CountL0R1130=0;
CountL1L2130=0;
CountL1R1130=0;
CountL2R1130=0;
CountL1L2R1130=0;
for n=1:(length(SpikeArrayWon))
    WR1130=0;
    WL1130=0;
    WL2130=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS9&SpikeArrayWon(n)+LWindowE9>LpegTouchallWon(i)
                WL1130=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS0&SpikeArrayWon(n)+LWindowE0>LpegTouchallWon(i) 
                WL2130=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS9&SpikeArrayWon(n)+RWindowE9>RpegTouchallWon(j)
                WR1130=1;
        end
    end
    
    if WL1130==0 & WL2130==0 & WR1130==0
       CountL0R0130=CountL0R0130+1;
    end
    if WL1130==1 & WL2130==0 & WR1130==0
       CountL1R0130=CountL1R0130+1;
    end
    if WL1130==0 & WL2130==1 & WR1130==0
       CountL2R0130=CountL2R0130+1;
    end
    if WL1130==0 & WL2130==0 & WR1130==1
       CountL0R1130=CountL0R1130+1;
    end
    if WL1130==1 & WL2130==1 & WR1130==0
       CountL1L2130=CountL1L2130+1;
    end
    if WL1130==1 & WL2130==0 & WR1130==1
       CountL1R1130=CountL1R1130+1;
    end
    if WL1130==0 & WL2130==1 & WR1130==1
       CountL2R1130=CountL2R1130+1;
    end
    if WL1130==1 & WL2130==1 & WR1130==1
       CountL1L2R1130=CountL1L2R1130+1;
    end
end

y15=[CountL0R0130,CountL1R0130,CountL2R0130,CountL0R1130,CountL1L2130,CountL1R1130,CountL2R1130,CountL1L2R1130];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,[3,4]);
bar(y15)
trimtfile=strtrim(tfile);
figname=['RepeattouchL2,R2,L2R1,130ms',trimtfile,pegpatternname,'.bmp'];
saveas(fig6,figname);
close(fig1);
close(fig2);
close(fig3);
close(fig4);
close(fig5);
close(fig6);
end
