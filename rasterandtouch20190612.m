function rasterandtouch20190612

cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
tfile=['Sc6_SS_03.t'];
SpikeArray=GetSpikeAll(dpath3,tfile);
load 11901_170607_Bgra\Bdata
pattern=['98'];
SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
%WaterOnのときのみのRpegTouchall
    if ~isempty(RpegTouchall)
        RTWon=ones(1,length(RpegTouchall));
        for k=1:length(RpegTouchall)
            if OnWater(RpegTouchall(k))==0
                RTWon(k)=0;
            end
        end
        RpegTouchallWon=RpegTouchall.*RTWon;
        RpegTouchallWon(RpegTouchallWon==0)=[];
        RpegTouchallWoff=RpegTouchall.*not(RTWon);
        RpegTouchallWoff(RpegTouchallWoff==0)=[];
    else
        RpegTouchallWon=0;
        RpegTouchallWoff=0;
    end
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
%WaterOnのときのみのスパイク
                if ~isempty(SpikeArray)
                SpikeWon=ones(1,length(SpikeArray));
                for k=1:length(SpikeArray)
                    if OnWater(SpikeArray(k))==0
                        SpikeWon(k)=0;
                    end
                end
                SpikeArrayWon=SpikeArray.*SpikeWon;
                SpikeArrayWon(SpikeArrayWon==0)=[];  
                end
TimeStamp=SpikeArray';   
RasterData=[];
for n=2:length(TurnMarkerTime)-1
    DataTemp=TimeStamp(TimeStamp>TurnMarkerTime(n-1) & TimeStamp<=TurnMarkerTime(n+1))-TurnMarkerTime(n-1);
    y_Temp=ones(length(DataTemp),1)*n;
    RasterDataTemp=[DataTemp y_Temp];
    RasterData=[RasterData;RasterDataTemp];
end
% RasterData=raster(SpikeArray',TurnMarkerTime)
fig1=figure;
% text(RasterData(:,1),RasterData(:,2),'l','FontSize',10,'color',[0 1 0]);
sz = 10;
scatter(RasterData(:,1),RasterData(:,2),sz,'ko','filled');
% maker='\mid';
% text(RasterData(:,1),RasterData(:,2),maker,'Interpreter','tex');
axis([0 OneTurnTime*2 0 max(RasterData(:,2))]);
box off;
% SpikeRaster=[0 RasterData(:,1)' OneTurnTime*2];
% SpikeHist=[];
% bin=500;
% SpikeHist=hist(SpikeRaster,bin);
% SpikeHist=MovWindow(SpikeHist,5);

bin=500;
[CrossCoRtouchWon]=CrossCorr(SpikeArray',RpegTouchallWon,5000,0,TurnMarkerTime);
%         CrossCoRtouch=[-2500;CrossCoRtouch;2500];
CCresultRtouchWon=hist(CrossCoRtouchWon,bin);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);
%         [CrossCoLtouch]=CrossCorr(LPegTouchAll,SpikeArray,5000,0,TurnMarkerTime);
[CrossCoLtouchWon]=CrossCorr(SpikeArray',LpegTouchallWon,5000,0,TurnMarkerTime);
%         CrossCoLtouch=[-2500;CrossCoLtouch;2500];
CCresultLtouchWon=hist(CrossCoLtouchWon,bin);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);

F=figure;
plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);hold on
plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
axis([0 5000 0 max(max(CCresultRtouchWon),max(CCresultLtouchWon))*1.1]);
axis off
filenameF=['Fig1.bmp'];
saveas(F,filenameF);




BIN=1000;
[CrossCoSpike]=CrossCorr(SpikeArrayWon',TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
CCresultSpike=hist(CrossCoSpike,BIN)/length(TurnMarkerTime);
CCresultSpike=MovWindow(CCresultSpike,5);
fig2=figure;
plot(linspace(1,OneTurnTime*2,BIN),CCresultSpike,'color','k','LineWidth',1)
axis([0 OneTurnTime*2 0 max(CCresultSpike)]);
box off;
% figure
% plot(linspace(1,OneTurnTime*2,bin),SpikeHist,'color','k','LineWidth',1)
% axis([0 OneTurnTime*2 0 max(SpikeHist)]);
% load 11941_170607_C7__\Bdata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bin=500;
[CrossCoRtouchWon]=CrossCorr(SpikeArray',RpegTouchallWon,5000,0,TurnMarkerTime);
CCresultRtouchWon=hist(CrossCoRtouchWon,bin);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);


[CrossCoLtouchWon]=CrossCorr(SpikeArray',LpegTouchallWon,5000,0,TurnMarkerTime);
CCresultLtouchWon=hist(CrossCoLtouchWon,bin);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);

fig3=figure
plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',1);hold on
plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',1);
axis([0 5000 0 max(max(CCresultRtouchWon),max(CCresultLtouchWon))*1.1]);
axis off;

Fig5=figure;
Max=5;
XR=floor(OneTurnTime*MedPegTimeR(1:end)/OneTurnTime);
XR=[XR XR+OneTurnTime];
YR=ones(1,length(MedPegTimeR)*2)'*Max*1.05;%0.85;
XL=floor(OneTurnTime*MedPegTimeL(1:end)/OneTurnTime);
XL=[XL XL+OneTurnTime];
YL=ones(1,length(MedPegTimeL)*2)'*Max*1.13;%0.95;    
text(XR,YR,'l','FontSize',20,'color',[0 0 1]);
text(XL,YL,'l','FontSize',20,'color',[1 0 0]);
axis([0 max(max(XR),max(XL))*1.3 0 max(max(YR),max(YL))*1.3]);

figname1=['raster',tfile(1:end-2),pattern,'.bmp'];
figname2=['hist',tfile(1:end-2),pattern,'.bmp'];
figname3=['CC',tfile(1:end-2),pattern,'.bmp'];
cd('C:\Users\C238\Desktop\terashita\figure');
saveas(fig1,figname1);
saveas(fig2,figname2);
saveas(fig3,figname3);
figname5=['pegpattern.bmp'];
saveas(Fig5,figname5);