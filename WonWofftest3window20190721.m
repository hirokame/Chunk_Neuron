function WonWofftest3window20190721

global StartTime FinishTime fname SpikeUnits TurnMarkerTime OneTurnTime RPegTouchAll LPegTouchAll DrinkOnArray dpath3...
MedPegTimeR MedPegTimeL RpegTimeArray LpegTimeArray RpegTouchall LpegTouchall WaterOnArrayOriginal WaterOffArrayOriginal...
RpegTimeArray LpegTimeArray DrName UnitDataUnited UnitData FigA FigA3 FigAA...
DiffMaxMinRpArray DiffMaxMinLpArray DiffMaxMinRArray DiffMaxMinLArray Spname...
SpikeArray tfile RepeatAnalysis TrimStr FigureSave TotalTime...
CrossCoWonCell CrossCoWoffCell NumWon NumWoff CleanWater CleanInterval WonTouch SpikeArrayWon...
FirstWaterOn FirstWaterOff CrossCoWonFirst CrossCoWoffFirst CrossCoWonCellFirst CrossCoWoffCellFirst NumWonF NumWoffF ...
LastWaterOn LastWaterOff CrossCoWonLast CrossCoWoffLast CrossCoWonCellLast CrossCoWoffCellLast NumWonL NumWoffL ...
MidWaterOn MidWaterOff CrossCoWonMid CrossCoWoffMid CrossCoWonCellMid CrossCoWoffCellMid NumWonM NumWoffM ...
IndepWaterOn IndepWaterOff CrossCoWonIndep CrossCoWoffIndep CrossCoWonCellIndep CrossCoWoffCellIndep NumWonI NumWoffI ...
RpegTouchallWon RpegTouchallWoff LpegTouchallWon LpegTouchallWoff CCresultRtouchWon CCresultLtouchWon ACresult ACresultW CCresultDrinkOn...
RmedianPTTM LmedianPTTM CCresultSpike DiffMaxMinR DiffMaxMinL Woffhpost Wonhpre Woffhpre Wonhpost dpath

Old=cd;
if length(SpikeArray)>0;
trimtfile=strtrim(tfile);
%%%%%%%%%%%%%%%%%Won%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
if isempty(RasterData)==0;
scatter(RasterData(:,1),RasterData(:,2),sz,'ko','filled');hold on
axis([-1000 1000 0 length(WaterOnArrayOriginal)]);

bin=500;

 [CrossCoWon]=CrossCorr(SpikeArray',WaterOnArrayOriginal',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';   
    
 CCresultWon=hist(CrossCoWon,bin)/length(WaterOnArrayOriginal);
 CCresultWon=MovWindow(CCresultWon,10);
    
[maxWon IndexWon]=max(CCresultWon);    
IndexWon=(IndexWon-250)*(10000/bin);


WonPrePostkaisu=[];
for i=1:length(WaterOnArrayOriginal)  
    PreWaterOnSpike=SpikeArray(WaterOnArrayOriginal(i)-1500+IndexWon<SpikeArray & SpikeArray<WaterOnArrayOriginal(i)+IndexWon-500)-WaterOnArrayOriginal(i);
    middleWaterOnSpike=SpikeArray(WaterOnArrayOriginal(i)-500+IndexWon<SpikeArray & SpikeArray<WaterOnArrayOriginal(i)+IndexWon+500)-WaterOnArrayOriginal(i);
    PostWaterOnSpike=SpikeArray(WaterOnArrayOriginal(i)+IndexWon+500>SpikeArray & SpikeArray>WaterOnArrayOriginal(i)+1500+IndexWon)-WaterOnArrayOriginal(i);
    WonPrePostkaisu=[WonPrePostkaisu;[length(PreWaterOnSpike) length(middleWaterOnSpike) length(PostWaterOnSpike)]];
end
WonPrePostkaisu 

[Wonhpre,ppre] = ttest2(WonPrePostkaisu(:,1),WonPrePostkaisu(:,2),'Tail','left');
[Wonhpost,ppost] = ttest2(WonPrePostkaisu(:,3),WonPrePostkaisu(:,2),'Tail','left');

title('Won');
xlabel([trimtfile,'  hpre=',num2str(Wonhpre),'  ppre=',num2str(ppre),'  hpost=',num2str(Wonhpost),'  ppre=',num2str(ppost)]);
hold off
Won3window=[Wonhpre Wonhpost];
end
    
% meanPreWon=mean(WonPrePostkaisu(:,1));
% meanPostWon=mean(WonPrePostkaisu(:,2));
% meanPreWon
% meanPostWon
% 
% 
%%%%%%%%%%%%%%%%%%%Woff%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% time=1000;

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
if isempty(RasterData)==0;
scatter(RasterData(:,1),RasterData(:,2),sz,'ko','filled');hold on
axis([-1000 1000 0 length(WaterOffArrayOriginal)]);



[CrossCoWoff]=CrossCorr(SpikeArray',WaterOffArrayOriginal',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';  
    CCresultWoff=hist(CrossCoWoff,bin)/length(WaterOffArrayOriginal);
    CCresultWoff=MovWindow(CCresultWoff,10);
[maxWoff IndexWoff]=max(CCresultWon);    
IndexWoff=(IndexWoff-250)*(10000/bin);

    

WoffPrePostkaisu=[];
for i=1:length(WaterOffArrayOriginal)  
    PreWaterOffSpike=SpikeArray(WaterOffArrayOriginal(i)-1500+IndexWoff<SpikeArray & SpikeArray<WaterOffArrayOriginal(i)+IndexWoff-500)-WaterOffArrayOriginal(i);
    middleWaterOffSpike=SpikeArray(WaterOffArrayOriginal(i)-500+IndexWoff<SpikeArray & SpikeArray<WaterOffArrayOriginal(i)+IndexWoff+500)-WaterOffArrayOriginal(i);
    PostWaterOffSpike=SpikeArray(WaterOffArrayOriginal(i)+IndexWoff+500>SpikeArray & SpikeArray>WaterOffArrayOriginal(i)+1500+IndexWoff)-WaterOffArrayOriginal(i);
    WoffPrePostkaisu=[WoffPrePostkaisu;[length(PreWaterOffSpike) length(middleWaterOffSpike) length(PostWaterOffSpike)]];
end
WoffPrePostkaisu 

[Woffhpre,ppre] = ttest2(WoffPrePostkaisu(:,1),WoffPrePostkaisu(:,2),'Tail','right');
[Woffhpost,ppost] = ttest2(WoffPrePostkaisu(:,3),WoffPrePostkaisu(:,2),'Tail','left');


title('Woff');
xlabel([trimtfile,'  hpre=',num2str(Woffhpre),'  ppre=',num2str(ppre),'  Woffhpost=',num2str(Woffhpost),'  ppre=',num2str(ppost)]);
hold off
Woff3window=[Wonhpre Wonhpost];
end

Folder=['WOnWofftest'];
mkdir(Folder);
cd(Folder)
figname1=['Won',trimtfile(1:end-1),num2str(time),'.bmp'];
figname2=['Woff',trimtfile(1:end-1),num2str(time),'.bmp'];
saveas(figWon,figname1);
saveas(figWoff,figname2);
close(figWon,figWoff);
end
cd(Old)



Old=cd;
CS=[dpath,'ParameterFolder'];
cd(CS);


tfiletrim=strtrim(tfile);
fnametrim=strtrim(fname);

FLName=[tfiletrim(1:end-2),fnametrim(1:end-4)];

save(FLName,'Won3window','Woff3window','IndexWon','IndexWoff','-append');
cd(Old)
