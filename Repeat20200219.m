function Repeat20200219
global RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 Spike_TouchRate IntervalCount FRvsIntervalTouchRate PhaseCountRate...
    TouchCount PeakInterval PeakPhaseCount pegpatternum RLRcount LRLcount ...
    LtTouchCount LtSpike_TouchRate Spike Spike_Bin SpikeFR_Bin LtSpikeFR_Bin RtTouchCount RtSpikeFR_Bin RtSpike_TouchRate...
    TouchCountW12345 SpikeFR_5Touch_Bin RLRLRcount LRLRLcount RtIntervalAverageTouchCount RtIntervalAverageSpikeFR_Bin LtIntervalAverageTouchCount LtIntervalAverageSpikeFR_Bin...
    LtFR_Array RtFR_Array LtSpike1FR_Bin LtSpike2FR_Bin LtSpike3FR_Bin LtSpike4FR_Bin LtTouchCount1 LtTouchCount2 LtTouchCount3 LtTouchCount4...
    RtTouchCount1 RtTouchCount2 RtTouchCount3 RtTouchCount4 RtSpike1FR_Bin RtSpike2FR_Bin RtSpike3FR_Bin RtSpike4FR_Bin...
    Spike1FR_5Touch_Bin Spike2FR_5Touch_Bin Spike3FR_5Touch_Bin Spike4FR_5Touch_Bin tTouchCount1 tTouchCount2 tTouchCount3 tTouchCount4 CCresultRtouchWon CCresultLtouchWon...
    W3distance W3distanceArray LtWindowintervaL RtWindowintervaL LtWindowintervaLArray RtWindowintervaLArray...
    LtPositiveFiringRate LtNegativeFiringRate RtPositiveFiringRate RtNegativeFiringRate...
    MeanLtPositiveFiringRateArray StdLtPositiveFiringRateArray MeanLtNegativeFiringRateArray StdLtNegativeFiringRateArray...
    MeanRtPositiveFiringRateArray StdRtPositiveFiringRateArray MeanRtNegativeFiringRateArray  StdRtNegativeFiringRateArray...
    LtPositiveSpikeOnKaisuu LtNegativeSpikeOnKaisuu RtPositiveSpikeOnKaisuu RtNegativeSpikeOnKaisuu...
    LtPositiveHistogramXaxis LtNegativeHistogramXaxis RtPositiveHistogramXaxis RtNegativeHistogramXaxis...
    LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu ...
    RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu ...
    LtPositiveFiringRateP1 LtNegativeFiringRateP1 RtPositiveFiringRateP1 RtNegativeFiringRateP1...
    LtPositiveFiringRateArray LtNegativeFiringRateArray RtPositiveFiringRateArray RtNegativeFiringRateArray...
    P1LtPositiveFiringRateArray P1LtNegativeFiringRateArray P1RtPositiveFiringRateArray P1RtNegativeFiringRateArray...
    LtPositive_beta_hist LtNegative_beta_hist RtPositive_beta_hist RtNegative_beta_hist LtPositive_R_hist LtNegative_R_hist RtPositive_R_hist RtNegative_R_hist...
    LtPositive_beta_histP1 LtNegative_beta_histP1 RtPositive_beta_histP1 RtNegative_beta_histP1 LtPositive_R_histP1 LtNegative_R_histP1 RtPositive_R_histP1 RtNegative_R_histP1...
    CellNumList
%%%%%%%'RtNegativeSpikeOnKaisuu','RtNegativeSpikeOffKaisuu','RtNegativeHistogramXaxis'
% デスクトップにフォルダー作る
cd('C:\Users\C238\Desktop')
Folder=['touchcellLtRt_Hirokane'];
mkdir(Folder)
% 新たなフォルダーで足取り反応細胞見つけて番号付けていく
path=['C:\Users\C238\Desktop\CheetahWRLV20200411'];
cd(path)
cellnum=0;
RLRtrial=0;
LRLtrial=0;
RLRLRtrial=0;
LRLRLtrial=0;
patternnum=1;


