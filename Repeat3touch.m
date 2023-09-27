function Repeat3touch
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 Spike_TouchRate TouchCount pegpatternum RLRcount LRLcount Spike Spike_Bin SpikeFR_Bin


%SpikeArrayでLPegTouchAll、RpegTouchallをアラインしたクロスコリオグラム
%SpikeArrayでLPegTouchAllをアラインする
duration=5000;
CrossCoL=[];
CrossCoR=[];
%両方向
for n=1:(length(SpikeArrayWon))
        Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoL=[CrossCoL Interval];
end
    
CrossCoL=[-1*duration/2 CrossCoL duration/2];

CrossCoL(CrossCoL==0)=[];

bin=500;
% CCresultLtouchWonの更新に必要
CCresultLtouchWon=hist(CrossCoL,bin);
CCresultLtouchWon=CCresultLtouchWon/sum(CCresultLtouchWon);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);

fig1=figure;
subplot(2,2,[1,2]);
plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
hold on
%SpikeArrayでRPegTouchAllをアラインする
for n=1:(length(SpikeArrayWon))
        Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoR=[CrossCoR Interval];
end
    
CrossCoR=[-1*duration/2 CrossCoR duration/2];

CrossCoR(CrossCoR==0)=[];
% CCresultRtouchWonの更新に必要
CCresultRtouchWon=hist(CrossCoR,bin);
CCresultRtouchWon=CCresultRtouchWon/sum(CCresultRtouchWon);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);

plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);
axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RpegTouchallWon
% LpegTouchallWon


% クロスコリオグラムからピークを検出
subplot(2,2,3);
% findpeaks(CCresultLtouchWon,'MinPeakDistance',20);
[Lpks,Llocs,Lwidth,Lproms]=findpeaks(CCresultLtouchWon,'MinPeakDistance',25);
findpeaks(CCresultLtouchWon,'MinPeakDistance',25);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>=0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(LlocsInterval2,'descend');
subplot(2,2,4);
% findpeaks(CCresultRtouchWon,'MinPeakDistance',20);
[Rpks,Rlocs,Rwidth,Rproms]=findpeaks(CCresultRtouchWon,'MinPeakDistance',25);
findpeaks(CCresultRtouchWon,'MinPeakDistance',25);
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>=0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(RlocsInterval2,'descend');
TouchArray=[LlocsInterval,RlocsInterval];
TouchArray1=sort(abs(TouchArray),'ascend');
% 
if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  

LWindowS1=Linterval2(1)*10-50;
LWindowE1=Linterval2(1)*10+50;
LWindowS2=Linterval1(1)*10-50;
LWindowE2=Linterval1(1)*10+50;

RWindowS1=Rinterval2(1)*10-50;
RWindowE1=Rinterval2(1)*10+50;
RWindowS2=Rinterval1(1)*10-50;
RWindowE2=Rinterval1(1)*10+50;

SpikeWindowS=-20;
SpikeWindowE=20;

trimtfile=strtrim(tfile);
figname=[trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
saveas(fig1,figname);
close(fig1);
%     for p=1:(length(RlocsInterval))    
%         for q=1:(length(RlocsInterval))
%             for r=1:(length(LlocsInterval))
Spike_Touch=[];
Spike_TouchRate=[];
Spike=[];
Spike_Bin=[];
SpikeFR_Bin=[];
RLRcount=0;
LRLcount=0;
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) < abs(Linterval1(1)) % ウインドウRLRの順
        
        RLRcount=1;
        
        windowS1=RWindowS1;
        windowE1=RWindowE1;
        windowS2=LWindowS1;
        windowE2=LWindowE1;
        windowS3=RWindowS2;
        windowE3=RWindowE2;
        %ウインドウの幅180ミリ秒ずつずれていく配列用意
        MoveTouchInterval1=windowS3-windowE1;
        MoveTouchInterval2=windowS2-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1; %動かすウインドウに対して幅40msのスパイクウインドウの位置決める
        
        MoveWindowArray_90=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;
        
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2=0;
        TouchCountW3=0;
        TouchCountW12=0;
        TouchCountW123=0;
        TouchCountW13=0;
        TouchCountW23=0;
        SpikeCountW0=0;
        SpikeCountW1=0;
        SpikeCountW2=0;
        SpikeCountW3=0;
        SpikeCountW12=0;
        SpikeCount_W123=0;
        SpikeCountW13=0;
        SpikeCountW23=0;
%全てのタッチ見て、用意した3つのウインドウにどれだけ当てはまっているか調べる
        WaterBreakTime=[];
        WaterRestartTime=[];
        for n=1:length(RpegTouchallWon)-1
            RpegTouchWonInterval1=RpegTouchallWon(n+1)-RpegTouchallWon(n);
            if RpegTouchWonInterval1>1000
                WaterBreakTime=[WaterBreakTime;RpegTouchallWon(n)];
                WaterRestartTime=[WaterRestartTime;RpegTouchallWon(n+1)];
            end
        end
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2=0;
        Spike_W3=0;
        Spike_W12=0;
        Spike_W123=0;
        Spike_W13=0;
        Spike_W23=0;
        WaterBreakRestartArray=[WaterBreakTime,WaterRestartTime];
            for n=1:MoveWindowArray_90
                MoveWindow1=0;
                MoveWindow2=0;
                MoveWindow3=0;
                MoveWindowSpike=0;
                MoveWindow1Start=RpegTouchallWon(1)+(n-1)*10;
                MoveWindow1End=MoveWindow1Start+180;
                MoveWindow2Start=MoveWindow1End+MoveTouchInterval2;
                MoveWindow2End=MoveWindow2Start+180;  
                MoveWindow3Start=MoveWindow1End+MoveTouchInterval1;
                MoveWindow3End=MoveWindow3Start+180;
                MoveWindowSpikeStart=MoveWindow1End+MoveSpikeInterval;
                MoveWindowSpikeEnd=MoveWindowSpikeStart+40;
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
                            a=1;
                        end
                    end
                end
                if a==0
                    for k=1:(length(SpikeArrayWon))
                        if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                            MoveWindowSpike=1;
                        end
                    end
                    for i=1:(length(RpegTouchallWon))
                        if RpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>RpegTouchallWon(i)
                            MoveWindow1=1;
                            W1TouchTime=[W1TouchTime RpegTouchallWon(i)];
                        end 
                        if RpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>RpegTouchallWon(i) 
                            MoveWindow3=1;
                            W3TouchTime=[W3TouchTime RpegTouchallWon(i)];
                        end
                    end
                    for j=1:(length(LpegTouchallWon))
                        if LpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>LpegTouchallWon(j)
                            MoveWindow2=1;
                            W2TouchTime=[W2TouchTime LpegTouchallWon(j)];
                        end 
                    end
                    %MoveWindowSpike=1だったとき、各ウインドウ当てはまったときの発火回数
                    if MoveWindowSpike==1
                        for k=1:(length(SpikeArrayWon))
                           if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                               if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0
                                   Spike_W0=Spike_W0+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0
                                   Spike_W1=Spike_W1+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0
                                   Spike_W2=Spike_W2+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1
                                   Spike_W3=Spike_W3+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0
                                   Spike_W12=Spike_W12+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1
                                   Spike_W123=Spike_W123+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1
                                   Spike_W13=Spike_W13+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1
                                   Spike_W23=Spike_W23+1;
                               end
                           end
                        end
                    end
                    %
                    %足取りだけでビン毎の当てはまった回数
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0
                        TouchCountW0=TouchCountW0+1;
                    end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0
                        TouchCountW1=TouchCountW1+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0
                        TouchCountW2=TouchCountW2+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1
                        TouchCountW3=TouchCountW3+1;
                    end 
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0
                        TouchCountW12=TouchCountW12+1;
                    end 
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1
                        TouchCountW123=TouchCountW123+1;
                    end         
                end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1
                        TouchCountW13=TouchCountW13+1;
                    end 
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1
                        TouchCountW23=TouchCountW23+1;
                    end
                end
                    %
                    %ビン毎に当てはまったときのうち、どれだけ発火してるか
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW0=SpikeCountW0+1;
                    end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW1=SpikeCountW1+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW2=SpikeCountW2+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW3=SpikeCountW3+1;
                    end 
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW12=SpikeCountW12+1;
                    end 
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCount_W123=SpikeCount_W123+1;
                    end  
                end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW13=SpikeCountW13+1;
                    end 
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW23=SpikeCountW23+1;
                    end
                end
                    %
                end
            end
            %
            SpikeW123=[Spike_W0,Spike_W1,Spike_W2,Spike_W3,Spike_W12,Spike_W123,Spike_W13,Spike_W23];  %各ビン毎に当てはまったMoveWindowSpikeの回数
