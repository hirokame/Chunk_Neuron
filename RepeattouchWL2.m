function y3=RepeattouchWL2
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2

% cd('C:\Users\C238\Desktop\CheetahData\2019-9-15_14-29-36 17301-03');
% dpath=('C:\Users\C238\Desktop\CheetahData\2019-9-15_14-29-36 17301-03\');
% dpath3=('C:\Users\C238\Desktop\CheetahData\2019-9-15_14-29-36 17301-03');
% data=load([dpath '14801_190315_98__'],'-ascii');
% dpath3
% load 17303_190915_C9__\Bdata
% LS=ls;
% for i=1:length(:,1)
%     file=LS(i,:);
%     cd(file)
%                                                                                                                                                                                                                        
%     if strcmp(file(end-3:end),'.mat');
%         load
% end
% Sc3_SS_01.t
% tfile=['Sc2_SS_02.t'];
% SpikeArray=GetSpikeAll(dpath3,tfile);
% SpikeArray
% LpegTouchall
% RpegTouchall
% 
% % bin=500;
% % [CrossCoLtouch]=CrossCorr(SpikeArray',LpegTouchall,5000,0,TurnMarkerTime);
% % CCresultLtouch=hist(CrossCoLtouch,bin);
% % CCresultLtouch=MovWindow(CCresultLtouch,10);
% % 
% % figure
% % plot(linspace(1,5000,bin),CCresultLtouch,'color','r','LineWidth',1);
% % axis([0 5000 0 max(CCresultLtouch)*1.1]);
% 
% if TurnMarkerTime~=0
%     SpikeArray=SpikeArray(SpikeArray>TurnMarkerTime(1)&SpikeArray<TurnMarkerTime(end));
%     LpegTouchall=LpegTouchall(LpegTouchall>TurnMarkerTime(1)&LpegTouchall<TurnMarkerTime(end));
% end
% 
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

figname=[trimFolder2,pegpatternname,'.bmp'];
saveas(fig1,figname);

if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  

% ウィンドウ設定
LWindowS1=Linterval1(1)*10-90;
LWindowE1=Linterval1(1)*10+90;

LWindowS2=-Linterval2(1)*10-90;
LWindowE2=-Linterval2(1)*10+90;

LWindowS3=Linterval1(2)*10-90;
LWindowE3=Linterval1(2)*10+90;

LWindowS4=-Linterval2(2)*10-90;
LWindowE4=-Linterval2(2)*10+90;


RWindowS1=Rinterval1(1)*10-90;
RWindowE1=Rinterval1(1)*10+90;

RWindowS2=-Rinterval2(1)*10-90;
RWindowE2=-Rinterval2(1)*10+90;

RWindowS3=Rinterval1(2)*10-90;
RWindowE3=Rinterval1(2)*10+90;

RWindowS4=-Rinterval2(2)*10-90;
RWindowE4=-Rinterval2(2)*10+90;

% 左足反応cellウインドウ2個
L1=0;
L2=0;
CountL0=0;
CountL1=0;
CountL2=0;
CountL12=0;
for n=1:(length(SpikeArrayWon))
    L1=0;
    L2=0;
    for i=1:(length(LpegTouchallWon))
            
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1&SpikeArrayWon(n)+LWindowE1>LpegTouchallWon(i)
                L1=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2&SpikeArrayWon(n)+LWindowE2>LpegTouchallWon(i) 
                L2=1;
            end
    end
    
    if L1==0 & L2==0
       CountL0=CountL0+1;
    end
    if L1==1 & L2==0
       CountL1=CountL1+1;
    end
    if L1==0 & L2==1
       CountL2=CountL2+1;
    end
    if L1==1 & L2==1
       CountL12=CountL12+1;
    end
end


y1=[CountL0,CountL1,CountL2,CountL12];
c=categorical({'notL12','L1only','L2only','L12'});

fig2=figure;
subplot(2,2,1);
bar(y1)

% 右足反応cellウインドウ2個
R1=0;
R2=0;
CountR0=0;
CountR1=0;
CountR2=0;
CountR12=0;
for n=1:(length(SpikeArrayWon))
    R1=0;
    R2=0;
    for i=1:(length(RpegTouchallWon))
            
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS1&SpikeArrayWon(n)+RWindowE1>RpegTouchallWon(i)
                R1=1;
            end
            if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS2&SpikeArrayWon(n)+RWindowE2>RpegTouchallWon(i) 
                R2=1;
            end
    end
    
    if R1==0 & R2==0
       CountR0=CountR0+1;
    end
    if R1==1 & R2==0
       CountR1=CountR1+1;
    end
    if R1==0 & R2==1
       CountR2=CountR2+1;
    end
    if R1==1 & R2==1
       CountR12=CountR12+1;
    end
end


y2=[CountR0,CountR1,CountR2,CountR12];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,2);
bar(y2)

% 右足ウインドウ1個、左足ウインドウ2個

WR1=0;
WL1=0;
WL2=0;
CountL0R0=0;
CountL1R0=0;
CountL2R0=0;
CountL0R1=0;
CountL1L2=0;
CountL1R1=0;
CountL2R1=0;
CountL1L2R1=0;
for n=1:(length(SpikeArrayWon))
    WR1=0;
    WL1=0;
    WL2=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1&SpikeArrayWon(n)+LWindowE1>LpegTouchallWon(i)
                WL1=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2&SpikeArrayWon(n)+LWindowE2>LpegTouchallWon(i) 
                WL2=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS1&SpikeArrayWon(n)+RWindowE1>RpegTouchallWon(j)
                WR1=1;
        end
    end
    
    if WL1==0 & WL2==0 & WR1==0
       CountL0R0=CountL0R0+1;
    end
    if WL1==1 & WL2==0 & WR1==0
       CountL1R0=CountL1R0+1;
    end
    if WL1==0 & WL2==1 & WR1==0
       CountL2R0=CountL2R0+1;
    end
    if WL1==0 & WL2==0 & WR1==1
       CountL0R1=CountL0R1+1;
    end
    if WL1==1 & WL2==1 & WR1==0
       CountL1L2=CountL1L2+1;
    end
    if WL1==1 & WL2==0 & WR1==1
       CountL1R1=CountL1R1+1;
    end
    if WL1==0 & WL2==1 & WR1==1
       CountL2R1=CountL2R1+1;
    end
    if WL1==1 & WL2==1 & WR1==1
       CountL1L2R1=CountL1L2R1+1;
    end
end

y3=[CountL0R0,CountL1R0,CountL2R0,CountL0R1,CountL1L2,CountL1R1,CountL2R1,CountL1L2R1];
c=categorical({'notL12','L1only','L2only','L12'});

subplot(2,2,[3,4]);
bar(y3)
trimtfile=strtrim(tfile);
figname=['RepeattouchL2,R2,L2R1',trimtfile,pegpatternname,'.bmp'];
saveas(fig2,figname);
close(fig1);
close(fig2);
end
