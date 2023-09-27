function WaterOnOff20190705
global StartTime FinishTime fname SpikeUnits TurnMarkerTime OneTurnTime RPegTouchAll LPegTouchAll DrinkOnArray dpath3 render...
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
% cd('C:\Users\C238\Desktop\CheetahWRLV20180729Part1\34\2017-9-25_19-50-23 3401-11');
% dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729Part1\34\2017-9-25_19-50-23 3401-11\');
% dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729Part1\34\2017-9-25_19-50-23 3401-11');
% tfile=['Sc2_SS_01.t'];
% SpikeArray=GetSpikeAll(dpath3,tfile);
% load 3411_170925_98__\Bdata
% pattern=['C7'];
SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
if ~isempty(SpikeArray);
    trimtfile=strtrim(tfile);
    %%%%%%%%%%%%%%%%%Won%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    time=1000;
    
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
    if render == 1
        figWon=figure;
    end
    sz = 10;
    if isempty(RasterData)==0;
        if render == 1
            scatter(RasterData(:,1),RasterData(:,2),sz,'ko','filled');hold on
            axis([-1000 1000 0 length(WaterOnArrayOriginal)]);
        end
        WonPrePostkaisu=[];
        for i=1:length(WaterOnArrayOriginal)
            PreWaterOnSpike=SpikeArray(WaterOnArrayOriginal(i)-time<SpikeArray & SpikeArray<WaterOnArrayOriginal(i))-WaterOnArrayOriginal(i);
            PostWaterOnSpike=SpikeArray(WaterOnArrayOriginal(i)+time>SpikeArray & SpikeArray>WaterOnArrayOriginal(i))-WaterOnArrayOriginal(i);
            WonPrePostkaisu=[WonPrePostkaisu;[length(PreWaterOnSpike) length(PostWaterOnSpike)]];
        end
        
        [Wonhpre,ppre] = ttest2(WonPrePostkaisu(:,1),WonPrePostkaisu(:,2),'Tail','right');
        [Wonhpost,ppost] = ttest2(WonPrePostkaisu(:,1),WonPrePostkaisu(:,2),'Tail','left');
        if render == 1
            title('Won');
            xlabel([trimtfile,'  hpre=',num2str(Wonhpre),'  ppre=',num2str(ppre),'  hpost=',num2str(Wonhpost),'  ppre=',num2str(ppost)]);
            hold off
        end
    end
    
    % meanPreWon=mean(WonPrePostkaisu(:,1));
    % meanPostWon=mean(WonPrePostkaisu(:,2));
    % meanPreWon
    % meanPostWon
    %
    %
    %%%%%%%%%%%%%%%%%%%Woff%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    time=1000;
    
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
    
    if render == 1
        figWoff=figure;
    end
    sz = 10;
    if isempty(RasterData)==0;
        if render == 1
            scatter(RasterData(:,1),RasterData(:,2),sz,'ko','filled');hold on
            axis([-1000 1000 0 length(WaterOffArrayOriginal)]);
        end
        WoffPrePostkaisu=[];
        for i=1:length(WaterOffArrayOriginal)
            PreWaterOffSpike=SpikeArray(WaterOffArrayOriginal(i)-time<SpikeArray & SpikeArray<WaterOffArrayOriginal(i))-WaterOffArrayOriginal(i);
            PostWaterOffSpike=SpikeArray(WaterOffArrayOriginal(i)+time>SpikeArray & SpikeArray>WaterOffArrayOriginal(i))-WaterOffArrayOriginal(i);
            WoffPrePostkaisu=[WoffPrePostkaisu;[length(PreWaterOffSpike) length(PostWaterOffSpike)]];
        end
        
        [Woffhpre,ppre] = ttest2(WoffPrePostkaisu(:,1),WoffPrePostkaisu(:,2),'Tail','right');
        [Woffhpost,ppost] = ttest2(WoffPrePostkaisu(:,1),WoffPrePostkaisu(:,2),'Tail','left');
        
        if render == 1
            title('Woff');
            xlabel([trimtfile,'  hpre=',num2str(Woffhpre),'  ppre=',num2str(ppre),'  Woffhpost=',num2str(Woffhpost),'  ppre=',num2str(ppost)]);
            hold off
            endS
        end
        Folder=['WOnWofftest'];
        if not(exist(Folder,'dir'))
            mkdir(Folder)
        end
        
        cd(Folder)
        if render == 1
            figname1=['Won',trimtfile(1:end-1),num2str(time),'.bmp'];
            figname2=['Woff',trimtfile(1:end-1),num2str(time),'.bmp'];
            saveas(figWon,figname1);
            saveas(figWoff,figname2);
            close(figWon,figWoff);
        end
    end
end



Oldc=cd;
CS=[dpath,'ParameterFolder'];
cd(CS);


tfiletrim=strtrim(tfile);
fnametrim=strtrim(fname);

FLName=[tfiletrim(1:end-2),fnametrim(1:end-4)];
Wonhpre1000=Wonhpre;
Woffhpost1000=Woffhpost;
save(FLName,'Wonhpre1000','Woffhpost1000','-append');
cd(Old)
% meanPreWoff=mean(WoffPrePostkaisu(:,1));
% meanPostWoff=mean(WoffPrePostkaisu(:,2));
% meanPreWoff
% meanPostWoff