%             SpikeCountW123=[SpikeCountW0,SpikeCountW1,SpikeCountW2,SpikeCountW3,SpikeCountW12,SpikeCount_W123,SpikeCountW13,SpikeCountW23];
            TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
            fig2=figure;
            bar(TouchCount)
            set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat3TouchCountRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig2,figname);
            close(fig2);
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(SpikeW123)
                if TouchCount(n)~=0;
                    SpikeFR_Bin=[SpikeFR_Bin SpikeW123(n)/(TouchCount(n)*10)];
                else
                    SpikeFR_Bin=[SpikeFR_Bin TouchCount(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_Bin)
            set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat3TouchSpikeFR_BinRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            FLName=['Repeat3Touch',pegpatternum,pegpatternname];
            save(FLName,'windowE1','MoveTouchInterval1','MoveTouchInterval2','MoveSpikeInterval','LpegTouchallWon','RpegTouchallWon','SpikeArrayWon'...
                ,'SpikeW123','TouchCount','SpikeFR_Bin');
%             %%MoveWindowSpike==1のときの総発火回数を、ウインドウ当てはまったビン毎で、タッチ当てはまり・かつ発火があった(MoveWindowSpike==1)回数で割る。発火があった場合、そのビンに一回当てはまった時の発火回数
%             for n=1:length(SpikeW123)
%                 if SpikeCountW123(n)~=0;
%                     Spike_Bin=[Spike_Bin SpikeW123(n)/SpikeCountW123(n)];
%                 else
%                     Spike_Bin=[Spike_Bin SpikeCountW123(n)];
%                 end
%             end
%             fig5=figure;
%             bar(Spike_Bin)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikeCount_BinRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig5,figname);
%             close(fig5);
%             
%             %%ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%             for n=1:length(SpikeW123)
%                 if TouchCount(n)~=0;
%                     Spike=[Spike SpikeW123(n)/TouchCount(n)];
%                 else
%                     Spike=[Spike TouchCount(n)];
%                 end
%             end
%             fig4=figure;
%             bar(Spike)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikevsBinRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig4,figname);
%             close(fig4);  
%             
%             fig3=figure;
%             subplot(2,1,1);
%             %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時に発火してるかどーか
%             for n=1:length(SpikeCountW123)
%                 if TouchCount(n)~=0;
%                     Spike_Touch=[Spike_Touch SpikeCountW123(n)/TouchCount(n)];
%                 else
%                     Spike_Touch=[Spike_Touch TouchCount(n)];
%                 end
%             end
%             %一回ビンに当てはまった時の全体の発火回数に対する割合
%             for n=1:length(SpikeCountW123)
%                 if Spike_Touch(n)~=0;
%                     Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
%                 else
%                     Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
%                 end
%             end
%             bar(Spike_Touch)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%             subplot(2,1,2);
%             bar(Spike_TouchRate)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikeCountRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig3,figname);
%             close(fig3);
            %
            
%         CountW0=0;
%         CountW1=0;
%         CountW2=0;
%         CountW3=0;
%         CountW12=0;
%         CountW13=0;
%         CountW23=0;
%         CountW123=0;
        
