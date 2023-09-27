function PegTouchAnalysis24ch_SSanalysis(R_PegTouchCell,L_PegTouchCell,TurnMarkerTime,OneTurnTime,RpegTimeArray2D,LpegTimeArray2D,FTselect)
%'PegTouch'はsensorの情報を得ただけ。12chすべてがRpeg12本に割り当てられているときにはPegTouchだけでもよかった。
%しかし、RLで6chずつ使用する際には、1-6、7-12を割り当てる必要がある。

%ペグの番号を唯一の基準にするプログラムに変更（20150508）
%TurnMarkerよりもペグ12が先に来るか否かを予めホイールでチェック
%patternValueによりTurnMarkerのペグ番号がTouchSensorのライン番号と符合するようにPegIndexR、PegIndexLを設定する。
%WheelAnalyzer24chを実行する際にはPegPatternが正しく設定されているかを意識する必要がある。

global SliderTouch OneTurnTime RefPeriod RpegMedian LpegMedian RLpegMedian RLpegName DrName fig_touchR fig_touchL fig_touchR_TM fig_touchL_TM fig_TMpegs...
    PtouchHistoCell_R PtouchHistoCell_L WaterOn_percent RLPegTouchAll RPegTouchAll LPegTouchAll FigureSave RpegTimeArray2D LpegTimeArray2D...
    RpegTouchBypegCell  LpegTouchBypegCell RmedianPTTM LmedianPTTM ShowFig patternValue...
    RpegNameSorted LpegNameSorted RLpegNameSorted RpegTouchTurnSorted LpegTouchTurnSorted RLpegTouchTurnSorted RLpegTouchCellSorted ...
    RpegTouchCell LpegTouchCell RpegTouchTurn LpegTouchTurn RpegTouchMatrix LpegTouchMatrix RpegTouchTurnMatrix RLpegTouchTurnMatrix...
    RpegTouchMatrixSorted LpegTouchMatrixSorted RLpegTouchMatrixSorted RpegMedianSorted LpegMedianSorted...
    RpegTouchTurnMatrixSorted LpegTouchTurnMatrixSorted RLpegTouchTurnMatrixSorted...
    RpegTimeArray2D_turn LpegTimeArray2D_turn fig_TouchRL fig_TouchR fig_TouchL RtouchHist LtouchHist RLtouchHist TurnMarkerTime...
    VoltAnalysis TouchTiming DetachTiming DrinkTiming RpNum LpNum RPegTouchAll LPegTouchAll

RpNum=0;
for n=1:length(RpegTimeArray2D_turn(1,:))            
    a=RpegTimeArray2D_turn(:,n);
    lena=length(a(a>0));
    if lena>length(TurnMarkerTime)/5
        RpNum=RpNum+1;
    end
end
LpNum=0;
for n=1:length(LpegTimeArray2D_turn(1,:))
    a=LpegTimeArray2D_turn(:,n);
    lena=length(a(a>0));
    if lena>length(TurnMarkerTime)/5
        LpNum=LpNum+1;
    end
end
% LpNum=9;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PegIndexR=[1:1:RpNum];% 2 3 4 5 6 7 8 9 10 11 12];
PegIndexL=[1:1:LpNum];% 2 3 4 5 6 7 8 9 10 11 12];
%RpegMedian,LpegMedianはTouch時間のMedian
%MedPegTimeR MedPegTimeLはPeg到達時間のMedian

% R_PegTouchCell%入力
% L_PegTouchCell%入力

%　出力はすべて回転ごとに最初のタッチ　
% RpegTouchCell%出力　実際の時間で表示。　
% LpegTouchCell%出力
% RpegTouchTurn%出力　回転内の時間で表示。　
% LpegTouchTurn%出力
% RpegTouchMatrix%出力　実際の時間で表示。回転ごとに行、タッチがない回は０になっている。
% LpegTouchMatrix%出力
% RpegTouchTurnMatrix%出力　回転内の時間で表示。回転ごとに行、タッチがない回は０になっている。
% LpegTouchTurnMatrix%出力

% SliderTouch
% OneTurnTime
% TurnMarkerTime

