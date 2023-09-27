function terashita190508

%タッチ間の位相からタッチに対する発火を予想し仮想の発火パターンをタッチで再びアラインする
cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% data=load([dpath '15103_190313_98__'],'-ascii');
dpath3
load 11931_170607_98__\Bdata

% Sc3_SS_01.t
SpikeArray=GetSpikeAll(dpath3,'Sc4_SS_02.t');

%WaterOnのときのみのLpegTouchall
    if ~isempty(LpegTouchall)
        LTWon=ones(1,length(LpegTouchall));
        for k=1:length(LpegTouchall)
            if OnWater(LpegTouchall(k))==0
                LTWon(k)=0;
            end
        end
        LpegTouchallWon=LpegTouchall.*LTWon;
        LpegTouchallWon(LpegTouchallWon==0)=[];
        LpegTouchallWoff=LpegTouchall.*not(LTWon);
        LpegTouchallWoff(LpegTouchallWoff==0)=[];
    else
        LpegTouchallWon=0;
        LpegTouchallWoff=0;
    end
    
    
bin=500;
[CrossCoLtouch]=CrossCorr(SpikeArray',LpegTouchall,5000,0,TurnMarkerTime);
CCresultLtouch=hist(CrossCoLtouch,bin);
CCresultLtouch=MovWindow(CCresultLtouch,10);


bin=500;
[CrossCoRtouch]=CrossCorr(SpikeArray',RpegTouchall,5000,0,TurnMarkerTime);
CCresultRtouch=hist(CrossCoRtouch,bin);
CCresultRtouch=MovWindow(CCresultRtouch,10);

figure
plot(linspace(1,5000,bin),CCresultRtouch,'color','b','LineWidth',1);hold on
axis([0 5000 0 max(CCresultRtouch)*1.1]);
plot(linspace(1,5000,bin),CCresultLtouch,'color','r','LineWidth',1);
axis([0 5000 0 max(max(CCresultRtouch),max(CCresultLtouch))*1.1]);
ylabel('CCresultLtouch');


    
%新しいSpikeArraNを作る
    SpikeArrayN=[];
for i=1:length(LpegTouchallWon)-1
    intervalL=LpegTouchallWon(i+1)-LpegTouchallWon(i);
    SpikeArrayN=[SpikeArrayN LpegTouchallWon(i)+intervalL*3/5];
    
end
bin=500;
[CrossCoLtouchN]=CrossCorr(SpikeArrayN',LpegTouchall,5000,0,TurnMarkerTime);
CCresultLtouchN=hist(CrossCoLtouchN,bin);
CCresultLtouchN=MovWindow(CCresultLtouchN,10);

figure
plot(linspace(1,5000,bin),CCresultLtouchN,'color','r','LineWidth',1);hold on
axis([0 5000 0 max(CCresultLtouchN)*1.1]);

bin=500;
[CrossCoRtouchN]=CrossCorr(SpikeArrayN',RpegTouchall,5000,0,TurnMarkerTime);
CCresultRtouchN=hist(CrossCoRtouchN,bin);
CCresultRtouchN=MovWindow(CCresultRtouchN,10);

plot(linspace(1,5000,bin),CCresultRtouchN,'color','b','LineWidth',1);
axis([0 5000 0 max(max(CCresultRtouchN),max(CCresultLtouchN))*1.1]);

ylabel('CCresultRtouchN');

distR=KLDiv(CCresultRtouchN,CCresultRtouch)
distL=KLDiv(CCresultLtouchN,CCresultLtouch)

distR
distL