%         全てのスパイク調べて、ウインドウにタッチが当てはまった時の発火頻度を調べる
%         for n=1:(length(SpikeArrayWon))
%             W1=0;
%             W2=0;
%             W3=0;
%             W1TouchTime=[];
%             W2TouchTime=[];
%             W3TouchTime=[];
%             for i=1:(length(RpegTouchallWon))
%                 if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>RpegTouchallWon(i)
%                     W1=1;
%                     W1TouchTime=[W1TouchTime RpegTouchallWon(i)];
%                 end
%                 if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>RpegTouchallWon(i) 
%                     W3=1;
%                     W3TouchTime=[W3TouchTime RpegTouchallWon(i)];
%                 end
%             end
%             for j=1:(length(LpegTouchallWon))
%                 if  LpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>LpegTouchallWon(j)
%                     W2=1;
%                     W2TouchTime=[W2TouchTime LpegTouchallWon(j)];
%                 end
%             end
%             if length(W1TouchTime)<2 && length(W2TouchTime)<2 && length(W3TouchTime)<2
%                     if W1==0 & W2==0 & W3==0
%                         CountW0=CountW0+1;
%                     end
%                     if W1==1 & W2==0 & W3==0
%                         CountW1=CountW1+1;
%                     end
%                     if W1==0 & W2==1 & W3==0
%                         CountW2=CountW2+1;
%                     end
%                     if W1==0 & W2==0 & W3==1
%                         CountW3=CountW3+1;
%                     end
%                 if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
%                     if W1==1 & W2==1 & W3==0
%                         CountW12=CountW12+1;
%                     end
%                 end
%                     if W1==1 & W2==0 & W3==1
%                         CountW13=CountW13+1;
%                     end
%                 if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
%                     if W1==0 & W2==1 & W3==1
%                         CountW23=CountW23+1;
%                     end
%                 end
%                 if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
%                     if W1==1 & W2==1 & W3==1
%                         CountW123=CountW123+1;
%                     end
%                 end
%             end
%         end
%         fig2=figure;
%         TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
%         bar(TouchCount)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         trimtfile=strtrim(tfile);
% %         ウインドウにどれだけタッチ当てはまったかの棒グラフ
%         figname=['Repeat3TouchCountRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%         saveas(fig2,figname);
%         close(fig2);  
% %         ウインドウにタッチ当てはまった時の発火回数
%         fig3=figure;
%         subplot(2,1,1);
%         W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
%         %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%         for n=1:length(W123)
%             if TouchCount(n)~=0;
%                 Spike_Touch=[Spike_Touch W123(n)/TouchCount(n)];
%             else
%                 Spike_Touch=[Spike_Touch TouchCount(n)];
%             end
%         end
%         %一回ビンに当てはまった時の全体の発火回数に対する割合
%         for n=1:length(W123)
%             if Spike_Touch(n)~=0;
%                 Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
%             else
%                 Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
%             end
%         end
%         bar(Spike_Touch)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%         subplot(2,1,2);
%         bar(Spike_TouchRate)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         trimtfile=strtrim(tfile);
%         figname=['Repeat3touchRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%         saveas(fig3,figname);
%         close(fig3);  
        
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) > abs(Rinterval1(1)) % ウインドウRLRの順    
        
        RLRcount=1;
        
        windowS1=RWindowS1;
        windowE1=RWindowE1;
        windowS2=LWindowS2;
        windowE2=LWindowE2;
        windowS3=RWindowS2;
        windowE3=RWindowE2;
        MoveTouchInterval1=windowS3-windowE1;
        MoveTouchInterval2=windowS2-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1; %動かすウインドウに対して幅40msのスパイクウインドウの位置決める
        
        MoveWindowArray_90=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2=0;
        TouchCountW3=0;
        TouchCountW12=0;
        TouchCountW123=0;
        TouchCountW13=0;
        TouchCountW23=0;
        SpikeCountW0=0;
        SpikeCountW1=0;
        SpikeCountW2=0;
        SpikeCountW3=0;
        SpikeCountW12=0;
        SpikeCount_W123=0;
        SpikeCountW13=0;
        SpikeCountW23=0;
        %
        WaterBreakTime=[];
        WaterRestartTime=[];
        for n=1:length(RpegTouchallWon)-1
            RpegTouchWonInterval1=RpegTouchallWon(n+1)-RpegTouchallWon(n);
            if RpegTouchWonInterval1>1000
                WaterBreakTime=[WaterBreakTime;RpegTouchallWon(n)];
                WaterRestartTime=[WaterRestartTime;RpegTouchallWon(n+1)];
            end
        end
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2=0;
        Spike_W3=0;
        Spike_W12=0;
        Spike_W123=0;
        Spike_W13=0;
        Spike_W23=0;
        WaterBreakRestartArray=[WaterBreakTime,WaterRestartTime];
            for n=1:MoveWindowArray_90
                MoveWindow1=0;
                MoveWindow2=0;
                MoveWindow3=0;
                MoveWindowSpike=0;
                MoveWindow1Start=RpegTouchallWon(1)+(n-1)*10;
                MoveWindow1End=MoveWindow1Start+180;
                MoveWindow2Start=MoveWindow1End+MoveTouchInterval2;
                MoveWindow2End=MoveWindow2Start+180;  
                MoveWindow3Start=MoveWindow1End+MoveTouchInterval1;
                MoveWindow3End=MoveWindow3Start+180;
                MoveWindowSpikeStart=MoveWindow1End+MoveSpikeInterval;
                MoveWindowSpikeEnd=MoveWindowSpikeStart+40;
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
                            a=1;
                        end
                    end
                end
                if a==0
                    for k=1:(length(SpikeArrayWon))
                        if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                            MoveWindowSpike=1;
                        end
                    end
                    for i=1:(length(RpegTouchallWon))
                        if RpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>RpegTouchallWon(i)
                            MoveWindow1=1;
                            W1TouchTime=[W1TouchTime RpegTouchallWon(i)];
                        end 
                        if RpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>RpegTouchallWon(i) 
                            MoveWindow3=1;
                            W3TouchTime=[W3TouchTime RpegTouchallWon(i)];
                        end
                    end
                    for j=1:(length(LpegTouchallWon))
                        if LpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>LpegTouchallWon(j)
                            MoveWindow2=1;
                            W2TouchTime=[W2TouchTime LpegTouchallWon(j)];
                        end 
                    end
                    %MoveWindowSpike=1だったとき、ウインドウ内で
                    if MoveWindowSpike==1
                        for k=1:(length(SpikeArrayWon))
                           if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                               if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0
                                   Spike_W0=Spike_W0+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0
                                   Spike_W1=Spike_W1+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0
                                   Spike_W2=Spike_W2+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1
                                   Spike_W3=Spike_W3+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0
                                   Spike_W12=Spike_W12+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1
                                   Spike_W123=Spike_W123+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1
                                   Spike_W13=Spike_W13+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1
                                   Spike_W23=Spike_W23+1;
                               end
                           end
                        end
                    end
                    %
                    %足取りだけでビン毎の当てはまった回数
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0
                        TouchCountW0=TouchCountW0+1;
                    end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0
                        TouchCountW1=TouchCountW1+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0
                        TouchCountW2=TouchCountW2+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1
                        TouchCountW3=TouchCountW3+1;
                    end 
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0
                        TouchCountW12=TouchCountW12+1;
                    end 
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1
                        TouchCountW123=TouchCountW123+1;
                    end         
                end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1
                        TouchCountW13=TouchCountW13+1;
                    end 
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1
                        TouchCountW23=TouchCountW23+1;
                    end
                end
                    %
                    %ビン毎に当てはまったときのうち、どれだけ発火してるか
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW0=SpikeCountW0+1;
                    end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW1=SpikeCountW1+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW2=SpikeCountW2+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW3=SpikeCountW3+1;
                    end 
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW12=SpikeCountW12+1;
                    end 
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCount_W123=SpikeCount_W123+1;
                    end  
                end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW13=SpikeCountW13+1;
                    end 
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW23=SpikeCountW23+1;
                    end
                end
                end
            end
            SpikeW123=[Spike_W0,Spike_W1,Spike_W2,Spike_W3,Spike_W12,Spike_W123,Spike_W13,Spike_W23];  %各ビン毎に当てはまったMoveWindowSpikeの回数
%             SpikeCountW123=[SpikeCountW0,SpikeCountW1,SpikeCountW2,SpikeCountW3,SpikeCountW12,SpikeCount_W123,SpikeCountW13,SpikeCountW23];
            TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
            fig2=figure;
            bar(TouchCount)
            set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat3TouchCountRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig2,figname);
            close(fig2);
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(SpikeW123)
                if TouchCount(n)~=0;
                    SpikeFR_Bin=[SpikeFR_Bin SpikeW123(n)/(TouchCount(n)*10)];
                else
                    SpikeFR_Bin=[SpikeFR_Bin TouchCount(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_Bin)
            set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat3TouchSpikeFR_BinRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
%             %%MoveWindowSpike==1のときの総発火回数を、ウインドウ当てはまったビン毎で、タッチ当てはまり・かつ発火があった(MoveWindowSpike==1)回数で割る。発火があった場合、そのビンに一回当てはまった時の発火回数
%             for n=1:length(SpikeW123)
%                 if SpikeCountW123(n)~=0;
%                     Spike_Bin=[Spike_Bin SpikeW123(n)/SpikeCountW123(n)];
%                 else
%                     Spike_Bin=[Spike_Bin SpikeCountW123(n)];
%                 end
%             end
%             fig5=figure;
%             bar(Spike_Bin)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             %ウインドウにどれだけタッチ当てはまったかの棒グラフ
%             figname=['Repeat3TouchSpikeCount_BinRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig5,figname);
%             close(fig5);
%             
%             %%ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%             for n=1:length(SpikeW123)
%                 if TouchCount(n)~=0;
%                     Spike=[Spike SpikeW123(n)/TouchCount(n)];
%                 else
%                     Spike=[Spike TouchCount(n)];
%                 end
%             end
%             fig4=figure;
%             bar(Spike)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikevsBinRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig4,figname);
%             close(fig4);  
%             
%             fig3=figure;
%             subplot(2,1,1);
%             %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時に発火してるかどーか
%             for n=1:length(SpikeCountW123)
%                 if TouchCount(n)~=0;
%                     Spike_Touch=[Spike_Touch SpikeCountW123(n)/TouchCount(n)];
%                 else
%                     Spike_Touch=[Spike_Touch TouchCount(n)];
%                 end
%             end
%             %一回ビンに当てはまった時の全体の発火回数に対する割合
%             for n=1:length(SpikeCountW123)
%                 if Spike_Touch(n)~=0;
%                     Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
%                 else
%                     Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
%                 end
%             end
%             bar(Spike_Touch)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%             subplot(2,1,2);
%             bar(Spike_TouchRate)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikeCountRLR',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig3,figname);
%             close(fig3);
            %
            FLName=['Repeat3Touch',pegpatternum,pegpatternname];
            save(FLName,'windowE1','MoveTouchInterval1','MoveTouchInterval2','MoveSpikeInterval','LpegTouchallWon','RpegTouchallWon','SpikeArrayWon'...
                ,'SpikeW123','TouchCount','SpikeFR_Bin');
    end
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) > abs(Linterval1(1)) % ウインドウLRLの順
        
        LRLcount=1;
        
        windowS1=LWindowS1;
        windowE1=LWindowE1;
        windowS2=RWindowS2;
        windowE2=RWindowE2;
        windowS3=LWindowS2;
        windowE3=LWindowE2;
        
        MoveTouchInterval1=windowS3-windowE1;
        MoveTouchInterval2=windowS2-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1;
        
        MoveWindowArray_90=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2=0;
        TouchCountW3=0;
        TouchCountW12=0;
        TouchCountW123=0;
        TouchCountW13=0;
        TouchCountW23=0;
        SpikeCountW0=0;
        SpikeCountW1=0;
        SpikeCountW2=0;
        SpikeCountW3=0;
        SpikeCountW12=0;
        SpikeCount_W123=0;
        SpikeCountW13=0;
        SpikeCountW23=0;
        
        WaterBreakTime=[];
        WaterRestartTime=[];
        for n=1:length(LpegTouchallWon)-1
            LpegTouchWonInterval1=LpegTouchallWon(n+1)-LpegTouchallWon(n);
            if LpegTouchWonInterval1>1000
                WaterBreakTime=[WaterBreakTime;LpegTouchallWon(n)];
                WaterRestartTime=[WaterRestartTime;LpegTouchallWon(n+1)];
            end
        end
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2=0;
        Spike_W3=0;
        Spike_W12=0;
        Spike_W123=0;
        Spike_W13=0;
        Spike_W23=0;
        WaterBreakRestartArray=[WaterBreakTime,WaterRestartTime];
            for n=1:MoveWindowArray_90
                MoveWindow1=0;
                MoveWindow2=0;
                MoveWindow3=0;
                MoveWindowSpike=0;
                MoveWindow1Start=LpegTouchallWon(1)+(n-1)*10;
                MoveWindow1End=MoveWindow1Start+180;
                MoveWindow2Start=MoveWindow1End+MoveTouchInterval2;
                MoveWindow2End=MoveWindow2Start+180;  
                MoveWindow3Start=MoveWindow1End+MoveTouchInterval1;
                MoveWindow3End=MoveWindow3Start+180;
                MoveWindowSpikeStart=MoveWindow1End+MoveSpikeInterval;
                MoveWindowSpikeEnd=MoveWindowSpikeStart+40;
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
                            a=1;
                        end
                    end
                end
                    if a==0
                        for k=1:(length(SpikeArrayWon))
                            if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                                MoveWindowSpike=1;
                            end
                        end
                        for i=1:(length(LpegTouchallWon))
                            if LpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>LpegTouchallWon(i)
                                MoveWindow1=1;
                                W1TouchTime=[W1TouchTime LpegTouchallWon(i)];
                            end 
                            if LpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>LpegTouchallWon(i) 
                                MoveWindow3=1;
                                W3TouchTime=[W3TouchTime LpegTouchallWon(i)];
                            end
                        end
                        for j=1:(length(RpegTouchallWon))
                            if RpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>RpegTouchallWon(j)
                                MoveWindow2=1;
                                W2TouchTime=[W2TouchTime RpegTouchallWon(j)];
                            end 
                        end
                        %MoveWindowSpike=1だったとき、ウインドウ内で
                        if MoveWindowSpike==1
                            for k=1:(length(SpikeArrayWon))
                               if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                                   if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0
                                       Spike_W0=Spike_W0+1;
                                   end
                                   if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0
                                       Spike_W1=Spike_W1+1;
                                   end
                                   if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0
                                       Spike_W2=Spike_W2+1;
                                   end
                                   if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1
                                       Spike_W3=Spike_W3+1;
                                   end
                                   if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0
                                       Spike_W12=Spike_W12+1;
                                   end
                                   if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1
                                       Spike_W123=Spike_W123+1;
                                   end
                                   if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1
                                       Spike_W13=Spike_W13+1;
                                   end
                                   if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1
                                       Spike_W23=Spike_W23+1;
                                   end
                               end
                            end
                        end
                    %
                        %足取りだけでビン毎の当てはまった回数
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0
                            TouchCountW0=TouchCountW0+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0
                            TouchCountW1=TouchCountW1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0
                            TouchCountW2=TouchCountW2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1
                            TouchCountW3=TouchCountW3+1;
                        end 
                    if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0
                            TouchCountW12=TouchCountW12+1;
                        end 
                    end
                    if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1
                            TouchCountW123=TouchCountW123+1;
                        end         
                    end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1
                            TouchCountW13=TouchCountW13+1;
                        end 
                    if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1
                            TouchCountW23=TouchCountW23+1;
                        end
                    end
                        %
                        %ビン毎に当てはまったときのうち、どれだけ発火してるか
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindowSpike==1
                            SpikeCountW0=SpikeCountW0+1;
                        end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindowSpike==1
                            SpikeCountW1=SpikeCountW1+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindowSpike==1
                            SpikeCountW2=SpikeCountW2+1;
                        end
                        if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindowSpike==1
                            SpikeCountW3=SpikeCountW3+1;
                        end 
                    if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindowSpike==1
                            SpikeCountW12=SpikeCountW12+1;
                        end 
                    end
                    if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                        if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindowSpike==1
                            SpikeCount_W123=SpikeCount_W123+1;
                        end  
                    end
                        if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindowSpike==1
                            SpikeCountW13=SpikeCountW13+1;
                        end 
                    if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                        if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindowSpike==1
                            SpikeCountW23=SpikeCountW23+1;
                        end
                    end
                    end
            end
            SpikeW123=[Spike_W0,Spike_W1,Spike_W2,Spike_W3,Spike_W12,Spike_W123,Spike_W13,Spike_W23];  %各ビン毎に当てはまったMoveWindowSpikeの回数
            SpikeCountW123=[SpikeCountW0,SpikeCountW1,SpikeCountW2,SpikeCountW3,SpikeCountW12,SpikeCount_W123,SpikeCountW13,SpikeCountW23];
            TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
            fig2=figure;
            bar(TouchCount)
            set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
            trimtfile=strtrim(tfile);
            figname=['Repeat3TouchCountLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig2,figname);
            close(fig2);  
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(SpikeW123)
                if TouchCount(n)~=0;
                    SpikeFR_Bin=[SpikeFR_Bin SpikeW123(n)/(TouchCount(n)*10)];
                else
                    SpikeFR_Bin=[SpikeFR_Bin TouchCount(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_Bin)
            set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat3TouchSpikeFR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
            FLName=['Repeat3Touch',pegpatternum,pegpatternname];
            save(FLName,'windowE1','MoveTouchInterval1','MoveTouchInterval2','MoveSpikeInterval','LpegTouchallWon','RpegTouchallWon','SpikeArrayWon'...
                ,'SpikeW123','TouchCount','SpikeFR_Bin');
%             %%MoveWindowSpike==1のときの総発火回数を、ウインドウ当てはまったビン毎で、タッチ当てはまり・かつ発火があった(MoveWindowSpike==1)回数で割る。発火があった場合、そのビンに一回当てはまった時の発火回数
%             for n=1:length(SpikeW123)
%                 if SpikeCountW123(n)~=0;
%                     Spike_Bin=[Spike_Bin SpikeW123(n)/SpikeCountW123(n)];
%                 else
%                     Spike_Bin=[Spike_Bin SpikeCountW123(n)];
%                 end
%             end
%             fig5=figure;
%             bar(Spike_Bin)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             %ウインドウにどれだけタッチ当てはまったかの棒グラフ
%             figname=['Repeat3TouchSpikeCount_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig5,figname);
%             close(fig5);
%             %%ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%             for n=1:length(SpikeW123)
%                 if TouchCount(n)~=0;
%                     Spike=[Spike SpikeW123(n)/TouchCount(n)];
%                 else
%                     Spike=[Spike TouchCount(n)];
%                 end
%             end
%             fig4=figure;
%             bar(Spike)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikevsBinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig4,figname);
%             close(fig4);  
%             fig3=figure;
%             subplot(2,1,1);
% %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時に発火してるかどーか
%             for n=1:length(SpikeCountW123)
%                 if TouchCount(n)~=0;
%                     Spike_Touch=[Spike_Touch SpikeCountW123(n)/TouchCount(n)];
%                 else
%                     Spike_Touch=[Spike_Touch TouchCount(n)];
%                 end
%             end
%             %一回ビンに当てはまった時の全体の発火回数に対する割合
%             for n=1:length(SpikeCountW123)
%                 if Spike_Touch(n)~=0;
%                     Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
%                 else
%                     Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
%                 end
%             end
%             bar(Spike_Touch)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%             subplot(2,1,2);
%             bar(Spike_TouchRate)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikeCountLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig3,figname);
%             close(fig3);
            
%         CountW0=0;
%         CountW1=0;
%         CountW2=0;
%         CountW3=0;
%         CountW12=0;
%         CountW13=0;
%         CountW23=0;
%         CountW123=0;
%         
%         for n=1:(length(SpikeArrayWon))
%             W1=0;
%             W2=0;
%             W3=0;
%             W1TouchTime=[];
%             W2TouchTime=[];
%             W3TouchTime=[];
%             for i=1:(length(LpegTouchallWon))
%                 if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>LpegTouchallWon(i)
%                     W1=1;
%                     W1TouchTime=[W1TouchTime LpegTouchallWon(i)];
%                 end
%                 if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>LpegTouchallWon(i) 
%                     W3=1;
%                     W3TouchTime=[W3TouchTime LpegTouchallWon(i)];
%                 end
%             end
%             for j=1:(length(RpegTouchallWon))
%                 if  RpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>RpegTouchallWon(j)
%                     W2=1;
%                     W2TouchTime=[W2TouchTime RpegTouchallWon(j)];
%                 end
%             end
%             if length(W1TouchTime)<2 && length(W2TouchTime)<2 && length(W3TouchTime)<2
%                     if W1==0 & W2==0 & W3==0
%                         CountW0=CountW0+1;
%                     end
%                     if W1==1 & W2==0 & W3==0
%                         CountW1=CountW1+1;
%                     end
%                     if W1==0 & W2==1 & W3==0
%                         CountW2=CountW2+1;
%                     end
%                     if W1==0 & W2==0 & W3==1
%                         CountW3=CountW3+1;
%                     end
%                 if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
%                     if W1==1 & W2==1 & W3==0
%                         CountW12=CountW12+1;
%                     end
%                 end
%                     if W1==1 & W2==0 & W3==1
%                         CountW13=CountW13+1;
%                     end
%                 if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
%                     if W1==0 & W2==1 & W3==1
%                         CountW23=CountW23+1;
%                     end
%                 end
%                 if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
%                     if W1==1 & W2==1 & W3==1
%                         CountW123=CountW123+1;
%                     end
%                 end
%             end
%         end
%         fig2=figure;
%         TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
%         bar(TouchCount)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         trimtfile=strtrim(tfile);
%         figname=['Repeat3TouchCountLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%         saveas(fig2,figname);
%         close(fig2);  
%         
%         fig3=figure;
%         subplot(2,1,1);
%         W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
%         %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%         for n=1:length(W123)
%             if TouchCount(n)~=0;
%                 Spike_Touch=[Spike_Touch W123(n)/TouchCount(n)];
%             else
%                 Spike_Touch=[Spike_Touch TouchCount(n)];
%             end
%         end
%         %一回ビンに当てはまった時の全体の発火回数に対する割合
%         for n=1:length(W123)
%             if Spike_Touch(n)~=0;
%                 Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
%             else
%                 Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
%             end
%         end
%         bar(Spike_Touch)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%         subplot(2,1,2);
%         bar(Spike_TouchRate)
%         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});            
%         trimtfile=strtrim(tfile);
%         figname=['Repeat3touchLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%         saveas(fig3,figname);
%         close(fig3);
     elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) < abs(Rinterval1(1)) % ウインドウLRLの順
         
         LRLcount=1;
         
        windowS1=LWindowS1;
        windowE1=LWindowE1;
        windowS2=RWindowS1;
        windowE2=RWindowE1;
        windowS3=LWindowS2;
        windowE3=LWindowE2;
        
        MoveTouchInterval1=windowS3-windowE1;
        MoveTouchInterval2=windowS2-windowE1;
        MoveSpikeInterval=SpikeWindowS-windowE1;
        
        MoveWindowArray_90=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;
        
        TouchCountW0=0;
        TouchCountW1=0;
        TouchCountW2=0;
        TouchCountW3=0;
        TouchCountW12=0;
        TouchCountW123=0;
        TouchCountW13=0;
        TouchCountW23=0;
        SpikeCountW0=0;
        SpikeCountW1=0;
        SpikeCountW2=0;
        SpikeCountW3=0;
        SpikeCountW12=0;
        SpikeCount_W123=0;
        SpikeCountW13=0;
        SpikeCountW23=0;
        
        WaterBreakTime=[];
        WaterRestartTime=[];
        for n=1:length(LpegTouchallWon)-1
            LpegTouchWonInterval1=LpegTouchallWon(n+1)-LpegTouchallWon(n);
            if LpegTouchWonInterval1>1000
                WaterBreakTime=[WaterBreakTime;LpegTouchallWon(n)];
                WaterRestartTime=[WaterRestartTime;LpegTouchallWon(n+1)];
            end
        end
        Spike_W0=0;
        Spike_W1=0;
        Spike_W2=0;
        Spike_W3=0;
        Spike_W12=0;
        Spike_W123=0;
        Spike_W13=0;
        Spike_W23=0;
        WaterBreakRestartArray=[WaterBreakTime,WaterRestartTime];
            for n=1:MoveWindowArray_90
                MoveWindow1=0;
                MoveWindow2=0;
                MoveWindow3=0;
                MoveWindowSpike=0;
                MoveWindow1Start=LpegTouchallWon(1)+(n-1)*10;
                MoveWindow1End=MoveWindow1Start+180;
                MoveWindow2Start=MoveWindow1End+MoveTouchInterval2;
                MoveWindow2End=MoveWindow2Start+180;  
                MoveWindow3Start=MoveWindow1End+MoveTouchInterval1;
                MoveWindow3End=MoveWindow3Start+180;
                MoveWindowSpikeStart=MoveWindow1End+MoveSpikeInterval;
                MoveWindowSpikeEnd=MoveWindowSpikeStart+40;
                W1TouchTime=[];
                W2TouchTime=[];
                W3TouchTime=[];
                a=0;
                if ~isempty(WaterBreakRestartArray) 
                    for k=1:length(WaterBreakRestartArray(:,1))
                        if WaterBreakRestartArray(k,1)<MoveWindow1Start && MoveWindow3End<WaterBreakRestartArray(k,2)
                            a=1;
                        end
                    end
                end
                if a==0
                    for k=1:(length(SpikeArrayWon))
                        if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                            MoveWindowSpike=1;
                        end
                    end
                    for i=1:(length(LpegTouchallWon))
                        if LpegTouchallWon(i)>MoveWindow1Start && MoveWindow1End>LpegTouchallWon(i)
                            MoveWindow1=1;
                            W1TouchTime=[W1TouchTime LpegTouchallWon(i)];
                        end 
                        if LpegTouchallWon(i)>MoveWindow3Start && MoveWindow3End>LpegTouchallWon(i) 
                            MoveWindow3=1;
                            W3TouchTime=[W3TouchTime LpegTouchallWon(i)];
                        end
                    end
                    for j=1:(length(RpegTouchallWon))
                        if RpegTouchallWon(j)>MoveWindow2Start && MoveWindow2End>RpegTouchallWon(j)
                            MoveWindow2=1;
                            W2TouchTime=[W2TouchTime RpegTouchallWon(j)];
                        end 
                    end
                    %MoveWindowSpike=1だったとき、ウインドウ内で
                    if MoveWindowSpike==1
                        for k=1:(length(SpikeArrayWon))
                           if SpikeArrayWon(k)>MoveWindowSpikeStart && MoveWindowSpikeEnd>SpikeArrayWon(k)
                               if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0
                                   Spike_W0=Spike_W0+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0
                                   Spike_W1=Spike_W1+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0
                                   Spike_W2=Spike_W2+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1
                                   Spike_W3=Spike_W3+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0
                                   Spike_W12=Spike_W12+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1
                                   Spike_W123=Spike_W123+1;
                               end
                               if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1
                                   Spike_W13=Spike_W13+1;
                               end
                               if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1
                                   Spike_W23=Spike_W23+1;
                               end
                           end
                        end
                    end
                    %
                    %足取りだけでビン毎の当てはまった回数
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0
                        TouchCountW0=TouchCountW0+1;
                    end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0
                        TouchCountW1=TouchCountW1+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0
                        TouchCountW2=TouchCountW2+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1
                        TouchCountW3=TouchCountW3+1;
                    end 
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0
                        TouchCountW12=TouchCountW12+1;
                    end 
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1
                        TouchCountW123=TouchCountW123+1;
                    end         
                end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1
                        TouchCountW13=TouchCountW13+1;
                    end 
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1
                        TouchCountW23=TouchCountW23+1;
                    end
                end
                        %
                    %ビン毎に当てはまったときのうち、どれだけ発火してるか
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW0=SpikeCountW0+1;
                    end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW1=SpikeCountW1+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW2=SpikeCountW2+1;
                    end
                    if MoveWindow1==0 && MoveWindow2==0 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW3=SpikeCountW3+1;
                    end 
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==0 && MoveWindowSpike==1
                        SpikeCountW12=SpikeCountW12+1;
                    end 
                end
                if length(W1TouchTime)==1 && length(W2TouchTime)==1 && length(W3TouchTime)==1 && W1TouchTime(1)<W2TouchTime(1) && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==1 && MoveWindow2==1 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCount_W123=SpikeCount_W123+1;
                    end  
                end
                    if MoveWindow1==1 && MoveWindow2==0 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW13=SpikeCountW13+1;
                    end 
                if length(W2TouchTime)==1 && length(W3TouchTime)==1 && W2TouchTime(1)<W3TouchTime(1)
                    if MoveWindow1==0 && MoveWindow2==1 && MoveWindow3==1 && MoveWindowSpike==1
                        SpikeCountW23=SpikeCountW23+1;
                    end
                end
                end
            end
            SpikeW123=[Spike_W0,Spike_W1,Spike_W2,Spike_W3,Spike_W12,Spike_W123,Spike_W13,Spike_W23];  %各ビン毎に当てはまったMoveWindowSpikeの回数
            SpikeCountW123=[SpikeCountW0,SpikeCountW1,SpikeCountW2,SpikeCountW3,SpikeCountW12,SpikeCount_W123,SpikeCountW13,SpikeCountW23];
            TouchCount=[TouchCountW0,TouchCountW1,TouchCountW2,TouchCountW3,TouchCountW12,TouchCountW123,TouchCountW13,TouchCountW23];
            fig2=figure;
            bar(TouchCount)
            set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
            trimtfile=strtrim(tfile);
            figname=['Repeat3TouchCountLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig2,figname);
            close(fig2);  
            %発火頻度を出す。各ビン毎に、スパイクの総回数を、トータル時間(足取り当てはまった回数×10ms)で割る。
            for n=1:length(SpikeW123)
                if TouchCount(n)~=0;
                    SpikeFR_Bin=[SpikeFR_Bin SpikeW123(n)/(TouchCount(n)*10)];
                else
                    SpikeFR_Bin=[SpikeFR_Bin TouchCount(n)];
                end
            end
            fig6=figure;
            bar(SpikeFR_Bin)
            set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
            trimtfile=strtrim(tfile);
            %ウインドウにどれだけタッチ当てはまったかの棒グラフ
            figname=['Repeat3TouchSpikeFR_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
            saveas(fig6,figname);
            close(fig6);
%             
%             %%MoveWindowSpike==1のときの総発火回数を、ウインドウ当てはまったビン毎で、タッチ当てはまり・かつ発火があった(MoveWindowSpike==1)回数で割る。発火があった場合、そのビンに一回当てはまった時の発火回数
%             for n=1:length(SpikeW123)
%                 if SpikeCountW123(n)~=0;
%                     Spike_Bin=[Spike_Bin SpikeW123(n)/SpikeCountW123(n)];
%                 else
%                     Spike_Bin=[Spike_Bin SpikeCountW123(n)];
%                 end
%             end
%             fig5=figure;
%             bar(Spike_Bin)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             %ウインドウにどれだけタッチ当てはまったかの棒グラフ
%             figname=['Repeat3TouchSpikeCount_BinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig5,figname);
%             close(fig5);
%             %%ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時の発火回数
%             for n=1:length(SpikeW123)
%                 if TouchCount(n)~=0;
%                     Spike=[Spike SpikeW123(n)/TouchCount(n)];
%                 else
%                     Spike=[Spike TouchCount(n)];
%                 end
%             end
%             fig4=figure;
%             bar(Spike)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikevsBinLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig4,figname);
%             close(fig4);  
%             
%             fig3=figure;
%             subplot(2,1,1);
%             %ウインドウ当てはまったビン毎に、タッチ当てはまった回数で割る。そのビンに一回当てはまった時に発火してるかどーか
%             for n=1:length(SpikeCountW123)
%                 if TouchCount(n)~=0;
%                     Spike_Touch=[Spike_Touch SpikeCountW123(n)/TouchCount(n)];
%                 else
%                     Spike_Touch=[Spike_Touch TouchCount(n)];
%                 end
%             end
%             %一回ビンに当てはまった時の全体の発火回数に対する割合
%             for n=1:length(SpikeCountW123)
%                 if Spike_Touch(n)~=0;
%                     Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)/sum(Spike_Touch)];
%                 else
%                     Spike_TouchRate=[Spike_TouchRate Spike_Touch(n)];
%                 end
%             end
%             bar(Spike_Touch)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%             subplot(2,1,2);
%             bar(Spike_TouchRate)
%             set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%             trimtfile=strtrim(tfile);
%             figname=['Repeat3TouchSpikeCountLRL',trimFolder2,trimtfile,pegpatternum,pegpatternname,'.bmp'];
%             saveas(fig3,figname);
%             close(fig3);
        FLName=['Repeat3Touch',pegpatternum,pegpatternname];
        save(FLName,'windowE1','MoveTouchInterval1','MoveTouchInterval2','MoveSpikeInterval','LpegTouchallWon','RpegTouchallWon','SpikeArrayWon'...
                ,'SpikeW123','TouchCount','SpikeFR_Bin');
    end
