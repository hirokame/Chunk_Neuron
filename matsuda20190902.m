function matsuda20190902
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile

% cd('C:\Users\C238\Desktop\CheetahData\2019-8-12_16-26-19 17201-02');
% dpath=('C:\Users\C238\Desktop\CheetahData\2019-8-12_16-26-19 17201-02\');
% dpath3=('C:\Users\C238\Desktop\CheetahData\2019-8-12_16-26-19 17201-02');
% % data=load([dpath '14801_190315_98__'],'-ascii');
% dpath3
% load 17201_190812_98__\Bdata
% % LS=ls;
% % for i=1:length(:,1)
% %     file=LS(i,:);
% %     cd(file)
% %                                                                                                                                                                                                                        
% %     if strcmp(file(end-3:end),'.mat');
% %         load
% % end
% % Sc3_SS_01.t
% tfile=['Sc5_SS_01.t'];
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

xbins4=[0 1 2 3 4];
xbins6=[0 1 2 3 4 5 6];
xbins8=[0 1 2 3 4 5 6 7 8];

% ウインドウ4つ
CountArray4=[];
for n=1:(length(SpikeArrayWon))
    CountL4=0;
    CountR4=0;
    Count4=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1&SpikeArrayWon(n)+LWindowE1>LpegTouchallWon(i)|...
                LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2&SpikeArrayWon(n)+LWindowE2>LpegTouchallWon(i)             
                CountL4=CountL4+1;
            end
    end
    for j=1:(length(RpegTouchallWon))    
            if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS1&SpikeArrayWon(n)+RWindowE1>RpegTouchallWon(j)|...
                RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS2&SpikeArrayWon(n)+RWindowE2>RpegTouchallWon(j)
                CountR4=CountR4+1;
            end
    end
    Count4=CountL4+CountR4;
    CountArray4=[CountArray4 Count4];
end

fig2=figure;
subplot(3,1,1);
hist(CountArray4,xbins4,'barwidth',0.1)

% ウインドウ6つ
CountArray6=[];
for n=1:(length(SpikeArrayWon))
    CountL6=0;
    CountR6=0;
    Count6=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1&SpikeArrayWon(n)+LWindowE1>LpegTouchallWon(i)|...
                LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2&SpikeArrayWon(n)+LWindowE2>LpegTouchallWon(i)             
                CountL6=CountL6+1;
            end
    end
    for j=1:(length(RpegTouchallWon))    
            if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS1&SpikeArrayWon(n)+RWindowE1>RpegTouchallWon(j)|...
                RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS2&SpikeArrayWon(n)+RWindowE2>RpegTouchallWon(j)
                CountR6=CountR6+1;
            end
    end
    Count6=CountL6+CountR6;
    CountArray6=[CountArray6 Count6];
end

subplot(3,1,2);
hist(CountArray6,xbins6,'barwidth',0.1)

% ウインドウ8つ
CountArray8=[];
for n=1:(length(SpikeArrayWon))
    CountL8=0;
    CountR8=0;
    Count8=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1&SpikeArrayWon(n)+LWindowE1>LpegTouchallWon(i)|...
                LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2&SpikeArrayWon(n)+LWindowE2>LpegTouchallWon(i)             
                CountL8=CountL8+1;
            end
    end
    for j=1:(length(RpegTouchallWon))    
            if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS1&SpikeArrayWon(n)+RWindowE1>RpegTouchallWon(j)|...
                RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS2&SpikeArrayWon(n)+RWindowE2>RpegTouchallWon(j)
                CountR8=CountR8+1;
            end
    end
    Count8=CountL8+CountR8;
    CountArray8=[CountArray8 Count8];
end

subplot(3,1,3);
hist(CountArray8,xbins8,'barwidth',0.1)
trimtfile=strtrim(tfile);
figname=['Repeattouch',trimtfile,'.bmp'];
saveas(fig2,figname);
close(fig1);
close(fig2);
end

% ウィンドウをL.Rタッチそれぞれで設定
% CountArrayL=[];
% for n=1:(length(SpikeArrayWon))
%     LCount=0;
%     for i=1:(length(LpegTouchallWon))
%             if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS1&SpikeArrayWon(n)+LWindowE1>LpegTouchallWon(i)|...
%                 LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2&SpikeArrayWon(n)+LWindowE2>LpegTouchallWon(i)|...
%                 LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3&SpikeArrayWon(n)+LWindowE3>LpegTouchallWon(i)|...
%                 LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS4&SpikeArrayWon(n)+LWindowE4>LpegTouchallWon(i)
%                 LCount=LCount+1;
%             end
%     end
%     CountArrayL=[CountArrayL LCount];
% end
% fig2=figure;
% subplot(2,1,1);
% hist(CountArrayL,xbins4,'barwidth',0.1)
% 
% CountArrayR=[];
% for n=1:(length(SpikeArrayWon))
%     RCount=0;
%     for i=1:(length(RpegTouchallWon))
%             if  RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS1&SpikeArrayWon(n)+RWindowE1>RpegTouchallWon(i)|...
%                 RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS2&SpikeArrayWon(n)+RWindowE2>RpegTouchallWon(i)|...
%                 RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS3&SpikeArrayWon(n)+RWindowE3>RpegTouchallWon(i)|...
%                 RpegTouchallWon(i)>SpikeArrayWon(n)+RWindowS4&SpikeArrayWon(n)+RWindowE4>RpegTouchallWon(i)
%                 RCount=RCount+1;
%             end
%     end
%     CountArrayR=[CountArrayR RCount];
% end
% subplot(2,1,2);
% hist(CountArrayR,xbins4,'barwidth',0.1)
% 
% figname=['RepeattouchLR',trimtfile,'.bmp'];
% saveas(fig2,figname);
close(fig1);
close(fig2);
end
