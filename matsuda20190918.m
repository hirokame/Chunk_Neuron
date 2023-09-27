function matsuda20190918
global RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 Spike_TouchRate IntervalCount FRvsIntervalTouchRate PhaseCountRate...
    TouchCount PeakInterval PeakPhaseCount pegpatternum RLRcount LRLcount ...
    LtTouchCount LtSpike_TouchRate Spike Spike_Bin SpikeFR_Bin LtSpikeFR_Bin RtTouchCount RtSpikeFR_Bin RtSpike_TouchRate...
    TouchCountW12345 SpikeFR_5Touch_Bin RLRLRcount LRLRLcount RtIntervalAverageTouchCount RtIntervalAverageSpikeFR_Bin LtIntervalAverageTouchCount LtIntervalAverageSpikeFR_Bin...
    LtFR_Array RtFR_Array LtSpike1FR_Bin LtSpike2FR_Bin LtSpike3FR_Bin LtSpike4FR_Bin LtTouchCount1 LtTouchCount2 LtTouchCount3 LtTouchCount4...
    RtTouchCount1 RtTouchCount2 RtTouchCount3 RtTouchCount4 RtSpike1FR_Bin RtSpike2FR_Bin RtSpike3FR_Bin RtSpike4FR_Bin...
    Spike1FR_5Touch_Bin Spike2FR_5Touch_Bin Spike3FR_5Touch_Bin Spike4FR_5Touch_Bin tTouchCount1 tTouchCount2 tTouchCount3 tTouchCount4


% デスクトップにフォルダー作る
cd('C:\Users\C238\Desktop')
Folder=['touchcellLtRt_matsuda'];
mkdir(Folder)
% 新たなフォルダーで足取り反応細胞見つけて番号付けていく
path=['G:\CheetahWRLV20200121'];
cd(path)
cellnum=1;
% RLRtrial=0;
% LRLtrial=0;
% RLRLRtrial=0;
% LRLRLtrial=0;
patternnum=1;

% Repeat3TouchCountArray=[];
% Repeat3TouchCountMeanArray=[];
% Repeat3TouchCountStdArray=[];
% 
% Repeat3TouchSpikeFR_BinArray=[];
% Repeat3TouchSpikeFR_BinMeanArray=[];
% Repeat3TouchSpikeFR_BinStdArray=[];

Repeat5TouchCountArray=[];
Repeat5TouchCount1Array=[];
Repeat5TouchCount2Array=[];
Repeat5TouchCount3Array=[];
Repeat5TouchCount4Array=[];

Repeat5TouchCountMeanArray=[];
Repeat5TouchCountStdArray=[];

Repeat5TouchSpikeFR_BinArray=[];
Repeat5TouchSpike1FR_BinArray=[];
Repeat5TouchSpike2FR_BinArray=[];
Repeat5TouchSpike3FR_BinArray=[];
Repeat5TouchSpike4FR_BinArray=[];

Repeat5TouchSpikeFR_BinMeanArray=[];
Repeat5TouchSpikeFR_BinStdArray=[];

LtRepeat5TouchCountArray=[];
LtRepeat5TouchCount1Array=[];
LtRepeat5TouchCount2Array=[];
LtRepeat5TouchCount3Array=[];
LtRepeat5TouchCount4Array=[];

LtRepeat5TouchCountMeanArray=[];
LtRepeat5TouchCountStdArray=[];

% LtRepeat5TouchSpikeRateArray=[];
% LtRepeat5TouchSpikeRateMeanArray=[];
% LtRepeat5TouchSpikeRateStdArray=[];

LtRepeat5TouchSpikeFR_BinArray=[];
LtRepeat5TouchSpike1FR_BinArray=[];
LtRepeat5TouchSpike2FR_BinArray=[];
LtRepeat5TouchSpike3FR_BinArray=[];
LtRepeat5TouchSpike4FR_BinArray=[];

LtRepeat5TouchSpikeFR_BinMeanArray=[];
LtRepeat5TouchSpikeFR_BinStdArray=[];

RtRepeat5TouchCountArray=[];
RtRepeat5TouchCount1Array=[];
RtRepeat5TouchCount2Array=[];
RtRepeat5TouchCount3Array=[];
RtRepeat5TouchCount4Array=[];

RtRepeat5TouchCountMeanArray=[];
RtRepeat5TouchCountStdArray=[];

% RtRepeat5TouchSpikeRateArray=[];
% RtRepeat5TouchSpikeRateMeanArray=[];
% RtRepeat5TouchSpikeRateStdArray=[];

RtRepeat5TouchSpikeFR_BinArray=[];
RtRepeat5TouchSpike1FR_BinArray=[];
RtRepeat5TouchSpike2FR_BinArray=[];
RtRepeat5TouchSpike3FR_BinArray=[];
RtRepeat5TouchSpike4FR_BinArray=[];


RtRepeat5TouchSpikeFR_BinMeanArray=[];
RtRepeat5TouchSpikeFR_BinStdArray=[];