CCresultRtouchWonUnit=[];
CCresultLtouchWonUnit=[];
W3distanceArray=[];
LtWindowintervaLArray=[];
RtWindowintervaLArray=[];

LtPositiveFiringRateArray=[];
LtNegativeFiringRateArray=[];
RtPositiveFiringRateArray=[];
RtNegativeFiringRateArray=[];

P1LtPositiveFiringRateArray=[];
P1LtNegativeFiringRateArray=[];
P1RtPositiveFiringRateArray=[];
P1RtNegativeFiringRateArray=[];

LtPositive_beta_hist=[];
LtNegative_beta_hist=[];
RtPositive_beta_hist=[];
RtNegative_beta_hist=[];
LtPositive_R_hist=[];
LtNegative_R_hist=[];
RtPositive_R_hist=[];
RtNegative_R_hist=[];

LtPositive_beta_histP1=[];
LtNegative_beta_histP1=[];
RtPositive_beta_histP1=[];
RtNegative_beta_histP1=[];
LtPositive_R_histP1=[];
LtNegative_R_histP1=[];
RtPositive_R_histP1=[];
RtNegative_R_histP1=[];

CellNumList=[];

LS1=ls;
for i=1:length(LS1(:,1)) %1列目で固定、行を動かす
    trimFolder=strtrim(LS1(i,:));
    if ~strcmp(trimFolder,'.') && ~st
        
        rcmp(trimFolder,'..') && isempty(strfind(trimFolder,'.bmp')) && ~strcmp(trimFolder,'CCSfigure') && isempty(strfind(trimFolder,'SpikeFormAnalysis')) && isempty(strfind(trimFolder,'Count')) && isempty(strfind(trimFolder,'widthPtoT')) && ~strcmp(trimFolder,'CCSfigure-Lt') && ~strcmp(trimFolder,'CCSfigure-RLt') && ~strcmp(trimFolder,'CCSfigure-Rt')
        CDFolder=[path,'\',trimFolder]; %cdフォルダ変更C:\Users\C238\Desktop\CheetahWRLV20180729Part1\trimfolder(mouseNo)
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
                        pegpattern=[pegpattern;trimLS3]; %ペグパターンを読み込む(.matファイル)
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
                        cellnum=cellnum+1;
                        SpikeArray=[];
                        tfile=[strtrim(TouchCellName(k,:)),'.t'];
                        %                     SpikeArray=GetSpikeAll(CDFolder2,tfile);
                        SpikeArrayWon=[];
                        cd('C:\Users\C238\Desktop\touchcellLtRt_Hirokane');
                        Foldercell=num2str(cellnum); %num2strは数値を
                        mkdir(Foldercell); %%1~82の細胞番号順にディレクトリを作成
                        for d=1:length(pegpattern(:,1));%保存したペグパターンごとに見ていく
                            if ~isempty(strfind(pegpattern(d,:),'_C'));%_Cの配列を見つけたら
                                CDFolder5=[CDFolder2,'\',pegpattern(d,(1:end-4))];
                                cd(CDFolder5)
                                file=['Bdata.mat'];
                                load(file);
                                SpikeArray=GetSpikeAll(CDFolder2,tfile);
                                SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                                %WaterOnのときのみのスパイク
                                if ~isempty(SpikeArray)
                                    SpikeWon=ones(1,length(SpikeArray));
                                    for l=1:length(SpikeArray)
                                        if OnWater(SpikeArray(l))==0
                                            SpikeWon(l)=0;
                                        end
                                    end
                                    SpikeArrayWon=SpikeArray.*SpikeWon;
                                    SpikeArrayWon(SpikeArrayWon==0)=[];
                                    
                                end
                                %WaterOnのときのみのRpegTouchall
                                if ~isempty(RpegTouchall)
                                    RTWon=ones(1,length(RpegTouchall));
                                    for l=1:length(RpegTouchall)
                                        if OnWater(RpegTouchall(l))==0
                                            RTWon(l)=0;
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
                                    for l=1:length(LpegTouchall)
                                        if OnWater(LpegTouchall(l))==0
                                            LTWon(l)=0;
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
                                Folder6=['C:\Users\C238\Desktop\touchcellLtRt_Hirokane','\',Foldercell]
                                cd(Folder6)
                                CCRtLtSave
                                CCresultRtouchWonUnit=[CCresultRtouchWonUnit;CCresultRtouchWon];
                                CCresultLtouchWonUnit=[CCresultLtouchWonUnit;CCresultLtouchWon];
                                patternnum=patternnum+1;
                                MovWindow20200220          %%%%%%%ウィンドウを動かす
                                RLt_Sum_20200303            %%%%%%%左右両方のウィンドウを同時に動かす
                                WindowApply20200225         %%%%%%%当てはまり方の計算
                                WindowApplyPattern1_20200228
                                W3distribution            %%%%%%%%W3の距離、インターバルの保存
                                
                                W3distanceArray=[W3distanceArray W3distance];      %%%%from W3distribution
                                LtWindowintervaLArray=[LtWindowintervaLArray LtWindowintervaL]; %%%%from W3distribution
                                RtWindowintervaLArray=[RtWindowintervaLArray RtWindowintervaL]; %%%%from W3distribution
                                LtPositiveFiringRateArray=[LtPositiveFiringRateArray;LtPositiveFiringRate];%%%%%% from WindowApply20200225
                                LtNegativeFiringRateArray=[LtNegativeFiringRateArray;LtNegativeFiringRate];%%%%%% from WindowApply20200225
                                RtPositiveFiringRateArray=[RtPositiveFiringRateArray;RtPositiveFiringRate];%%%%%% from WindowApply20200225
                                RtNegativeFiringRateArray=[RtNegativeFiringRateArray;RtNegativeFiringRate];%%%%%% from WindowApply20200225
                                
                                P1LtPositiveFiringRateArray=[P1LtPositiveFiringRateArray;LtPositiveFiringRateP1];%%%%%% from WindowApply20200225
                                P1LtNegativeFiringRateArray=[P1LtNegativeFiringRateArray;LtNegativeFiringRateP1];%%%%%% from WindowApply20200225
                                P1RtPositiveFiringRateArray=[P1RtPositiveFiringRateArray;RtPositiveFiringRateP1];%%%%%% from WindowApply20200225
                                P1RtNegativeFiringRateArray=[P1RtNegativeFiringRateArray;RtNegativeFiringRateP1];%%%%%% from WindowApply20200225
                                
                                close all
                            end
                        end
                    end
                end
            end
        end
    end
end

CCresultRtouchWonUnit;
CCresultLtouchWonUnit;
% MakeDistribution20200227  %%%%%%%分布のfigureを保存%%%%%単体で使う
FirngRate_AllCell20200227   %%%%%%%%%全細胞の平均、STDの計算
cd('C:\Users\C238\Desktop\touchcellLtRt_Hirokane')
filename=['CCRtLt.mat'];
save(filename,'CCresultRtouchWonUnit','CCresultLtouchWonUnit');

filename2=['RtLtFirngRate_AllCell.mat'];
save(filename2,'LtPositiveFiringRateArray','LtNegativeFiringRateArray','RtPositiveFiringRateArray','RtNegativeFiringRateArray'...
    ,'MeanLtPositiveFiringRateArray','StdLtPositiveFiringRateArray','MeanLtNegativeFiringRateArray','StdLtNegativeFiringRateArray'...
    ,'MeanRtPositiveFiringRateArray','StdRtPositiveFiringRateArray','MeanRtNegativeFiringRateArray','StdRtNegativeFiringRateArray'...
    ,'LtPositiveSpikeOnKaisuu','LtPositiveSpikeOffKaisuu','LtPositiveHistogramXaxis'...
    ,'LtNegativeSpikeOnKaisuu','LtNegativeSpikeOffKaisuu','LtNegativeHistogramXaxis'...
    ,'RtPositiveSpikeOnKaisuu','RtPositiveSpikeOffKaisuu','RtPositiveHistogramXaxis'...
    ,'RtNegativeSpikeOnKaisuu','RtNegativeSpikeOffKaisuu','RtNegativeHistogramXaxis'...
    ,'pegpatternum'...
    ,'P1LtPositiveFiringRateArray','P1LtNegativeFiringRateArray','P1RtPositiveFiringRateArray','P1RtNegativeFiringRateArray'...
    ,'LtPositive_beta_hist','LtNegative_beta_hist','RtPositive_beta_hist','RtNegative_beta_hist','LtPositive_R_hist','LtNegative_R_hist','RtPositive_R_hist','RtNegative_R_hist'...
    ,'LtPositive_beta_histP1','LtNegative_beta_histP1','RtPositive_beta_histP1','RtNegative_beta_histP1'...
    ,'LtPositive_R_histP1','LtNegative_R_histP1','RtPositive_R_histP1','RtNegative_R_histP1','CellNumList');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%回帰直線の傾き(beta)と決定係数(R^2)の分布をプロット
beta_Hist=figure;
subplot(2,2,1)
histogram(LtPositive_beta_hist,20);
subplot(2,2,2)
histogram(LtNegative_beta_hist,20);
subplot(2,2,3)
histogram(RtPositive_beta_hist,20);
subplot(2,2,4)
histogram(RtNegative_beta_hist,20);
figname=['beta_histogram.bmp'];
saveas(beta_Hist,figname);

R_Hist=figure;
subplot(2,2,1)
histogram(LtPositive_R_hist,20);
subplot(2,2,2)
histogram(LtNegative_R_hist,20);
subplot(2,2,3)
histogram(RtPositive_R_hist,20);
subplot(2,2,4)
histogram(RtNegative_R_hist,20);
figname=['R_histogram.bmp'];
saveas(R_Hist,figname);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Paattern1
%回帰直線の傾き(beta)と決定係数(R^2)の分布をプロット
beta_Hist_P1=figure;
subplot(2,2,1)
histogram(LtPositive_beta_histP1,20);
subplot(2,2,2)
histogram(LtNegative_beta_histP1,20);
subplot(2,2,3)
histogram(RtPositive_beta_histP1,20);
subplot(2,2,4)
histogram(RtNegative_beta_histP1,20);
figname=['beta_histogram_P1.bmp'];
saveas(beta_Hist_P1,figname);

R_Hist_P1=figure;
subplot(2,2,1)
histogram(LtPositive_R_histP1,20);
subplot(2,2,2)
histogram(LtNegative_R_histP1,20);
subplot(2,2,3)
histogram(RtPositive_R_histP1,20);
subplot(2,2,4)
histogram(RtNegative_R_histP1,20);
figname=['R_histogram_P1.bmp'];
saveas(R_Hist_P1,figname);


% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% FLName=['anovadata'];
% % save(FLName,'Repeat5TouchCountArray','Repeat5TouchCount1Array','Repeat5TouchCount2Array','Repeat5TouchCount3Array','Repeat5TouchCount4Array'...
% %             ,'Repeat5TouchSpikeFR_BinArray','Repeat5TouchSpike1FR_BinArray','Repeat5TouchSpike2FR_BinArray','Repeat5TouchSpike3FR_BinArray','Repeat5TouchSpike4FR_BinArray');
% save(FLName,'LtRepeat5TouchSpikeFR_BinArray','LtRepeat5TouchCountArray','RtRepeat5TouchSpikeFR_BinArray','RtRepeat5TouchCountArray'...
%             ,'LtRepeat5TouchSpike1FR_BinArray','LtRepeat5TouchCount1Array','LtRepeat5TouchSpike2FR_BinArray','LtRepeat5TouchCount2Array'...
%             ,'LtRepeat5TouchSpike3FR_BinArray','LtRepeat5TouchCount3Array','LtRepeat5TouchSpike4FR_BinArray','LtRepeat5TouchCount4Array'...
%             ,'RtRepeat5TouchSpike1FR_BinArray','RtRepeat5TouchCount1Array','RtRepeat5TouchSpike2FR_BinArray','RtRepeat5TouchCount2Array'...
%             ,'RtRepeat5TouchSpike3FR_BinArray','RtRepeat5TouchCount3Array','RtRepeat5TouchSpike4FR_BinArray','RtRepeat5TouchCount4Array','patternnum');
%
% % cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% % FLName=['seqTouch'];
% % save(FLName,'Ltseq5TouchFRArray','Rtseq5TouchFRArray');
% % cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% % FLName=[pegpatternum,pegpatternname];
% % save(FLName,'LtRepeat5TouchSpikeFR_BinArray','LtRepeat5TouchCountArray','RtRepeat5TouchSpikeFR_BinArray','RtRepeat5TouchCountArray'...
% %             ,'Repeat5TouchSpikeFR_BinArray','Repeat5TouchCountArray','Repeat3TouchSpikeFR_BinArray','Repeat3TouchCountArray'...
% %             ,'RLRtrial','LRLtrial','RLRLRtrial','LRLRLtrial','LtIntervalAverageTouchCountArray','LtIntervalAverageSpikeFR_BinArray'...
% %             ,'RtIntervalAverageTouchCountArray','RtIntervalAverageSpikeFR_BinArray');
% % % 両足ピークから0sから近い3つピーク検出
% % %Repeat3touchにおける、ビン毎にそれぞれ何回タッチが当てはまったかの平均
% % for d=1:8
% %     mean(Repeat3TouchCountArray(:,d));
% %     std(Repeat3TouchCountArray(:,d));
% %     Repeat3TouchCountMeanArray=[Repeat3TouchCountMeanArray mean(Repeat3TouchCountArray(:,d))];
% %     Repeat3TouchCountStdArray=[Repeat3TouchCountStdArray std(Repeat3TouchCountArray(:,d))/sqrt(patternnum)];
% % end
% % fig6=figure;
% % y=1:8;
% % bar(y,Repeat3TouchCountMeanArray)
% % set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
% % hold on
% % errorbar(y,Repeat3TouchCountMeanArray,Repeat3TouchCountStdArray,'o')
% % hold off
% % cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% % figname=['Repeat3TouchCountAverageLtRt','.bmp'];
% % saveas(fig6,figname);
% % close(fig6);
% % %Repeat3Touchの発火頻度平均
% % for d=1:8
% %     mean(Repeat3TouchSpikeFR_BinArray(:,d));
% %     std(Repeat3TouchSpikeFR_BinArray(:,d));
% %     Repeat3TouchSpikeFR_BinMeanArray=[Repeat3TouchSpikeFR_BinMeanArray mean(Repeat3TouchSpikeFR_BinArray(:,d))];
% %     Repeat3TouchSpikeFR_BinStdArray=[Repeat3TouchSpikeFR_BinStdArray std(Repeat3TouchSpikeFR_BinArray(:,d))/sqrt(patternnum)];
% % end
% % fig2=figure;
% % y=1:8;
% % bar(y,Repeat3TouchSpikeFR_BinMeanArray)
% % set(gca,'xticklabel',{'no','1','2','3','12','123','13','23'});
% % hold on
% % errorbar(y,Repeat3TouchSpikeFR_BinMeanArray,Repeat3TouchSpikeFR_BinStdArray,'o')
% % hold off
% % cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% % figname=['Repeat3TouchSpikeFR_BinLtRt','.bmp'];
% % saveas(fig2,figname);
% % close(fig2);
% %両足ピーク0sから近い5つ検出
% %タッチカウント平均
% for d=1:13
%     mean(Repeat5TouchCountArray(:,d));
%     std(Repeat5TouchCountArray(:,d));
%     Repeat5TouchCountMeanArray=[Repeat5TouchCountMeanArray mean(Repeat5TouchCountArray(:,d))];
%     Repeat5TouchCountStdArray=[Repeat5TouchCountStdArray std(Repeat5TouchCountArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:13;
% bar(y,Repeat5TouchCountMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
% hold on
% errorbar(y,Repeat5TouchCountMeanArray,Repeat5TouchCountStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['Repeat5TouchCountAverageLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
% %発火頻度平均
% for d=1:13
%     mean(Repeat5TouchSpikeFR_BinArray(:,d));
%     std(Repeat5TouchSpikeFR_BinArray(:,d));
%     Repeat5TouchSpikeFR_BinMeanArray=[Repeat5TouchSpikeFR_BinMeanArray mean(Repeat5TouchSpikeFR_BinArray(:,d))];
%     Repeat5TouchSpikeFR_BinStdArray=[Repeat5TouchSpikeFR_BinStdArray std(Repeat5TouchSpikeFR_BinArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:13;
% bar(y,Repeat5TouchSpikeFR_BinMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','1no','2no','3no','4no','5no','3only','23,34'});
% hold on
% errorbar(y,Repeat5TouchSpikeFR_BinMeanArray,Repeat5TouchSpikeFR_BinStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['Repeat5TouchSpikeFR_BinAverageLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
% %右足0sから近い5つのピーク検出
% %タッチカウント平均
% for d=1:10
%     mean(RtRepeat5TouchCountArray(:,d));
%     std(RtRepeat5TouchCountArray(:,d));
%     RtRepeat5TouchCountMeanArray=[RtRepeat5TouchCountMeanArray mean(RtRepeat5TouchCountArray(:,d))];
%     RtRepeat5TouchCountStdArray=[RtRepeat5TouchCountStdArray std(RtRepeat5TouchCountArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:10;
% bar(y,RtRepeat5TouchCountMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
% hold on
% errorbar(y,RtRepeat5TouchCountMeanArray,RtRepeat5TouchCountStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['RtRepeat5TouchCount_BinAverageLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
% %発火頻度平均
% for d=1:10
%     mean(RtRepeat5TouchSpikeFR_BinArray(:,d));
%     std(RtRepeat5TouchSpikeFR_BinArray(:,d));
%     RtRepeat5TouchSpikeFR_BinMeanArray=[RtRepeat5TouchSpikeFR_BinMeanArray mean(RtRepeat5TouchSpikeFR_BinArray(:,d))];
%     RtRepeat5TouchSpikeFR_BinStdArray=[RtRepeat5TouchSpikeFR_BinStdArray std(RtRepeat5TouchSpikeFR_BinArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:10;
% bar(y,RtRepeat5TouchSpikeFR_BinMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
% hold on
% errorbar(y,RtRepeat5TouchSpikeFR_BinMeanArray,RtRepeat5TouchSpikeFR_BinStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['RtRepeat5TouchSpikeFR_BinAverageLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);
% %左足0sから近い5つのピーク検出
% %タッチカウント平均
% for g=1:10
%     mean(LtRepeat5TouchCountArray(:,g));
%     std(LtRepeat5TouchCountArray(:,g));
%     LtRepeat5TouchCountMeanArray=[LtRepeat5TouchCountMeanArray mean(LtRepeat5TouchCountArray(:,g))];
%     LtRepeat5TouchCountStdArray=[LtRepeat5TouchCountStdArray std(LtRepeat5TouchCountArray(:,g))/sqrt(patternnum)];
% end
% fig9=figure;
% y=1:10;
% bar(y,LtRepeat5TouchCountMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
% hold on
% errorbar(y,LtRepeat5TouchCountMeanArray,LtRepeat5TouchCountStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% trimtfile=strtrim(tfile);
% figname=['LtRepeat5TouchCountAverageLtRt',trimFolder2,trimtfile,'.bmp'];
% saveas(fig9,figname);
% close(fig9);
% %発火頻度平均
% for d=1:10
%     mean(LtRepeat5TouchSpikeFR_BinArray(:,d));
%     std(LtRepeat5TouchSpikeFR_BinArray(:,d));
%     LtRepeat5TouchSpikeFR_BinMeanArray=[LtRepeat5TouchSpikeFR_BinMeanArray mean(LtRepeat5TouchSpikeFR_BinArray(:,d))];
%     LtRepeat5TouchSpikeFR_BinStdArray=[LtRepeat5TouchSpikeFR_BinStdArray std(LtRepeat5TouchSpikeFR_BinArray(:,d))/sqrt(patternnum)];
% end
% fig2=figure;
% y=1:10;
% bar(y,LtRepeat5TouchSpikeFR_BinMeanArray)
% set(gca,'xticklabel',{'no','1','2seq','3seq','4seq','5seq','3no','3only','23,34','5only'});
% hold on
% errorbar(y,LtRepeat5TouchSpikeFR_BinMeanArray,LtRepeat5TouchSpikeFR_BinStdArray,'o')
% hold off
% cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
% figname=['LtRepeat5TouchSpikeFR_BinAverageLtRt','.bmp'];
% saveas(fig2,figname);
% close(fig2);





% Repeat3TouchCountArray=[];
% Repeat3TouchCountMeanArray=[];
% Repeat3TouchCountStdArray=[];
%
% Repeat3TouchSpikeFR_BinArray=[];
% Repeat3TouchSpikeFR_BinMeanArray=[];
% Repeat3TouchSpikeFR_BinStdArray=[];
%
% Repeat5TouchCountArray=[];
% Repeat5TouchCount1Array=[];
% Repeat5TouchCount2Array=[];
% Repeat5TouchCount3Array=[];
% Repeat5TouchCount4Array=[];
%
% Repeat5TouchCountMeanArray=[];
% Repeat5TouchCountStdArray=[];
%
% Repeat5TouchSpikeFR_BinArray=[];
% Repeat5TouchSpike1FR_BinArray=[];
% Repeat5TouchSpike2FR_BinArray=[];
% Repeat5TouchSpike3FR_BinArray=[];
% Repeat5TouchSpike4FR_BinArray=[];
%
% Repeat5TouchSpikeFR_BinMeanArray=[];
% Repeat5TouchSpikeFR_BinStdArray=[];
%
% LtRepeat5TouchCountArray=[];
% LtRepeat5TouchCount1Array=[];
% LtRepeat5TouchCount2Array=[];
% LtRepeat5TouchCount3Array=[];
% LtRepeat5TouchCount4Array=[];
%
% LtRepeat5TouchCountMeanArray=[];
% LtRepeat5TouchCountStdArray=[];
%
% LtRepeat5TouchSpikeRateArray=[];
% LtRepeat5TouchSpikeRateMeanArray=[];
% LtRepeat5TouchSpikeRateStdArray=[];
%
% LtRepeat5TouchSpikeFR_BinArray=[];
% LtRepeat5TouchSpike1FR_BinArray=[];
% LtRepeat5TouchSpike2FR_BinArray=[];
% LtRepeat5TouchSpike3FR_BinArray=[];
% LtRepeat5TouchSpike4FR_BinArray=[];
%
% LtRepeat5TouchSpikeFR_BinMeanArray=[];
% LtRepeat5TouchSpikeFR_BinStdArray=[];
%
% RtRepeat5TouchCountArray=[];
% RtRepeat5TouchCount1Array=[];
% RtRepeat5TouchCount2Array=[];
% RtRepeat5TouchCount3Array=[];
% RtRepeat5TouchCount4Array=[];
%
% RtRepeat5TouchCountMeanArray=[];
% RtRepeat5TouchCountStdArray=[];
%
% RtRepeat5TouchSpikeRateArray=[];
% RtRepeat5TouchSpikeRateMeanArray=[];
% RtRepeat5TouchSpikeRateStdArray=[];
%
% RtRepeat5TouchSpikeFR_BinArray=[];
% RtRepeat5TouchSpike1FR_BinArray=[];
% RtRepeat5TouchSpike2FR_BinArray=[];
% RtRepeat5TouchSpike3FR_BinArray=[];
% RtRepeat5TouchSpike4FR_BinArray=[];
%
%
% RtRepeat5TouchSpikeFR_BinMeanArray=[];
% RtRepeat5TouchSpikeFR_BinStdArray=[];
%
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