if VoltAnalysis==0

    RpegTouchCell=cell(1,RpNum);
    LpegTouchCell=cell(1,LpNum);
    RpegTouchTurn=cell(1,RpNum);
    LpegTouchTurn=cell(1,LpNum);

    if FTselect==1
        Duration=OneTurnTime*0.2;%First touches
    elseif FTselect==2
        Duration=OneTurnTime*0.4;%All touches
    end

    RpegTouchMatrix=zeros(length(TurnMarkerTime),RpNum);
    LpegTouchMatrix=zeros(length(TurnMarkerTime),LpNum);
    RpegTouchTurnMatrix=zeros(length(TurnMarkerTime),RpNum);
    LpegTouchTurnMatrix=zeros(length(TurnMarkerTime),LpNum);
    k=0;
    for n=1:12
        if length(R_PegTouchCell{n})>length(TurnMarkerTime)/2
            k=k+1;
            if k<=length(RpegTouchCell)%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            for m=1:length(TurnMarkerTime)-1
        %         Rtouch=R_PegTouchCell{n}(R_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime & R_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration);
        %         Ltouch=L_PegTouchCell{n}(L_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime & L_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime+Duration);

                Rmin=min(R_PegTouchCell{n}(R_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime & R_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration));
        %         Lmin=min(L_PegTouchCell{n}(L_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime & L_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime+Duration));

        RpegTouchCell{k}=[RpegTouchCell{k}; Rmin];
        %         LpegTouchCell{n}=[LpegTouchCell{n}; Lmin];
                if Rmin>TurnMarkerTime(m+1)
                    RtouchTurn= -TurnMarkerTime(m+1) + Rmin;
                else
                    RtouchTurn= -TurnMarkerTime(m) + Rmin;
                end

                RpegTouchTurn{k}=[RpegTouchTurn{k};RtouchTurn];

                if ~isempty(Rmin);RpegTouchTurnMatrix(m,k)=RtouchTurn;RpegTouchMatrix(m,k)=Rmin;end

            end
            RpegTouchTurn{k}(RpegTouchTurn{k}==0)=[];
            end
        end%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    k=0;
    for n=1:12
        if length(L_PegTouchCell{n})>length(TurnMarkerTime)/5
            k=k+1;
            if k<=LpNum%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            for m=1:length(TurnMarkerTime)-1
        %         Rtouch=R_PegTouchCell{n}(R_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime & R_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration);
        %         Ltouch=L_PegTouchCell{n}(L_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime & L_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime+Duration);

        %         Rmin=min(R_PegTouchCell{n}(R_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime & R_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration));
                Lmin=min(L_PegTouchCell{n}(L_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime & L_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime+Duration));
        %         RpegTouchCell{n}=[RpegTouchCell{n}; Rmin];

        LpegTouchCell{k}=[LpegTouchCell{k}; Lmin];
                if Lmin>TurnMarkerTime(m+1)
                    LtouchTurn= -TurnMarkerTime(m+1) + Lmin;
                else
                    LtouchTurn= -TurnMarkerTime(m) + Lmin;
                end

                LpegTouchTurn{k}=[LpegTouchTurn{k};LtouchTurn];

                if ~isempty(Lmin);LpegTouchTurnMatrix(m,k)=LtouchTurn;LpegTouchMatrix(m,k)=Lmin;end

            end
            LpegTouchTurn{k}(LpegTouchTurn{k}==0)=[];
            end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    end

    RPegTouchAll=[];
    for n=1:RpNum
        RPegTouchAll=[RPegTouchAll; RpegTouchCell{n}];
    end
    RPegTouchAll=sort(RPegTouchAll);
    LPegTouchAll=[];
    for n=1:LpNum
        LPegTouchAll=[LPegTouchAll; LpegTouchCell{n}];
    end
    LPegTouchAll=sort(LPegTouchAll);
    RLPegTouchAll=sort([RPegTouchAll;LPegTouchAll]);
