function SpikeAnalysisSet20190214(n,U,M)
%AutocorはSpikeArray、DrinkはSpikeArrayWon,WaterOn/OffではSpikeArray
%TouchではSpikeArrayとTを使用。

global StartTime FinishTime fname SpikeUnits TurnMarkerTime OneTurnTime RPegTouchAll LPegTouchAll DrinkOnArray dpath3 render ...
    MedPegTimeR MedPegTimeL RpegTimeArray LpegTimeArray RpegTouchall LpegTouchall WaterOnArrayOriginal WaterOffArrayOriginal...
    RpegTimeArray LpegTimeArray DrName UnitDataUnited UnitData FigA FigA3 FigAA...
    DiffMaxMinRpArray DiffMaxMinLpArray DiffMaxMinRArray DiffMaxMinLArray Spname...
    SpikeArray tfile RepeatAnalysis TrimStr FigureSave TotalTime...
    CrossCoWonCell CrossCoWoffCell NumWon NumWoff CleanWater CleanInterval WonTouch SpikeArrayWon...
    FirstWaterOn FirstWaterOff CrossCoWonFirst CrossCoWoffFirst CrossCoWonCellFirst CrossCoWoffCellFirst NumWonF NumWoffF ...
    LastWaterOn LastWaterOff CrossCoWonLast CrossCoWoffLast CrossCoWonCellLast CrossCoWoffCellLast NumWonL NumWoffL ...
    MidWaterOn MidWaterOff CrossCoWonMid CrossCoWoffMid CrossCoWonCellMid CrossCoWoffCellMid NumWonM NumWoffM ...
    IndepWaterOn IndepWaterOff CrossCoWonIndep CrossCoWoffIndep CrossCoWonCellIndep CrossCoWoffCellIndep NumWonI NumWoffI ...
    RpegTouchallWon RpegTouchallWoff LpegTouchallWon LpegTouchallWoff CCresultRtouchWon CCresultLtouchWon ACresult ACresultW CCresultDrinkOn...
    RmedianPTTM LmedianPTTM CCresultSpike DiffMaxMinR DiffMaxMinL fig_spike qMaxFRratio qMinFRratio dpath SpikePerTouchWoff

