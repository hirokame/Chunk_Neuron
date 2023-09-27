function SaveParameter20190531

global SpikeArray TotalTime qMaxFRratio qMinFRratio WaterOnArrayOriginal WaterOffArrayOriginal render...
    TurnMarkerTime WaterOnPoint WaterOffPoint pksP1 locsP1 pksP2 locsP2 tfile fname dpath ADon CCresultDrinkOn CCresultRtouchWon CCresultLtouchWon...
    MaxADon MaxA1Rt MaxA2Lt Wokaisu Woffkaisu  ratio DiffDon WaterOnPointmean WaterOffPointmean WaterOnPointstd WaterOffPointstd MaxZ MaxZR MaxZL phaseL phaseR...
    MaxZWoff MaxZWon DiffMaxMinR DiffMaxMinL RpegTouchallWon LpegTouchallWon frequency A1Rt A2Lt AFreq ZFreq Woffhpost Wonhpre...
    Woffhpost1000 Wonhpre1000 Woffhpost2000 Wonhpre2000 Woffhpost3000 Wonhpre3000 mensekiR mensekiL Woffhpre1000 Wonhpost1000 Woffhpre2000 Wonhpost2000 Woffhpre3000 Wonhpost3000...
    Woffhpre Wonhpost SpikePerTouchWoff LtRsq RtRsq Ltbeta Rtbeta LtRsq_P1 RtRsq_P1 Ltbeta_P1 Rtbeta_P1 

Freq=length(SpikeArray)/TotalTime;
Wokaisu=length(WaterOnArrayOriginal);
Woffkaisu=length(WaterOffArrayOriginal);
ratio=qMaxFRratio/qMinFRratio;
% locsP1=sort(locsP1,'')
bin=200;
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
[MaxCCresultWon IndexCCresultWon]=max(CCresultWon(50:150));
[MaxCCresultWoff IndexCCresultWoff]=max(CCresultWoff(50:150));
MeanCCresultWon=mean(CCresultWon);
MeanCCresultWoff=mean(CCresultWoff);

WaterOnPointmean=MaxCCresultWon/MeanCCresultWon;
WaterOffPointmean=MaxCCresultWoff/MeanCCresultWoff;


stdCCresultWon=std(CCresultWon);
stdCCresultWoff=std(CCresultWoff);

WaterOnPointstd=MaxCCresultWon/stdCCresultWon;
WaterOffPointstd=MaxCCresultWoff/stdCCresultWoff;
figure
ZWon=zscore(CCresultWon);

plot(linspace(1,10000,bin),ZWon);
if max(ZWon)~=0;
    axis([0 10000 0 max(ZWon)*1.1]);
end
% close;
[MaxZWon locsZ]=max(ZWon(50:150));


figure
ZWoff=zscore(CCresultWoff);

plot(linspace(1,10000,bin),ZWoff);
if max(ZWon)~=0;
    axis([0 10000 0 max(ZWoff)*1.1]);
end
% close;
[MaxZWoff locsZ]=max(ZWoff(50:150));


Oldc=cd;
CS=[dpath,'ParameterFolder'];
cd(CS);
tfiletrim=strtrim(tfile);
fnametrim=strtrim(fname);

FLName=[tfiletrim(1:end-2),fnametrim(1:end-4)];

CCDon=CCresultDrinkOn(201:300);
DiffDon=max(CCDon)/min(CCDon);


CCRt=CCresultRtouchWon(201:300);     %%%%(101:400) in SpikeAnalysisSet20190214
CCLt=CCresultLtouchWon(201:300);

DiffMaxMinR=max(CCRt)/min(CCRt);
DiffMaxMinL=max(CCLt)/min(CCLt);


intervalArrayR=[];
intervalArrayL=[];
for i=1:length(RpegTouchallWon)-1;
    intervalR=RpegTouchallWon(i+1)-RpegTouchallWon(i);
    intervalArrayR=[intervalArrayR intervalR];
end
intervalArrayR=intervalArrayR(300<intervalArrayR & intervalArrayR<700);
meanintervalR=mean(intervalArrayR);

for i=1:length(LpegTouchallWon)-1;
    intervalL=LpegTouchallWon(i+1)-LpegTouchallWon(i);
    intervalArrayL=[intervalArrayL intervalL];
end
intervalArrayL=intervalArrayL(300<intervalArrayL & intervalArrayL<700);
meanintervalL=mean(intervalArrayL);




StepFreqR=1000/meanintervalR;
StepFreqL=1000/meanintervalL;


frequencyR=abs(frequency-StepFreqR);
[minR locsR]=min(frequencyR);
A1RtStepFreq=A1Rt(locsR);

frequencyL=abs(frequency-StepFreqL);
[minL locsL]=min(frequencyL);
A2LtStepFreq=A2Lt(locsL);

WaterOnOff20190705
Woffhpost1000=Woffhpost;
Wonhpre1000=Wonhpre;
Woffhpre1000=Woffhpre;
Wonhpost1000=Wonhpost;

WonWoffTtest2000
Woffhpost2000=Woffhpost;
Wonhpre2000=Wonhpre;
Woffhpre2000=Woffhpre;
Wonhpost2000=Wonhpost;


WonWoffTtest3000
Woffhpost3000=Woffhpost;
Wonhpre3000=Wonhpre;
Woffhpre3000=Woffhpre;
Wonhpost3000=Wonhpost;

save(FLName,'DiffMaxMinR','DiffMaxMinL','Freq','Wokaisu','Woffkaisu','WaterOnPointmean','WaterOffPointmean','ratio','MaxA1Rt','MaxA2Lt','locsP1'...
    ,'pksP2','locsP2','MaxZR','MaxZL','MaxADon','DiffDon','MaxZ','WaterOnPointstd','WaterOffPointstd','MaxZWon','MaxZWoff','StepFreqR','StepFreqL'...
    ,'A1RtStepFreq','A2LtStepFreq','AFreq','ZFreq','Woffhpost1000','Wonhpre1000','Woffhpost2000','Wonhpre2000','Woffhpost3000','Wonhpre3000','mensekiR','mensekiL'...
    ,'Woffhpre1000','Wonhpost1000','Woffhpre2000','Wonhpost2000','Woffhpre3000','Wonhpost3000','SpikePerTouchWoff'...
    ,'LtRsq', 'RtRsq', 'Ltbeta', 'Rtbeta', 'LtRsq_P1', 'RtRsq_P1', 'Ltbeta_P1', 'Rtbeta_P1', 'phaseL', 'phaseR');
cd(Oldc);