elseif VoltAnalysis==1
    RpegTouchTurn=cell(1,12);
    LpegTouchTurn=cell(1,12);
    RPegTouchAll=[];LPegTouchAll=[];RLPegTouchAll=[];
    RpegTouchCell=cell(1,12);RpegTouchall=[];
    LpegTouchCell=cell(1,12);LpegTouchall=[];
    for n=1:12
        RpegTouchCell{n}=find(TouchTiming(n+12,:)==1)';
        LpegTouchCell{n}=find(TouchTiming(n,:)==1)';
        
        RPegTouchAll=[RPegTouchAll RpegTouchCell{n}'];
        LPegTouchAll=[LPegTouchAll LpegTouchCell{n}'];
    end
    RPegTouchAll=sort(RPegTouchAll);
    LPegTouchAll=sort(LPegTouchAll);
    RLPegTouchAll=[RPegTouchAll,LPegTouchAll];
    RLPegTouchAll=sort(RLPegTouchAll);
    
    RpegTouchMatrix=zeros(length(TurnMarkerTime)-1,12);
    LpegTouchMatrix=zeros(length(TurnMarkerTime)-1,12);
    RpegTouchTurnMatrix=zeros(length(TurnMarkerTime)-1,12);
    LpegTouchTurnMatrix=zeros(length(TurnMarkerTime)-1,12);
    for n=1:12
        for m=1:length(TurnMarkerTime)-1
            tempR=RpegTouchCell{n}(RpegTouchCell{n}<TurnMarkerTime(m+1));
            if tempR>0 & max(tempR)>TurnMarkerTime(m)
                RpegTouchMatrix(m,n)=max(tempR);
                RpegTouchTurnMatrix(m,n)=max(tempR)-TurnMarkerTime(m);
                RpegTouchTurn{n}=[RpegTouchTurn{n}; max(tempR)-TurnMarkerTime(m)];
            end
            tempL=LpegTouchCell{n}(LpegTouchCell{n}<TurnMarkerTime(m+1));
            if tempL>0 & max(tempL)>TurnMarkerTime(m)
                LpegTouchMatrix(m,n)=max(tempL);
                LpegTouchTurnMatrix(m,n)=max(tempL)-TurnMarkerTime(m);
                LpegTouchTurn{n}=[LpegTouchTurn{n}; max(tempL)-TurnMarkerTime(m)];
            end
        end
    end
end

RpegName=char('Rpeg1','Rpeg2','Rpeg3','Rpeg4','Rpeg5','Rpeg6','Rpeg7','Rpeg8','Rpeg9','Rpeg10','Rpeg11','Rpeg12');
LpegName=char('Lpeg1','Lpeg2','Lpeg3','Lpeg4','Lpeg5','Lpeg6','Lpeg7','Lpeg8','Lpeg9','Lpeg10','Lpeg11','Lpeg12');
RLpegName=char('Rpeg1','Rpeg2','Rpeg3','Rpeg4','Rpeg5','Rpeg6','Rpeg7','Rpeg8','Rpeg9','Rpeg10','Rpeg11','Rpeg12','Lpeg1','Lpeg2','Lpeg3','Lpeg4','Lpeg5','Lpeg6','Lpeg7','Lpeg8','Lpeg9','Lpeg10','Lpeg11','Lpeg12');
% RLpegName=char('Rpeg1','Lpeg1','Rpeg2','Lpeg2','Rpeg3','Lpeg3','Rpeg4','Lpeg4','Rpeg5','Lpeg5','Rpeg6','Lpeg6','Rpeg7','Lpeg7','Rpeg8','Lpeg8','Rpeg9','Lpeg9','Rpeg10','Lpeg10','Rpeg11','Lpeg11','Rpeg12','Lpeg12');

for n=1:RpNum
    Rttm=RpegTouchTurnMatrix(:,n);
    MedianRtouch(n)=median(Rttm(Rttm~=0),1);
end
for n=1:LpNum
    Lttm=LpegTouchTurnMatrix(:,n);
    MedianLtouch(n)=median(Lttm(Lttm~=0),1);
end

RpegMedian=zeros(1,RpNum);LpegMedian=zeros(1,LpNum);
for n=1:RpNum
    Rarray=RpegTimeArray2D_turn(:,n);
    Rarray(isnan(Rarray))=[];
    RpegMedian(n)=median(Rarray); 
end
for n=1:LpNum
    Larray=LpegTimeArray2D_turn(:,n);
    Larray(isnan(Larray))=[];
    LpegMedian(n)=median(Larray); 
end
% % % % % if RpegMedian(end)>OneTurnTime*0.96
% % % % %     RpegMedian=[RpegMedian(end) RpegMedian(1:end-1)];
% % % % %     RpegTimeArray2Dm=[RpegTimeArray2D(:,end) RpegTimeArray2D(:,1:end-1)];
% % % % %     RpegTimeArray2Dm_turn=[RpegTimeArray2D_turn(:,end) RpegTimeArray2D_turn(:,1:end-1)];
% % % % % else
    RpegTimeArray2Dm=RpegTimeArray2D;
%     RpegTimeArray2Dm_turn=RpegTimeArray2D_turn;
% % % % % end
% % % % % if LpegMedian(end)>OneTurnTime*0.96
% % % % %     LpegMedian=[LpegMedian(end) LpegMedian(1:end-1)];
% % % % %     LpegTimeArray2Dm=[LpegTimeArray2D(:,end) LpegTimeArray2D(:,1:end-1)];
% % % % %     LpegTimeArray2Dm_turn=[LpegTimeArray2D_turn(:,end) LpegTimeArray2D_turn(:,1:end-1)];
% % % % % else
    LpegTimeArray2Dm= LpegTimeArray2D;
%     LpegTimeArray2Dm_turn=LpegTimeArray2D_turn;
% % % % % end

    
RpegTouchMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),RpNum);
LpegTouchMatrixSorted=zeros(length(LpegTouchMatrix(:,1)),LpNum);
RpegTouchTurnMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),RpNum);
LpegTouchTurnMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),LpNum);
for n=1:RpNum
    RpegTouchTurnSorted{n}=RpegTouchTurn{PegIndexR(n)};
    RpegTouchCellSorted{n}=RpegTouchCell{PegIndexR(n)};
    RpegTouchMatrixSorted(:,n)=RpegTouchMatrix(:,PegIndexR(n));
    RpegTouchTurnMatrixSorted(:,n)=RpegTouchTurnMatrix(:,PegIndexR(n));
