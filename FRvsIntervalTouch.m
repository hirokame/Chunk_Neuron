function FRvsIntervalTouch
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 IntervalCount FRvsIntervalTouchRate pegpatternum

% クロスコリオグラムからピークを検出
% subplot(2,2,3);
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
TouchArray=[LlocsInterval,RlocsInterval];
TouchArray1=sort(abs(TouchArray),'ascend');

if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  
%    
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) > abs(Linterval1(1)) % ウインドウLRLの順
        Spikecount_50=0;
        Spikecount_100=0;
        Spikecount_150=0;
        Spikecount_200=0;
        Spikecount_250=0;
        Spikecount_300=0;
        Spikecount_350=0;
        Spikecount_400=0;
        Spikecount_450=0;
        Spikecount_500=0;
        Spikecount_550=0;
        Spikecount_600=0;
        Spikecount_650=0;
        FR_50=0;
        FR_100=0;
        FR_150=0;
        FR_200=0;
        FR_250=0;
        FR_300=0;
        FR_350=0;
        FR_400=0;
        FR_450=0;
        FR_500=0;
        FR_550=0;
        FR_600=0;
        FR_650=0;
        FRvsIntervalTouchRate=[]; 
%         全てのLタッチ調べて、タッチ間のインターバル計算。そのインターバル内における発火頻度計算して、インターバルごとの分布作る
        for i=1:(length(LpegTouchallWon)-1)
            TouchInterval=LpegTouchallWon(i+1)-LpegTouchallWon(i);
            for n=1:(length(SpikeArrayWon))
                if LpegTouchallWon(i)<SpikeArrayWon(n) & SpikeArrayWon(n)<LpegTouchallWon(i+1)
                    if 0<=TouchInterval & TouchInterval<50
                        Spikecount_50=Spikecount_50+1;
                    end
                    if 50<=TouchInterval & TouchInterval<100
                        Spikecount_100=Spikecount_100+1;
                    end
                    if 100<=TouchInterval & TouchInterval<150
                        Spikecount_150=Spikecount_150+1;
                    end
                    if 150<=TouchInterval & TouchInterval<200
                        Spikecount_200=Spikecount_200+1;
                    end
                    if 200<=TouchInterval & TouchInterval<250
                        Spikecount_250=Spikecount_250+1;
                    end
                    if 250<=TouchInterval & TouchInterval<300
                        Spikecount_300=Spikecount_300+1;
                    end
                    if 300<=TouchInterval & TouchInterval<350
                        Spikecount_350=Spikecount_350+1;
                    end
                    if 350<=TouchInterval & TouchInterval<400
                        Spikecount_400=Spikecount_400+1;
                    end
                    if 400<=TouchInterval & TouchInterval<450
                        Spikecount_450=Spikecount_450+1;
                    end
                    if 450<=TouchInterval & TouchInterval<500
                        Spikecount_500=Spikecount_500+1;
                    end
                    if 500<=TouchInterval & TouchInterval<550
                        Spikecount_550=Spikecount_550+1;
                    end
                    if 550<=TouchInterval & TouchInterval<600
                        Spikecount_600=Spikecount_600+1;
                    end
                    if 600<=TouchInterval & TouchInterval<650
                        Spikecount_650=Spikecount_650+1;
                    end
                end 
            end
            FR_50=FR_50+Spikecount_50;
            FR_100=FR_100+Spikecount_100;
            FR_150=FR_150+Spikecount_150;
            FR_200=FR_200+Spikecount_200;
            FR_250=FR_250+Spikecount_250;
            FR_300=FR_300+Spikecount_300;
            FR_350=FR_350+Spikecount_350;
            FR_400=FR_400+Spikecount_400;
            FR_450=FR_450+Spikecount_450;
            FR_500=FR_500+Spikecount_500;
            FR_550=FR_550+Spikecount_550;
            FR_600=FR_600+Spikecount_600;
            FR_650=FR_650+Spikecount_650;
        end
        fig1=figure;
        FRvsIntervalTouch=[FR_50,FR_100,FR_150,FR_200,FR_250,FR_300,FR_350,FR_400,FR_450,FR_500,FR_550,FR_600,FR_650];
