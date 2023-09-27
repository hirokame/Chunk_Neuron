function matsuda20190423
cd('C:\Users\C238\Desktop\CheetahData\2019-3-13_12-19-0 15101-04');
dpath=('C:\Users\C238\Desktop\CheetahData\2019-3-13_12-19-0 15101-04\');
dpath3=('C:\Users\C238\Desktop\CheetahData\2019-3-13_12-19-0 15101-04');
% data=load([dpath '15103_190313_98__'],'-ascii');
dpath3
load 15103_190313_98__\Bdata

% Sc3_SS_01.t
SpikeArray=GetSpikeAll(dpath3,'Sc3_SS_01.t');
SpikeArray
LpegTouchall
RpegTouchall
pks=findpeaks(LpegTouchall)

% bin=500;
% [CrossCoLtouch]=CrossCorr(SpikeArray',LpegTouchall,5000,0,TurnMarkerTime);
% CCresultLtouch=hist(CrossCoLtouch,bin);
% CCresultLtouch=MovWindow(CCresultLtouch,10);
% 
% figure
% plot(linspace(1,5000,bin),CCresultLtouch,'color','r','LineWidth',1);
% axis([0 5000 0 max(CCresultLtouch)*1.1]);

if TurnMarkerTime~=0
    SpikeArray=SpikeArray(SpikeArray>TurnMarkerTime(1)&SpikeArray<TurnMarkerTime(end));
    LpegTouchall=LpegTouchall(LpegTouchall>TurnMarkerTime(1)&LpegTouchall<TurnMarkerTime(end));
end

%LPegTouchAllでSpikeArrayをアラインする
duration=5000;
CrossCo=[];

%両方向
for n=1:(length(LpegTouchall))
        Interval=SpikeArray((SpikeArray>LpegTouchall(n)-duration/2)&(LpegTouchall(n)>SpikeArray-duration/2))-LpegTouchall(n);
        CrossCo=[CrossCo Interval];
end
    
CrossCo=[-1*duration/2 CrossCo duration/2];

CrossCo(CrossCo==0)=[];

bin=500;
CCresultLtouch=hist(CrossCo,bin);
CCresultLtouch=MovWindow(CCresultLtouch,10);

%RPegTouchAllも同様にヒストグラム作って、plotで重ねる。

figure
plot(linspace(1,5000,bin),CCresultLtouch,'color','r','LineWidth',1);
axis([0 5000 0 max(CCresultLtouch)*1.1]);
