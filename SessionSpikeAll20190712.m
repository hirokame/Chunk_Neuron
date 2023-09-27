function SessionSpikeAll20190712
%%% For striatum analysis
close all;

global FigureSave ShowFig RinterindexArrayBgra LinterindexArrayBgra RinterindexArrayCx LinterindexArrayCx dpath3...
    MaxA1Rt_count MaxZR_count MaxA2Lt_count MaxZL_count MaxADon_count MaxZ_count ZFreq_Int_dist ZFreq_Ph_dist ZFreq_Int_dist_All ZFreq_Ph_dist_All...
    beta_dist Rsq_dist beta_P1_dist Rsq_P1_dist beta_dist_All Rsq_dist_All beta_P1_dist_All Rsq_P1_dist_All...
    render 


CoreDir='E:\CheetahWRLV20200411';
cd(CoreDir);

FigureSave=1;
ShowFig=1;
render=0; %%PLotしないなら0, するなら1

H=ls;
MaxA1Rt_count=[]; % SpectrogramをZscore化→1.5-3.0Hzのピーク。各細胞の最大値を集めた。
MaxZR_count=[]; % Zscore化しない値
MaxA2Lt_count=[];
MaxZL_count=[];
MaxADon_count=[];
MaxZ_count=[];
ZFreq_Int_dist=[]; % Turn MarkerでアラインしたCCのspectrogramの2Hz帯の値。Touch細胞のみで統計
ZFreq_Ph_dist=[];
ZFreq_Int_dist_All=[]; % Touch細胞だけじゃなく、すべての細胞で統計
ZFreq_Ph_dist_All=[];

beta_dist=[];
Rsq_dist=[];
beta_P1_dist=[];
Rsq_P1_dist=[];
beta_dist_All=[];
Rsq_dist_All=[];
beta_P1_dist_All=[];
Rsq_P1_dist_All=[];