bin=500;%bin=floor(duration/10);
[AutoCo]=AutoCorr(SpikeArray',5000,0);
ACresult=hist(AutoCo,500)/length(SpikeArray);
ACresult=MovWindow(ACresult,5);

[AutoCoW]=AutoCorr(SpikeArrayWon',5000,0);
ACresultW=hist(AutoCoW,500)/length(SpikeArrayWon);
ACresultW=MovWindow(ACresultW,5);

if render==1;
    fig_spike=figure;
    subplot(3,6,1:2);
    plot(linspace(1,5000,bin),ACresult,'color','k');hold on
    plot(linspace(1,5000,bin),ACresultW,'color','b');
    if max(ACresult)>0;
        axis([0 5000 0 max(ACresult)*1.1]);
    end
end
[pksA,locsA]=findpeaks(ACresultW(101:400),'minpeakdistance',19,'sortstr','descend');

if length(locsA)>1
    IntA=abs(locsA(1)-locsA(2))*10;
else
    IntA=0;
end
if render==1;
    xlabel(['AC,Interval(Won) ',int2str(IntA),' ms']);
end

[CrossCoDrinkOn]=CrossCorr(SpikeArrayWon',DrinkOnArray,2000,0,TurnMarkerTime);
CCresultDrinkOn=hist(CrossCoDrinkOn,bin)/length(DrinkOnArray);
CCresultDrinkOn=MovWindow(CCresultDrinkOn,5);


% [CrossCoRtouchDrinkOn]=CrossCorr(RPegTouchAll,DrinkOnArray,2000,0,TurnMarkerTime);
% CCresultRtouchDrinkOn=hist(CrossCoRtouchDrinkOn,bin)/length(DrinkOnArray);
% CCresultRtouchDrinkOn=MovWindow(CCresultRtouchDrinkOn,5);
%
% [CrossCoLtouchDrinkOn]=CrossCorr(LPegTouchAll,DrinkOnArray,2000,0,TurnMarkerTime);
% CCresultLtouchDrinkOn=hist(CrossCoLtouchDrinkOn,bin)/length(DrinkOnArray);
% CCresultLtouchDrinkOn=MovWindow(CCresultLtouchDrinkOn,5);

MaxD=max(CCresultDrinkOn);
% MaxR=max(CCresultRtouchDrinkOn);
% MaxL=max(CCresultLtouchDrinkOn);

% CCresultRtouchDrinkOn=CCresultRtouchDrinkOn/(MaxR/MaxD);
% CCresultLtouchDrinkOn=CCresultLtouchDrinkOn/(MaxL/MaxD);
%         subplot(3,2,2);
if render==1;
    subplot(3,6,3:4);
    plot(linspace(1,2000,bin),CCresultDrinkOn,'color','k');hold on
    %         plot(linspace(1,2000,bin),CCresultRtouchDrinkOn,'color','b');%DrinkでAlignしたTouchをプロット
    %         plot(linspace(1,2000,bin),CCresultLtouchDrinkOn,'color','r');
    
    
    axis([0 2000 0 max(CCresultDrinkOn)*1.1]);
    xlabel('Spike/DrinkOn');
    %         xlabel('Spike,Rt,Lt/DrinkOn');
end
if CleanWater==1%FirstかつLastというものもあるので、合計はOriginalと等しくならなくてもOK
    %     CleanInterval=1500;
    WaterTimes=[WaterOnArrayOriginal; WaterOffArrayOriginal];
    WaterOnMiddle=WaterOnArrayOriginal;
    WaterOffMiddle=WaterOffArrayOriginal;
    FirstWaterOn=[];
    FirstWaterOff=[];
    LastWaterOn=[];
    LastWaterOff=[];
    MidWaterOn=[];
    MidWaterOff=[];
    IndepWaterOn=[];
    IndepWaterOff=[];
    for n=1:length(WaterOnArrayOriginal)
        Mid=0;
        if isempty(WaterTimes(WaterTimes>WaterOnArrayOriginal(n)-CleanInterval & WaterTimes<WaterOnArrayOriginal(n)))
            FirstWaterOn=[FirstWaterOn WaterOnArrayOriginal(n)];
            if isempty(WaterTimes(WaterTimes>WaterOnArrayOriginal(n) & WaterTimes<WaterOnArrayOriginal(n)+CleanInterval))
                IndepWaterOn=[IndepWaterOn WaterOnArrayOriginal(n)];
            end
        else
            Mid=1;
        end
        if isempty(WaterTimes(WaterTimes>WaterOnArrayOriginal(n) & WaterTimes<WaterOnArrayOriginal(n)+CleanInterval))
            LastWaterOn=[LastWaterOn WaterOnArrayOriginal(n)];
        else
            if Mid==1
                MidWaterOn=[MidWaterOn WaterOnArrayOriginal(n)];
            end
        end
        
    end
    for n=1:length(WaterOffArrayOriginal)
        Mid=0;
        if isempty(WaterTimes(WaterTimes>WaterOffArrayOriginal(n)-CleanInterval & WaterTimes<WaterOffArrayOriginal(n)))
            FirstWaterOff=[FirstWaterOff WaterOffArrayOriginal(n)];
            if isempty(WaterTimes(WaterTimes>WaterOffArrayOriginal(n) & WaterTimes<WaterOffArrayOriginal(n)+CleanInterval))
                IndepWaterOff=[IndepWaterOff WaterOffArrayOriginal(n)];
            end
        else
            Mid=1;
        end
        if isempty(WaterTimes(WaterTimes>WaterOffArrayOriginal(n) & WaterTimes<WaterOffArrayOriginal(n)+CleanInterval))
            LastWaterOff=[LastWaterOff WaterOffArrayOriginal(n)];
        else
            if Mid==1
                MidWaterOff=[MidWaterOff WaterOffArrayOriginal(n)];
            end
        end
    end
    
    CrossCoWonFirst=[];CrossCoWoffFirst=[];
    if ~isempty(FirstWaterOn)
        [CrossCoWonFirst]=CrossCorr(SpikeArray',FirstWaterOn',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
        CrossCoWonCellFirst{M,U}=CrossCoWonFirst;
        NumWonF(M)=length(FirstWaterOn);
    else
        CrossCoWonCellFirst{M,U}=[];
    end
    if ~isempty(FirstWaterOff)
        [CrossCoWoffFirst]=CrossCorr(SpikeArray',FirstWaterOff',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
        CrossCoWoffCellFirst{M,U}=CrossCoWoffFirst;
        NumWoffF(M)=length(FirstWaterOff);
    else
        CrossCoWoffCellFirst{M,U}=[];
    end
    
    CrossCoWonLast=[];CrossCoWoffLast=[];
    if ~isempty(LastWaterOn)
        [CrossCoWonLast]=CrossCorr(SpikeArray',LastWaterOn',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
        CrossCoWonCellLast{M,U}=CrossCoWonLast;
        NumWonL(M)=length(LastWaterOn);
    else
        CrossCoWonCellLast{M,U}=[];
    end
    if ~isempty(LastWaterOff)
        [CrossCoWoffLast]=CrossCorr(SpikeArray',LastWaterOff',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
        CrossCoWoffCellLast{M,U}=CrossCoWoffLast;
        NumWoffL(M)=length(LastWaterOff);
    else
        CrossCoWoffCellLast{M,U}=[];
    end
    
    CrossCoWonMid=[];CrossCoWoffMid=[];
    if ~isempty(MidWaterOn)
        [CrossCoWonMid]=CrossCorr(SpikeArray',MidWaterOn',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
        CrossCoWonCellMid{M,U}=CrossCoWonMid;
        NumWonM(M)=length(MidWaterOn);
    else
        CrossCoWonCellMid{M,U}=[];
    end
    if ~isempty(MidWaterOff)
        [CrossCoWoffMid]=CrossCorr(SpikeArray',MidWaterOff',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
        CrossCoWoffCellMid{M,U}=CrossCoWoffMid;
        NumWoffM(M)=length(MidWaterOff);
    else
        CrossCoWoffCellMid{M,U}=[];
    end
    
    CrossCoWonIndep=[];CrossCoWoffIndep=[];
    if ~isempty(IndepWaterOn)
        [CrossCoWonIndep]=CrossCorr(SpikeArray',IndepWaterOn',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
        CrossCoWonCellIndep{M,U}=CrossCoWonIndep;
        NumWonI(M)=length(IndepWaterOn);
    else
        CrossCoWonCellIndep{M,U}=[];
    end
    if ~isempty(IndepWaterOff)
        [CrossCoWoffIndep]=CrossCorr(SpikeArray',IndepWaterOff',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
        CrossCoWoffCellIndep{M,U}=CrossCoWoffIndep;
        NumWoffI(M)=length(IndepWaterOff);
    else
        CrossCoWoffCellIndep{M,U}=[];
    end
end

CrossCoWon=[];CrossCoWoff=[];
if ~isempty(WaterOnArrayOriginal)
    [CrossCoWon]=CrossCorr(SpikeArray',WaterOnArrayOriginal',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
    CrossCoWonCell{M,U}=CrossCoWon;
    NumWon(M)=length(WaterOnArrayOriginal);
    %         CrossCoWon=[-5000;CrossCoWon;5000];
    CCresultWon=hist(CrossCoWon,bin)/length(WaterOnArrayOriginal);
    CCresultWon=MovWindow(CCresultWon,10);
    if render==1;
        subplot(3,6,5:6);
        plot(linspace(1,10000,bin),CCresultWon,'color','b');hold on
        axis([0 10000 0 max(CCresultWon)*1.1]);
        xlabel(['/WaterOn(',int2str(length(WaterOnArrayOriginal)),')']);
    end
end
if ~isempty(WaterOffArrayOriginal)
    [CrossCoWoff]=CrossCorr(SpikeArray',WaterOffArrayOriginal',10000,0,TurnMarkerTime);%;S='aligned by WaterOn';
    CrossCoWoffCell{M,U}=CrossCoWoff;
    NumWoff(M)=length(WaterOffArrayOriginal);
    %         CrossCoWoff=[-5000;CrossCoWoff;5000];
    CCresultWoff=hist(CrossCoWoff,bin)/length(WaterOffArrayOriginal);
    CCresultWoff=MovWindow(CCresultWoff,10);
    if render==1;
        subplot(3,6,5:6);
        plot(linspace(1,10000,bin),CCresultWoff,'color','r');
        axis([0 10000 0 max(CCresultWoff)*1.1]);
        xlabel(['/WaterOff(',int2str(length(WaterOffArrayOriginal)),')']);
    end
end


if ~isempty(WaterOnArrayOriginal) && ~isempty(WaterOffArrayOriginal)
    if render==1;
        axis([0 10000 0 max(max(CCresultWon),max(CCresultWoff))*1.1]);
        %             xlabel('/WaterOnOff');
        xlabel(['/WaterOn(',int2str(length(WaterOnArrayOriginal)),')',', /WaterOff(',int2str(length(WaterOffArrayOriginal)),')']);
    end
end

% % % % % %Touch解析WaterOnのときのTouch
% % % % % if RPegTouchAllWon==0 & LPegTouchAllWon==0
% % % % %     RPTAll=RPegTouchAll;
% % % % %     LPTAll=LPegTouchAll;
% % % % % elseif RPegTouchAllWon~=0 & LPegTouchAllWon~=0
% % % % %     RPTAll=RPegTouchAllWon;
% % % % %     LPTAll=LPegTouchAllWon;
% % % % % elseif exist('RPegTouchAll')
% % % % %   RPTAll=RPegTouchAll;
% % % % %   LPTAll=LPegTouchAll;
% % % % % else
% % % % %   RPTAll=RpegTouchall;
% % % % %   LPTAll=LpegTouchall;
% % % % % end

LenTouchAll=length(RpegTouchall)+length(LpegTouchall);
LenTouchWon=length(RpegTouchallWon)+length(LpegTouchallWon);
LenTouchWoff=LenTouchAll-LenTouchWon;

LenSpikeAll=length(SpikeArray);
LenSpikeWon=length(SpikeArrayWon);
LenSpikeWoff=LenSpikeAll-LenSpikeWon;

SpikePerTouchWon=LenSpikeWon/LenTouchWon;%Wonのときの発火数/総Wonタッチ
SpikePerTouchWoff=LenSpikeWoff/LenTouchWoff;%Woffのときの発火数/総Woffタッチ


[CrossCoRtouchWon]=CrossCorr(SpikeArray',RpegTouchallWon,5000,0,TurnMarkerTime);
%         CrossCoRtouch=[-2500;CrossCoRtouch;2500];
CCresultRtouchWon=hist(CrossCoRtouchWon,bin);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);
%         [CrossCoLtouch]=CrossCorr(LPegTouchAll,SpikeArray,5000,0,TurnMarkerTime);
[CrossCoLtouchWon]=CrossCorr(SpikeArray',LpegTouchallWon,5000,0,TurnMarkerTime);
%         CrossCoLtouch=[-2500;CrossCoLtouch;2500];
CCresultLtouchWon=hist(CrossCoLtouchWon,bin);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);
if render==1;
    subplot(3,6,7:8);
    plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',1);hold on
    plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',1);
    axis([0 5000 0 max(max(CCresultRtouchWon),max(CCresultLtouchWon))*1.1]);
end

CCRt=CCresultRtouchWon(101:400);
CCLt=CCresultLtouchWon(101:400);

DiffMaxMinR=max(CCRt)/min(CCRt);
DiffMaxMinL=max(CCLt)/min(CCLt);

[pksA,locsA]=findpeaks(CCLt,'minpeakdistance',19,'sortstr','descend');
if numel(locsA)>1;
    Peak1=locsA(1);
    locsA(locsA<Peak1-100 | locsA>Peak1+100)=[];
end

if numel(locsA)>1;
    IntL=abs(locsA(1)-locsA(2))*10;
else
    IntL=0;
end

[pksA,locsA]=findpeaks(CCRt,'minpeakdistance',19,'sortstr','descend');

if numel(locsA)>1;
    IntR=abs(locsA(1)-locsA(2))*10;
else
    IntR=0;
end
%         %0の左右で分ける場合%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         [pksA,locsA]=findpeaks(CCLt(1:51),'minpeakdistance',19,'sortstr','descend');
%         [pksB,locsB]=findpeaks(CCLt(49:100),'minpeakdistance',19,'sortstr','descend');
% %         A=locsA
% %         B=locsB
% %         pksA(pksA>(min(CCLt)+(max(CCLt)-min(CCLt))*0.6))=[];
% %         pksB(pksB>(min(CCLt)+(max(CCLt)-min(CCLt))*0.6))=[];
%         pksB(locsB<=2)=[];
%         locsB(locsB<=2)=[];
%         if min(CCLt)<max(CCLt)*0.3
%             locsA(pksA<(min(CCLt)+(max(CCLt)-min(CCLt))*0.6))=[];
%             locsB(pksB<(min(CCLt)+(max(CCLt)-min(CCLt))*0.6))=[];
%         end
%
%         if length(locsA)>=1 && length(locsB)>=1%length(locs)>=2
% %             IntL=abs(locs(1)-locs(2))*10;%ms;
%             LocsA=max(locsA);
%             LocsB=min(locsB);
%             IntL=abs((LocsB+48)-LocsA)*10;%ms;
%         else
%             IntL=0;
%         end
%         %%%%%%%%%%%%%%%%%%%%%%

% if WonTouch~=1
%     xlabel(['S/T, DifR',num2str(DiffMaxMinR),', DifL',num2str(DiffMaxMinL),' IntR',int2str(IntR),', IntL',int2str(IntL)]);
% elseif WonTouch==1
if render==1;
    xlabel(['S/Ton ',num2str(SpikePerTouchWon),' DifR',num2str(DiffMaxMinR),', DifL',num2str(DiffMaxMinL)]);%,'' IntR',int2str(IntR),', IntL',int2str(IntL)]);
end
% end

DiffMaxMinRArray=[DiffMaxMinRArray DiffMaxMinR];
DiffMaxMinLArray=[DiffMaxMinLArray DiffMaxMinL];


[CrossCoRtouchWoff]=CrossCorr(SpikeArray',RpegTouchallWoff,5000,0,TurnMarkerTime);
%         CrossCoRtouch=[-2500;CrossCoRtouch;2500];
CCresultRtouchWoff=hist(CrossCoRtouchWoff,bin);
CCresultRtouchWoff=MovWindow(CCresultRtouchWoff,10);
%         [CrossCoLtouch]=CrossCorr(LPegTouchAll,SpikeArray,5000,0,TurnMarkerTime);
[CrossCoLtouchWoff]=CrossCorr(SpikeArray',LpegTouchallWoff,5000,0,TurnMarkerTime);
%         CrossCoLtouch=[-2500;CrossCoLtouch;2500];
CCresultLtouchWoff=hist(CrossCoLtouchWoff,bin);
CCresultLtouchWoff=MovWindow(CCresultLtouchWoff,10);
if render==1;
    subplot(3,6,9:10);
    plot(linspace(1,5000,bin),CCresultRtouchWoff,'color','b');hold on
    plot(linspace(1,5000,bin),CCresultLtouchWoff,'color','r');
    axis([0 5000 0 max(max(CCresultRtouchWoff),max(CCresultLtouchWoff))*1.1]);
    xlabel(['S/Toff ',num2str(SpikePerTouchWoff)]);
end



%         RpegTimeArray LpegTimeArray
%         [CrossCoRpeg]=CrossCorr(RpegTimeArray,SpikeArray,5000,0,TurnMarkerTime);
[CrossCoRpeg]=CrossCorr(SpikeArrayWon',RpegTimeArray,5000,0,TurnMarkerTime);
%         CrossCoRtouch=[-2500;CrossCoRtouch;2500];
CCresultRpeg=hist(CrossCoRpeg,bin);
CCresultRpeg=MovWindow(CCresultRpeg,5);
%         [CrossCoLpeg]=CrossCorr(LpegTimeArray,SpikeArray,5000,0,TurnMarkerTime);
[CrossCoLpeg]=CrossCorr(SpikeArrayWon',LpegTimeArray,5000,0,TurnMarkerTime);
%         CrossCoLtouch=[-2500;CrossCoLtouch;2500];
CCresultLpeg=hist(CrossCoLpeg,bin);
CCresultLpeg=MovWindow(CCresultLpeg,5);


if render==1;
    subplot(3,6,11:12);
    plot(linspace(1,5000,bin),CCresultRpeg,'color','b');hold on
    plot(linspace(1,5000,bin),CCresultLpeg,'color','r');
    axis([0 5000 0 max(max(CCresultRpeg),max(CCresultLpeg))*1.1]);
end

CCRp=CCresultRpeg(201:300);
CCLp=CCresultLpeg(201:300);
DiffMaxMinRp=max(CCRp)/min(CCRp);
DiffMaxMinLp=max(CCLp)/min(CCLp);
%         DiffMaxMinRp=max(CCresultRpeg)/min(CCresultRpeg);
%         DiffMaxMinLp=max(CCresultLpeg)/min(CCresultLpeg);
%         xlabel(['Peg/Spike, DifRp= ',num2str(DiffMaxMinRp),', DifLp= ',num2str(DiffMaxMinLp)]);
if render==1;
    xlabel(['Swon/P, DifRp= ',num2str(DiffMaxMinRp),', DifLp= ',num2str(DiffMaxMinLp)]);
end

DiffMaxMinRpArray=[DiffMaxMinRpArray DiffMaxMinRp];
DiffMaxMinLpArray=[DiffMaxMinLpArray DiffMaxMinLp];
%%%%%TurnMarkerTimeを中心に２Trialぶん表示
% BIN=floor(OneTurnTime/50);
%RpegTouchall
BIN=1000;
[CrossCoSpike]=CrossCorr(SpikeArrayWon',TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
CCresultSpike=hist(CrossCoSpike,BIN)/length(TurnMarkerTime);
CCresultSpike=MovWindow(CCresultSpike,5);



% % % % %         [CrossCoRtouch2]=CrossCorr(RpegTimeArray,TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
% % % % [CrossCoRtouch2]=CrossCorr(RPegTouchAll,TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
% % % % %         CrossCoRtouch2=[-1*OneTurnTime; CrossCoRtouch2; OneTurnTime];
% % % % CCresultRtouch2=hist(CrossCoRtouch2,BIN)/length(TurnMarkerTime);
% % % % CCresultRtouch2=MovWindow(CCresultRtouch2,5);
% % % % [CrossCoLtouch2]=CrossCorr(LPegTouchAll,TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
% % % % %         CrossCoLtouch2=[-1*OneTurnTime; CrossCoLtouch2; OneTurnTime];
% % % % %         [CrossCoLtouch2]=CrossCorr(LpegTimeArray,TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
% % % % CCresultLtouch2=hist(CrossCoLtouch2,BIN)/length(TurnMarkerTime);
% % % % CCresultLtouch2=MovWindow(CCresultLtouch2,5);


if render==1;
    subplot(3,6,13:18);
    plot(linspace(1,OneTurnTime*2,BIN),CCresultSpike,'color','b');hold on
    % % % % %         plot(linspace(1,OneTurnTime*2,BIN),CCresultRtouch2,'color','b');hold on
    % % % % %         plot(linspace(1,OneTurnTime*2,BIN),CCresultLtouch2,'color','r');
end


Oldc=cd;
C=[dpath,'CCSFolder'];
cd(C);
tfiletrim=strtrim(tfile);
FolderCCS=['CCS',tfiletrim(1:end-2),fname(end-8:end-4)];
save(FolderCCS,'CCresultSpike');                          %20190531tera
cd(Oldc);

%全スパイク
[CrossCoSpikeAll]=CrossCorr(SpikeArray',TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
CCresultSpikeAll=hist(CrossCoSpikeAll,BIN)/length(TurnMarkerTime);
CCresultSpikeAll=MovWindow(CCresultSpikeAll,5);
if render==1;
    plot(linspace(1,OneTurnTime*2,BIN),CCresultSpikeAll,'color','k');hold on
end
%         figure
%         plot(CCresultSpike,'color','k');hold on
%         plot(CCresultRtouch2,'color','b');hold on
%         plot(CCresultLtouch2,'color','r');

% % % % %         Max=max([max(CCresultSpike),max(CCresultRtouch2),max(CCresultLtouch2)]);
Max=max(CCresultSpikeAll);

XR=floor(OneTurnTime*MedPegTimeR(1:end)/OneTurnTime);
XR=[XR XR+OneTurnTime];
YR=ones(1,length(MedPegTimeR)*2)'*Max*1.05;%0.85;
XL=floor(OneTurnTime*MedPegTimeL(1:end)/OneTurnTime);
XL=[XL XL+OneTurnTime];
YL=ones(1,length(MedPegTimeL)*2)'*Max*1.13;%0.95;

%%%%%%TurnMarkerTimeを左端にして１Trialぶん表示
%         [CrossCoSpike]=CrossCorr(SpikeArray',TurnMarkerTime,OneTurnTime,1,TurnMarkerTime);
%         CCresultSpike=hist(CrossCoSpike,floor(OneTurnTime/10))/length(TurnMarkerTime);
%         CCresultSpike=MovWindow(CCresultSpike,5);
%         [CrossCoRtouch2]=CrossCorr(RPegTouchAll',TurnMarkerTime,OneTurnTime,1,TurnMarkerTime);
%         CCresultRtouch2=hist(CrossCoRtouch2,floor(OneTurnTime/10))/length(TurnMarkerTime);
%         CCresultRtouch2=MovWindow(CCresultRtouch2,5);
%         [CrossCoLtouch2]=CrossCorr(LPegTouchAll',TurnMarkerTime,OneTurnTime,1,TurnMarkerTime);
%         CCresultLtouch2=hist(CrossCoLtouch2,floor(OneTurnTime/10))/length(TurnMarkerTime);
%         CCresultLtouch2=MovWindow(CCresultLtouch2,5);
%         figure
%         subplot(3,2,5:6);
%         plot(linspace(1,OneTurnTime,floor(OneTurnTime/10)),CCresultSpike,'color','k');hold on
%         plot(linspace(1,OneTurnTime,floor(OneTurnTime/10)),CCresultRtouch2,'color','g');hold on
%         plot(linspace(1,OneTurnTime,floor(OneTurnTime/10)),CCresultLtouch2,'color','r');

%         Max=max([max(CCresultSpike),max(CCresultRtouch2),max(CCresultLtouch2)]);
%         XR=floor(OneTurnTime*MedPegTimeR(1:end)/OneTurnTime);
%         YR=ones(1,length(MedPegTimeR))'*Max*1.05;%0.85;
%         XL=floor(OneTurnTime*MedPegTimeL(1:end)/OneTurnTime);
%         YL=ones(1,length(MedPegTimeL))'*Max*1.13;%0.95;
% text(XR,YR,'l','FontSize',10,'color',[0 0 1]);
% text(XL,YL,'l','FontSize',10,'color',[1 0 0]);
if render==1;
    text(XR,YR,'l','FontSize',10,'color',[0 0 1]);
    text(XL,YL,'l','FontSize',10,'color',[1 0 0]);
    axis([0 OneTurnTime*2 0 Max*1.3]);
end
hFRratio=zeros(1,length(CCresultSpike)/2);
qFRratio=zeros(1,length(CCresultSpike)/2);
CCresultSpike2=[CCresultSpike(501:1000) CCresultSpike(501:1000)];
for p=1:500
    %             hFRratio(p)=sum(CCresultSpike2(p:p+249));%/sum(CCresultSpike2(p+250:p+499));
    qFRratio(p)=sum(CCresultSpike2(p:p+124));%/sum(CCresultSpike2(p+250:p+374));
end
%         hMaxFRratio=max(hFRratio);
%         hFFRMAX=find(hFRratio==max(hFRratio));
%         hPointMaxFRR=hFFRMAX(1)+125;
qMaxFRratio=max(qFRratio);
qFFRMAX=find(qFRratio==max(qFRratio));
qPointMaxFRR=qFFRMAX(1)+62.5;

qMinFRratio=min(qFRratio);
qFFRMIN=find(qFRratio==min(qFRratio));
qPointMinFRR=qFFRMIN(1)+62.5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ペグ間ごとに発火頻度最大値を求める。ペグ1本ずつずらしていって、4半パターンでの最大最小を比較
RpegSpikes=zeros(1,length(XR)/2);
for p=length(XR)/2+1:length(XR)
    if p==length(XR)/2+1
        value=max(max(CCresultSpike(501:floor(1000/(OneTurnTime*2)*XR(p)))),max(CCresultSpike(floor(1000/(OneTurnTime*2)*XR(end))+1:end)))...
            -min(min(CCresultSpike(501:floor(1000/(OneTurnTime*2)*XR(p)))),min(CCresultSpike(floor(1000/(OneTurnTime*2)*XR(end))+1:end)));
        if ~isempty(value)
            RpegSpikes(p-length(XR)/2)=value;
        end
    else
        value=max(CCresultSpike(floor(1000/(OneTurnTime*2)*XR(p-1))+1:floor(1000/(OneTurnTime*2)*XR(p))))...
            -min(CCresultSpike(floor(1000/(OneTurnTime*2)*XR(p-1))+1:floor(1000/(OneTurnTime*2)*XR(p))));
        if ~isempty(value)
            RpegSpikes(p-length(XR)/2)=value;
        end
    end
end
LpegSpikes=zeros(1,length(XL)/2);
for p=length(XL)/2+1:length(XL)
    if p==length(XL)/2+1
        value=max(max(CCresultSpike(501:floor(1000/(OneTurnTime*2)*XL(p)))),max(CCresultSpike(floor(1000/(OneTurnTime*2)*XL(end))+1:end)))...
            -min(min(CCresultSpike(501:floor(1000/(OneTurnTime*2)*XL(p)))),min(CCresultSpike(floor(1000/(OneTurnTime*2)*XL(end))+1:end)));
        if ~isempty(value)
            LpegSpikes(p-length(XL)/2)=value;
        end
    else
        value=max(CCresultSpike(floor(1000/(OneTurnTime*2)*XL(p-1))+1:floor(1000/(OneTurnTime*2)*XL(p))))...
            -min(CCresultSpike(floor(1000/(OneTurnTime*2)*XL(p-1))+1:floor(1000/(OneTurnTime*2)*XL(p))));
        if ~isempty(value)
            LpegSpikes(p-length(XL)/2)=value;
        end
    end
end

%         LpegSpikes=zeros(1,length(XL)/2);
%         for p=length(XL)/2+1:length(XL)
%             if p==length(XL)/2+1
%                 LpegSpikes(p-length(XL)/2)=max(max(CCresultSpike(501:1000/(OneTurnTime*2)*XL(p)))+max(CCresultSpike(1000/(OneTurnTime*2)*XL(end)+1:end)));
%             else
%                 LpegSpikes(p-length(XL)/2)=max(CCresultSpike(1000/(OneTurnTime*2)*XL(p-1)+1:1000/(OneTurnTime*2)*XL(p)));
%             end
%         end

RpeakComp=zeros(2,length(RpegSpikes));
num=floor(length(RpegSpikes)/4);
RpegSpikes2=[RpegSpikes RpegSpikes];
for p=1:length(RpegSpikes)
    RpeakComp(1,p)=sum(RpegSpikes2(p:p+num-1));
    RpeakComp(2,p)=sum(RpegSpikes2(p+floor(length(RpegSpikes)/2):p+floor(length(RpegSpikes)/2)+num-1));
end
RpeakRatio=RpeakComp(1,:)./RpeakComp(2,:);

LpeakComp=zeros(2,length(LpegSpikes));
num=floor(length(LpegSpikes)/4);
LpegSpikes2=[LpegSpikes LpegSpikes];
for p=1:length(LpegSpikes)
    LpeakComp(1,p)=sum(LpegSpikes2(p:p+num-1));
    LpeakComp(2,p)=sum(LpegSpikes2(p+floor(length(LpegSpikes)/2):p+floor(length(LpegSpikes)/2)+num-1));
    %             LpeakComp(1,p)=sum(LpegSpikes2(p:p+num-1));
    %             LpeakComp(2,p)=sum(LpegSpikes2(p+num:p+num*2-1));
end
LpeakRatio=LpeakComp(1,:)./LpeakComp(2,:);
RpeakRatio(isinf(RpeakRatio))=[];LpeakRatio(isinf(LpeakRatio))=[];
MaxPeakRatioPeg=max(max(RpeakRatio),max(LpeakRatio));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TotalTime=(FinishTime-StartTime)/1000;%sec

%至適なペグ間隔を計算

% % % %         if strcmp(tfile(1:3),'Sc4')
%         MPL=sort([MedPegTimeL floor(qPointMaxFRR*OneTurnTime/500)],'ascend');
%          Ord=find(MPL==floor(qPointMaxFRR*OneTurnTime/500))
%          if Ord==1
%              PintL=MPL(2)+(OneTurnTime-MPL(end));
%          elseif Ord==length(MPL)
%              PintL=MPL(1)+(OneTurnTime-MPL(end-1));
%          else
%              PintL=MPL(Ord(1)+1)-MPL(Ord(1)-1);
%          end
% % % %         end

%至適なエリアと非至適エリア

MPTL=MedPegTimeL;
MPTL(MPTL==0)=[];

MinArea=[floor(qPointMinFRR*OneTurnTime/500-OneTurnTime/8) floor(qPointMinFRR*OneTurnTime/500+OneTurnTime/8)];
MaxArea=[floor(qPointMaxFRR*OneTurnTime/500-OneTurnTime/8) floor(qPointMaxFRR*OneTurnTime/500+OneTurnTime/8)];

MedPegTimeLtriple=[MPTL OneTurnTime+MPTL 2*OneTurnTime+MPTL];
%          MedPegTimeLtriple=[MedPegTimeL OneTurnTime+MedPegTimeL 2*OneTurnTime+MedPegTimeL];

qMinPegs=MedPegTimeLtriple(MedPegTimeLtriple>MinArea(1)+OneTurnTime & MedPegTimeLtriple<MinArea(2)+OneTurnTime);
qMaxPegs=MedPegTimeLtriple(MedPegTimeLtriple>MaxArea(1)+OneTurnTime & MedPegTimeLtriple<MaxArea(2)+OneTurnTime);
if numel(qMaxPegs)>0&&numel(qMinPegs)>0;      %%%%20190309変更
    Min1Peg=find(MedPegTimeLtriple==qMinPegs(1));
    Min2Peg=find(MedPegTimeLtriple==qMinPegs(end));
    Max1Peg=find(MedPegTimeLtriple==qMaxPegs(1));
    Max2Peg=find(MedPegTimeLtriple==qMaxPegs(end));
    
    MeanqMinInt=round(mean(diff(MedPegTimeLtriple(Min1Peg-1:Min2Peg+1))));
    MeanqMaxInt=round(mean(diff(MedPegTimeLtriple(Max1Peg-1:Max2Peg+1))));
    
    if render==1;
        xlabel([fname,'  ',tfile(1:11),' ',int2str(length(SpikeArrayWon)),'/',int2str(length(SpikeArray)),'spikes,',num2str(length(SpikeArray)/TotalTime),'Hz',...
            ', qFRmax ',int2str(MeanqMaxInt),' at ',num2str(floor(qPointMaxFRR*OneTurnTime/500)),...
            ', qFRmin ',int2str(MeanqMinInt),' at ',num2str(floor(qPointMinFRR*OneTurnTime/500)),', ratio',num2str(qMaxFRratio/qMinFRratio)]);%',PeakRatio=',num2str(MaxPeakRatioPeg)]);
    end
    UnitData(U).fname=fname;
    UnitData(U).tfile=tfile;
    UnitData(U).Spike=SpikeArray';
    UnitData(U).SpikeWon=SpikeArrayWon';
    UnitData(U).Hz=length(SpikeArray)/TotalTime;
    UnitData(U).qMaxFRposition=floor(qPointMaxFRR*OneTurnTime/500);
    UnitData(U).qMinFRposition=floor(qPointMinFRR*OneTurnTime/500);
    UnitData(U).MaxMinRatio=qMaxFRratio/qMinFRratio;
    UnitData(U).RtouchMaxMinRatio=DiffMaxMinR;
    UnitData(U).LtouchMaxMinRatio=DiffMaxMinL;
    UnitData(U).RpegMaxMinRatio=DiffMaxMinRp;
    UnitData(U).LpegMaxMinRatio=DiffMaxMinLp;
    UnitData(U).MeanqMaxInt=MeanqMaxInt;
    UnitData(U).MeanqMinInt=MeanqMinInt;
    UnitData(U).SpikePerTouchWon=SpikePerTouchWon;
    UnitData(U).SpikePerTouchWoff=SpikePerTouchWoff;
end
Position_=strfind(fname,'_');
PatternNum=PegPattrn(fname);
UnitDataUnited(U,1)=str2num(fname(1:Position_(1)-1));
UnitDataUnited(U,2)=str2num(fname(Position_(1)+1:Position_(2)-1));
UnitDataUnited(U,3)=PatternNum;
UnitDataUnited(U,4)=str2num(tfile(1,3));
UnitDataUnited(U,5)=str2num(tfile(1,8:9));
UnitDataUnited(U,6)=length(SpikeArray)/TotalTime;
UnitDataUnited(U,7)=DiffMaxMinR;
UnitDataUnited(U,8)=DiffMaxMinL;
UnitDataUnited(U,9)=qMaxFRratio/qMinFRratio;
UnitDataUnited(U,10)=IntA;
UnitDataUnited(U,11)=IntR;
UnitDataUnited(U,12)=IntL;
UnitDataUnited(U,13)=SpikePerTouchWon;
UnitDataUnited(U,14)=SpikePerTouchWoff;
UnitDataUnited(U,15)=floor(qPointMaxFRR*OneTurnTime/500);%qMaxFRposition
UnitDataUnited(U,16)=floor(qPointMinFRR*OneTurnTime/500);%qMinFRposition




if RepeatAnalysis==1
    % % % % % %     繰り返しの発火頻度を見たい場合%%%%脚タッチを基準とした周期をもとにした反復%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % % % %         if ~exist('TouchIntSet_L')%LPTAll
    % % % % % %             NN=400:25:600;
    % % % % % % SortPTA=sort(diff(LPTAll),'ascend');
    % % % % % % A=SortPTA(10)-mod(SortPTA(10),50);
    % % % % % % B=SortPTA(end-50)-mod(SortPTA(end-50),50)+50;
    % % % % % % A
    % % % % % % B
    % % % % % % IntStep=round((SortPTA(end-50)-SortPTA(10))/6);
    % % % % % % NN=SortPTA(10):IntStep:SortPTA(10)+IntStep*5;
    % % % % % diff(LPTAll)
    % % % % %
    % % % % %             DifPeg=diff(MedPegTimeLtriple(2:end-1));
    % % % % %             MinDP=round(min(DifPeg));
    % % % % %             MaxDP=round(max(DifPeg));
    % % % % %             DifDP=MaxDP-MinDP;
    % % % % %             MeanDP=round(mean(DifPeg));
    % % % % %             if DifDP<25%Phase taskの場合、ペグ間隔の最大最小は10以下
    % % % % % %                 MeanDP=round(mean(DifPeg));
    % % % % %                 NNN=[MeanDP*0.7 MeanDP*0.8 MeanDP*0.9 MeanDP MeanDP*1.1 MeanDP*1.2 MeanDP*1.3];
    % % % % %             elseif MinDP<200%C7
    % % % % %                 DT=median(diff(LPTAll));
    % % % % %                 NNN=[DT*0.7 DT*0.8 DT*0.9 DT DT*1.1 DT*1.2 DT*1.3];
    % % % % % %                 NNN=[MeanDP*0.4 MeanDP*0.6 MeanDP*0.8 MeanDP MeanDP*1.2 MeanDP*1.4 MeanDP*1.6];
    % % % % %             else%Bgra
    % % % % %                 NNN=MinDP:round(DifDP/7):MaxDP;
    % % % % %             end
    % % % % %             NN=round(NNN);
    % % % % % %             NN=round(NNN(2:end-1));
    % % % % %
    % % % % % %             NN=300:50:500;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % % % %
    % % % % % %             NN=round([IntL*0.5 IntL*0.67 IntL*0.83 IntL IntL*1.16 IntL*1.34 IntL*1.5]);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % % % %             TouchIntSet_L=FindTouchRepeat20170823(LPTAll,NN);
    % % % % % %             TouchIntSet_L=FindTouchRepeat20171229(LPTAll,NN);
    % % % % %             %             TouchIntSet_L=FindTouchRepeat(LPTAll,NN);
    % % % % %         end
    % % % % % %         [Fig3 FigA3 FigAA]=PlotRepeatTouchSpike20171011(TouchIntSet_L,SpikeArray,NN,LPTAll,fname,tfile);
    % % % % %         PlotRepeatTouchSpike20180306(TouchIntSet_L,SpikeArray,NN,LPTAll,fname,tfile);
    % % % % % %     繰り返しの発火頻度を見たい場合%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if IntA<800 && IntA>150
        NN=round([IntA*0.7 IntA IntA*1.3]);
        TouchIntSet_L=FindTouchRepeat20170823(LPTAll,NN);
        PlotRepeatTouchSpike20180312(TouchIntSet_L,SpikeArray,NN,LPTAll,fname,tfile);
        %          NN=round([IntR*0.8 IntR IntR*1.2]);
        TouchIntSet_R=FindTouchRepeat20170823(RPTAll,NN);
        PlotRepeatTouchSpike20180312(TouchIntSet_R,SpikeArray,NN,RPTAll,fname,tfile);
    end
    
else
    
end
FigName=[fname,' ',TrimStr(1:end-1),'.bmp'];%char(strcat({S1},{' '},{S2},{' '},{S3},{' '},{S4},{' '},{S5},{' '},{S6},{S7},{' '},{S8},{' '},{S9},{' '},{S10},{'.bmp'}));
if FigureSave==1 && render==1;
    saveas(fig_spike,FigName);
    if exist('Fig1') && Fig1~=0 && exist('Fig2') && Fig2~=0
        saveas(Fig1,['A',FigName]);
        saveas(Fig2,['B',FigName]);
    end
    if exist('FigA') && FigA~=0% && exist('Fig4') && Fig4~=0
        saveas(FigA,['C',FigName]);
        saveas(Fig4,['D',FigName]);
        saveas(Fig5,['E',FigName]);
        saveas(FigA3,['F',FigName]);
        saveas(FigAA,['G',FigName]);
    end
end