end
                
%                 if TouchArray1(1)==RlocsInterval(q) & TouchArray1(2)==LlocsInterval(r) & TouchArray1(3)==RlocsInterval(p)|...  %ウインドウRLRの順
%                    -TouchArray1(1)==RlocsInterval(q) & -TouchArray1(2)==LlocsInterval(r) & -TouchArray1(3)==RlocsInterval(p)|...
%                    -TouchArray1(1)==LlocsInterval(r) & TouchArray1(2)==RlocsInterval(q) & -TouchArray1(3)==RlocsInterval(p)|...
%                    TouchArray1(1)==LlocsInterval(r) & TouchArray1(2)==RlocsInterval(q) & -TouchArray1(3)==RlocsInterval(p)|...
%                    TouchArray1(1)==RlocsInterval(q) & -TouchArray1(2)==LlocsInterval(r) & -TouchArray1(3)==RlocsInterval(p)|...
%                    -TouchArray1(1)==LlocsInterval(r) & -TouchArray1(2)==RlocsInterval(q) & TouchArray1(3)==RlocsInterval(p)|...
%                    TouchArray1(1)==LlocsInterval(r) & -TouchArray1(2)==RlocsInterval(q) & TouchArray1(3)==RlocsInterval(p)|...
%                    -TouchArray1(1)==RlocsInterval(q) & TouchArray1(2)==LlocsInterval(r) & TouchArray1(3)==RlocsInterval(p)
            