for n=1:length(H(:,1))
    TrimStr1=strtrim(H(n,:));
    if ~strcmp(TrimStr1,'.') && ~strcmp(TrimStr1,'..') && isempty(strfind(TrimStr1,'.mat')) && numel(TrimStr1)<4
        cd([CoreDir '\' TrimStr1]);
        H2=ls;
        for m=1:length(H2(:,1))
            cd([CoreDir '\' TrimStr1]);
            TrimStr2=strtrim(H2(m,:));
            if length(TrimStr2)>2 && isdir(TrimStr2)   %~strcmp(TrimStr2(end-4:end),'pptx')
                dpath3=[CoreDir '\' TrimStr1 '\' TrimStr2]
                SessionSpike20180625(dpath3)           % 反応性の解析→変数をsaveするまで
                cellclassify20190712                   % すでにセーブしたデータで分類のcliteriaだけ変えるときはこっちでOK
            end
        end
    end
end
savedir = [CoreDir '\Zscore.mat'];
save(savedir,'MaxA1Rt_count','MaxZR_count','MaxA2Lt_count','MaxZL_count','MaxADon_count','MaxZ_count','ZFreq_Int_dist','ZFreq_Ph_dist','ZFreq_Int_dist_All','ZFreq_Ph_dist_All'...
    ,'beta_dist', 'Rsq_dist', 'beta_P1_dist', 'Rsq_P1_dist', 'beta_dist_All', 'Rsq_dist_All', 'beta_P1_dist_All', 'Rsq_P1_dist_All')

function SessionSpike20180625(dpath3)%pushbutton_SpikeAnalysis2_Callback(hObject, eventdata, handles)
%20180515まではintervalを解析するプログラム、その後はLV（SpikeAnalysis1）とcheetahを同時に解析するプログラム
close all;

global StartTime FinishTime fname SpikeUnits TurnMarkerTime OneTurnTime RPegTouchAll LPegTouchAll DrinkOnArray render ...
    MedPegTimeR MedPegTimeL RpegTimeArray LpegTimeArray RpegTouchall LpegTouchall WaterOnArrayOriginal WaterOffArrayOriginal...
    RpegTimeArray LpegTimeArray DrName UnitDataUnited UnitData FigA FigA3 FigAA...
    DiffMaxMinRpArray DiffMaxMinLpArray DiffMaxMinRArray DiffMaxMinLArray Spname...
    SpikeArray tfile RepeatAnalysis TrimStr FigureSave TotalTime dpath...
    CrossCoWonCell CrossCoWoffCell CrossCoWonCell CrossCoWoffCell NumWon NumWoff CleanWater CleanWaterOn CleanWaterOff...
    CrossCoWonCellClean CrossCoWoffCellClean NumWonC NumWoffC CleanInterval OnWater SpikeArrayWon...
    RpegTouchallWon RpegTouchallWoff LpegTouchallWon LpegTouchallWoff

global CrossCoWonCell CrossCoWoffCell NumWon NumWoff CleanWater CleanInterval WonTouch SpikeArrayWon...
    FirstWaterOn FirstWaterOff CrossCoWonFirst CrossCoWoffFirst CrossCoWonCellFirst CrossCoWoffCellFirst NumWonF NumWoffF ...
    LastWaterOn LastWaterOff CrossCoWonLast CrossCoWoffLast CrossCoWonCellLast CrossCoWoffCellLast NumWonL NumWoffL ...
    MidWaterOn MidWaterOff CrossCoWonMid CrossCoWoffMid CrossCoWonCellMid CrossCoWoffCellMid NumWonM NumWoffM ...
    IndepWaterOn IndepWaterOff CrossCoWonIndep CrossCoWoffIndep CrossCoWonCellIndep CrossCoWoffCellIndep NumWonI NumWoffI ...
    RpegTouchallWon RpegTouchallWoff LpegTouchallWon LpegTouchallWoff OnSize bin...
    fname SpikeName CleanInterval FigureSave

global SliderTouch OneTurnTime RefPeriod RpegMedian LpegMedian RLpegMedian RLpegName DrName fig_touchR fig_touchL fig_touchR_TM fig_touchL_TM fig_TMpegs...
    PtouchHistoCell_R PtouchHistoCell_L WaterOn_percent RLPegTouchAll RPegTouchAll LPegTouchAll FigureSave RpegTimeArray2D LpegTimeArray2D...
    RpegTouchBypegCell  LpegTouchBypegCell RmedianPTTM LmedianPTTM ShowFig patternValue...
    RpegNameSorted LpegNameSorted RLpegNameSorted RpegTouchTurnSorted LpegTouchTurnSorted RLpegTouchTurnSorted RLpegTouchCellSorted ...
    RpegTouchCell LpegTouchCell RpegTouchTurn LpegTouchTurn RpegTouchMatrix LpegTouchMatrix RpegTouchTurnMatrix RLpegTouchTurnMatrix...
    RpegTouchMatrixSorted LpegTouchMatrixSorted RLpegTouchMatrixSorted RpegMedianSorted LpegMedianSorted...
    RpegTouchTurnMatrixSorted LpegTouchTurnMatrixSorted RLpegTouchTurnMatrixSorted...
    RpegTimeArray2D_turn LpegTimeArray2D_turn fig_TouchRL fig_TouchR fig_TouchL RtouchHist LtouchHist RLtouchHist TurnMarkerTime...
    VoltAnalysis TouchTiming DetachTiming DrinkTiming RpNum LpNum RPegTouchAll LPegTouchAll CCresultDrinkOn ClassifyFL TouchSpikeFL KLfname fname TrimStrB...
    FLName KLD1 KLD2 KLD3 KLD4 KLD5 KLD6
global R_PegTouchCell L_PegTouchCell R_PegTouchTurn L_PegTouchTurn %RpegTouchall LpegTouchall

CleanInterval=1500;
CleanWater=1;%WaterOn, WaterOffをきれいにする（3秒間以上空白の後のWaterOnのみ使用、など）なら1、SpikeAnalysisでは0,SpikeAnalysis2では1
CrossCoWonCell=cell(1,2);
CrossCoWoffCell=cell(1,2);
NumWon=[];
NumWoff=[];

FigA=0;


% FigName=[fname,' ',TrimStr(1:end-1),'.bmp'];%char(strcat({S1},{' '},{S2},{' '},{S3},{' '},{S4},{' '},{S5},{' '},{S6},{S7},{' '},{S8},{' '},{S9},{' '},{S10},{'.bmp'}));
% if FigureSave==1;mkdir('C:\Users\B133_2\Desktop',[fname,' spike']);end
% ExD=exist(['C:\Users\B133_2\Desktop',DrName);
% if FigureSave==1 && ExD~=7;mkdir('C:\Users\B133_2\Desktop',[fname,' spike']);end
% if length(dpath3)<45;
%     dpath3 = uigetdir('C:\Users\kit\Desktop\CheetahData');
% end
cd(char(dpath3));
dpath=[dpath3,'\'];
% WD=cd;
SpikeUnits={};
SpikeUnitsWon={};
SpikeName=cell(1,2);
h=ls;
h1=ls;

% U=0;
M=0;
% UnitDataUnited=[];
% DiffMaxMinRpArray=[];
% DiffMaxMinLpArray=[];
% DiffMaxMinRArray=[];
% DiffMaxMinLArray=[];
% RinterindexArray=[];
% LinterindexArray=[];
% R_LPhaseindexArray=[];
% OnePhaseLindexArray=[];
% RtInLtPhaseArray=[];
% LtIntervalArray=[];
% Interval=['IntervalFolder'];
% R_LPhase=['R_LPhaseFolder'];
% OnePhase=['OnePhaseFolder'];
% RtInLtPhase=['RtInLtFolder'];
% LtInterval=['LtIntervalFolder'];
SaveParameter=['ParameterFolder'];
CCS=['CCSFolder'];
% mkdir(R_LPhase);
% mkdir(Interval);
% mkdir(OnePhase);
% mkdir(RtInLtPhase);
% mkdir(LtInterval);
if not(exist(SaveParameter,'dir'))
    mkdir(SaveParameter);
end
if not(exist(CCS, 'dir'))
    mkdir(CCS);
end
for n=1:length(h(:,1))
    TrimStrB=strtrim(h(n,:));
    if length(TrimStrB)>2 && ~strcmp(TrimStrB(1:5),'Event');
        if strcmp(TrimStrB(end-3:end),'.mat')
            if ~strcmp(TrimStrB(end-4:end),'V.mat') && ~strcmp(TrimStrB(1),'a') && ~strcmp(TrimStrB(1),'B')   %% それぞれのpatternのMATLABデータで回していく
                
                
                %         set(handles.text_FileName,'String',TrimStrB(1:end-4));
                M=M+1;
                cd(char(dpath3));
                [SUCCESS,MESSAGE,MESSAGEID] = mkdir(TrimStrB(1:length(TrimStrB)-4));
                if strcmp(MESSAGE,'Directory already exists.')%MESSAGE=='ディレクトリが既に存在します。'
                    rmdir(TrimStrB(1:length(TrimStrB)-4),'s');
                    mkdir(TrimStrB(1:length(TrimStrB)-4));
                end
                
                
                Classifyfolder=strcat(TrimStrB(1:length(TrimStrB)-4),'_Classify');
                if not(exist(Classifyfolder, 'dir'))
                    mkdir(Classifyfolder);
                end
                TouchSpikefolder=strcat(TrimStrB(1:length(TrimStrB)-4),'_TouchSpike');
                if not(exist(TouchSpikefolder, 'dir'))
                    mkdir(TouchSpikefolder);
                end
                
                FLName=[dpath,TrimStrB(1:length(TrimStrB)-4)];
                %         cd(FLName);                   %%tera20190622
                
                
                ClassifyFL=strcat(dpath,Classifyfolder);
                TouchSpikeFL=strcat(dpath,TouchSpikefolder);
                cd(FLName);
                %         Folder=['minKLDF'];
                %         mkdir(Folder);
                %         Kldist=['KLDIV'];
                %         mkdir(Kldist);
                %         Kl=[FLName '\KLDIV'];
                %         cd(Kl);
                %         KLfname=['KL',TrimStrB(1:length(TrimStrB)-4)];
                %         mkdir(KLfname);
                %         cd(FLName);
                %         RtInLt=['RtInLttimeFolder'];
                %         mkdir(RtInLt);
                %         PPT=['prepost'];
                %         mkdir(PPT);
                %
                
                fname=TrimStrB;
                Dataload;%_pushbutton_Callback(hObject, eventdata, handles);
                
                % % % % % % %         PegTouchAnalysis24ch_SSanalysis(R_PegTouchCell,L_PegTouchCell,TurnMarkerTime,OneTurnTime,RpegTimeArray2D,LpegTimeArray2D,1)
                
                U=0;
                for N=1:length(h(:,1))
                    h=h1;
                    TrimStr=strtrim(h(N,:));
                    if length(TrimStr)>2;
                        if TrimStr(end-1:end)=='.t'% & h(k,:)~='.';%length(h(k,:))>5;
                            U=U+1;
                            SpikeName{U}=TrimStr;
                            SpikeArray=GetSpikeAll(dpath3,h(N,:));
                            SpikeArrayWon=[];
                            SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                            SpikeUnits{U}=SpikeArray;
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
                                SpikeUnitsWon{U}=SpikeArrayWon;
                            else
                                SpikeUnitsWon{U}=0;
                            end
                            tfile=h(N,:)
                            Touchfile=[strtrim(tfile),'touchfile.mat'];                 %tera20190622
                            if strcmp(fname((end-8):end-4),'_98__');
                                RpegTouchallWon98=RpegTouchallWon;
                                LpegTouchallWon98=LpegTouchallWon;
                                OneTurnTime98=OneTurnTime;
                                TurnMarkerTime98=TurnMarkerTime;
                                FinishTime98=FinishTime;
                                SpikeArray98=SpikeArrayWon;
                                save(Touchfile,'RpegTouchallWon98','LpegTouchallWon98','OneTurnTime98','TurnMarkerTime98','FinishTime98','SpikeArray98');
                            end
                            %                 if strcmp(tfile,'Sc4_SS_05.t')==1
                            %                     tfile
                            %                 end
                            %         FourierAnalysis(SpikeArray,StartTime,FinishTime);
                            %Interval, Phase analysis
                            %         [Fig1, Fig2]=TouchSpikeAnalysis20170328(SpikeArray,RpegTouchall,LpegTouchall,fname,TrimStr);%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            %                 SpikeAnalysisSet20180528(N,U,M)
                            SpikeAnalysisSet20190214(N,U,M)  
                            Fourierfunction(CCresultDrinkOn) % LickでアラインしたCCをFT -> SpectrogramのZscore計算
                            FourierfunctionRtouch190213 % TouchでアラインしたCCをFT -> SpectrogramのZscore計算 ＋ 1歩の中の位相反応性
                            modulation20190709  % TurnmarkerでアラインしたCCをFT -> SpectrogramのZscore計算
                            Repeat_20230510  % Repeat解析(betaとR^2をすべてのpatternで計算)
                            SaveParameter20190531 % Approach/Leaveの前後で発火頻度計算　→　t-test　→ここまでのすべての変数を保存
                        end
                    end
                end
                %         pushbutton_save_Callback(hObject, eventdata, handles);
                SAVEall;
                %         cd(char(dpath3));
                eval(['save a',fname(1,1:end-4),' UnitData UnitDataUnited TotalTime OneTurnTime;']);
            end
        end
    end
    close all hidden;
end

OnSize=size(CrossCoWonCell);%CrossCoWonCell,CrossCoWoffCellはSpikeAnalysisSetで計算されるSession通しでのWon/offでのCrossCo

cd(char(dpath3));
bin=500;

for m=1:OnSize(2)%OnSize(1)はSession数、OnSize(2)はUnit数
    OnAll=[];OffAll=[];
    for n=1:OnSize(1)
        a=CrossCoWonCell{n,m};
        OnAll=[OnAll; a];
        OffAll=[OffAll; CrossCoWoffCell{n,m}];
    end
    OnAll(OnAll==-5000)=[];OnAll(OnAll==5000)=[];
    OffAll(OffAll==-5000)=[];OffAll(OffAll==5000)=[];
    OnAll=[-5000; OnAll; 5000];
    OffAll=[-5000; OffAll; 5000];
    eval(['WaterFigA',int2str(m),'=figure;']);
    %     eval(['FigNum=WaterFigA',int2str(m)]);
    if render==1;
        subplot(5,1,1);
        if sum(NumWon)~=0 && sum(NumWoff)~=0
            
            CCresultWon=hist(OnAll,bin)/sum(NumWon);
            CCresultWon=MovWindow(CCresultWon,10);
            %         subplot(3,6,5:6);
            plot(linspace(1,10000,bin),CCresultWon,'color','b');hold on
            
            CCresultWoff=hist(OffAll,bin)/sum(NumWoff);
            CCresultWoff=MovWindow(CCresultWoff,10);
            %         subplot(3,6,5:6);
            plot(linspace(1,10000,bin),CCresultWoff,'color','r');
            axis([0 10000 0 max(max(CCresultWon),max(CCresultWoff))*1.1]);
            xlabel([fname,'  ',SpikeName{m},', All On/Off, /WaterOn(',int2str(sum(NumWon)),'), /WaterOff(',int2str(sum(NumWoff)),')']);
            
        elseif sum(NumWon)~=0
            CCresultWon=hist(OnAll,bin)/sum(NumWon);
            CCresultWon=MovWindow(CCresultWon,10);
            %         subplot(3,6,5:6);
            plot(linspace(1,10000,bin),CCresultWon,'color','b');
            axis([0 10000 0 max(CCresultWon)*1.1]);
            xlabel([fname,'  ',SpikeName{m},', All On/Off, /WaterOn(',int2str(sum(NumWon)),')']);
        elseif sum(NumWoff)~=0
            %         figure
            CCresultWoff=hist(OffAll,bin)/sum(NumWoff);
            CCresultWoff=MovWindow(CCresultWoff,10);
            %         subplot(3,6,5:6);
            plot(linspace(1,10000,bin),CCresultWoff,'color','r');
            axis([0 10000 0 max(CCresultWoff)*1.1]);
            xlabel([fname,'  ',SpikeName{m},', All On/Off, /WaterOff(',int2str(sum(NumWoff)),')']);
        end
        
        % eval(['WaterFig=WaterFigA',int2str(m)]);
        AllWaterFig20180703(CrossCoWonCellFirst,CrossCoWoffCellFirst,NumWonF,NumWoffF,2,'First On/Off',m);%,WaterFig);
        AllWaterFig20180703(CrossCoWonCellMid,CrossCoWoffCellMid,NumWonM,NumWoffM,3,'Middle On/Off',m);
        AllWaterFig20180703(CrossCoWonCellLast,CrossCoWoffCellLast,NumWonL,NumWoffL,4,'Last On/Off',m);
        AllWaterFig20180703(CrossCoWonCellIndep,CrossCoWoffCellIndep,NumWonI,NumWoffI,5,'Independent On/Off',m);
        
        FigName=[SpikeName{m},' AllWater.bmp'];%char(strcat({S1},{' '},{S2},{' '},{S3},{' '},{S4},{' '},{S5},{' '},{S6},{S7},{' '},{S8},{' '},{S9},{' '},{S10},{'.bmp'}));
        if FigureSave==1
            eval(['saveas(WaterFigA',int2str(m),',FigName);']);
            %         eval(['clear WaterFigA',int2str(m)]);
        end
    end
end
% clear WaterFigA*

function Dataload%_pushbutton_Callback(hObject, eventdata, handles)

global dpath fname PegOffset RpegTimeArray LpegTimeArray OneTurnTime TurnMarkerTime RpegTimeArray2D LpegTimeArray2D render ...
    WaterOnArray WaterOffArray WaterOnArrayOriginal WaterOffArrayOriginal SpikeNum data DrName ShowFig FigureSave modif patternValue...
    NumDrinkTurn NumDrinkTurnCum OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum OnWater VoltAnalysis StartTime FinishTime...
    TouchTiming DetachTiming DrinkTiming DrinkOnArray OnWater RpegTouchall LpegTouchall WonTouch...
     RpegTouchallWoff LpegTouchallWon LpegTouchallWoff FigureSave ShowFig MedPegTimeR MedPegTimeL
%SpikeNumはDataLoadでSpikeNum=1と設定され、あとはSpikeAnalysis内で実行のたびに１ずつ増加する。
% ShowFig=0%get(handles.radiobutton_ShowFigure,'Value');
% FigureSave=get(handles.radiobutton_SaveFigure,'Value');
% patternValue=get(handles.popupmenu_pattern,'Value');
% PegOffsetCell=get(handles.popupmenu_offset,'String');
% PegOffset=str2double(PegOffsetCell(get(handles.popupmenu_offset,'Value')))
PegOffset=0;%使用しない。なくしてもいいが、Dataloadの引数になっているので注意。
[RpegTimeArray,LpegTimeArray,RpegTimeArray2D,LpegTimeArray2D,OneTurnTime TurnMarkerTime data]=DataLoad24ch(PegOffset,dpath,fname);

% MedPegTimeR(MedPegTimeR==0)=[];
% MedPegTimeL(MedPegTimeL==0)=[];

% % % % BgraR=[49,380,825,1326,1884,2436,2940,3385,3716];
% % % % BgraL=[43,372,815,1315,1870,2424,2925,3369,3703];
% % % A=int32(MedPegTimeR/OneTurnTime*10000);
% % % B=int32(MedPegTimeL/OneTurnTime*10000);
% % % if length(MedPegTimeR)==9 && length(MedPegTimeL)==9 && ...
% % %         sum(abs(A-int32([112,940,1912,3018,4273,5657,6922,8026,9138])))<300 && sum(abs(B-int32([77,907,1892,2996,4255,5630,6879,7991,9105])))<300
% % %         patternValue=11;%Bgra
% % % elseif length(MedPegTimeR)==10 && length(MedPegTimeR)==9
% % %     patternValue=12;%9-8
% % % elseif length(MedPegTimeR)==9 && length(MedPegTimeR)==10
% % %     patternValue=13;%8-9
% % % elseif length(MedPegTimeR)==12 && length(MedPegTimeL)==11 && sum(abs(MedPegTimeR-[75,487,906,1322,1738,2154,2575,2991,3412,3832,4257,4676]))<100 && sum(abs(MedPegTimeL-[68,487,903,1320,1738,2154,2571,3196,3614,4029,4454]))<100
% % %     patternValue=14;%B7-A
% % % elseif length(MedPegTimeR)==12 && length(MedPegTimeL)==13 && ...
% % %     sum(abs(MedPegTimeR-[87,435,991,1336,1754,2033,2523,3074,3355,3772,4187,4742]))<100 && sum(abs(MedPegTimeL-[104,489,869,1246,2010,2421,2628,2975,3598,3945,4366,4851,2428]))<100
% % %     patternValue=15;%C3
% % % elseif length(MedPegTimeR)==12 && length(MedPegTimeL)==12 && ...
% % %     sum(abs(MedPegTimeR-[609,887,1235,1718,2206,2345,2896,3381,3869,4287,4563,4903]))<100 && sum(abs(MedPegTimeL-[330,673,1229,1506,1994,2340,2896,3314,3942,4217,4771,4908]))<100
% % %     patternValue=16;%C7
% % % elseif length(MedPegTimeR)==9 && length(MedPegTimeL)==8 && ...
% % %     sum(abs(A-int32([783,1895,2998,4108,5213,6320,7435,8550,9665])))<100 && sum(abs(B-int32([83,1335,2575,3825,5065,6310,7560,8823])))<100
% % %     patternValue=17;%9-8
% % % elseif length(MedPegTimeR)==14 && length(MedPegTimeL)==14 && ...
% % %     sum(abs(A-int32([297,1136,1865,2682,3438,4252,5054,5828,6649,7438,8220,8944,9483,0])))<300 && sum(abs(B-int32([645,1333,2447,3001,3970,4664,5783,6617,7868,8424,9533,9810,0,0])))<300
% % %     patternValue=18;%C9+
% % % end

StartTime=data(1,2);
FinishTime=data(1,3);

% VoltAnalysis=get(handles.radiobutton_VoltageAnalysis,'Value');
VoltAnalysis=0;
RpegTouchall=[];
LpegTouchall=[];
global R_PegTouchCell L_PegTouchCell R_PegTouchTurn L_PegTouchTurn %RpegTouchall LpegTouchall

if VoltAnalysis==1
    Fig=0;
    [TouchTiming DetachTiming DrinkTiming]=VoltageAnalysis20170719(dpath,fname,Fig);
    
    DrinkOnArray=find(DrinkTiming==1)';
    
    %     % 離れたタイミングでのノイズが多い場合に持ちいる
    %     RpegAreaMatrix=zeros(12,FinishTime);
    %     LpegAreaMatrix=zeros(12,FinishTime);
    %     for n=1:12
    %         for m=1:min(length(RpegTimeArray2D(:,1)),length(LpegTimeArray2D(:,1)))
    %             A=max(1,RpegTimeArray2D(m,n)-999);
    %             B=min(FinishTime,RpegTimeArray2D(m,n)+1000);
    %             RpegAreaMatrix(n,A:B)=1;
    %             A=max(1,LpegTimeArray2D(m,n)-999);
    %             B=min(FinishTime,LpegTimeArray2D(m,n)+1000);
    %             LpegAreaMatrix(n,A:B)=1;
    %         end
    %     end
    %     TouchTiming=TouchTiming.* [LpegAreaMatrix;RpegAreaMatrix];
    
    %     TouchTiming=DetachTiming;
else
    WonTouch=0;%1のとき、WaterOnのときのTouchのみを選別。
    RightTouchData=[data(:,14),data(:,15),data(:,16),data(:,17),data(:,18),data(:,19),data(:,20),data(:,21),data(:,22),data(:,23),data(:,24),data(:,25)];
    [R_PegTouchCell,R_PegTouchTurn]=PegTouch24ch(RightTouchData);
    
    LeftTouchData=[data(:,42),data(:,43),data(:,44),data(:,45),data(:,46),data(:,47),data(:,48),data(:,49),data(:,50),data(:,51),data(:,52),data(:,53)];
    [L_PegTouchCell,L_PegTouchTurn]=PegTouch24ch(LeftTouchData);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %連続して複数回のタッチがあった場合、最初のものを採用。きれいなタッチが取れている場合のみ有効
    RpegTouchcell=cell(1,12);RpegTouchall=[];
    for n=1:length(R_PegTouchCell)
        if ~isempty(R_PegTouchCell{n})
            RpegTouchcell{n}=[RpegTouchcell{n} R_PegTouchCell{n}(1)];
        end
        for m=2:length(R_PegTouchCell{n})
            if R_PegTouchCell{n}(m)-R_PegTouchCell{n}(m-1)>OneTurnTime/2
                RpegTouchcell{n}=[RpegTouchcell{n} R_PegTouchCell{n}(m)];
            end
        end
        RpegTouchall=[RpegTouchall RpegTouchcell{n}];
    end
    RpegTouchall=sort(RpegTouchall,'ascend');
    
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
    
    LpegTouchcell=cell(1,12);
    for n=1:length(L_PegTouchCell)
        if ~isempty(L_PegTouchCell{n})
            LpegTouchcell{n}=[LpegTouchcell{n} L_PegTouchCell{n}(1)];
        end
        for m=2:length(L_PegTouchCell{n})
            if L_PegTouchCell{n}(m)-L_PegTouchCell{n}(m-1)>OneTurnTime/2
                LpegTouchcell{n}=[LpegTouchcell{n} L_PegTouchCell{n}(m)];
            end
        end
        LpegTouchall=[LpegTouchall LpegTouchcell{n}];
    end
    LpegTouchall=sort(LpegTouchall,'ascend');
    
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DrinkOnArrayOriginal=data(:,27);
    DrinkOffArrayOriginal=data(:,41);
    
    EventName='DrinkOn';
    [DrinkOnArrayOriginal,DrinkOffArrayOriginal,DrinkOnArray,DrinkOffArray]=Modify_Events(DrinkOnArrayOriginal,DrinkOffArrayOriginal,StartTime,FinishTime,EventName);
    
    [DrinkOn_percent]=Water_percentage(DrinkOnArray,DrinkOffArray,StartTime,FinishTime);
    DrinkMark=WaterMark(DrinkOnArray, DrinkOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);
    if render == 1
        fig_DrinkMark=figure;
        plot(DrinkMark);axis([0 OneTurnTime 0 100]);title('DrinkMark');zoom xon
        if FigureSave==1;
            saveas(fig_DrinkMark,[DrName,' ','DrinkMark.bmp']);
        end
    end
end

DrinkOnRaster=raster(DrinkOnArray,TurnMarkerTime);
if VoltAnalysis==0;DrinkOffRaster=raster(DrinkOffArray,TurnMarkerTime);end

NumDrinkTurn=zeros(1,length(TurnMarkerTime)-1);
NumDrinkTurnCum=zeros(1,length(TurnMarkerTime)-1);
if ~isempty(DrinkOnRaster)
    for n=1:length(TurnMarkerTime)-1
        NumDrinkTurn(n)=sum(DrinkOnRaster(:,2)==n);
        if n>=2
            NumDrinkTurnCum(n)=NumDrinkTurnCum(n-1)+NumDrinkTurn(n);
        end
    end
    if render == 1
        fig_DrinkOnCount=figure;
        plot(NumDrinkTurn);
        title('DrinkOnCount/Turn');
        fig_NumDrink=figure;
        plot(NumDrinkTurnCum);
        title('Cumlative DrinkOnCount/Turn');
        if FigureSave==1;
            saveas(fig_NumDrink,[DrName,' ','NumDrink.bmp']);
        end
        fig_DrinkOn=figure;hold on
        if length(DrinkOnRaster)>1;
            plot(DrinkOnRaster(:,1),DrinkOnRaster(:,2),'go');
        end
        if VoltAnalysis==0 && length(DrinkOffRaster)>1;
            plot(DrinkOffRaster(:,1),DrinkOffRaster(:,2),'rx');
        end
        title('Drink');
        zoom xon;
        hold off;
        if FigureSave==1;
            saveas(fig_DrinkOn,[DrName,' ','DrinkOn.bmp']);
        end
    end
end
modif=0;
% disp('loaded');

function SAVEall
global data PegOffset dpath fname PegTouchTurn SliderTouch PegTouchCell...
    RpegTouchCell LpegTouchCell RLpegTouchCell CrossVar CrossVarInv OneTurnTime DrName RpegTouchTurn LpegTouchTurn  RPegTouchAll LPegTouchAll RLPegTouchAll FTselect RefPeriod ... %FTselect=first touch or All touches
    TurnMarkerTime RpegTimeArray LpegTimeArray PtouchHistoCell_R PtouchHistoCell_L CrossVarInv_2 CrossVarInv_3 CrossVarInv_4 WaterOnArray WaterOffArray WaterOnArrayOriginal WaterOffArrayOriginal...
    RpegTimeArray2D LpegTimeArray2D RpegTimeArray2D_turn LpegTimeArray2D_turn RLpegName RLpegMedian RpegMedian LpegMedian MedPegTimeR MedPegTimeL StartTime FinishTime ...
    CovInterval_3 CoefInterval_3 SpikeArrayCell CovInterval_5 CoefInterval_5 VarMeans VarSTD Spike ...
    Prod_Int_dev_abs_Mean_3 Prod_Int_dev_abs_Var_3 Prod_Int_dev_abs_Mean_5 Prod_Int_dev_abs_Var_5 PegVar VarNextPeg...
    WaterOn_percent DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray DrinkOn_percent FloorTouch_percent Num_SmallVar ChunkLength ChunkEnd...
    SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 SE lengthEvent Repeat RLRphase LRLphase RLRbefore LRLbefore IntervalR IntervalL...
    RatioAlikeLRL RatioAlikeRLR RatioBlikeLRL RatioBlikeRLR StdLRLphase StdRLRphase StdLRLdiff StdRLRdiff StdIntervalRL StdRLTouchInterval WaterN MeanWaterTime...
    RpegTouchBypegCell LpegTouchBypegCell RmedianPTTM LmedianPTTM LTouchAll RTouchAll LRLpegphase RLRpegphase LRLpegTimeArray RLRpegTimeArray ...
    TurnMarkerTime_L TurnMarkerTime_R MedPegTimeL_L MedPegTimeL_R MedPegTimeR_L MedPegTimeR_R TurnMarkerTimeB TurnMarkerTimeA patternValue ...
    LTouchfromPeg StdLTouchTiming RTouchfromPeg StdRTouchTiming MeanStdTouch VarianceList...
    RpegTouchall LpegTouchall RpegTouchall LpegTouchall filename OnWater...
    NumDrinkTurn NumDrinkTurnCum OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum fig_TouchR fig_TouchL RtouchHist LtouchHist...
    RLtouchHist SpikeUnits UnitDataUnited UnitData...
    PeakMatrix TroughMatrix SameT_peak SameT_trough...
    DifT_peak DifT_trough DiffMaxMinRpArray DiffMaxMinLpArray DiffMaxMinRArray DiffMaxMinLArray U TetrodeNum CCresultSp1Sp2 Colors SpikeCell TurnMarkerTime

%RpegMedian,LpegMedianはTouch時間のMedian
%MedPegTimeR MedPegTimeLはPeg到達時間のMedian

Sname=[DrName 'Bdata.mat'];
feval('save',Sname);%すべてのデータをmat形式で保存

function [RpegTimeArray,LpegTimeArray,RpegTimeArray2D,LpegTimeArray2D,OneTurnTime,TurnMarkerTime data]=DataLoad24ch(PegOffset,dpath,fname)

%1A：Info（date, mouseID, sessionNo,training condition, Num.Turns,TotalTouchTime, TotalWaterOn, Num.Stops, 1-10, 11-20, 21-30, 31-40,,,)
%2B:Start time array
%3C:Stop time array
%4D:TurnTime, cumulative
%5E:OneTurnTime
%6F:cumulativeTouchTime array; fall down
%7G:WaterOnTime array
%8H:WaterOffTime array
%9I:Stop Time array
%10J:Lpeg Time array
%11K:Rpeg Time array
%12L:CumulativeTouchTime; fall down
%13M:TotalTouchTime by 10;fall down
%14N-25Y:TouchTime sensor 1-12
%28AB-39AM:DetachTime sensor 1-12
%26Z:Floor Touch sensor
%27AA:Spout Touch sensor//
%40AN:Floor Detach sensor
%41AU:Spout Detach sensor//


%clear all
% %Eventデータの読み込み
% cd 'C:\Documents and Settings\kit\デスクトップ\WR LVdata';
% %dpath='C:\Documents and Settings\kit\デスクトップ\WR LVdata\';
% [fname,dpath] = uigetfile('*.xls');
%

global  OneTurnTimeArray ...
    WaterOnArrayOriginal WaterOffArrayOriginal WaterOnArray WaterOffArray render...
    RpegTimeArray2D_turn LpegTimeArray2D_turn MedPegTimeR MedPegTimeL StartTime FinishTime...
    SpikeNum WaterOn_percent DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray DrinkOn_percent FloorTouch_percent DrName...
    fig_WaterMark fig_DrinkMark fig_FloorMark fig_WaterOn fig_DrinkOn fig_Floor FigureSave patternValue...
    TurnMarkerTime_L TurnMarkerTime_R MedPegTimeL_L MedPegTimeL_R MedPegTimeR_L MedPegTimeR_R TurnMarkerTimeB TurnMarkerTimeA...
    NumDrinkTurn NumDrinkTurnCum OnWater OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum...
    fig_OnWater fig_DrinkMark fig_NumDrink fig_FloorMark fig_NumFloorTouch fig_WaterOnLen fig_DrinkOnCount fig_FloorTouchCount VoltAnalysis

if strfind(fname,' ')>0
    data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
elseif strfind(fname,'_')>0
    %     cd(dpath)
    %     A=[dpath fname];
    try
        data=load([dpath fname],'-ascii');
    catch exception
        data=load([dpath fname]);
    end
    
else
    data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
end
%num_pegs=12;
SpikeNum=1;

%Sessionの最初と最後を規定。複数セッションの解析のためには作り直す必要あり。
StartTime=data(1,2);
FinishTime=data(1,3);

%PegOffset: Peg　位置補正 TurnMarkerと重なったとき
RpegTimeArrayOriginal=data(:,11)-PegOffset;RpegTimeArrayOriginal(RpegTimeArrayOriginal==-PegOffset)=[];
LpegTimeArrayOriginal=data(:,10)-PegOffset;LpegTimeArrayOriginal(LpegTimeArrayOriginal==-PegOffset)=[];
RpegTimeArray=RpegTimeArrayOriginal(RpegTimeArrayOriginal>StartTime & RpegTimeArrayOriginal<FinishTime);
LpegTimeArray=LpegTimeArrayOriginal(LpegTimeArrayOriginal>StartTime & LpegTimeArrayOriginal<FinishTime);

%dataを内容ごとに分離、要素０の場合要素を削除%最終的にStartTimeとFinishTimeの間のものだけを残す。
TurnMarkerTimeA=[];TurnMarkerTimeB=[];
if patternValue==15 % RLpegがBlikeで入ったときのTurnMarkerをTurnMarkerTimeとする。ただし、そのときマウスは逆位置でAlike。
    TurnMarkerTimeOriginal=data(:,4);TurnMarkerTimeOriginal(TurnMarkerTimeOriginal==0)=[];
    TurnMarkerTime=TurnMarkerTimeOriginal(TurnMarkerTimeOriginal>StartTime & TurnMarkerTimeOriginal<=FinishTime);
    for n=1:length(TurnMarkerTime)-1
        RTime=RpegTimeArray-TurnMarkerTime(n);
        LTime=LpegTimeArray-TurnMarkerTime(n);
        if abs(min(RTime(RTime>0))-min(LTime(LTime>0)))<20
            TurnMarkerTimeA=[TurnMarkerTimeA;TurnMarkerTime(n)];
        elseif abs(max(RTime(RTime<0))-max(LTime(LTime<0)))<20
            TurnMarkerTimeB=[TurnMarkerTimeB;TurnMarkerTime(n)];
        end
    end
    OneTurnTimeArray=data(:,5);OneTurnTimeArray(find(OneTurnTimeArray==0))=[];%for n=length(OneTurnTimeArray):-1:1;if OneTurnTimeArray(n)==0;On nTimeArray(n)=[];end;end;
    OneTurnTime=median(OneTurnTimeArray)*2;
    TurnMarkerTime=TurnMarkerTimeA;
else
    TurnMarkerTimeOriginal=data(:,4);TurnMarkerTimeOriginal(TurnMarkerTimeOriginal==0)=[];
    TurnMarkerTime=TurnMarkerTimeOriginal(TurnMarkerTimeOriginal>StartTime & TurnMarkerTimeOriginal<=FinishTime);
    OneTurnTimeArray=data(:,5);OneTurnTimeArray(find(OneTurnTimeArray==0))=[];%for n=length(OneTurnTimeArray):-1:1;if OneTurnTimeArray(n)==0;On nTimeArray(n)=[];end;end;
    
    %One turnの中央値を一周の時間とする
    OneTurnTime=median(OneTurnTimeArray);
end

%WaterEventの処理　Original:記録されたそのまま　-----------------------begin
WaterOnArrayOriginal=data(:,7);
WaterOffArrayOriginal=data(:,8);

%WaterOnArrayは、最初と最後やデータ抜けなどを修正したもの。
EventName='WaterOn';
[WaterOnArrayOriginal,WaterOffArrayOriginal,WaterOnArray,WaterOffArray]=Modify_Events(WaterOnArrayOriginal,WaterOffArrayOriginal,StartTime,FinishTime,EventName);
[WaterOn_percent]=Water_percentage(WaterOnArray,WaterOffArray,StartTime,FinishTime);
WaterMarkTurn=WaterMark(WaterOnArray, WaterOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);

if WaterOnArray(1)<WaterOffArray(1)
    OnWater=zeros(1,FinishTime);
else
    OnWater=ones(1,FinishTime);
end

a=1;b=1;

% if WaterOnArray(1)==1
%     OnWater(1)=1;
%     a=2;
% end

% ここでエラーが出たら上4行を操作（コメントイン or アウト）要、修正。
for n=2:length(OnWater)
    if n~=WaterOnArray(a) && n~=WaterOffArray(b)
        OnWater(n)=OnWater(n-1);
    elseif n==WaterOnArray(a)
        OnWater(n)=1;
        if a<length(WaterOnArray);a=a+1;end
    elseif n==WaterOffArray(b)
        OnWater(n)=0;
        if b<length(WaterOffArray);b=b+1;end
    end
end

OnWaterLen=zeros(1,length(TurnMarkerTime)-1);
OnWaterLenCum=zeros(1,length(TurnMarkerTime)-1);
for n=1:length(TurnMarkerTime)-1
    TempOnW=OnWater(TurnMarkerTime(n):TurnMarkerTime(n+1));
    OnWaterLen(n)=sum(TempOnW(TempOnW==1));
    if n>=2
        OnWaterLenCum(n)=OnWaterLenCum(n-1)+OnWaterLen(n);
    end
end
if render==1;
    fig_WaterOnLen=figure;
    plot(OnWaterLen);
    title('WaterOnLen/Turn');
    
    fig_OnWater=figure;
    plot(OnWaterLenCum);
    title('Cumlative WaterOnLen/Turn');
    if FigureSave==1;
        saveas(fig_OnWater,[DrName,' ','fig_OnWater.bmp']);
    end
    
    fig_WaterMark=figure;
    plot(WaterMarkTurn);
    axis([0 OneTurnTime 0 100]);
    title('WaterMark');
    if FigureSave==1;
        saveas(fig_WaterMark,[DrName,' ','WaterMark.bmp']);
    end
end
WaterOnRaster=raster(WaterOnArray,TurnMarkerTime);
WaterOffRaster=raster(WaterOffArray,TurnMarkerTime);
if render==1;
    fig_WaterOn=figure;
    hold on
    if length(WaterOnRaster)>1;
        plot(WaterOnRaster(:,1),WaterOnRaster(:,2),'go');
    end
    if length(WaterOffRaster)>1;
        plot(WaterOffRaster(:,1),WaterOffRaster(:,2),'rx');
    end
    title('WaterOn-Off');
    hold off;
    if FigureSave==1;
        saveas(fig_WaterOn,[DrName,' ','WaterOn.bmp']);
    end
end

%WaterEvent処理--------------------------------------------------------end

%Drink解析　Water_percentage、WaterMarkを流用----------------------------
% % % % % if VoltAnalysis==0%VoltageAnalysis, Voltage dataからのDrinkを計算しない場合
% % % % %     DrinkOnArrayOriginal=data(:,27);
% % % % %     DrinkOffArrayOriginal=data(:,41);
% % % % %
% % % % %     EventName='DrinkOn';
% % % % %     [DrinkOnArrayOriginal,DrinkOffArrayOriginal,DrinkOnArray,DrinkOffArray]=Modify_Events(DrinkOnArrayOriginal,DrinkOffArrayOriginal,StartTime,FinishTime,EventName);
% % % % %
% % % % %     [DrinkOn_percent]=Water_percentage(DrinkOnArray,DrinkOffArray,StartTime,FinishTime);
% % % % %     DrinkMark=WaterMark(DrinkOnArray, DrinkOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);
% % % % %
% % % % %     fig_DrinkMark=figure;
% % % % %     plot(DrinkMark);axis([0 OneTurnTime 0 100]);title('DrinkMark');zoom xon
% % % % %     if FigureSave==1;saveas(fig_DrinkMark,[DrName,' ','DrinkMark.bmp']);end
% % % % %
% % % % %     DrinkOnRaster=raster(DrinkOnArray,TurnMarkerTime);
% % % % %     DrinkOffRaster=raster(DrinkOffArray,TurnMarkerTime);
% % % % %
% % % % %     NumDrinkTurn=zeros(1,length(TurnMarkerTime)-1);
% % % % %     NumDrinkTurnCum=zeros(1,length(TurnMarkerTime)-1);
% % % % %     for n=1:length(TurnMarkerTime)-1
% % % % %         NumDrinkTurn(n)=sum(DrinkOnRaster(:,2)==n);
% % % % %         if n>=2
% % % % %             NumDrinkTurnCum(n)=NumDrinkTurnCum(n-1)+NumDrinkTurn(n);
% % % % %         end
% % % % %     end
% % % % %     fig_DrinkOnCount=figure;
% % % % %     plot(NumDrinkTurn);title('DrinkOnCount/Turn');
% % % % %     fig_NumDrink=figure;
% % % % %     plot(NumDrinkTurnCum);title('Cumlative DrinkOnCount/Turn');
% % % % %     if FigureSave==1;saveas(fig_NumDrink,[DrName,' ','NumDrink.bmp']);end
% % % % %
% % % % %     fig_DrinkOn=figure;hold on
% % % % %     if length(DrinkOnRaster)>1;plot(DrinkOnRaster(:,1),DrinkOnRaster(:,2),'go');end
% % % % %     if length(DrinkOffRaster)>1;plot(DrinkOffRaster(:,1),DrinkOffRaster(:,2),'rx');end
% % % % %     title('Drink');zoom xon;hold off;
% % % % %     if FigureSave==1;saveas(fig_DrinkOn,[DrName,' ','DrinkOn.bmp']);end
% % % % % end
%-----------------------------------------------------------------------

% % % % % % %足の踏み外し解析　Water_percentage、WaterMarkを流用----------------------
% % % % % % FloorTouchArrayOriginal=data(:,26);
% % % % % % FloorDetachArrayOriginal=data(:,40);
% % % % % %
% % % % % % % if FloorTouchArrayOriginal(1)==0;FloorTouchArrayOriginal(1)=1;end
% % % % % % % if FloorTouchArrayOriginal(end)>FloorDetachArrayOriginal(end);FloorDetachArrayOriginal(length(FloorDetachArrayOriginal))=FinishTime;end
% % % % % %
% % % % % % if FloorTouchArrayOriginal(1)==0 & FloorTouchArrayOriginal(end)==0;
% % % % % %     FloorTouch_percent=0
% % % % % % else
% % % % % %     EventName='FloorTouch'
% % % % % %     [FloorTouchArrayOriginal,FloorDetachArrayOriginal,FloorTouchArray,FloorDetachArray]=Modify_Events(FloorTouchArrayOriginal,FloorDetachArrayOriginal,StartTime,FinishTime,EventName);
% % % % % %     [FloorTouch_percent]=Water_percentage(FloorTouchArray,FloorDetachArray,StartTime,FinishTime)
% % % % % %     FloorMark=WaterMark(FloorTouchArray, FloorDetachArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);
% % % % % %
% % % % % %     fig_FloorMark=figure;
% % % % % %     plot(FloorMark);axis([0 OneTurnTime 0 100]);
% % % % % %     if FigureSave==1;saveas(fig_FloorMark,[DrName,' ','FloorMark.bmp']);end
% % % % % %
% % % % % %     FloorTouchRaster=raster(FloorTouchArray,TurnMarkerTime);
% % % % % %     FloorDetachRaster=raster(FloorDetachArray,TurnMarkerTime);
% % % % % %
% % % % % %     DrinkOnRaster=raster(DrinkOnArray,TurnMarkerTime);
% % % % % %     DrinkOffRaster=raster(DrinkOffArray,TurnMarkerTime);
% % % % % %
% % % % % %     NumFloorTouchTurn=zeros(1,length(TurnMarkerTime)-1);
% % % % % %     NumFloorTouchTurnCum=zeros(1,length(TurnMarkerTime)-1);
% % % % % %     for n=1:length(TurnMarkerTime)-1
% % % % % %         NumFloorTouchTurn(n)=sum(FloorTouchRaster(:,2)==n);
% % % % % %         if n>=2
% % % % % %             NumFloorTouchTurnCum(n)=NumFloorTouchTurnCum(n-1)+NumFloorTouchTurn(n);
% % % % % %         end
% % % % % %     end
% % % % % %     fig_FloorTouchCount=figure
% % % % % %     plot(NumFloorTouchTurn);title('FloorTouchCount/Turn');
% % % % % %     fig_NumFloorTouch=figure
% % % % % %     plot(NumFloorTouchTurnCum);title('Cumlative FloorTouchCount/Turn');
% % % % % %     if FigureSave==1;saveas(fig_NumFloorTouch,[DrName,' ','NumFloorTouch.bmp']);end
% % % % % %
% % % % % %     fig_Floor=figure;hold on
% % % % % %     if length(FloorTouchRaster)>1;plot(FloorTouchRaster(:,1),FloorTouchRaster(:,2),'go');end
% % % % % %     if length(FloorDetachRaster)>1;plot(FloorDetachRaster(:,1),FloorDetachRaster(:,2),'rx');end
% % % % % %     title('FloorTouch');hold off;
% % % % % %     if FigureSave==1;saveas(fig_Floor,[DrName,' ','FloorTouch.bmp']);end
% % % % % % end
% % % % % %
% % % % % % %-----------------------------------------------------------------------


%Rpeg番号
R_under=0;
R_over=0;
TM=1;
RpegTimeArray2D=[];
RpegTimeArray2D_turn=[];
pegN=1;%pegN<=12 ペグ12本のとき
for n=1:length(RpegTimeArray)
    if pegN==13&&RpegTimeArray(n)>TurnMarkerTime(TM)&&RpegTimeArray(n)+50>TurnMarkerTime(TM+1)
        RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTime(TM+1);
        pegN=2;
        TM=TM+1;
    elseif TM<length(TurnMarkerTime)&&RpegTimeArray(n)>=TurnMarkerTime(TM)&&RpegTimeArray(n)<TurnMarkerTime(TM+1)
        RpegTimeArray2D(TM,pegN)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM,pegN)=RpegTimeArray(n)-TurnMarkerTime(TM);
        pegN=pegN+1;
    elseif TM<(length(TurnMarkerTime)-1)&&RpegTimeArray(n)>=TurnMarkerTime(TM+1)
        RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTime(TM+1);
        if pegN<12;R_under=R_under+1;end
        if pegN>13;R_over=R_over+1;end
        
        pegN=2;
        TM=TM+1;
    end
end
%Lpeg番号
L_under=0;
L_over=0;
TM=1;
LpegTimeArray2D=[];
LpegTimeArray2D_turn=[];
pegN=1;%pegN<=12 ペグ12本のとき
for n=1:length(LpegTimeArray)
    if pegN==13&&LpegTimeArray(n)>TurnMarkerTime(TM)&&LpegTimeArray(n)+50>TurnMarkerTime(TM+1)
        LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTime(TM+1);
        pegN=2;
        TM=TM+1;
    elseif TM<length(TurnMarkerTime)&&LpegTimeArray(n)>=TurnMarkerTime(TM)&&LpegTimeArray(n)<TurnMarkerTime(TM+1)
        LpegTimeArray2D(TM,pegN)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM,pegN)=LpegTimeArray(n)-TurnMarkerTime(TM);
        pegN=pegN+1;
    elseif TM<(length(TurnMarkerTime)-1)&&LpegTimeArray(n)>=TurnMarkerTime(TM+1)
        LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTime(TM+1);
        if pegN<12;L_under=L_under+1;end
        if pegN>13;L_over=L_over+1;end
        pegN=2;
        TM=TM+1;
    end
end

% Pegのカウントミスを補正
% 抜けた部分をnanにして一つずらす
if patternValue<9
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rpeg6を抜いて右ペグ11本で測定したとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==8
    Ins=nan(length(RpegTimeArray2D(:,11)),1);
    RpegTimeArray2D=[RpegTimeArray2D(:,1:5) Ins RpegTimeArray2D(:,6:11)];
    RpegTimeArray2D_turn=[RpegTimeArray2D_turn(:,1:5) Ins RpegTimeArray2D_turn(:,6:11)];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rpeg6,Lpeg6を各ターンで交互に抜いて左右ペグ11.5本で測定したとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==9
    if length(RpegTimeArray2D(1,:))>9
        RpegTimeArray2D(:,10:length(RpegTimeArray2D(1,:)))=[];
        RpegTimeArray2D_turn(:,10:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>9
        LpegTimeArray2D(:,10:length(LpegTimeArray2D(1,:)))=[];
        LpegTimeArray2D_turn(:,10:length(LpegTimeArray2D_turn(1,:)))=[];
    end
    
    for n=1:length(RpegTimeArray2D)
        if RpegTimeArray2D(n,9)==0 && RpegTimeArray2D(n,5)-RpegTimeArray2D(n,4)>500
            RpegTimeArray2D(n,:)=[RpegTimeArray2D(n,1:4) nan RpegTimeArray2D(n,5:8)];
            RpegTimeArray2D_turn(n,:)=[RpegTimeArray2D_turn(n,1:4) nan RpegTimeArray2D_turn(n,5:8)];
        end
        if LpegTimeArray2D(n,9)==0 && LpegTimeArray2D(n,5)-LpegTimeArray2D(n,4)>500
            LpegTimeArray2D(n,:)=[LpegTimeArray2D(n,1:4) nan LpegTimeArray2D(n,5:8)];
            LpegTimeArray2D_turn(n,:)=[LpegTimeArray2D_turn(n,1:4) nan LpegTimeArray2D_turn(n,5:8)];
        end
    end
    % Pegのカウントミスを補正
    % 抜けた部分をnanにして一つずらす
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    % Ins=nan(length(RpegTimeArray2D(:,11)),1);
    % RpegTimeArray2D=[RpegTimeArray2D(:,1:5) Ins RpegTimeArray2D(:,6:11)];
    % RpegTimeArray2D_turn=[RpegTimeArray2D_turn(:,1:5) Ins RpegTimeArray2D_turn(:,6:11)];
    % Ins=nan(length(LpegTimeArray2D(:,11)),1);
    % LpegTimeArray2D=[LpegTimeArray2D(:,1:5) Ins LpegTimeArray2D(:,6:11)];
    % LpegTimeArray2D_turn=[LpegTimeArray2D_turn(:,1:5) Ins LpegTimeArray2D_turn(:,6:11)];
    % for n=1:length(RpegTimeArray2D_turn(1,:))
    %     for m=1:length(RpegTimeArray2D_turn(:,1))
    %         A=RpegTimeArray2D_turn(:,n);
    %         if RpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>100
    %             RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
    %             RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
    %         end
    %     end
    % end
    %
    % for n=1:length(LpegTimeArray2D_turn(1,:))
    %     for m=1:length(LpegTimeArray2D_turn(:,1))
    %         A=LpegTimeArray2D_turn(:,n);
    %         if LpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>100
    %             LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
    %             LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
    %         end
    %     end
    % end
    TurnMarkerTime_R=[];TurnMarkerTime_L=[];
    LpegTimeArray2D_turn_R=[];RpegTimeArray2D_turn_R=[];
    LpegTimeArray2D_turn_L=[];RpegTimeArray2D_turn_L=[];
    for n=1:length(TurnMarkerTime)-1
        if isnan(LpegTimeArray2D(n,5))==1 && isnan(RpegTimeArray2D(n,5))==0 %photobeam Lpegなし=Rpeg for Touchなし
            TMR=TurnMarkerTime(n);
            TurnMarkerTime_R=[TurnMarkerTime_R; TMR];
            LpegTimeArray2D_turn_R=[LpegTimeArray2D_turn_R;LpegTimeArray2D_turn(n,:)]; % Lpeg(6)=nan
            RpegTimeArray2D_turn_R=[RpegTimeArray2D_turn_R;RpegTimeArray2D_turn(n,:)];
        elseif isnan(LpegTimeArray2D(n,5))==0 && isnan(RpegTimeArray2D(n,5))==1 %photobeam Rpegなし=Lpeg for Touchなし
            TML=TurnMarkerTime(n);
            TurnMarkerTime_L=[TurnMarkerTime_L; TML];
            LpegTimeArray2D_turn_L=[LpegTimeArray2D_turn_L;LpegTimeArray2D_turn(n,:)];
            RpegTimeArray2D_turn_L=[RpegTimeArray2D_turn_L;RpegTimeArray2D_turn(n,:)]; % Rpeg(6)=nan
        end
    end
    
    
    % AA-1パターンにおいては、マウスにとって右ペグがないとき(_Rで示す)フォトビームでは左ペグがないことになる（実時間記録上において）。
    % 従って右ペグ抜きときの2D_turn（フォトビームには右ペグがあって左ペグがない）は左ペグがなかったときの2D_turnとして扱うのが妥当である。
    % つまり実際に走ったペグによる時間情報・ペグ情報を利用する。これはすべての各TurnMarkerTimeが正確にカウントされている限り有効。
    %１周のなかでRペグが来るタイミング
    MedPegTimeR_L=[];MedPegTimeR_R=[];
    for n=1:length(RpegTimeArray2D_turn(1,:))
        MedPegTimeR_L(n)=nanmedian(RpegTimeArray2D_turn_R(:,n)); % 実時間上からのあてはめ
        MedPegTimeR_R(n)=nanmedian(RpegTimeArray2D_turn_L(:,n)); % 実時間上からのあてはめ
    end
    
    %１周のなかでLペグが来るタイミング
    MedPegTimeL_L=[];MedPegTimeL_R=[];
    for n=1:length(LpegTimeArray2D_turn(1,:))
        MedPegTimeL_L(n)=nanmedian(LpegTimeArray2D_turn_R(:,n)); % 実時間上からのあてはめ
        MedPegTimeL_R(n)=nanmedian(LpegTimeArray2D_turn_L(:,n)); % 実時間上からのあてはめ
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%% ABパターン(7peg)のとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if patternValue==10
% Ins=nan(length(RpegTimeArray2D(:,9)),3);
% RpegTimeArray2D=[RpegTimeArray2D Ins];
% RpegTimeArray2D_turn=[RpegTimeArray2D_turn Ins];
% Ins=nan(length(LpegTimeArray2D(:,8)),4);
% LpegTimeArray2D=[LpegTimeArray2D Ins];
% LpegTimeArray2D_turn=[LpegTimeArray2D_turn Ins];
% end

if patternValue==15
    %Rpeg番号
    R_under=0;
    R_over=0;
    TM=1;
    RpegTimeArray2D=[];
    RpegTimeArray2D_turn=[];
    pegN=1;%pegN<=12 ペグ12本のとき
    for n=1:length(RpegTimeArray)
        if pegN==15&&RpegTimeArray(n)>TurnMarkerTimeB(TM)&&RpegTimeArray(n)+50>TurnMarkerTimeB(TM+1)
            RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
            RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTimeB(TM+1);
            pegN=2;
            TM=TM+1;
        elseif TM<length(TurnMarkerTimeB)&&RpegTimeArray(n)>=TurnMarkerTimeB(TM)&&RpegTimeArray(n)<TurnMarkerTimeB(TM+1)
            RpegTimeArray2D(TM,pegN)=RpegTimeArray(n);
            RpegTimeArray2D_turn(TM,pegN)=RpegTimeArray(n)-TurnMarkerTimeB(TM);
            pegN=pegN+1;
        elseif TM<(length(TurnMarkerTimeB)-1)&&RpegTimeArray(n)>=TurnMarkerTimeB(TM+1)
            RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
            RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTimeB(TM+1);
            if pegN<14;R_under=R_under+1;end
            if pegN>14;R_over=R_over+1;end
            
            pegN=2;
            TM=TM+1;
        end
    end
    %Lpeg番号
    L_under=0;
    L_over=0;
    TM=1;
    LpegTimeArray2D=[];
    LpegTimeArray2D_turn=[];
    pegN=1;%pegN<=12 ペグ12本のとき
    for n=1:length(LpegTimeArray)
        if pegN==15&&LpegTimeArray(n)>TurnMarkerTimeB(TM)&&LpegTimeArray(n)+50>TurnMarkerTimeB(TM+1)
            LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
            LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTimeB(TM+1);
            pegN=2;
            TM=TM+1;
        elseif TM<length(TurnMarkerTimeB)&&LpegTimeArray(n)>=TurnMarkerTimeB(TM)&&LpegTimeArray(n)<TurnMarkerTimeB(TM+1)
            LpegTimeArray2D(TM,pegN)=LpegTimeArray(n);
            LpegTimeArray2D_turn(TM,pegN)=LpegTimeArray(n)-TurnMarkerTimeB(TM);
            pegN=pegN+1;
        elseif TM<(length(TurnMarkerTimeB)-1)&&LpegTimeArray(n)>=TurnMarkerTimeB(TM+1)
            LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
            LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTimeB(TM+1);
            if pegN<14;L_under=L_under+1;end
            if pegN>14;L_over=L_over+1;end
            pegN=2;
            TM=TM+1;
        end
    end
    
    
    if length(RpegTimeArray2D(1,:))>14
        RpegTimeArray2D(:,15:length(RpegTimeArray2D(1,:)))=[];
        RpegTimeArray2D_turn(:,15:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>14
        LpegTimeArray2D(:,15:length(LpegTimeArray2D(1,:)))=[];
        LpegTimeArray2D_turn(:,15:length(LpegTimeArray2D_turn(1,:)))=[];
    end
    
    
    % Ins=nan(length(RpegTimeArray2D(:,11)),1);
    % RpegTimeArray2D=[RpegTimeArray2D(:,1:5) Ins RpegTimeArray2D(:,6:11)];
    % RpegTimeArray2D_turn=[RpegTimeArray2D_turn(:,1:5) Ins RpegTimeArray2D_turn(:,6:11)];
    % Ins=nan(length(LpegTimeArray2D(:,11)),1);
    % LpegTimeArray2D=[LpegTimeArray2D(:,1:5) Ins LpegTimeArray2D(:,6:11)];
    % LpegTimeArray2D_turn=[LpegTimeArray2D_turn(:,1:5) Ins LpegTimeArray2D_turn(:,6:11)];
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>150
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>150
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ABパターン(9,8peg)のとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==10
    
    if length(RpegTimeArray2D(1,:))>9
        RpegTimeArray2D(:,10:length(RpegTimeArray2D(1,:)))=[];
        RpegTimeArray2D_turn(:,10:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>9
        LpegTimeArray2D(:,10:length(LpegTimeArray2D(1,:)))=[];
        LpegTimeArray2D_turn(:,10:length(LpegTimeArray2D_turn(1,:)))=[];
    end
    % Pegのカウントミスを補正
    % 抜けた部分をnanにして一つずらす
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




if patternValue<9
    if length(RpegTimeArray2D(1,:))>12
        RpegTimeArray2D(:,13:length(RpegTimeArray2D(1,:)))=[];
        RpegTimeArray2D_turn(:,13:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>12
        LpegTimeArray2D(:,13:length(LpegTimeArray2D(1,:)))=[];
        LpegTimeArray2D_turn(:,13:length(LpegTimeArray2D_turn(1,:)))=[];
    end
end

% patternValue
% if patternValue~=9
%１周のなかでRペグが来るタイミング
MedPegTimeR=[];
for n=1:length(RpegTimeArray2D_turn(1,:))
    MedPegTimeR(n)=nanmedian(RpegTimeArray2D_turn(:,n));
end
%Rペグのタイミングを適正な位置に調整
for n=1:length(MedPegTimeR)
    MedPegTimeR(n)=MedPegTimeR(n);%-OneTurnTime*0.1;
    if MedPegTimeR(n)<0;MedPegTimeR(n)=MedPegTimeR(n)+OneTurnTime;end;
end
%１周のなかでLペグが来るタイミング
MedPegTimeL=[];
for n=1:length(LpegTimeArray2D_turn(1,:))
    MedPegTimeL(n)=nanmedian(LpegTimeArray2D_turn(:,n));
end
%Lペグのタイミングを適正な位置に調整
for n=1:length(MedPegTimeL)
    MedPegTimeL(n)=MedPegTimeL(n);%-OneTurnTime*0.1;
    if MedPegTimeL(n)<0;MedPegTimeL(n)=MedPegTimeL(n)+OneTurnTime;end;
end