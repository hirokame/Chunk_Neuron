function TouchInterval
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 IntervalCount pegpatternum

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

LWindowS1=Linterval2(1)*10-90;
LWindowE1=Linterval2(1)*10+90;
LWindowS2=Linterval1(1)*10-90;
LWindowE2=Linterval1(1)*10+90;

RWindowS1=Rinterval2(1)*10-90;
RWindowE1=Rinterval2(1)*10+90;
RWindowS2=Rinterval1(1)*10-90;
RWindowE2=Rinterval1(1)*10+90;

    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) < abs(Linterval1(1)) % ウインドウRLRの順
        count_50=0;
        count_100=0;
        count_150=0;
        count_200=0;
        count_250=0;
        count_300=0;
        count_350=0;
        count_400=0;
        count_450=0;
        count_500=0;
        count_550=0;
        count_600=0;
        count_650=0;
%         全てのRタッチ調べて、タッチ間のインターバル計算。分布作る。
        for i=1:(length(RpegTouchallWon)-1)
            TouchInterval=RpegTouchallWon(i+1)-RpegTouchallWon(i);
            if 0<=TouchInterval & TouchInterval<50
                count_50=count_50+1;
            end
            if 50<=TouchInterval & TouchInterval<100
                count_100=count_100+1;
            end
            if 100<=TouchInterval & TouchInterval<150
                count_150=count_150+1;
            end
            if 150<=TouchInterval & TouchInterval<200
                count_200=count_200+1;
            end
            if 200<=TouchInterval & TouchInterval<250
                count_250=count_250+1;
            end
            if 250<=TouchInterval & TouchInterval<300
                count_300=count_300+1;
            end
            if 300<=TouchInterval & TouchInterval<350
                count_350=count_350+1;
            end
            if 350<=TouchInterval & TouchInterval<400
                count_400=count_400+1;
            end
            if 400<=TouchInterval & TouchInterval<450
                count_450=count_450+1;
            end
            if 450<=TouchInterval & TouchInterval<500
                count_500=count_500+1;
            end
            if 500<=TouchInterval & TouchInterval<550
                count_550=count_550+1;
            end
            if 550<=TouchInterval & TouchInterval<600
                count_600=count_600+1;
            end
            if 600<=TouchInterval & TouchInterval<650
                count_650=count_650+1;
            end
        end
        fig1=figure;
        IntervalCount=[count_50,count_100,count_150,count_200,count_250,count_300,count_350,count_400,count_450,count_500,count_550,count_600,count_650];
        bar(IntervalCount)
        set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        trimtfile=strtrim(tfile);
        figname=['TouchIntervalRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig1,figname);
        close(fig1); 
        
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) > abs(Rinterval1(1)) % ウインドウRLRの順
        count_50=0;
        count_100=0;
        count_150=0;
        count_200=0;
        count_250=0;
        count_300=0;
        count_350=0;
        count_400=0;
        count_450=0;
        count_500=0;
        count_550=0;
        count_600=0;
        count_650=0;
        %         全てのRタッチ調べて、タッチ間のインターバル計算。分布作る。
        for i=1:(length(RpegTouchallWon)-1)
            TouchInterval=RpegTouchallWon(i+1)-RpegTouchallWon(i);
            if 0<=TouchInterval & TouchInterval<50
                count_50=count_50+1;
            end
            if 50<=TouchInterval & TouchInterval<100
                count_100=count_100+1;
            end
            if 100<=TouchInterval & TouchInterval<150
                count_150=count_150+1;
            end
            if 150<=TouchInterval & TouchInterval<200
                count_200=count_200+1;
            end
            if 200<=TouchInterval & TouchInterval<250
                count_250=count_250+1;
            end
            if 250<=TouchInterval & TouchInterval<300
                count_300=count_300+1;
            end
            if 300<=TouchInterval & TouchInterval<350
                count_350=count_350+1;
            end
            if 350<=TouchInterval & TouchInterval<400
                count_400=count_400+1;
            end
            if 400<=TouchInterval & TouchInterval<450
                count_450=count_450+1;
            end
            if 450<=TouchInterval & TouchInterval<500
                count_500=count_500+1;
            end
            if 500<=TouchInterval & TouchInterval<550
                count_550=count_550+1;
            end
            if 550<=TouchInterval & TouchInterval<600
                count_600=count_600+1;
            end
            if 600<=TouchInterval & TouchInterval<650
                count_650=count_650+1;
            end
        end
        fig1=figure;
        IntervalCount=[count_50,count_100,count_150,count_200,count_250,count_300,count_350,count_400,count_450,count_500,count_550,count_600,count_650];
        bar(IntervalCount)
        set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        trimtfile=strtrim(tfile);
        figname=['TouchIntervalRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig1,figname);
        close(fig1); 
    end
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) > abs(Linterval1(1)) % ウインドウLRLの順
        count_50=0;
        count_100=0;
        count_150=0;
        count_200=0;
        count_250=0;
        count_300=0;
        count_350=0;
        count_400=0;
        count_450=0;
        count_500=0;
        count_550=0;
        count_600=0;
        count_650=0;
        %         全てのLタッチ調べて、タッチ間のインターバル計算。分布作る。
        for i=1:(length(LpegTouchallWon)-1)
            TouchInterval=LpegTouchallWon(i+1)-LpegTouchallWon(i);
            if 0<=TouchInterval & TouchInterval<50
                count_50=count_50+1;
            end
            if 50<=TouchInterval & TouchInterval<100
                count_100=count_100+1;
            end
            if 100<=TouchInterval & TouchInterval<150
                count_150=count_150+1;
            end
            if 150<=TouchInterval & TouchInterval<200
                count_200=count_200+1;
            end
            if 200<=TouchInterval & TouchInterval<250
                count_250=count_250+1;
            end
            if 250<=TouchInterval & TouchInterval<300
                count_300=count_300+1;
            end
            if 300<=TouchInterval & TouchInterval<350
                count_350=count_350+1;
            end
            if 350<=TouchInterval & TouchInterval<400
                count_400=count_400+1;
            end
            if 400<=TouchInterval & TouchInterval<450
                count_450=count_450+1;
            end
            if 450<=TouchInterval & TouchInterval<500
                count_500=count_500+1;
            end
            if 500<=TouchInterval & TouchInterval<550
                count_550=count_550+1;
            end
            if 550<=TouchInterval & TouchInterval<600
                count_600=count_600+1;
            end
            if 600<=TouchInterval & TouchInterval<650
                count_650=count_650+1;
            end
        end
        fig1=figure;
        IntervalCount=[count_50,count_100,count_150,count_200,count_250,count_300,count_350,count_400,count_450,count_500,count_550,count_600,count_650];
        bar(IntervalCount)
        set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        trimtfile=strtrim(tfile);
        figname=['TouchIntervalLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig1,figname);
        close(fig1); 
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) < abs(Rinterval1(1)) % ウインドウLRLの順
        count_50=0;
        count_100=0;
        count_150=0;
        count_200=0;
        count_250=0;
        count_300=0;
        count_350=0;
        count_400=0;
        count_450=0;
        count_500=0;
        count_550=0;
        count_600=0;
        count_650=0;
        %         全てのLタッチ調べて、タッチ間のインターバル計算。分布作る。
        for i=1:(length(LpegTouchallWon)-1)
            TouchInterval=LpegTouchallWon(i+1)-LpegTouchallWon(i);
            if 0<=TouchInterval & TouchInterval<50
                count_50=count_50+1;
            end
            if 50<=TouchInterval & TouchInterval<100
                count_100=count_100+1;
            end
            if 100<=TouchInterval & TouchInterval<150
                count_150=count_150+1;
            end
            if 150<=TouchInterval & TouchInterval<200
                count_200=count_200+1;
            end
            if 200<=TouchInterval & TouchInterval<250
                count_250=count_250+1;
            end
            if 250<=TouchInterval & TouchInterval<300
                count_300=count_300+1;
            end
            if 300<=TouchInterval & TouchInterval<350
                count_350=count_350+1;
            end
            if 350<=TouchInterval & TouchInterval<400
                count_400=count_400+1;
            end
            if 400<=TouchInterval & TouchInterval<450
                count_450=count_450+1;
            end
            if 450<=TouchInterval & TouchInterval<500
                count_500=count_500+1;
            end
            if 500<=TouchInterval & TouchInterval<550
                count_550=count_550+1;
            end
            if 550<=TouchInterval & TouchInterval<600
                count_600=count_600+1;
            end
            if 600<=TouchInterval & TouchInterval<650
                count_650=count_650+1;
            end
        end
        fig1=figure;
        IntervalCount=[count_50,count_100,count_150,count_200,count_250,count_300,count_350,count_400,count_450,count_500,count_550,count_600,count_650];
        bar(IntervalCount)
        set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
        trimtfile=strtrim(tfile);
        figname=['TouchIntervalLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
        saveas(fig1,figname);
        close(fig1); 
    end
end