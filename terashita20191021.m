function terashita20191021

cd('C:\Users\C238\Desktop\CheetahData\2019-10-16_15-13-58 17301-04');
dpath=('C:\Users\C238\Desktop\CheetahData\2019-10-16_15-13-58 17301-04\');
dpath3=('C:\Users\C238\Desktop\CheetahData\2019-10-16_15-13-58 17301-04');
% data=load([dpath '15103_190313_98__'],'-ascii');
dpath3
load 17304_191016_98__\Bdata

% Sc3_SS_01.t
SpikeArrayFSI=GetSpikeAll(dpath3,'Sc7_SS_01.t');
SpikeArrayMSN=GetSpikeAll(dpath3,'Sc7_SS_02.t');

LpegTouchall
RpegTouchall


bin=500;
[CrossCoFSIMSN]=CrossCorr(SpikeArrayFSI',SpikeArrayMSN,5000,0,TurnMarkerTime);
%         CrossCoRtouch=[-2500;CrossCoRtouch;2500];
CCresultFSIMSN=hist(CrossCoFSIMSN,bin);
CCresultFSIMSN=MovWindow(CCresultFSIMSN,10);


figure
plot(linspace(1,5000,bin),CCresultFSIMSN,'color','b','LineWidth',1);hold on