% LtIntervalAverageTouchCountArray=[];
% LtIntervalAverageTouchCountMeanArray=[];
% LtIntervalAverageTouchCountStdArray=[];
% 
% LtIntervalAverageSpikeFR_BinArray=[];
% LtIntervalAverageTouchSpikeFR_BinMeanArray=[];
% LtIntervalAverageTouchSpikeFR_BinStdArray=[];
% 
% RtIntervalAverageTouchCountArray=[];
% RtIntervalAverageTouchCountMeanArray=[];
% RtIntervalAverageTouchCountStdArray=[];
% 
% RtIntervalAverageSpikeFR_BinArray=[];
% RtIntervalAverageTouchSpikeFR_BinMeanArray=[];
% RtIntervalAverageTouchSpikeFR_BinStdArray=[];
% 
% Ltseq5TouchFRArray=[];
% Rtseq5TouchFRArray=[];
% 
% PeakIntervalArray=[];
% 
% IntervalTouchRateArray=[];
% IntervalTouchRateMeanArray=[];
% IntervalTouchRateStdArray=[];
% 
% FRvsIntervalTouchRateArray=[];
% FRvsIntervalTouchRateMeanArray=[];
% FRvsIntervalTouchRateStdArray=[];
% 
% PhaseCountRateArray=[];
% PhaseCountRateMeanArray=[];
% PhaseCountRateStdArray=[];
% 
% PeakPhaseCountArray=[];
% PhaseCountRateSumArray=[];
% PhaseCountRateStdArray=[];