end
for n=1:LpNum
    LpegTouchTurnSorted{n}=LpegTouchTurn{PegIndexL(n)};
    LpegTouchCellSorted{n}=LpegTouchCell{PegIndexL(n)};
    LpegTouchMatrixSorted(:,n)=LpegTouchMatrix(:,PegIndexL(n));
    LpegTouchTurnMatrixSorted(:,n)=LpegTouchTurnMatrix(:,PegIndexL(n));
end

Rt=RpegTouchTurnMatrixSorted(:);
Rt(Rt==0)=[];
RtouchHist=hist(Rt,500);
Lt=LpegTouchTurnMatrixSorted(:);
Lt(Lt==0)=[];
LtouchHist=hist(Lt,500);

RLtouchHist=[RtouchHist LtouchHist];


fig_TouchR=figure
for n=1:RpNum
    subplot(RpNum,1,n);
    hist(RpegTouchTurnSorted{n},round(OneTurnTime/10));axis([0 OneTurnTime 0 5]);
    text(100,6,RpegName(n,:));
    text(RpegMedian(n),2,'l','FontSize',16,'color',[0 1 0]);
end
if FigureSave==1;saveas(fig_TouchR,[DrName,' ','fig_TouchR.bmp']);end

fig_TouchL=figure
for n=1:LpNum
    subplot(LpNum,1,n);
    hist(LpegTouchTurnSorted{n},round(OneTurnTime/10));axis([0 OneTurnTime 0 5]);
    text(100,6,LpegName(n,:));
    text(LpegMedian(n),2,'l','FontSize',16,'color',[1 0 0]);
end
if FigureSave==1;saveas(fig_TouchL,[DrName,' ','fig_TouchL.bmp']);end


%　0の場合は直前のペグタッチの値を入れておく％％％％％24連の図を描く際の並び替えのためだけに使用
R0=find(isnan(MedianRtouch));
if ~isempty(R0)
    for n=1:length(R0)
        if R0(n)==1
            MedianRtouch(R0(n))=MedianRtouch(R0(n)+1);%OneTurnTime*0.01;
        else
            MedianRtouch(R0(n))=MedianRtouch(R0(n)-1);
        end
    end
end
L0=find(isnan(MedianLtouch));
if ~isempty(L0)
    for n=1:length(L0)
        if L0(n)==1
            MedianLtouch(L0(n))=MedianLtouch(L0(n)+1);%OneTurnTime*0.01;
        else
            MedianLtouch(L0(n))=MedianLtouch(L0(n)-1);
        end
    end
end

