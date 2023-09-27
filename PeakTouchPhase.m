function PeakTouchPhase
% クロスコリオグラムのピークの位相分布
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 IntervalCount PeakInterval PeakPhaseCount

findpeaks(CCresultLtouchWon,'MinPeakDistance',30);
[Lpks,Llocs]=findpeaks(CCresultLtouchWon,'MinPeakDistance',30);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(LlocsInterval2,'descend');
% subplot(2,2,4);
findpeaks(CCresultRtouchWon,'MinPeakDistance',30);
[Rpks,Rlocs]=findpeaks(CCresultRtouchWon,'MinPeakDistance',30);
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(RlocsInterval2,'descend');

PeakPhaseCount_10=0;
PeakPhaseCount_20=0;
PeakPhaseCount_30=0;
PeakPhaseCount_40=0;
PeakPhaseCount_50=0;
PeakPhaseCount_60=0;
PeakPhaseCount_70=0;
PeakPhaseCount_80=0;
PeakPhaseCount_90=0;
PeakPhaseCount_100=0;
PeakPhaseCount=[];
if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) < abs(Linterval1(1)) % ウインドウRLRの順
        PeakInterval=(Rinterval1(1)-Rinterval2(1))*10;
        IntervalPhase_10=PeakInterval/10;
        IntervalPhase_20=PeakInterval*2/10;
        IntervalPhase_30=PeakInterval*3/10;
        IntervalPhase_40=PeakInterval*4/10;
        IntervalPhase_50=PeakInterval*5/10;
        IntervalPhase_60=PeakInterval*6/10;
        IntervalPhase_70=PeakInterval*7/10;
        IntervalPhase_80=PeakInterval*8/10;
        IntervalPhase_90=PeakInterval*9/10;
        if Rinterval2(1)*10<=Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_10
            PeakPhaseCount_10=PeakPhaseCount_10+1;
        end
        if Rinterval2(1)*10+IntervalPhase_10<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_20
            PeakPhaseCount_20=PeakPhaseCount_20+1;
        end
        if Rinterval2(1)*10+IntervalPhase_20<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_30
            PeakPhaseCount_30=PeakPhaseCount_30+1;
        end
        if Rinterval2(1)*10+IntervalPhase_30<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_40
            PeakPhaseCount_40=PeakPhaseCount_40+1;
        end
        if Rinterval2(1)*10+IntervalPhase_40<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_50
            PeakPhaseCount_50=PeakPhaseCount_50+1;
        end
        if Rinterval2(1)*10+IntervalPhase_50<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_60
            PeakPhaseCount_60=PeakPhaseCount_60+1;
        end
        if Rinterval2(1)*10+IntervalPhase_60<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_70
            PeakPhaseCount_70=PeakPhaseCount_70+1;
        end
        if Rinterval2(1)*10+IntervalPhase_70<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_80
            PeakPhaseCount_80=PeakPhaseCount_80+1;
        end
        if Rinterval2(1)*10+IntervalPhase_80<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval2(1)*10+IntervalPhase_90
            PeakPhaseCount_90=PeakPhaseCount_90+1;
        end
        if Rinterval2(1)*10+IntervalPhase_90<Linterval2(1)*10 && Linterval2(1)*10<=Rinterval1(1)*10
            PeakPhaseCount_100=PeakPhaseCount_100+1;
        end
        PeakPhaseCount=[PeakPhaseCount_10,PeakPhaseCount_20,PeakPhaseCount_30,PeakPhaseCount_40,PeakPhaseCount_50,PeakPhaseCount_60,PeakPhaseCount_70,PeakPhaseCount_80,PeakPhaseCount_90,PeakPhaseCount_100];
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) > abs(Rinterval1(1)) % ウインドウRLRの順
        PeakInterval=(Rinterval1(1)-Rinterval2(1))*10;
        IntervalPhase_10=PeakInterval/10;
        IntervalPhase_20=PeakInterval*2/10;
        IntervalPhase_30=PeakInterval*3/10;
        IntervalPhase_40=PeakInterval*4/10;
        IntervalPhase_50=PeakInterval*5/10;
        IntervalPhase_60=PeakInterval*6/10;
        IntervalPhase_70=PeakInterval*7/10;
        IntervalPhase_80=PeakInterval*8/10;
        IntervalPhase_90=PeakInterval*9/10;
        if Rinterval2(1)*10<=Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_10
            PeakPhaseCount_10=PeakPhaseCount_10+1;
        end
        if Rinterval2(1)*10+IntervalPhase_10<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_20
            PeakPhaseCount_20=PeakPhaseCount_20+1;
        end
        if Rinterval2(1)*10+IntervalPhase_20<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_30
            PeakPhaseCount_30=PeakPhaseCount_30+1;
        end
        if Rinterval2(1)*10+IntervalPhase_30<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_40
            PeakPhaseCount_40=PeakPhaseCount_40+1;
        end
        if Rinterval2(1)*10+IntervalPhase_40<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_50
            PeakPhaseCount_50=PeakPhaseCount_50+1;
        end
        if Rinterval2(1)*10+IntervalPhase_50<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_60
            PeakPhaseCount_60=PeakPhaseCount_60+1;
        end
        if Rinterval2(1)*10+IntervalPhase_60<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_70
            PeakPhaseCount_70=PeakPhaseCount_70+1;
        end
        if Rinterval2(1)*10+IntervalPhase_70<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_80
            PeakPhaseCount_80=PeakPhaseCount_80+1;
        end
        if Rinterval2(1)*10+IntervalPhase_80<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval2(1)*10+IntervalPhase_90
            PeakPhaseCount_90=PeakPhaseCount_90+1;
        end
        if Rinterval2(1)*10+IntervalPhase_90<Linterval1(1)*10 && Linterval1(1)*10<=Rinterval1(1)*10
            PeakPhaseCount_100=PeakPhaseCount_100+1;
        end
        PeakPhaseCount=[PeakPhaseCount_10,PeakPhaseCount_20,PeakPhaseCount_30,PeakPhaseCount_40,PeakPhaseCount_50,PeakPhaseCount_60,PeakPhaseCount_70,PeakPhaseCount_80,PeakPhaseCount_90,PeakPhaseCount_100];
    end
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) > abs(Linterval1(1)) % ウインドウLRLの順   
        PeakInterval=(Linterval1(1)-Linterval2(1))*10;
        IntervalPhase_10=PeakInterval/10;
        IntervalPhase_20=PeakInterval*2/10;
        IntervalPhase_30=PeakInterval*3/10;
        IntervalPhase_40=PeakInterval*4/10;
        IntervalPhase_50=PeakInterval*5/10;
        IntervalPhase_60=PeakInterval*6/10;
        IntervalPhase_70=PeakInterval*7/10;
        IntervalPhase_80=PeakInterval*8/10;
        IntervalPhase_90=PeakInterval*9/10;
        if Linterval2(1)*10<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_10
            PeakPhaseCount_10=PeakPhaseCount_10+1;
        end
        if Linterval2(1)*10+IntervalPhase_10<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_20
            PeakPhaseCount_20=PeakPhaseCount_20+1;
        end
        if Linterval2(1)*10+IntervalPhase_20<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_30
            PeakPhaseCount_30=PeakPhaseCount_30+1;
        end
        if Linterval2(1)*10+IntervalPhase_30<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_40
            PeakPhaseCount_40=PeakPhaseCount_40+1;
        end
        if Linterval2(1)*10+IntervalPhase_40<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_50
            PeakPhaseCount_50=PeakPhaseCount_50+1;
        end
        if Linterval2(1)*10+IntervalPhase_50<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_60
            PeakPhaseCount_60=PeakPhaseCount_60+1;
        end
        if Linterval2(1)*10+IntervalPhase_60<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_70
            PeakPhaseCount_70=PeakPhaseCount_70+1;
        end
        if Linterval2(1)*10+IntervalPhase_70<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_80
            PeakPhaseCount_80=PeakPhaseCount_80+1;
        end
        if Linterval2(1)*10+IntervalPhase_80<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval2(1)*10+IntervalPhase_90
            PeakPhaseCount_90=PeakPhaseCount_90+1;
        end
        if Linterval2(1)*10+IntervalPhase_90<Rinterval1(1)*10 && Rinterval1(1)*10<Linterval1(1)*10
            PeakPhaseCount_100=PeakPhaseCount_100+1;
        end
        PeakPhaseCount=[PeakPhaseCount_10,PeakPhaseCount_20,PeakPhaseCount_30,PeakPhaseCount_40,PeakPhaseCount_50,PeakPhaseCount_60,PeakPhaseCount_70,PeakPhaseCount_80,PeakPhaseCount_90,PeakPhaseCount_100];
        
        
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) < abs(Rinterval1(1)) % ウインドウLRLの順
        PeakInterval=(Linterval1(1)-Linterval2(1))*10;
        IntervalPhase_10=PeakInterval/10;
        IntervalPhase_20=PeakInterval*2/10;
        IntervalPhase_30=PeakInterval*3/10;
        IntervalPhase_40=PeakInterval*4/10;
        IntervalPhase_50=PeakInterval*5/10;
        IntervalPhase_60=PeakInterval*6/10;
        IntervalPhase_70=PeakInterval*7/10;
        IntervalPhase_80=PeakInterval*8/10;
        IntervalPhase_90=PeakInterval*9/10;
        if Linterval2(1)*10<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_10
            PeakPhaseCount_10=PeakPhaseCount_10+1;
        end
        if Linterval2(1)*10+IntervalPhase_10<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_20
            PeakPhaseCount_20=PeakPhaseCount_20+1;
        end
        if Linterval2(1)*10+IntervalPhase_20<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_30
            PeakPhaseCount_30=PeakPhaseCount_30+1;
        end
        if Linterval2(1)*10+IntervalPhase_30<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_40
            PeakPhaseCount_40=PeakPhaseCount_40+1;
        end
        if Linterval2(1)*10+IntervalPhase_40<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_50
            PeakPhaseCount_50=PeakPhaseCount_50+1;
        end
        if Linterval2(1)*10+IntervalPhase_50<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_60
            PeakPhaseCount_60=PeakPhaseCount_60+1;
        end
        if Linterval2(1)*10+IntervalPhase_60<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_70
            PeakPhaseCount_70=PeakPhaseCount_70+1;
        end
        if Linterval2(1)*10+IntervalPhase_70<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_80
            PeakPhaseCount_80=PeakPhaseCount_80+1;
        end
        if Linterval2(1)*10+IntervalPhase_80<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval2(1)*10+IntervalPhase_90
            PeakPhaseCount_90=PeakPhaseCount_90+1;
        end
        if Linterval2(1)*10+IntervalPhase_90<Rinterval2(1)*10 && Rinterval2(1)*10<Linterval1(1)*10
            PeakPhaseCount_100=PeakPhaseCount_100+1;
        end
        PeakPhaseCount=[PeakPhaseCount_10,PeakPhaseCount_20,PeakPhaseCount_30,PeakPhaseCount_40,PeakPhaseCount_50,PeakPhaseCount_60,PeakPhaseCount_70,PeakPhaseCount_80,PeakPhaseCount_90,PeakPhaseCount_100];
    end
end  