LS1=ls;
for i=1:length(LS1(:,1)) %1列目で固定、行を動かす
   trimFolder=strtrim(LS1(i,:));
   if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && isempty(strfind(trimFolder,'.bmp')) && ~strcmp(trimFolder,'CCSfigure') && isempty(strfind(trimFolder,'SpikeFormAnalysis')) && isempty(strfind(trimFolder,'Count')) && isempty(strfind(trimFolder,'widthPtoT')) && ~strcmp(trimFolder,'CCSfigure-Lt') && ~strcmp(trimFolder,'CCSfigure-RLt') && ~strcmp(trimFolder,'CCSfigure-Rt')
       CDFolder=[path,'\',trimFolder]; %cdフォルダ変更C:\Users\C238\Desktop\CheetahWRLV20180729Part1\trimFolder
      cd(CDFolder);
      LS2=ls;
      for j=1:length(LS2(:,1))
        trimFolder2=strtrim(LS2(j,:));
        if length(trimFolder2)>4 && ~strcmp(trimFolder2(end-3:end),'.mat');
            CDFolder2=[CDFolder,'\',trimFolder2];  %C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51
            pegpattern=[];
            cd(CDFolder2)
            LS3=ls;
            for c=1:length(LS3(:,1))
               trimLS3=strtrim(LS3(c,:));
               if length(trimLS3)>10 && strcmp(trimLS3(end-3:end),'.mat');
                    pegpattern=[pegpattern;trimLS3]; %ペグパターンを読み込む
               end
               
            end
            TouchCellName=[]; 
            CDFolder3=[CDFolder2,'\CellCell'];%C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51\CellCell
            cd(CDFolder3)
            LSC=ls;
            for x=1:length(LSC(:,1));
                trimCellFolder=strtrim(LSC(x,:));
                if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                CDFolder5=[CDFolder3,'\',trimCellFolder]; %C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51\CellCell\Sc2_SS_01
                cd(CDFolder5)
                load('response.mat')
                if length(strfind(response,'Rt'))>0 && length(strfind(response,'Lt'))>0; %タッチに反応する細胞見つける
                   TouchCellName=[TouchCellName;trimCellFolder]; 
                end
                end
            end
            
            
            if ~isempty(TouchCellName);
                for k=1:length(TouchCellName(:,1));
                    SpikeArray=[];
                    tfile=[strtrim(TouchCellName(k,:)),'.t'];
%                     SpikeArray=GetSpikeAll(CDFolder2,tfile);
                    SpikeArrayWon=[];
                    cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
                    Foldercell=num2str(cellnum); %num2strは数値を
                    mkdir(Foldercell);
                    for d=1:length(pegpattern(:,1));
                    if ~isempty(strfind(pegpattern(d,:),'_C'));
                        CDFolder5=[CDFolder2,'\',pegpattern(d,(1:end-4))];
                        cd(CDFolder5)
                        file=['Bdata.mat'];
                        load(file);
                        SpikeArray=GetSpikeAll(CDFolder2,tfile);
                        SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                        %WaterOnのときのみのスパイク
                        if ~isempty(SpikeArray)
                        SpikeWon=ones(1,length(SpikeArray));
                        for k=1:length(SpikeArray)
                            if OnWater(SpikeArray(k))==0
                                SpikeWon(k)=0;
                            end
                        end
                        SpikeArrayWon=SpikeArray.*SpikeWon;
                        SpikeArrayWon(SpikeArrayWon==0)=[];
                        
                        end
                        %WaterOnのときのみのRpegTouchall
                        if ~isempty(RpegTouchall)
                        RTWon=ones(1,length(RpegTouchall));
                        for k=1:length(RpegTouchall)
                            if OnWater(RpegTouchall(k))==0
                                RTWon(k)=0;
                            end
                        end
                        RpegTouchallWon=RpegTouchall.*RTWon;
                        RpegTouchallWon(RpegTouchallWon==0)=[];
                        RpegTouchallWoff=RpegTouchall.*not(RTWon);
                        RpegTouchallWoff(RpegTouchallWoff==0)=[];
                        else
                        RpegTouchallWon=0;
                         RpegTouchallWoff=0;
                        end
                        %WaterOnのときのみのLpegTouchall
                        if ~isempty(LpegTouchall)
                         LTWon=ones(1,length(LpegTouchall));
                            for k=1:length(LpegTouchall)
                                if OnWater(LpegTouchall(k))==0
                                    LTWon(k)=0;
                                end
                            end
                            LpegTouchallWon=LpegTouchall.*LTWon;
                            LpegTouchallWon(LpegTouchallWon==0)=[];
                            LpegTouchallWoff=LpegTouchall.*not(LTWon);
                            LpegTouchallWoff(LpegTouchallWoff==0)=[];
                        else
                            LpegTouchallWon=0;
                            LpegTouchallWoff=0;
                        end
                        pegpatternname=pegpattern(d,(end-8:end-4));
                        pegpatternum=pegpattern(d,(1:5));
                        Folder6=['C:\Users\C238\Desktop\touchcellLtRt_matsuda','\',Foldercell]
                        cd(Folder6)
%                         Ltseq5Touch
%                         Rtseq5Touch
%                         Repeat3touch_pre
%                         Repeat3touch
                        Repeat5touchLtRt
                        LtPeakTouch
                        RtPeakTouch
%                         matsuda20200210
%                         LtIntervalAverage5Touch
%                         RtIntervalAverage5Touch
%                         if RLRcount==1 && LRLcount==0;
%                             RLRtrial=RLRtrial+1;
%                         else RLRcount==0 && LRLcount==1;
%                             LRLtrial=LRLtrial+1;
%                         end
%                         if RLRLRcount==1 && LRLRLcount==0;
%                             RLRLRtrial=RLRLRtrial+1;
%                         else RLRLRcount==0 && LRLRLcount==1;
%                             LRLRLtrial=LRLRLtrial+1;
%                         end

%                         PeakTouchPhase
%                         PeakTouchInterval
%                         TouchInterval
%                         FRvsIntervalTouch
%                         TouchPhase
%                         save response
%                         y3=RepeattouchWL2
%                         Y3(cellnum,:)=y3;
%                         YY3(cellnum,:)=Y3(cellnum,:)./sum(Y3(cellnum,:));
%                       save RepeatResul Y3
%                         Repeat3touchRateArray=[Repeat3touchRateArray;Spike_TouchRate]; %ratearrayはpatternnum×8の行列
%                         Repeat3TouchSpikeFR_BinArray=[Repeat3TouchSpikeFR_BinArray;SpikeFR_Bin];
%                         Repeat3TouchCountArray=[Repeat3TouchCountArray;TouchCount];
%                         Repeat3TouchSpikevsBinArray=[Repeat3TouchSpikevsBinArray;Spike];
%                         Repeat3TouchSpikeCount_BinArray=[Repeat3TouchSpikeCount_BinArray;Spike_Bin]; %Spike_Binの平均求めるための行列
%                         
                        Repeat5TouchCountArray=[Repeat5TouchCountArray;TouchCountW12345];
                        Repeat5TouchSpikeFR_BinArray=[Repeat5TouchSpikeFR_BinArray;SpikeFR_5Touch_Bin];
                        Repeat5TouchCount1Array=[Repeat5TouchCount1Array;tTouchCount1];
                        Repeat5TouchSpike1FR_BinArray=[Repeat5TouchSpike1FR_BinArray;Spike1FR_5Touch_Bin];
                        Repeat5TouchCount2Array=[Repeat5TouchCount2Array;tTouchCount2];
                        Repeat5TouchSpike2FR_BinArray=[Repeat5TouchSpike2FR_BinArray;Spike2FR_5Touch_Bin];
                        Repeat5TouchCount3Array=[Repeat5TouchCount3Array;tTouchCount3];
                        Repeat5TouchSpike3FR_BinArray=[Repeat5TouchSpike3FR_BinArray;Spike3FR_5Touch_Bin];
                        Repeat5TouchCount4Array=[Repeat5TouchCount4Array;tTouchCount4];
                        Repeat5TouchSpike4FR_BinArray=[Repeat5TouchSpike4FR_BinArray;Spike4FR_5Touch_Bin];
%                         
                        LtRepeat5TouchSpikeFR_BinArray=[LtRepeat5TouchSpikeFR_BinArray;LtSpikeFR_Bin];
                        LtRepeat5TouchCountArray=[LtRepeat5TouchCountArray;LtTouchCount];
                        LtRepeat5TouchSpike1FR_BinArray=[LtRepeat5TouchSpike1FR_BinArray;LtSpike1FR_Bin];
                        LtRepeat5TouchCount1Array=[LtRepeat5TouchCount1Array;LtTouchCount1];
                        LtRepeat5TouchSpike2FR_BinArray=[LtRepeat5TouchSpike2FR_BinArray;LtSpike2FR_Bin];
                        LtRepeat5TouchCount2Array=[LtRepeat5TouchCount2Array;LtTouchCount2];
                        LtRepeat5TouchSpike3FR_BinArray=[LtRepeat5TouchSpike3FR_BinArray;LtSpike3FR_Bin];
                        LtRepeat5TouchCount3Array=[LtRepeat5TouchCount3Array;LtTouchCount3];
                        LtRepeat5TouchSpike4FR_BinArray=[LtRepeat5TouchSpike4FR_BinArray;LtSpike4FR_Bin];
                        LtRepeat5TouchCount4Array=[LtRepeat5TouchCount4Array;LtTouchCount4];
                        
%                         LtRepeat5TouchSpikeRateArray=[LtRepeat5TouchSpikeRateArray;LtSpike_TouchRate];  
                        RtRepeat5TouchCountArray=[RtRepeat5TouchCountArray;RtTouchCount];
                        RtRepeat5TouchSpikeFR_BinArray=[RtRepeat5TouchSpikeFR_BinArray;RtSpikeFR_Bin];
                        RtRepeat5TouchSpike1FR_BinArray=[RtRepeat5TouchSpike1FR_BinArray;RtSpike1FR_Bin];
                        RtRepeat5TouchCount1Array=[RtRepeat5TouchCount1Array;RtTouchCount1];
                        RtRepeat5TouchSpike2FR_BinArray=[RtRepeat5TouchSpike2FR_BinArray;RtSpike2FR_Bin];
                        RtRepeat5TouchCount2Array=[RtRepeat5TouchCount2Array;RtTouchCount2];
                        RtRepeat5TouchSpike3FR_BinArray=[RtRepeat5TouchSpike3FR_BinArray;RtSpike3FR_Bin];
                        RtRepeat5TouchCount3Array=[RtRepeat5TouchCount3Array;RtTouchCount3];
                        RtRepeat5TouchSpike4FR_BinArray=[RtRepeat5TouchSpike4FR_BinArray;RtSpike4FR_Bin];
                        RtRepeat5TouchCount4Array=[RtRepeat5TouchCount4Array;RtTouchCount4];
%                         
%                         LtIntervalAverageTouchCountArray=[LtIntervalAverageTouchCountArray;LtIntervalAverageTouchCount];
%                         LtIntervalAverageSpikeFR_BinArray=[LtIntervalAverageSpikeFR_BinArray;LtIntervalAverageSpikeFR_Bin];
%                         RtIntervalAverageTouchCountArray=[RtIntervalAverageTouchCountArray;RtIntervalAverageTouchCount];
%                         RtIntervalAverageSpikeFR_BinArray=[RtIntervalAverageSpikeFR_BinArray;RtIntervalAverageSpikeFR_Bin];

%                           Ltseq5TouchFRArray=[Ltseq5TouchFRArray;LtFR_Array];
%                           Rtseq5TouchFRArray=[Rtseq5TouchFRArray;RtFR_Array];
                        
%                         PeakIntervalArray=[PeakIntervalArray PeakInterval];
%                         IntervalTouchRateArray=[IntervalTouchRateArray;IntervalCount];
%                         FRvsIntervalTouchRateArray=[FRvsIntervalTouchRateArray;FRvsIntervalTouchRate];
%                         PhaseCountRateArray=[PhaseCountRateArray;PhaseCountRate];
%                         PeakPhaseCountArray=[PeakPhaseCountArray;PeakPhaseCount];
                        patternnum=patternnum+1;                   
                    end
                    end
                    cellnum=cellnum+1; 
                end
            end
         
        end
      end
   end
end
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
FLName=['FiringRate_TouchCountData'];
save(FLName,'LtRepeat5TouchSpikeFR_BinArray','LtRepeat5TouchCountArray','RtRepeat5TouchSpikeFR_BinArray','RtRepeat5TouchCountArray'...
            ,'LtRepeat5TouchSpike1FR_BinArray','LtRepeat5TouchCount1Array','LtRepeat5TouchSpike2FR_BinArray','LtRepeat5TouchCount2Array'...
            ,'LtRepeat5TouchSpike3FR_BinArray','LtRepeat5TouchCount3Array','LtRepeat5TouchSpike4FR_BinArray','LtRepeat5TouchCount4Array'...
            ,'RtRepeat5TouchSpike1FR_BinArray','RtRepeat5TouchCount1Array','RtRepeat5TouchSpike2FR_BinArray','RtRepeat5TouchCount2Array'...
            ,'RtRepeat5TouchSpike3FR_BinArray','RtRepeat5TouchCount3Array','RtRepeat5TouchSpike4FR_BinArray','RtRepeat5TouchCount4Array','patternnum'...
            ,'Repeat5TouchCountArray','Repeat5TouchSpikeFR_BinArray','Repeat5TouchCount1Array','Repeat5TouchSpike1FR_BinArray'...
            ,'Repeat5TouchSpike2FR_BinArray','Repeat5TouchCount2Array','Repeat5TouchSpike3FR_BinArray','Repeat5TouchCount3Array'...
            ,'Repeat5TouchSpike4FR_BinArray','Repeat5TouchCount4Array');
        
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% FLName=['seqTouch'];
% save(FLName,'Ltseq5TouchFRArray','Rtseq5TouchFRArray');
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% FLName=[pegpatternum,pegpatternname];
% save(FLName,'LtRepeat5TouchSpikeFR_BinArray','LtRepeat5TouchCountArray','RtRepeat5TouchSpikeFR_BinArray','RtRepeat5TouchCountArray'...
%             ,'Repeat5TouchSpikeFR_BinArray','Repeat5TouchCountArray','Repeat3TouchSpikeFR_BinArray','Repeat3TouchCountArray'...
%             ,'RLRtrial','LRLtrial','RLRLRtrial','LRLRLtrial','LtIntervalAverageTouchCountArray','LtIntervalAverageSpikeFR_BinArray'...
%             ,'RtIntervalAverageTouchCountArray','RtIntervalAverageSpikeFR_BinArray');
% % 両足ピークから0sから近い3つピーク検出
% %Repeat3touchにおける、ビン毎にそれぞれ何回タッチが当てはまったかの平均
% for d=1:8
%     mean(Repeat3TouchCountArray(:,d));
%     std(Repeat3TouchCountArray(:,d));
%     Repeat3TouchCountMeanArray=[Repeat3TouchCountMeanArray mean(Repeat3TouchCountArray(:,d))];
%     Repeat3TouchCountStdArray=[Repeat3TouchCountStdArray std(Repeat3TouchCountArray(:,d))/sqrt(patternnum)];
% end
% fig6=figure;
% y=1:8;
% bar(y,Repeat3TouchCountMeanArray)
% set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
% hold on
% errorbar(y,Repeat3TouchCountMeanArray,Repeat3TouchCountStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['Repeat3TouchCountAverageLtRt','.bmp'];
% saveas(fig6,figname);
% close(fig6);
% %Repeat3Touchの発火頻度平均
% for d=1:8
%     mean(Repeat3TouchSpikeFR_BinArray(:,d));
%     std(Repeat3TouchSpikeFR_BinArray(:,d));
%     Repeat3TouchSpikeFR_BinMeanArray=[Repeat3TouchSpikeFR_BinMeanArray mean(Repeat3TouchSpikeFR_BinArray(:,d))];
%     Repeat3TouchSpikeFR_BinStdArray=[Repeat3TouchSpikeFR_BinStdArray std(Repeat3TouchSpikeFR_BinArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:8;
% bar(y,Repeat3TouchSpikeFR_BinMeanArray)
% set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
% hold on
% errorbar(y,Repeat3TouchSpikeFR_BinMeanArray,Repeat3TouchSpikeFR_BinStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['Repeat3TouchSpikeFR_BinLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
%両足ピーク0sから近い5つ検出
%タッチカウント平均
for d=1:13
    mean(Repeat5TouchCountArray(:,d));
    std(Repeat5TouchCountArray(:,d));
    Repeat5TouchCountMeanArray=[Repeat5TouchCountMeanArray mean(Repeat5TouchCountArray(:,d))];
    Repeat5TouchCountStdArray=[Repeat5TouchCountStdArray std(Repeat5TouchCountArray(:,d))/sqrt(patternnum)];
end
fig2=figure;
y=1:13;
bar(y,Repeat5TouchCountMeanArray)
set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
hold on
errorbar(y,Repeat5TouchCountMeanArray,Repeat5TouchCountStdArray,'o')
hold off
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
figname=['Repeat5TouchCountAverageLtRt','.bmp'];
saveas(fig2,figname);
close(fig2);
%発火頻度平均
for d=1:13
    mean(Repeat5TouchSpikeFR_BinArray(:,d));
    std(Repeat5TouchSpikeFR_BinArray(:,d));
    Repeat5TouchSpikeFR_BinMeanArray=[Repeat5TouchSpikeFR_BinMeanArray mean(Repeat5TouchSpikeFR_BinArray(:,d))];
    Repeat5TouchSpikeFR_BinStdArray=[Repeat5TouchSpikeFR_BinStdArray std(Repeat5TouchSpikeFR_BinArray(:,d))/sqrt(patternnum)];
end
fig2=figure;
y=1:13;
bar(y,Repeat5TouchSpikeFR_BinMeanArray)
set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
hold on
errorbar(y,Repeat5TouchSpikeFR_BinMeanArray,Repeat5TouchSpikeFR_BinStdArray,'o')
hold off
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
figname=['Repeat5TouchSpikeFR_BinAverageLtRt','.bmp'];
saveas(fig2,figname);
close(fig2);
%右足0sから近い5つのピーク検出
%タッチカウント平均
for d=1:10
    mean(RtRepeat5TouchCountArray(:,d));
    std(RtRepeat5TouchCountArray(:,d));
    RtRepeat5TouchCountMeanArray=[RtRepeat5TouchCountMeanArray mean(RtRepeat5TouchCountArray(:,d))];
    RtRepeat5TouchCountStdArray=[RtRepeat5TouchCountStdArray std(RtRepeat5TouchCountArray(:,d))/sqrt(patternnum)];
end
fig2=figure;
y=1:10;
bar(y,RtRepeat5TouchCountMeanArray)
set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
hold on
errorbar(y,RtRepeat5TouchCountMeanArray,RtRepeat5TouchCountStdArray,'o')
hold off
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
figname=['RtRepeat5TouchCount_BinAverageLtRt','.bmp'];
saveas(fig2,figname);
close(fig2);
%発火頻度平均
for d=1:10
    mean(RtRepeat5TouchSpikeFR_BinArray(:,d));
    std(RtRepeat5TouchSpikeFR_BinArray(:,d));
    RtRepeat5TouchSpikeFR_BinMeanArray=[RtRepeat5TouchSpikeFR_BinMeanArray mean(RtRepeat5TouchSpikeFR_BinArray(:,d))];
    RtRepeat5TouchSpikeFR_BinStdArray=[RtRepeat5TouchSpikeFR_BinStdArray std(RtRepeat5TouchSpikeFR_BinArray(:,d))/sqrt(patternnum)];
end
fig2=figure;
y=1:10;
bar(y,RtRepeat5TouchSpikeFR_BinMeanArray)
set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
hold on
errorbar(y,RtRepeat5TouchSpikeFR_BinMeanArray,RtRepeat5TouchSpikeFR_BinStdArray,'o')
hold off
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
figname=['RtRepeat5TouchSpikeFR_BinAverageLtRt','.bmp'];
saveas(fig2,figname);
close(fig2);
%左足0sから近い5つのピーク検出
%タッチカウント平均
for g=1:10
    mean(LtRepeat5TouchCountArray(:,g));
    std(LtRepeat5TouchCountArray(:,g));
    LtRepeat5TouchCountMeanArray=[LtRepeat5TouchCountMeanArray mean(LtRepeat5TouchCountArray(:,g))];
    LtRepeat5TouchCountStdArray=[LtRepeat5TouchCountStdArray std(LtRepeat5TouchCountArray(:,g))/sqrt(patternnum)];
end
fig9=figure;
y=1:10;
bar(y,LtRepeat5TouchCountMeanArray)
set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
hold on
errorbar(y,LtRepeat5TouchCountMeanArray,LtRepeat5TouchCountStdArray,'o')
hold off
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
trimtfile=strtrim(tfile);
figname=['LtRepeat5TouchCountAverageLtRt',trimFolder2,trimtfile,'.bmp'];
saveas(fig9,figname);
close(fig9);
%発火頻度平均
for d=1:10
    mean(LtRepeat5TouchSpikeFR_BinArray(:,d));
    std(LtRepeat5TouchSpikeFR_BinArray(:,d));
    LtRepeat5TouchSpikeFR_BinMeanArray=[LtRepeat5TouchSpikeFR_BinMeanArray mean(LtRepeat5TouchSpikeFR_BinArray(:,d))];
    LtRepeat5TouchSpikeFR_BinStdArray=[LtRepeat5TouchSpikeFR_BinStdArray std(LtRepeat5TouchSpikeFR_BinArray(:,d))/sqrt(patternnum)];
end
fig2=figure;
y=1:10;
bar(y,LtRepeat5TouchSpikeFR_BinMeanArray)
set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
hold on
errorbar(y,LtRepeat5TouchSpikeFR_BinMeanArray,LtRepeat5TouchSpikeFR_BinStdArray,'o')
hold off
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
figname=['LtRepeat5TouchSpikeFR_BinAverageLtRt','.bmp'];
saveas(fig2,figname);
close(fig2);
% % 右足3個目のピーク基準にピーク間のインターバル平均化したもの
% % タッチカウントの平均
% for d=1:14
%     mean(RtIntervalAverageTouchCountArray(:,d));
%     std(RtIntervalAverageTouchCountArray(:,d));
%     RtIntervalAverageTouchCountMeanArray=[RtIntervalAverageTouchCountMeanArray mean(RtIntervalAverageTouchCountArray(:,d))];
%     RtIntervalAverageTouchCountStdArray=[RtIntervalAverageTouchCountStdArray std(RtIntervalAverageTouchCountArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:14;
% bar(y,RtIntervalAverageTouchCountMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','123','345','1-5'});
% hold on
% errorbar(y,RtIntervalAverageTouchCountMeanArray,RtIntervalAverageTouchCountStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['RtIntervalAverage5TouchCount_BinAverageLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
% %発火頻度平均
% for d=1:14
%     mean(RtIntervalAverageSpikeFR_BinArray(:,d));
%     std(RtIntervalAverageSpikeFR_BinArray(:,d));
%     RtIntervalAverageTouchSpikeFR_BinMeanArray=[RtIntervalAverageTouchSpikeFR_BinMeanArray mean(RtIntervalAverageSpikeFR_BinArray(:,d))];
%     RtIntervalAverageTouchSpikeFR_BinStdArray=[RtIntervalAverageTouchSpikeFR_BinStdArray std(RtIntervalAverageSpikeFR_BinArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:14;
% bar(y,RtIntervalAverageTouchSpikeFR_BinMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','123','345','1-5'});
% hold on
% errorbar(y,RtIntervalAverageTouchSpikeFR_BinMeanArray,RtIntervalAverageTouchSpikeFR_BinStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['RtIntervalAverage5TouchSpikeFR_BinAverageLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
% %左足3個目のピーク基準にピーク間のインターバル平均化したもの
% %タッチカウントの平均
% for g=1:14
%     mean(LtIntervalAverageTouchCountArray(:,g));
%     std(LtIntervalAverageTouchCountArray(:,g));
%     LtIntervalAverageTouchCountMeanArray=[LtIntervalAverageTouchCountMeanArray mean(LtIntervalAverageTouchCountArray(:,g))];
%     LtIntervalAverageTouchCountStdArray=[LtIntervalAverageTouchCountStdArray std(LtIntervalAverageTouchCountArray(:,g))/sqrt(patternnum)];
% end
% fig9=figure;
% y=1:14;
% bar(y,LtIntervalAverageTouchCountMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','123','345','1-5'});
% hold on
% errorbar(y,LtIntervalAverageTouchCountMeanArray,LtIntervalAverageTouchCountStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% trimtfile=strtrim(tfile);
% figname=['LtIntervalAverage5TouchCountAverageLtRt''.bmp'];
% saveas(fig9,figname);
% close(fig9);
% %発火頻度平均
% for d=1:14
%     mean(LtIntervalAverageSpikeFR_BinArray(:,d));
%     std(LtIntervalAverageSpikeFR_BinArray(:,d));
%     LtIntervalAverageTouchSpikeFR_BinMeanArray=[LtIntervalAverageTouchSpikeFR_BinMeanArray mean(LtIntervalAverageSpikeFR_BinArray(:,d))];
%     LtIntervalAverageTouchSpikeFR_BinStdArray=[LtIntervalAverageTouchSpikeFR_BinStdArray std(LtIntervalAverageSpikeFR_BinArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:14;
% bar(y,LtIntervalAverageTouchSpikeFR_BinMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','123','345','1-5'});
% hold on
% errorbar(y,LtIntervalAverageTouchSpikeFR_BinMeanArray,LtIntervalAverageTouchSpikeFR_BinStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['LtIntervalAverage5TouchSpikeFR_BinAverageLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
%ANOVA検定
% for a=1:6
%     ANOVA_LtRepeat5TouchSpikeFR_BinArray=[ANOVA_LtRepeat5TouchSpikeFR_BinArray,LtRepeat5TouchSpikeFR_BinArray(:,a)];
% end
% [p,anovatab,stats]=anova1(ANOVA_LtRepeat5TouchSpikeFR_BinArray);
% [c1,m1,h1,nms1]=multcompare(stats);
% [c,~,~,gnames] = multcompare(stats);

% for d=1:8
%     mean(Repeat3TouchSpikeCount_BinArray(:,d));
%     std(Repeat3TouchSpikeCount_BinArray(:,d));
%     Repeat3TouchSpikeCount_BinMeanArray=[Repeat3TouchSpikeCount_BinMeanArray mean(Repeat3TouchSpikeCount_BinArray(:,d))];
%     Repeat3TouchSpikeCount_BinStdArray=[Repeat3TouchSpikeCount_BinStdArray std(Repeat3TouchSpikeCount_BinArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:8;
% bar(y,Repeat3TouchSpikeCount_BinMeanArray)
% set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
% hold on
% errorbar(y,Repeat3TouchSpikeCount_BinMeanArray,Repeat3TouchSpikeCount_BinStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['Repeat3TouchSpikeCount_BinLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
% for d=1:8
%     mean(Repeat3TouchSpikevsBinArray(:,d));
%     std(Repeat3TouchSpikevsBinArray(:,d));
%     Repeat3TouchSpikevsBinMeanArray=[Repeat3TouchSpikevsBinMeanArray mean(Repeat3TouchSpikevsBinArray(:,d))];
%     Repeat3TouchSpikevsBinStdArray=[Repeat3TouchSpikevsBinStdArray std(Repeat3TouchSpikevsBinArray(:,d))/sqrt(patternnum)];
% end
% fig1=figure;
% y=1:8;
% bar(y,Repeat3TouchSpikevsBinMeanArray)
% set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
% hold on
% errorbar(y,Repeat3TouchSpikevsBinMeanArray,Repeat3TouchSpikevsBinStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['Repeat3TouchSpikevsBinLtRt','.bmp'];
% saveas(fig1,figname);
% close(fig1);
%左脚ピークにウインドウ5個、ビン毎のタッチカウント

%Repeat3touchにおける、ビン毎の発火頻度。全体１としたときの割合
% for a=1:13
%     mean(LtRepeat5TouchSpikeRateArray(:,a));
%     std(LtRepeat5TouchSpikeRateArray(:,a));
%     LtRepeat5TouchSpikeRateMeanArray=[LtRepeat5TouchSpikeRateMeanArray mean(LtRepeat5TouchSpikeRateArray(:,a))];
%     LtRepeat5TouchSpikeRateStdArray=[LtRepeat5TouchSpikeRateStdArray std(LtRepeat5TouchSpikeRateArray(:,a))];
% end
% fig10=figure;
% y=1:13;
% bar(y,LtRepeat5TouchSpikeRateMeanArray)
% set(gca,'xticklabel',{'no','1','2','3','4','5','12','123','23','234','1234','2345','12345'});
% hold on
% errorbar(y,LtRepeat5TouchSpikeRateMeanArray,LtRepeat5TouchSpikeRateStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% trimtfile=strtrim(tfile);
% figname=['LtRepeat5TouchSpikeRateAverageLtRt',trimFolder2,trimtfile,'.bmp'];
% saveas(fig10,figname);
% close(fig10);


%%クロスコリオグラムからとった三つのピークの位相分布
% for f=1:10
%     sum(PeakPhaseCountArray(:,f));
% %     std(PeakPhaseCountArray(:,f));
%     PhaseCountRateSumArray=[PhaseCountRateSumArray sum(PeakPhaseCountArray(:,f))];
% %     PhaseCountRateStdArray=[PhaseCountRateStdArray std(PhaseCountRateArray(:,f))];
% end
% fig8=figure;
% z=1:10;
% bar(z,PhaseCountRateSumArray)
% set(gca,'xticklabel',{'0-1','1-2','2-3','3-4','4-5','5-6','6-7','7-8','8-9','9-10'});
% % hold on
% % errorbar(z,PhaseCountRateMeanArray,PhaseCountRateStdArray,'o')
% % hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% trimtfile=strtrim(tfile);
% figname=['PeakTouchPhaseLtRt',trimFolder2,trimtfile,'.bmp'];
% saveas(fig8,figname);
% close(fig8);

%クロスコリオグラムからとった三つのピークのインターバル分布
% count_50=0;
% count_100=0;
% count_150=0;
% count_200=0;
% count_250=0;
% count_300=0;
% count_350=0;
% count_400=0;
% count_450=0;
% count_500=0;
% count_550=0;
% count_600=0;
% count_650=0;
% for e=1:length(PeakIntervalArray);
%     if 0<=PeakIntervalArray(e) & PeakIntervalArray(e)<50
%         count_50=count_50+1;
%     end
%     if 50<=PeakIntervalArray(e) & PeakIntervalArray(e)<100
%         count_100=count_100+1;
%     end
%     if 100<=PeakIntervalArray(e) & PeakIntervalArray(e)<150
%         count_150=count_150+1;
%     end
%     if 150<=PeakIntervalArray(e) & PeakIntervalArray(e)<200
%         count_200=count_200+1;
%     end
%     if 200<=PeakIntervalArray(e) & PeakIntervalArray(e)<250
%         count_250=count_250+1;
%     end
%     if 250<=PeakIntervalArray(e) & PeakIntervalArray(e)<300
%         count_300=count_300+1;
%     end
%     if 300<=PeakIntervalArray(e) & PeakIntervalArray(e)<350
%         count_350=count_350+1;
%     end
%     if 350<=PeakIntervalArray(e) & PeakIntervalArray(e)<400
%         count_400=count_400+1;
%     end
%     if 400<=PeakIntervalArray(e) & PeakIntervalArray(e)<450
%         count_450=count_450+1;
%     end
%     if 450<=PeakIntervalArray(e) & PeakIntervalArray(e)<500
%         count_500=count_500+1;
%     end
%     if 500<=PeakIntervalArray(e) & PeakIntervalArray(e)<550
%         count_550=count_550+1;
%     end
%     if 550<=PeakIntervalArray(e) & PeakIntervalArray(e)<600
%         count_600=count_600+1;
%     end
%     if 600<=PeakIntervalArray(e) & PeakIntervalArray(e)<650
%         count_650=count_650+1;
%     end
% end
%     PeakIntervalCount=[count_50,count_100,count_150,count_200,count_250,count_300,count_350,count_400,count_450,count_500,count_550,count_600,count_650];
%     fig7=figure;
%     bar(PeakIntervalCount);
%     set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
%     cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
%     trimtfile=strtrim(tfile);
%     figname=['PeakTouckIntervalLtRt',trimFolder2,trimtfile,'.bmp'];
%     saveas(fig7,figname);
%     close(fig7);
%     

%Repeat3touchにおける、ビン毎の発火頻度。全体１としたときの割合
% for a=1:8
%     mean(Repeat3touchRateArray(:,a));
%     std(Repeat3touchRateArray(:,a));
%     Repeat3touchRateMeanArray=[Repeat3touchRateMeanArray mean(Repeat3touchRateArray(:,a))];
%     Repeat3touchRateStdArray=[Repeat3touchRateStdArray std(Repeat3touchRateArray(:,a))/sqrt(patternnum)];
% end
% fig4=figure;
% y=1:8;
% bar(y,Repeat3touchRateMeanArray)
% set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
% hold on
% errorbar(y,Repeat3touchRateMeanArray,Repeat3touchRateStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['Repeat3touchavarageLtRt','.bmp'];
% saveas(fig4,figname);
% close(fig4);
%どのインターバルでタッチしている細胞が多いか
% for g=1:13
%      mean(IntervalTouchRateArray(:,g));
%      std(IntervalTouchRateArray(:,g));
%      IntervalTouchRateMeanArray=[IntervalTouchRateMeanArray mean(IntervalTouchRateArray(:,g))];
%      IntervalTouchRateStdArray=[IntervalTouchRateStdArray std(IntervalTouchRateArray(:,g))];
% end
% fig9=figure;
% x=1:13;
% bar(x,IntervalTouchRateMeanArray)
% set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
% hold on
% errorbar(x,IntervalTouchRateMeanArray,IntervalTouchRateStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% trimtfile=strtrim(tfile);
% figname=['IntervalTouchAvarageLtRt',trimFolder2,trimtfile,'.bmp'];
% saveas(fig9,figname);
% close(fig9);
%どのインターバルにおいて発火頻度が多いか
% for b=1:13
%      mean(FRvsIntervalTouchRateArray(:,b));
%      std(FRvsIntervalTouchRateArray(:,b));
%      FRvsIntervalTouchRateMeanArray=[FRvsIntervalTouchRateMeanArray mean(FRvsIntervalTouchRateArray(:,b))];
%      FRvsIntervalTouchRateStdArray=[FRvsIntervalTouchRateStdArray std(FRvsIntervalTouchRateArray(:,b))];
% end
% fig3=figure;
% x=1:13;
% bar(x,FRvsIntervalTouchRateMeanArray)
% set(gca,'xticklabel',{'50','100','150','200','250','300','350','400','450','500','550','600','650'});
% hold on
% errorbar(x,FRvsIntervalTouchRateMeanArray,FRvsIntervalTouchRateStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% trimtfile=strtrim(tfile);
% figname=['FRvsIntervalTouchAvarageLtRt',trimFolder2,trimtfile,'.bmp'];
% saveas(fig3,figname);
% close(fig3);

% for c=1:10
%     mean(PhaseCountRateArray(:,c));
%     std(PhaseCountRateArray(:,c));
%     PhaseCountRateMeanArray=[PhaseCountRateMeanArray mean(PhaseCountRateArray(:,c))];
%     PhaseCountRateStdArray=[PhaseCountRateStdArray std(PhaseCountRateArray(:,c))];
% end
% fig5=figure;
% z=1:10;
% bar(z,PhaseCountRateMeanArray)
% set(gca,'xticklabel',{'0-1','1-2','2-3','3-4','4-5','5-6','6-7','7-8','8-9','9-10'});
% hold on
% errorbar(z,PhaseCountRateMeanArray,PhaseCountRateStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\matsudatouchcellLtRt');
% trimtfile=strtrim(tfile);
% figname=['TouchPhaseAverageLtRt',trimFolder2,trimtfile,'.bmp'];
% saveas(fig5,figname);
% close(fig5);



% save RepeatResult Y3 YY3

% YY3=zeros(cellnum,8);
% for n=1:cellnum;
%     
%     YY3(n,:)=Y3(n,:)./sum(Y3(n,:));
%                                
%     
%     semYY3=std(YY3)./sqrt(cellnum);
% end