MedianAll=[MedianRtouch MedianLtouch];
[S ind]=sort(MedianAll,'ascend');
RLpegNameSorted=RLpegName(ind,:);
RLpegTouchTurn=[RpegTouchTurn LpegTouchTurn];
RLpegTouchCell=[RpegTouchCell LpegTouchCell];
RLpegTouchTurnMatrix=[RpegTouchTurnMatrix LpegTouchTurnMatrix];
RLpegTouchMatrix=[RpegTouchMatrix,LpegTouchMatrix];
RLpegTouchMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),RpNum+LpNum);
RLpegTouchTurnMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),RpNum+LpNum);
for n=1:RpNum+LpNum
    RLpegTouchTurnSorted{n}=RLpegTouchTurn{ind(n)};
    RLpegTouchCellSorted{n}=RLpegTouchCell{ind(n)};
    RLpegTouchMatrixSorted(:,n)=RLpegTouchMatrix(:,ind(n));
    RLpegTouchTurnMatrixSorted(:,n)=RLpegTouchTurnMatrix(:,ind(n));
end
fig_TouchRL=figure('Position',[450 1 700 1115]);
for n=1:RpNum+LpNum
    subplot(RpNum+LpNum,1,n);
    hist(RLpegTouchTurnSorted{n},round(OneTurnTime/10),'k');axis([0 OneTurnTime 0 5]);
    text(100,5,RLpegNameSorted(n,:));
end
if FigureSave==1;saveas(fig_TouchRL,[DrName,' ','fig_TouchRL.bmp']);end

yhight=20;
%if RefPeriod<=100;yhight=50;else yhight=20;end
[fig_touchR PtouchHistoCell_R RpegTouchBypegCell]=TouchAlignByPeg(RpegTouchCellSorted,RpegTimeArray2Dm,yhight);
if FigureSave==1;saveas(fig_touchR,[DrName,' ','TouchAlignRpeg.bmp']);end
[fig_touchL PtouchHistoCell_L LpegTouchBypegCell]=TouchAlignByPeg(LpegTouchCellSorted,LpegTimeArray2Dm,yhight);
if FigureSave==1;saveas(fig_touchL,[DrName,' ','TouchAlignLpeg.bmp']);end

[fig_touchR_TM,PTTMHistoCell_R RmedianPTTM Rmax]=TouchAlignByTM(RpegTouchCell,TurnMarkerTime,yhight);
[fig_touchL_TM,PTTMHistoCell_L LmedianPTTM Lmax]=TouchAlignByTM(LpegTouchCell,TurnMarkerTime,yhight);
if FigureSave==1;saveas(fig_touchR_TM,[DrName,' ','touchR_TM.bmp']);end
if FigureSave==1;saveas(fig_touchL_TM,[DrName,' ','touchL_TM.bmp']);end

    Cell_R=zeros(1,length(PTTMHistoCell_R{1}));Cell_L=zeros(1,length(PTTMHistoCell_L{1}));
    fig_TMpegs=figure;hold on
    Max=max([Rmax Lmax]);
    axis([0 ceil(OneTurnTime/10) 0 Max+2]);
    
    for n=1:12;Cell_R=Cell_R+PTTMHistoCell_R{n};end%text(RmedianPTTM(n),Max+1,'l','FontSize',18,'g');end;
    for n=1:12;Cell_L=Cell_L+PTTMHistoCell_L{n};end%text(LmedianPTTM(n),Max+2,'l','FontSize',18,'r');end;
%     for n=1:12;plot(PTTMHistoCell_R{n},'g');end%text(RmedianPTTM(n),Max+1,'l','FontSize',18,'g');end;
%     for n=1:12;plot(PTTMHistoCell_L{n},'r');end%text(LmedianPTTM(n),Max+2,'l','FontSize',18,'r');end;
    plot(Cell_R,'g');
    plot(Cell_L,'r');
    for n=1:RpNum
        text(RmedianPTTM(n),Max-0.5,'l','FontSize',18,'color',[0 1 0]);
        text(RpegMedian(n)/10,Max+1,'l','FontSize',16,'color',[0 1 1]);
    end
    for n=1:LpNum
        text(LmedianPTTM(n),Max,'l','FontSize',18,'color',[1 0 0]);        
        text(LpegMedian(n)/10,Max+1.5,'l','FontSize',16,'color',[1 0 1]);
    end
    
    hold off;
    if FigureSave==1;saveas(fig_TMpegs,[DrName,' ','TM_pegRL.bmp']);end
% end