%                     windowS1=RWindowS1;
%                     windowE1=RWindowE1;
%                     windowS2=LWindowS1;
%                     windowE2=LWindowE1;
%                     windowS3=RWindowS2;
%                     windowE3=RWindowE2;
    
%                     W1=0;
%                     W2=0;
%                     W3=0;
%                     CountW0=0;
%                     CountW1=0;
%                     CountW2=0;
%                     CountW3=0;
%                     CountW12=0;
%                     CountW13=0;
%                     CountW23=0;
%                     CountW123=0;
%                     W0rate=0;
%                     W1rate=0;
%                     W2rate=0;
%                     W3rate=0;
%                     W12rate=0;
%                     w123rate=0;
%                     W13rate=0;
%                     W23rate=0;
%                     
%                         for n=1:(length(SpikeArrayWon))
%                             W1=0;
%                             W2=0;
%                             W3=0;
%                                 for i=1:(length(RpegTouchallWon))
%                                     if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>RpegTouchallWon(i)
%                                         W1=1;
%                                     end
%                                     if  RpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>RpegTouchallWon(i) 
%                                         W3=1;
%                                     end
%                                 end
%                                 for j=1:(length(LpegTouchallWon))
%                                     if  LpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>LpegTouchallWon(j)
%                                         W2=1;
%                                     end
%                                 end
%     
%                                 if W1==0 & W2==0 & W3==0
%                                     CountW0=CountW0+1;
%                                 end
%                                 if W1==1 & W2==0 & W3==0
%                                     CountW1=CountW1+1;
%                                 end
%                                 if W1==0 & W2==1 & W3==0
%                                     CountW2=CountW2+1;
%                                 end
%                                 if W1==0 & W2==0 & W3==1
%                                     CountW3=CountW3+1;
%                                 end
%                                 if W1==1 & W2==1 & W3==0
%                                     CountW12=CountW12+1;
%                                 end
%                                 if W1==1 & W2==0 & W3==1
%                                     CountW13=CountW13+1;
%                                 end
%                                 if W1==0 & W2==1 & W3==1
%                                     CountW23=CountW23+1;
%                                 end
%                                 if W1==1 & W2==1 & W3==1
%                                     CountW123=CountW123+1;
%                                 end
%                         end
%                         fig2=figure;
%                         subplot(2,1,1);
%                         W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
%                         bar(W123)
%                         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%                         % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%                         W0rate=CountW0/sum(W123);
%                         W1rate=CountW1/sum(W123);
%                         W2rate=CountW2/sum(W123);
%                         W3rate=CountW3/sum(W123);
%                         W12rate=CountW12/sum(W123);
%                         w123rate=CountW123/sum(W123);
%                         W13rate=CountW13/sum(W123);
%                         W23rate=CountW23/sum(W123);
%                         W123rate=[W0rate,W1rate,W2rate,W3rate,W12rate,w123rate,W13rate,W23rate];
%                         subplot(2,1,2);
%                         bar(W123rate)
%                         set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%                         
%                         trimtfile=strtrim(tfile);
%                         figname=['Repeat3touchRLR',trimFolder2,trimtfile,pegpatternname,'.bmp'];
%                         saveas(fig2,figname);
%                         close(fig2);
% %                 end
% %             end
% %         end
% %     end
%     for p=1:(length(LlocsInterval))    
%         for q=1:(length(LlocsInterval))
%             for r=1:(length(RlocsInterval))
%                 if TouchArray1(1)==LlocsInterval(q) & TouchArray1(2)==RlocsInterval(r) & TouchArray1(3)==LlocsInterval(p)|...  %ウインドウLRLの順
%                    -TouchArray1(1)==LlocsInterval(q) & -TouchArray1(2)==RlocsInterval(r) & -TouchArray1(3)==LlocsInterval(p)|...
%                    -TouchArray1(1)==RlocsInterval(r) & TouchArray1(2)==LlocsInterval(q) & -TouchArray1(3)==LlocsInterval(p)|...
%                    TouchArray1(1)==RlocsInterval(r) & TouchArray1(2)==LlocsInterval(q) & -TouchArray1(3)==LlocsInterval(p)|...
%                    TouchArray1(1)==LlocsInterval(q) & -TouchArray1(2)==RlocsInterval(r) & -TouchArray1(3)==LlocsInterval(p)|...
%                    -TouchArray1(1)==RlocsInterval(r) & -TouchArray1(2)==LlocsInterval(q) & TouchArray1(3)==LlocsInterval(p)|...
%                    TouchArray1(1)==RlocsInterval(r) & -TouchArray1(2)==LlocsInterval(q) & TouchArray1(3)==LlocsInterval(p)|...
%                    -TouchArray1(1)==LlocsInterval(q) & TouchArray1(2)==RlocsInterval(r) & TouchArray1(3)==LlocsInterval(p)    
%                         
%                     windowS1=LWindowS1; 
%                     windowE1=LWindowE1;
%                     windowS2=RWindowS1;
%                     windowE2=RWindowE1;
%                     windowS3=LWindowS2;
%                     windowE3=LWindowE2;
%                     MoveTouchInterval=LWindowS2-LWindowE1;
% 
%                     MoveWindowArray_90=linspace(0,18000,101);
%                     MoveWindowL1=0;
%                     MoveWindowL2=0;
%                     TouchL0_90W12=0;
%                     TouchL1_90W12=0;
%                     TouchL2_90W12=0;
%                     TouchL12_90W12=0;
%                     
%                     for n=1:(length(MoveWindowArray_90))
%                         MoveWindowL1=0;
%                         MoveWindowL2=0;
%                         MoveL1Start=MoveWindowArray_90(n);
%                         MoveL1End=MoveL1Start+180;
%                         MoveL2Start=MoveL1End+MoveTouchInterval;
%                         MoveL2End=MoveL2Start+180;
%                         
%                         for i=1:(length(LpegTouchallWon))
%                             if  LpegTouchallWon(i)>MoveL1Start & MoveL1End>LpegTouchallWon(i)
%                                 MoveWindowL1=1;
%                             end 
%                             if  LpegTouchallWon(i)>preWS2_90 & preWE2_90>LpegTouchallWon(i) 
%                                 MoveWindowL2=1;
%                             end
%                         end
%                         if MoveWindowL1==0 & MoveWindowL2==0
%                            TouchL0_90W12=TouchL0_90W12+1;
%                         end
%                         if MoveWindowL1==1 & MoveWindowL2==0
%                            TouchL1_90W12=TouchL1_90W12+1;
%                         end
%                         if MoveWindowL1==0 & MoveWindowL2==1
%                            TouchL2_90W12=TouchL2_90W12+1;
%                         end
%                         if MoveWindowL1==1 & MoveWindowL2==1
%                            TouchL12_90W12=TouchL12_90W12+1;
%                         end 
%                         
%                         
%                     end
%                    
%                     
%                     
%                     W1=0;
%                     W2=0;
%                     W3=0;
%                     CountW0=0;
%                     CountW1=0;
%                     CountW2=0;
%                     CountW3=0;
%                     CountW12=0;
%                     CountW13=0;
%                     CountW23=0;
%                     CountW123=0;
%                     W0rate=0;
%                     W1rate=0;
%                     W2rate=0;
%                     W3rate=0;
%                     W12rate=0;
%                     w123rate=0;
%                     W13rate=0;
%                     W23rate=0;
%                         for n=1:(length(SpikeArrayWon))
%                             W1=0;
%                             W2=0;
%                             W3=0;
%                                 for i=1:(length(LpegTouchallWon))
%                                     if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS1&SpikeArrayWon(n)+windowE1>LpegTouchallWon(i)
%                                         W1=1;
%                                     end
%                                     if  LpegTouchallWon(i)>SpikeArrayWon(n)+windowS3&SpikeArrayWon(n)+windowE3>LpegTouchallWon(i) 
%                                         W3=1;
%                                     end
%                                 end
%                                 for j=1:(length(RpegTouchallWon))
%                                     if  RpegTouchallWon(j)>SpikeArrayWon(n)+windowS2&SpikeArrayWon(n)+windowE2>RpegTouchallWon(j)
%                                         W2=1;
%                                     end
%                                 end
% 
%                                 if W1==0 & W2==0 & W3==0
%                                     CountW0=CountW0+1;
%                                 end
%                                 if W1==1 & W2==0 & W3==0
%                                     CountW1=CountW1+1;
%                                 end
%                                 if W1==0 & W2==1 & W3==0
%                                     CountW2=CountW2+1;
%                                 end
%                                 if W1==0 & W2==0 & W3==1
%                                     CountW3=CountW3+1;
%                                 end
%                                 if W1==1 & W2==1 & W3==0
%                                     CountW12=CountW12+1;
%                                 end
%                                 if W1==1 & W2==0 & W3==1
%                                     CountW13=CountW13+1;
%                                 end
%                                 if W1==0 & W2==1 & W3==1
%                                     CountW23=CountW23+1;
%                                 end
%                                 if W1==1 & W2==1 & W3==1
%                                     CountW123=CountW123+1;
%                                 end
%                         end
%                     fig2=figure;
%                     subplot(2,1,1);
%                     W123=[CountW0,CountW1,CountW2,CountW3,CountW12,CountW123,CountW13,CountW23];
%                     bar(W123)
%                     set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%                     % xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')
%                     W0rate=CountW0/sum(W123);
%                     W1rate=CountW1/sum(W123);
%                     W2rate=CountW2/sum(W123);
%                     W3rate=CountW3/sum(W123);
%                     W12rate=CountW12/sum(W123);
%                     w123rate=CountW123/sum(W123);
%                     W13rate=CountW13/sum(W123);
%                     W23rate=CountW23/sum(W123);
%                     W123rate=[W0rate,W1rate,W2rate,W3rate,W12rate,w123rate,W13rate,W23rate];
%                     subplot(2,1,2);
%                     bar(W123rate)
%                     set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
%                     
%                     trimtfile=strtrim(tfile);
%                     figname=['Repeat3touchLRL',trimFolder2,trimtfile,pegpatternname,'.bmp'];
%                     saveas(fig2,figname);
%                     close(fig2);
%                 end
%             end
%         end
%     end
% end