% 発火頻度をIntervalCountで割り、インターバルごとの分布作成
        for a=1:length(FRvsIntervalTouch)
            if IntervalCount(a)~=0;
                FRvsIntervalTouchRate=[FRvsIntervalTouchRate FRvsIntervalTouch(a)/IntervalCount(a)];
            else
                FRvsIntervalTouchRate=[FRvsIntervalTouchRate FRvsIntervalTouch(a)];
            end
        end
        bar(FRvsIntervalTouchRate)
        set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        trimtfile=strtrim(tfile);
        figname=['FRvsIntervalTouchLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig1,figname);
        close(fig1);
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) < abs(Rinterval1(1)) % ウインドウLRLの順
        Spikecount_50=0;
        Spikecount_100=0;
        Spikecount_150=0;
        Spikecount_200=0;
        Spikecount_250=0;
        Spikecount_300=0;
        Spikecount_350=0;
        Spikecount_400=0;
        Spikecount_450=0;
        Spikecount_500=0;
        Spikecount_550=0;
        Spikecount_600=0;
        Spikecount_650=0;
        FR_50=0;
        FR_100=0;
        FR_150=0;
        FR_200=0;
        FR_250=0;
        FR_300=0;
        FR_350=0;
        FR_400=0;
        FR_450=0;
        FR_500=0;
        FR_550=0;
        FR_600=0;
        FR_650=0;
        FRvsIntervalTouchRate=[]; 
        for i=1:(length(LpegTouchallWon)-1)
            TouchInterval=LpegTouchallWon(i+1)-LpegTouchallWon(i);
            for n=1:(length(SpikeArrayWon))
                if LpegTouchallWon(i)<SpikeArrayWon(n) & SpikeArrayWon(n)<LpegTouchallWon(i+1)
                    if 0<=TouchInterval & TouchInterval<50
                        Spikecount_50=Spikecount_50+1;
                    end
                    if 50<=TouchInterval & TouchInterval<100
                        Spikecount_100=Spikecount_100+1;
                    end
                    if 100<=TouchInterval & TouchInterval<150
                        Spikecount_150=Spikecount_150+1;
                    end
                    if 150<=TouchInterval & TouchInterval<200
                        Spikecount_200=Spikecount_200+1;
                    end
                    if 200<=TouchInterval & TouchInterval<250
                        Spikecount_250=Spikecount_250+1;
                    end
                    if 250<=TouchInterval & TouchInterval<300
                        Spikecount_300=Spikecount_300+1;
                    end
                    if 300<=TouchInterval & TouchInterval<350
                        Spikecount_350=Spikecount_350+1;
                    end
                    if 350<=TouchInterval & TouchInterval<400
                        Spikecount_400=Spikecount_400+1;
                    end
                    if 400<=TouchInterval & TouchInterval<450
                        Spikecount_450=Spikecount_450+1;
                    end
                    if 450<=TouchInterval & TouchInterval<500
                        Spikecount_500=Spikecount_500+1;
                    end
                    if 500<=TouchInterval & TouchInterval<550
                        Spikecount_550=Spikecount_550+1;
                    end
                    if 550<=TouchInterval & TouchInterval<600
                        Spikecount_600=Spikecount_600+1;
                    end
                    if 600<=TouchInterval & TouchInterval<650
                        Spikecount_650=Spikecount_650+1;
                    end
                end 
            end
            FR_50=FR_50+Spikecount_50;
            FR_100=FR_100+Spikecount_100;
            FR_150=FR_150+Spikecount_150;
            FR_200=FR_200+Spikecount_200;
            FR_250=FR_250+Spikecount_250;
            FR_300=FR_300+Spikecount_300;
            FR_350=FR_350+Spikecount_350;
            FR_400=FR_400+Spikecount_400;
            FR_450=FR_450+Spikecount_450;
            FR_500=FR_500+Spikecount_500;
            FR_550=FR_550+Spikecount_550;
            FR_600=FR_600+Spikecount_600;
            FR_650=FR_650+Spikecount_650;
        end
        fig1=figure;
        FRvsIntervalTouch=[FR_50,FR_100,FR_150,FR_200,FR_250,FR_300,FR_350,FR_400,FR_450,FR_500,FR_550,FR_600,FR_650];
        for a=1:length(FRvsIntervalTouch)
            if IntervalCount(a)~=0;
                FRvsIntervalTouchRate=[FRvsIntervalTouchRate FRvsIntervalTouch(a)/IntervalCount(a)];
            else
                FRvsIntervalTouchRate=[FRvsIntervalTouchRate FRvsIntervalTouch(a)];
            end
        end
        bar(FRvsIntervalTouchRate)
        set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        trimtfile=strtrim(tfile);
        figname=['FRvsIntervalTouchLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig1,figname);
        close(fig1);
    end
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) < abs(Linterval1(1)) % ウインドウRLRの順
        Spikecount_50=0;
        Spikecount_100=0;
        Spikecount_150=0;
        Spikecount_200=0;
        Spikecount_250=0;
        Spikecount_300=0;
        Spikecount_350=0;
        Spikecount_400=0;
        Spikecount_450=0;
        Spikecount_500=0;
        Spikecount_550=0;
        Spikecount_600=0;
        Spikecount_650=0;
        FR_50=0;
        FR_100=0;
        FR_150=0;
        FR_200=0;
        FR_250=0;
        FR_300=0;
        FR_350=0;
        FR_400=0;
        FR_450=0;
        FR_500=0;
        FR_550=0;
        FR_600=0;
        FR_650=0;
        FRvsIntervalTouchRate=[]; 
        for i=1:(length(RpegTouchallWon)-1)
            TouchInterval=RpegTouchallWon(i+1)-RpegTouchallWon(i);
            for n=1:(length(SpikeArrayWon))
                if RpegTouchallWon(i)<SpikeArrayWon(n) & SpikeArrayWon(n)<RpegTouchallWon(i+1)
                    if 0<=TouchInterval & TouchInterval<50
                        Spikecount_50=Spikecount_50+1;
                    end
                    if 50<=TouchInterval & TouchInterval<100
                        Spikecount_100=Spikecount_100+1;
                    end
                    if 100<=TouchInterval & TouchInterval<150
                        Spikecount_150=Spikecount_150+1;
                    end
                    if 150<=TouchInterval & TouchInterval<200
                        Spikecount_200=Spikecount_200+1;
                    end
                    if 200<=TouchInterval & TouchInterval<250
                        Spikecount_250=Spikecount_250+1;
                    end
                    if 250<=TouchInterval & TouchInterval<300
                        Spikecount_300=Spikecount_300+1;
                    end
                    if 300<=TouchInterval & TouchInterval<350
                        Spikecount_350=Spikecount_350+1;
                    end
                    if 350<=TouchInterval & TouchInterval<400
                        Spikecount_400=Spikecount_400+1;
                    end
                    if 400<=TouchInterval & TouchInterval<450
                        Spikecount_450=Spikecount_450+1;
                    end
                    if 450<=TouchInterval & TouchInterval<500
                        Spikecount_500=Spikecount_500+1;
                    end
                    if 500<=TouchInterval & TouchInterval<550
                        Spikecount_550=Spikecount_550+1;
                    end
                    if 550<=TouchInterval & TouchInterval<600
                        Spikecount_600=Spikecount_600+1;
                    end
                    if 600<=TouchInterval & TouchInterval<650
                        Spikecount_650=Spikecount_650+1;
                    end
                end 
            end
            FR_50=FR_50+Spikecount_50;
            FR_100=FR_100+Spikecount_100;
            FR_150=FR_150+Spikecount_150;
            FR_200=FR_200+Spikecount_200;
            FR_250=FR_250+Spikecount_250;
            FR_300=FR_300+Spikecount_300;
            FR_350=FR_350+Spikecount_350;
            FR_400=FR_400+Spikecount_400;
            FR_450=FR_450+Spikecount_450;
            FR_500=FR_500+Spikecount_500;
            FR_550=FR_550+Spikecount_550;
            FR_600=FR_600+Spikecount_600;
            FR_650=FR_650+Spikecount_650;
        end
        fig1=figure;
        FRvsIntervalTouch=[FR_50,FR_100,FR_150,FR_200,FR_250,FR_300,FR_350,FR_400,FR_450,FR_500,FR_550,FR_600,FR_650];
        for a=1:length(FRvsIntervalTouch)
            if IntervalCount(a)~=0;
                FRvsIntervalTouchRate=[FRvsIntervalTouchRate FRvsIntervalTouch(a)/IntervalCount(a)];
            else
                FRvsIntervalTouchRate=[FRvsIntervalTouchRate FRvsIntervalTouch(a)];
            end
        end
        bar(FRvsIntervalTouchRate)
        set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        trimtfile=strtrim(tfile);
        figname=['FRvsIntervalTouchRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig1,figname);
        close(fig1);
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) > abs(Rinterval1(1)) % ウインドウRLRの順
        Spikecount_50=0;
        Spikecount_100=0;
        Spikecount_150=0;
        Spikecount_200=0;
        Spikecount_250=0;
        Spikecount_300=0;
        Spikecount_350=0;
        Spikecount_400=0;
        Spikecount_450=0;
        Spikecount_500=0;
        Spikecount_550=0;
        Spikecount_600=0;
        Spikecount_650=0;
        FR_50=0;
        FR_100=0;
        FR_150=0;
        FR_200=0;
        FR_250=0;
        FR_300=0;
        FR_350=0;
        FR_400=0;
        FR_450=0;
        FR_500=0;
        FR_550=0;
        FR_600=0;
        FR_650=0;
        FRvsIntervalTouchRate=[]; 
        for i=1:(length(RpegTouchallWon)-1)
            TouchInterval=RpegTouchallWon(i+1)-RpegTouchallWon(i);
            for n=1:(length(SpikeArrayWon))
                if RpegTouchallWon(i)<SpikeArrayWon(n) & SpikeArrayWon(n)<RpegTouchallWon(i+1)
                    if 0<=TouchInterval & TouchInterval<50
                        Spikecount_50=Spikecount_50+1;
                    end
                    if 50<=TouchInterval & TouchInterval<100
                        Spikecount_100=Spikecount_100+1;
                    end
                    if 100<=TouchInterval & TouchInterval<150
                        Spikecount_150=Spikecount_150+1;
                    end
                    if 150<=TouchInterval & TouchInterval<200
                        Spikecount_200=Spikecount_200+1;
                    end
                    if 200<=TouchInterval & TouchInterval<250
                        Spikecount_250=Spikecount_250+1;
                    end
                    if 250<=TouchInterval & TouchInterval<300
                        Spikecount_300=Spikecount_300+1;
                    end
                    if 300<=TouchInterval & TouchInterval<350
                        Spikecount_350=Spikecount_350+1;
                    end
                    if 350<=TouchInterval & TouchInterval<400
                        Spikecount_400=Spikecount_400+1;
                    end
                    if 400<=TouchInterval & TouchInterval<450
                        Spikecount_450=Spikecount_450+1;
                    end
                    if 450<=TouchInterval & TouchInterval<500
                        Spikecount_500=Spikecount_500+1;
                    end
                    if 500<=TouchInterval & TouchInterval<550
                        Spikecount_550=Spikecount_550+1;
                    end
                    if 550<=TouchInterval & TouchInterval<600
                        Spikecount_600=Spikecount_600+1;
                    end
                    if 600<=TouchInterval & TouchInterval<650
                        Spikecount_650=Spikecount_650+1;
                    end
                end 
            end
            FR_50=FR_50+Spikecount_50;
            FR_100=FR_100+Spikecount_100;
            FR_150=FR_150+Spikecount_150;
            FR_200=FR_200+Spikecount_200;
            FR_250=FR_250+Spikecount_250;
            FR_300=FR_300+Spikecount_300;
            FR_350=FR_350+Spikecount_350;
            FR_400=FR_400+Spikecount_400;
            FR_450=FR_450+Spikecount_450;
            FR_500=FR_500+Spikecount_500;
            FR_550=FR_550+Spikecount_550;
            FR_600=FR_600+Spikecount_600;
            FR_650=FR_650+Spikecount_650;
        end
        fig1=figure;
        FRvsIntervalTouch=[FR_50,FR_100,FR_150,FR_200,FR_250,FR_300,FR_350,FR_400,FR_450,FR_500,FR_550,FR_600,FR_650];
        for a=1:length(FRvsIntervalTouch)
            if IntervalCount(a)~=0;
                FRvsIntervalTouchRate=[FRvsIntervalTouchRate FRvsIntervalTouch(a)/IntervalCount(a)];
            else
                FRvsIntervalTouchRate=[FRvsIntervalTouchRate FRvsIntervalTouch(a)];
            end
        end
        bar(FRvsIntervalTouchRate)
        set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        trimtfile=strtrim(tfile);
        figname=['FRvsIntervalTouchRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig1,figname);
        close(fig1);
    end
end
