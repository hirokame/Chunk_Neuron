function rasterTouchDrink20190711

cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');

tfile=['Sc4_SS_02.t'];
SpikeArray=GetSpikeAll(dpath3,tfile);
session=['11931_170607_98__'];
load 11931_170607_98__\Bdata
% pattern=['C7'];
SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
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
                SpikeUnitsWon{U}=SpikeArrayWon;
                else
                    SpikeUnitsWon{U}=0;
                end


%Rtraster%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%
time=2500;


RasterData=[];
for i=1:length(RpegTouchallWon)
    DataTemp=SpikeArray(RpegTouchallWon(i)-time<SpikeArray & RpegTouchallWon(i)+time>SpikeArray);
    DataTemp=DataTemp-RpegTouchallWon(i);
    y=ones(length(DataTemp),1)*i;
    RasterDataTemp=[DataTemp' y];
    RasterData=[RasterData;RasterDataTemp];
end
figRt=figure;
sz = 10;
scatter(RasterData(:,1),RasterData(:,2),sz,'bo','filled');hold on
axis([time*(-1) time 0 length(RpegTouchallWon)]);
fignameRt=[session,tfile,'Rt.bmp'];
cd('C:\Users\C238\Desktop\terashita\figure');
saveas(figRt,fignameRt);
cd(dpath3);
%Ltraster%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%
time=2500;


RasterData=[];
for i=1:length(LpegTouchallWon)
    DataTemp=SpikeArray(LpegTouchallWon(i)-time<SpikeArray & LpegTouchallWon(i)+time>SpikeArray);
    DataTemp=DataTemp-LpegTouchallWon(i);
    y=ones(length(DataTemp),1)*i;
    RasterDataTemp=[DataTemp' y];
    RasterData=[RasterData;RasterDataTemp];
end

figLt=figure;
sz = 10;
scatter(RasterData(:,1),RasterData(:,2),sz,'ro','filled');hold on
axis([time*(-1) time 0 length(LpegTouchallWon)]);
fignameLt=[session,tfile,'Lt.bmp'];
cd('C:\Users\C238\Desktop\terashita\figure');
saveas(figLt,fignameLt);
cd(dpath3);


%Drinkonraster%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


time=1000;


RasterData=[];
for i=1:length(DrinkOnArray)
    DataTemp=SpikeArrayWon(DrinkOnArray(i)-time<SpikeArrayWon & DrinkOnArray(i)+time>SpikeArrayWon);
    DataTemp=DataTemp-DrinkOnArray(i);
    y=ones(length(DataTemp),1)*i;
    RasterDataTemp=[DataTemp' y];
    RasterData=[RasterData;RasterDataTemp];
end
figDrinkon=figure;
sz = 10;
scatter(RasterData(:,1),RasterData(:,2),sz,'ko','filled');hold on
axis([time*(-1) time 0 length(DrinkOnArray)]);
fignameDon=[session,tfile,'Don.bmp'];
cd('C:\Users\C238\Desktop\terashita\figure');
saveas(figDrinkon,fignameDon);
cd(dpath3);

%Won/off%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Won
time=5000;

WaterOnSpike=[];
AllWaterOnSpike=[];
y=[];
RasterData=[];
for i=1:length(WaterOnArrayOriginal)
    DataTemp=SpikeArray(WaterOnArrayOriginal(i)-time<SpikeArray & WaterOnArrayOriginal(i)+time>SpikeArray);
    DataTemp=DataTemp-WaterOnArrayOriginal(i);
    y=ones(length(DataTemp),1)*i;
    RasterDataTemp=[DataTemp' y];
    RasterData=[RasterData;RasterDataTemp];
end
figWon=figure;
sz = 10;
scatter(RasterData(:,1),RasterData(:,2),sz,'bo','filled');hold on
axis([-5000 5000 0 length(WaterOnArrayOriginal)]);
fignameWon=[session,tfile,'Won.bmp'];
cd('C:\Users\C238\Desktop\terashita\figure');
saveas(figWon,fignameWon);
cd(dpath3);

%Woff
time=5000;

WaterOffSpike=[];
AllWaterOffSpike=[];
y=[];
RasterData=[];
for i=1:length(WaterOffArrayOriginal)
    DataTemp=SpikeArray(WaterOffArrayOriginal(i)-time<SpikeArray & WaterOffArrayOriginal(i)+time>SpikeArray);
    DataTemp=DataTemp-WaterOffArrayOriginal(i);
    y=ones(length(DataTemp),1)*i;
    RasterDataTemp=[DataTemp' y];
    RasterData=[RasterData;RasterDataTemp];
end
figWoff=figure;
sz = 10;
scatter(RasterData(:,1),RasterData(:,2),sz,'ro','filled');hold on
axis([-5000 5000 0 length(WaterOffArrayOriginal)]);

fignameWoff=[session,tfile,'Woff.bmp'];
cd('C:\Users\C238\Desktop\terashita\figure');
saveas(figWoff,fignameWoff);
cd(dpath3);

bin=500;

[CrossCoDrinkOn]=CrossCorr(SpikeArrayWon',DrinkOnArray,2000,0,TurnMarkerTime);
CCresultDrinkOn=hist(CrossCoDrinkOn,bin)/length(DrinkOnArray);
CCresultDrinkOn=MovWindow(CCresultDrinkOn,5);


Fig5=figure
plot(linspace(1,2000,bin),CCresultDrinkOn,'color','k','LineWidth',2);hold on
axis([0 2000 0 max(CCresultDrinkOn)*1.1]);

axis off
Figname=['FigDrinkon.bmp'];
cd('C:\Users\C238\Desktop\terashita\figure');
saveas(Fig5,Figname);
cd(dpath3);

[CrossCoWon]=CrossCorr(SpikeArray',WaterOnArrayOriginal',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';   
    
    CCresultWon=hist(CrossCoWon,bin)/length(WaterOnArrayOriginal);
    CCresultWon=MovWindow(CCresultWon,10);
Fig6=figure;
    plot(linspace(1,10000,bin),CCresultWon,'color','b','LineWidth',2);hold on
%     axis([0 10000 0 max(CCresultWon)*1.1]);
 [CrossCoWoff]=CrossCorr(SpikeArray',WaterOffArrayOriginal',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';  
    
    CCresultWoff=hist(CrossCoWoff,bin)/length(WaterOffArrayOriginal);
    CCresultWoff=MovWindow(CCresultWoff,10);

    plot(linspace(1,10000,bin),CCresultWoff,'color','r','LineWidth',2);
%     axis([0 10000 0 max(CCresultWoff)*1.1]);
axis off
Figname6=['WonWoff.bmp'];
cd('C:\Users\C238\Desktop\terashita\figure');
saveas(Fig6,Figname6);
