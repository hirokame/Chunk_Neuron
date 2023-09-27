function Fourierfunction4touchCC(n,U,M)
%AutocorはSpikeArray、DrinkはSpikeArrayWon,WaterOn/OffではSpikeArray
%TouchではSpikeArrayとTを使用。

global StartTime FinishTime fname SpikeUnits TurnMarkerTime dpath3...
SpikeArray RpegTouchallWon LpegTouchallWon CCresultRtouchWon CCresultLtouchWon 


[CrossCoRtouchWon]=CrossCorr(SpikeArray',RpegTouchallWon,5000,0,TurnMarkerTime);
%         CrossCoRtouch=[-2500;CrossCoRtouch;2500];
CCresultRtouchWon=hist(CrossCoRtouchWon,bin);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);
%         [CrossCoLtouch]=CrossCorr(LPegTouchAll,SpikeArray,5000,0,TurnMarkerTime);
[CrossCoLtouchWon]=CrossCorr(SpikeArray',LpegTouchallWon,5000,0,TurnMarkerTime);
%         CrossCoLtouch=[-2500;CrossCoLtouch;2500];
CCresultLtouchWon=hist(CrossCoLtouchWon,bin);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);