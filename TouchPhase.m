function TouchPhase
% 両足のタッチの位相調べる
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 PhaseCountRate


%SpikeArrayでLPegTouchAll、RpegTouchallをアラインしたクロスコリオグラム
%SpikeArrayでLPegTouchAllをアラインする
% duration=5000;
% CrossCoL=[];
% CrossCoR=[];
%両方向
% for n=1:(length(SpikeArrayWon))
%         Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
%         CrossCoL=[CrossCoL Interval];
% end
%     
% CrossCoL=[-1*duration/2 CrossCoL duration/2];
% 
% CrossCoL(CrossCoL==0)=[];
% 
% bin=500;
% CCresultLtouchWon=hist(CrossCoL,bin);
% CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);
% 
% fig1=figure;
% subplot(2,2,[1,2]);
% plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',1);
% axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
% hold on
%SpikeArrayでRPegTouchAllをアラインする
% for n=1:(length(SpikeArrayWon))
%         Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
%         CrossCoR=[CrossCoR Interval];
% end
%     
% CrossCoR=[-1*duration/2 CrossCoR duration/2];
% 
% CrossCoR(CrossCoR==0)=[];
% 
% bin=500;
% CCresultRtouchWon=hist(CrossCoR,bin);
% CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);
% 
% plot(linspace(1,5000,bin),CCresultRtouchWon,'color','g','LineWidth',1);
% axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
% hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RpegTouchallWon
% LpegTouchallWon

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

% LWindowS1=Linterval2(1)*10-90;
% LWindowE1=Linterval2(1)*10+90;
% LWindowS2=Linterval1(1)*10-90;
% LWindowE2=Linterval1(1)*10+90;
% 
% RWindowS1=Rinterval2(1)*10-90;
% RWindowE1=Rinterval2(1)*10+90;
% RWindowS2=Rinterval1(1)*10-90;
% RWindowE2=Rinterval1(1)*10+90;

% trimtfile=strtrim(tfile);
% figname=[trimFolder2,trimtfile,pegpatternname,'.bmp'];
% saveas(fig1,figname);
    


