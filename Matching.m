function Matching

global  ACresult ACresultW CCresultDrinkOn SpikeArray RpegTouchallWon LpegTouchallWon TurnMarkerTime RmedianPTTM RpegMedian LmedianPTTM LpegMedian...
    RpNum LpNum  OneTurnTime CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 fname tfile WaterOnArrayOriginal A1Rt A2Lt htouch TouchSpikeFL...

bin=1000;

[TouchbySpikeR]=CrossCorr(RpegTouchallWon',SpikeArray,1000,0,TurnMarkerTime);
TouchbySpikeR=hist(TouchbySpikeR,bin);
TouchbySpikeR=MovWindow(TouchbySpikeR,20);


[TouchbySpikeL]=CrossCorr(LpegTouchallWon',SpikeArray,1000,0,TurnMarkerTime);
TouchbySpikeL=hist(TouchbySpikeL,bin);
TouchbySpikeL=MovWindow(TouchbySpikeL,20);

TouchSpike=figure;
plot(linspace(1,1000,bin),TouchbySpikeR,'color','b');hold on
plot(linspace(1,1000,bin),TouchbySpikeL,'color','r');
axis([0 1000 0 max(max(TouchbySpikeR),max(TouchbySpikeL))*1.1]);


D=cd;
cd(TouchSpikeFL);

FigName=[tfile(1:end-2), 'touchspike','.bmp'];
saveas(TouchSpike,FigName);

cd(D);
[pksTSR,locsTSR]=findpeaks(TouchbySpikeR,'MinPeakDistance',300,'sortstr','descend');  %%スパイクでアラインしたタッチの中から300ms離れたピークを探す
figure;
findpeaks(TouchbySpikeL,'MinPeakDistance',300);
[pksTSL,locsTSL]=findpeaks(TouchbySpikeL,'MinPeakDistance',300,'sortstr','descend');


% PeakWindowR=zeros(1,bin);
% PeakWindowR((locsTSR(1)-5):(locsTSR(1)+5))=1;
% PeakWindowR((locsTSR(2)-5):(locsTSR(2)+5))=1;
% 
% PeakWindowL=zeros(1,bin);
% PeakWindowL((locsTSL(1)-5):(locsTSL(1)+5))=1;
% PeakWindowL((locsTSL(2)-5):(locsTSL(2)+5))=1;


locsTSR=locsTSR-500;  
locsTSL=locsTSL-500;
MatchPoint=0;

for i=1:length(SpikeArray)
    for j=1:length(RpegTouchallWon)
        if (SpikeArray(i)+locsTSR(1)-25)<RpegTouchallWon(j) && RpegTouchallWon(j)<(SpikeArray(i)+locsTSR(1)+25);
            MatchPoint=MatchPoint+1;
        end
        if (SpikeArray(i)+locsTSR(2)-25)<RpegTouchallWon(j) && RpegTouchallWon(j)<(SpikeArray(i)+locsTSR(1)+25);
            MatchPoint=MatchPoint+1;
        end
    end
    for k=1:length(LpegTouchallWon)
        if (SpikeArray(i)+locsTSL(1)-25)<LpegTouchallWon(j) && LpegTouchallWon(j)<(SpikeArray(i)+locsTSL(1)+25);
            MatchPoint=MatchPoint+1;
        end
        if (SpikeArray(i)+locsTSL(2)-25)<LpegTouchallWon(j) && LpegTouchallWon(j)<(SpikeArray(i)+locsTSL(2)+25);
            MatchPoint=MatchPoint+1;
        end
    end
        if MatchPoint==4;
            Spiketimes(1,4)=Spiketimes(1,4)+1;
        end
        if MatchPoint==3;
            Spiketimes(1,3)=Spiketimes(1,3)+1;
        end
        if MatchPoint==2;
            Spiketimes(1,2)=Spiketimes(1,2)+1;
        end
        if MatchPoint==1;
            Spiketimes(1,1)=Spiketimes(1,1)+1;
        end
end








