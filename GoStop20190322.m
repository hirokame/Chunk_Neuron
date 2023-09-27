function GoStop20190322
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
RmedianPTTM LmedianPTTM CCresultSpike DiffMaxMinR DiffMaxMinL WaterOnPoint WaterOffPoint
bin=1000;
if ~isempty(WaterOnArrayOriginal)
    [CrossCoWon]=CrossCorr(SpikeArray',WaterOnArrayOriginal',10000,0,TurnMarkerTime);  
    CCresultWon=hist(CrossCoWon,bin)/length(WaterOnArrayOriginal);
    CCresultWon=MovWindow(CCresultWon,10);
else
    CCresultWon=zeros(1,bin);

end
if ~isempty(WaterOffArrayOriginal)
    [CrossCoWoff]=CrossCorr(SpikeArray',WaterOffArrayOriginal',10000,0,TurnMarkerTime); 
    CCresultWoff=hist(CrossCoWoff,bin)/length(WaterOffArrayOriginal);
    CCresultWoff=MovWindow(CCresultWoff,10);
else
    CCresultWoff=zeros(1,bin);

end
[MaxCCresultWon IndexCCresultWon]=max(CCresultWon(400:600));
[MaxCCresultWoff IndexCCresultWoff]=max(CCresultWoff(400:600));
stdCCresultWon=std(CCresultWon);
stdCCresultWoff=std(CCresultWoff);


figure
WaterOnPointstd=MaxCCresultWon/stdCCresultWon;
WaterOffPointstd=MaxCCresultWoff/stdCCresultWoff;
 subplot(2,1,1);
    plot(linspace(1,10000,bin),CCresultWon,'color','b');hold on
    if max(CCresultWon)~=0;
    axis([0 10000 0 max(CCresultWon)*1.1]);
    end
    plot(linspace(1,10000,bin),CCresultWoff,'color','r');
    if max(CCresultWoff)~=0;
    axis([0 10000 0 max(CCresultWoff)*1.1]);
    end
    xlabel(['Wonpeakratio=',num2str(WaterOnPoint),'   Woffpeakratio=',num2str(WaterOffPoint)]);
    close;