%ウインドウLRLの順
    for p=1:(length(LlocsInterval))    
        for q=1:(length(LlocsInterval))
            for r=1:(length(RlocsInterval))
                if TouchArray1(1)==LlocsInterval(q) & TouchArray1(2)==RlocsInterval(r) & TouchArray1(3)==LlocsInterval(p)|...
                   -TouchArray1(1)==LlocsInterval(q) & -TouchArray1(2)==RlocsInterval(r) & -TouchArray1(3)==LlocsInterval(p)|...
                   -TouchArray1(1)==RlocsInterval(r) & TouchArray1(2)==LlocsInterval(q) & -TouchArray1(3)==LlocsInterval(p)|...
                   TouchArray1(1)==RlocsInterval(r) & TouchArray1(2)==LlocsInterval(q) & -TouchArray1(3)==LlocsInterval(p)|...
                   TouchArray1(1)==LlocsInterval(q) & -TouchArray1(2)==RlocsInterval(r) & -TouchArray1(3)==LlocsInterval(p)|...
                   -TouchArray1(1)==RlocsInterval(r) & -TouchArray1(2)==LlocsInterval(q) & TouchArray1(3)==LlocsInterval(p)|...
                   TouchArray1(1)==RlocsInterval(r) & -TouchArray1(2)==LlocsInterval(q) & TouchArray1(3)==LlocsInterval(p)|...
                   -TouchArray1(1)==LlocsInterval(q) & TouchArray1(2)==RlocsInterval(r) & TouchArray1(3)==LlocsInterval(p)    

                    Phasecount0_10=0;
                    Phasecount10_20=0;
                    Phasecount20_30=0;
                    Phasecount30_40=0;
                    Phasecount40_50=0;
                    Phasecount50_60=0;
                    Phasecount60_70=0;
                    Phasecount70_80=0;
                    Phasecount80_90=0;
                    Phasecount90_100=0;
                    PhaseCountRate=[];
                    
                    for j=1:(length(RpegTouchallWon)-1)
                        for i=1:(length(LpegTouchallWon)-1)
                            TouchInterval=LpegTouchallWon(i+1)-LpegTouchallWon(i);
                            TouchInterval_10=TouchInterval/10;
                            TouchInterval_20=TouchInterval*2/10;
                            TouchInterval_30=TouchInterval*3/10;
                            TouchInterval_40=TouchInterval*4/10;
                            TouchInterval_50=TouchInterval*5/10;
                            TouchInterval_60=TouchInterval*6/10;
                            TouchInterval_70=TouchInterval*7/10;
                            TouchInterval_80=TouchInterval*8/10;
                            TouchInterval_90=TouchInterval*9/10;
                            if LpegTouchallWon(i)<=RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_10
                               Phasecount0_10=Phasecount0_10+1;
                            end                            
                            if LpegTouchallWon(i)+TouchInterval_10<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_20
                               Phasecount10_20=Phasecount10_20+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_20<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_30
                               Phasecount20_30=Phasecount20_30+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_30<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_40
                               Phasecount30_40=Phasecount30_40+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_40<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_50
                               Phasecount40_50=Phasecount40_50+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_50<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_60
                               Phasecount50_60=Phasecount50_60+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_60<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_70
                               Phasecount60_70=Phasecount60_70+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_70<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_80
                               Phasecount70_80=Phasecount70_80+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_80<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_90
                               Phasecount80_90=Phasecount80_90+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_90<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval
                               Phasecount90_100=Phasecount90_100+1;
                            end
                        end
                    end
                        fig1=figure;
                        PhaseCount=[Phasecount0_10,Phasecount10_20,Phasecount20_30,Phasecount30_40,Phasecount40_50,Phasecount50_60,Phasecount60_70,Phasecount70_80,Phasecount80_90,Phasecount90_100];
                        for a=1:length(PhaseCount)
                            PhaseCountRate=[PhaseCountRate PhaseCount(a)/sum(PhaseCount)];
                        end
                        subplot(2,1,1);
                        bar(PhaseCount)
                        set(gca,'xticklabel',{'0-1','1-2','2-3','3-4','4-5','5-6','6-7','7-8','8-9','9-10'});
                        subplot(2,1,2);
                        bar(PhaseCountRate)
                        set(gca,'xticklabel',{'0-1','1-2','2-3','3-4','4-5','5-6','6-7','7-8','8-9','9-10'});
                        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
                        trimtfile=strtrim(tfile);
                        figname=['TouchPhaseLRL',trimFolder2,trimtfile,pegpatternname,'.bmp'];
                        saveas(fig1,figname);
                        close(fig1); 
                end
            end
        end
    end
    %ウインドウRLRの順
    for p=1:(length(RlocsInterval))    
        for q=1:(length(RlocsInterval))
            for r=1:(length(LlocsInterval))
                if TouchArray1(1)==RlocsInterval(q) & TouchArray1(2)==LlocsInterval(r) & TouchArray1(3)==RlocsInterval(p)|...
                   -TouchArray1(1)==RlocsInterval(q) & -TouchArray1(2)==LlocsInterval(r) & -TouchArray1(3)==RlocsInterval(p)|...
                   -TouchArray1(1)==LlocsInterval(r) & TouchArray1(2)==RlocsInterval(q) & -TouchArray1(3)==RlocsInterval(p)|...
                   TouchArray1(1)==LlocsInterval(r) & TouchArray1(2)==RlocsInterval(q) & -TouchArray1(3)==RlocsInterval(p)|...
                   TouchArray1(1)==RlocsInterval(q) & -TouchArray1(2)==LlocsInterval(r) & -TouchArray1(3)==RlocsInterval(p)|...
                   -TouchArray1(1)==LlocsInterval(r) & -TouchArray1(2)==RlocsInterval(q) & TouchArray1(3)==RlocsInterval(p)|...
                   TouchArray1(1)==LlocsInterval(r) & -TouchArray1(2)==RlocsInterval(q) & TouchArray1(3)==RlocsInterval(p)|...
                   -TouchArray1(1)==RlocsInterval(q) & TouchArray1(2)==LlocsInterval(r) & TouchArray1(3)==RlocsInterval(p)

                    Phasecount0_10=0;
                    Phasecount10_20=0;
                    Phasecount20_30=0;
                    Phasecount30_40=0;
                    Phasecount40_50=0;
                    Phasecount50_60=0;
                    Phasecount60_70=0;
                    Phasecount70_80=0;
                    Phasecount80_90=0;
                    Phasecount90_100=0;
                    PhaseCountRate=[];

                    for j=1:(length(RpegTouchallWon)-1)
                        for i=1:(length(LpegTouchallWon)-1)
                            TouchInterval=LpegTouchallWon(i+1)-LpegTouchallWon(i);
                            TouchInterval_10=TouchInterval/10;
                            TouchInterval_20=TouchInterval*2/10;
                            TouchInterval_30=TouchInterval*3/10;
                            TouchInterval_40=TouchInterval*4/10;
                            TouchInterval_50=TouchInterval*5/10;
                            TouchInterval_60=TouchInterval*6/10;
                            TouchInterval_70=TouchInterval*7/10;
                            TouchInterval_80=TouchInterval*8/10;
                            TouchInterval_90=TouchInterval*9/10;
                            if LpegTouchallWon(i)<=RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_10
                               Phasecount0_10=Phasecount0_10+1;
                            end                            
                            if LpegTouchallWon(i)+TouchInterval_10<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_20
                               Phasecount10_20=Phasecount10_20+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_20<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_30
                               Phasecount20_30=Phasecount20_30+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_30<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_40
                               Phasecount30_40=Phasecount30_40+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_40<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_50
                               Phasecount40_50=Phasecount40_50+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_50<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_60
                               Phasecount50_60=Phasecount50_60+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_60<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_70
                               Phasecount60_70=Phasecount60_70+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_70<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_80
                               Phasecount70_80=Phasecount70_80+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_80<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval_90
                               Phasecount80_90=Phasecount80_90+1;
                            end
                            if LpegTouchallWon(i)+TouchInterval_90<RpegTouchallWon(j) & RpegTouchallWon(j)<=LpegTouchallWon(i)+TouchInterval
                               Phasecount90_100=Phasecount90_100+1;
                            end
                        end
                    end
                        fig1=figure;
                        PhaseCount=[Phasecount0_10,Phasecount10_20,Phasecount20_30,Phasecount30_40,Phasecount40_50,Phasecount50_60,Phasecount60_70,Phasecount70_80,Phasecount80_90,Phasecount90_100];
                        for a=1:length(PhaseCount)
                            PhaseCountRate=[PhaseCountRate PhaseCount(a)/sum(PhaseCount)];
                        end
                        subplot(2,1,1);
                        bar(PhaseCount)
                        set(gca,'xticklabel',{'0-1','1-2','2-3','3-4','4-5','5-6','6-7','7-8','8-9','9-10'});
                        subplot(2,1,2);
                        bar(PhaseCountRate)
                        set(gca,'xticklabel',{'0-1','1-2','2-3','3-4','4-5','5-6','6-7','7-8','8-9','9-10'});
                        % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
                        trimtfile=strtrim(tfile);
                        figname=['TouchPhaseRLR',trimFolder2,trimtfile,pegpatternname,'.bmp'];
                        saveas(fig1,figname);
                        close(fig1); 
                end
            end
        end
    end
end