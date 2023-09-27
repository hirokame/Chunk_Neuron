function PegTouchAnalysis24ch(R_PegTouchCell,L_PegTouchCell,SliderTouch,TurnMarkerTime,OneTurnTime,RpegTimeArray2D,LpegTimeArray2D,FTselect)
%'PegTouch'��sensor�̏��𓾂������B12ch���ׂĂ�Rpeg12�{�Ɋ��蓖�Ă��Ă���Ƃ��ɂ�PegTouch�����ł��悩�����B
%�������ARL��6ch���g�p����ۂɂ́A1-6�A7-12�����蓖�Ă�K�v������B

%�y�O�̔ԍ���B��̊�ɂ���v���O�����ɕύX�i20150508�j
%TurnMarker�����y�O12����ɗ��邩�ۂ���\�߃z�C�[���Ń`�F�b�N
%patternValue�ɂ��TurnMarker�̃y�O�ԍ���TouchSensor�̃��C���ԍ��ƕ�������悤��PegIndexR�APegIndexL��ݒ肷��B
%WheelAnalyzer24ch�����s����ۂɂ�PegPattern���������ݒ肳��Ă��邩���ӎ�����K�v������B

global SliderTouch OneTurnTime RefPeriod RpegMedian LpegMedian RLpegMedian RLpegName DrName fig_touchR fig_touchL fig_touchR_TM fig_touchL_TM fig_TMpegs...
    PtouchHistoCell_R PtouchHistoCell_L WaterOn_percent RLPegTouchAll RPegTouchAll LPegTouchAll FigureSave RpegTimeArray2D LpegTimeArray2D...
    RpegTouchBypegCell  LpegTouchBypegCell RmedianPTTM LmedianPTTM ShowFig patternValue...
    RpegNameSorted LpegNameSorted RLpegNameSorted RpegTouchTurnSorted LpegTouchTurnSorted RLpegTouchTurnSorted RLpegTouchCellSorted ...
    RpegTouchCell LpegTouchCell RpegTouchTurn LpegTouchTurn RpegTouchMatrix LpegTouchMatrix RpegTouchTurnMatrix RLpegTouchTurnMatrix...
    RpegTouchMatrixSorted LpegTouchMatrixSorted RLpegTouchMatrixSorted RpegMedianSorted LpegMedianSorted...
    RpegTouchTurnMatrixSorted LpegTouchTurnMatrixSorted RLpegTouchTurnMatrixSorted...
    RpegTimeArray2D_turn LpegTimeArray2D_turn fig_TouchRL fig_TouchR fig_TouchL RtouchHist LtouchHist RLtouchHist

%patternValue�ɂ��TurnMarker�̃y�O�ԍ���TouchSensor�̃��C���ԍ��ƕ�������悤��PegIndexR�APegIndexL��ݒ肷��B
if patternValue==1
    PegIndexR=[12 1 2 3 4 5 6 7 8 9 10 11];
    PegIndexL=[1 2 3 4 5 6 7 8 9 10 11 12];
else
    PegIndexR=[1 2 3 4 5 6 7 8 9 10 11 12];
    PegIndexL=[1 2 3 4 5 6 7 8 9 10 11 12];
end

%RpegMedian,LpegMedian��Touch���Ԃ�Median
%MedPegTimeR MedPegTimeL��Peg���B���Ԃ�Median

% R_PegTouchCell%����
% L_PegTouchCell%����

%�@�o�͂͂��ׂĉ�]���Ƃɍŏ��̃^�b�`�@
% RpegTouchCell%�o�́@���ۂ̎��Ԃŕ\���B�@
% LpegTouchCell%�o��
% RpegTouchTurn%�o�́@��]���̎��Ԃŕ\���B�@
% LpegTouchTurn%�o��
% RpegTouchMatrix%�o�́@���ۂ̎��Ԃŕ\���B��]���Ƃɍs�A�^�b�`���Ȃ���͂O�ɂȂ��Ă���B
% LpegTouchMatrix%�o��
% RpegTouchTurnMatrix%�o�́@��]���̎��Ԃŕ\���B��]���Ƃɍs�A�^�b�`���Ȃ���͂O�ɂȂ��Ă���B
% LpegTouchTurnMatrix%�o��

% SliderTouch
% OneTurnTime
% TurnMarkerTime

RpegTouchCell=cell(1,12);
LpegTouchCell=cell(1,12);
RpegTouchTurn=cell(1,12);
LpegTouchTurn=cell(1,12);

if FTselect==1
    Duration=OneTurnTime*0.2;%First touches
elseif FTselect==2
    Duration=OneTurnTime*0.4;%All touches
end

RpegTouchMatrix=zeros(length(TurnMarkerTime),12);
LpegTouchMatrix=zeros(length(TurnMarkerTime),12);
RpegTouchTurnMatrix=zeros(length(TurnMarkerTime),12);
LpegTouchTurnMatrix=zeros(length(TurnMarkerTime),12);
for n=1:12
    for m=1:length(TurnMarkerTime)-1
%         Rtouch=R_PegTouchCell{n}(R_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime & R_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration);
%         Ltouch=L_PegTouchCell{n}(L_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime & L_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime+Duration);
    
        Rmin=min(R_PegTouchCell{n}(R_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime & R_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration));
        Lmin=min(L_PegTouchCell{n}(L_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime & L_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime+Duration));
        RpegTouchCell{n}=[RpegTouchCell{n}; Rmin];
        LpegTouchCell{n}=[LpegTouchCell{n}; Lmin];
        if Rmin>TurnMarkerTime(m+1)
            RtouchTurn= -TurnMarkerTime(m+1) + Rmin;
        else
            RtouchTurn= -TurnMarkerTime(m) + Rmin;
        end
        if Lmin>TurnMarkerTime(m+1)
            LtouchTurn= -TurnMarkerTime(m+1) + Lmin;
        else
            LtouchTurn= -TurnMarkerTime(m) + Lmin;
        end
        
%         Rtouch=  min(R_PegTouchCell{n}(R_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime & R_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration));
%         Ltouch=  min(L_PegTouchCell{n}(L_PegTouchCell{n}>TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime & L_PegTouchCell{n}<TurnMarkerTime(m)+SliderTouch(n+12)*OneTurnTime+Duration));
        
        RpegTouchTurn{n}=[RpegTouchTurn{n};RtouchTurn];
        LpegTouchTurn{n}=[LpegTouchTurn{n};LtouchTurn];
    
        if ~isempty(Rmin);RpegTouchTurnMatrix(m,n)=RtouchTurn;RpegTouchMatrix(m,n)=Rmin;end
        if ~isempty(Lmin);LpegTouchTurnMatrix(m,n)=LtouchTurn;LpegTouchMatrix(m,n)=Lmin;end
        
%         if ~isempty(Rtouch);RpegTouchMatrix(m,n)=Rtouch;end
%         if ~isempty(Ltouch);LpegTouchMatrix(m,n)=Ltouch;end
    
    end
%     RpegTouchTurn{n}=RpegTouchMatrix(:,n);
    RpegTouchTurn{n}(RpegTouchTurn{n}==0)=[];
%     LpegTouchTurn{n}=LpegTouchMatrix(:,n);
    LpegTouchTurn{n}(LpegTouchTurn{n}==0)=[];
end
% RpegTouchMatrix
% LpegTouchMatrix

RPegTouchAll=sort([RpegTouchCell{1}; RpegTouchCell{2}; RpegTouchCell{3}; RpegTouchCell{4}; RpegTouchCell{5}; RpegTouchCell{6};...
    RpegTouchCell{7}; RpegTouchCell{8}; RpegTouchCell{9}; RpegTouchCell{10}; RpegTouchCell{11}; RpegTouchCell{12}]);
LPegTouchAll=sort([LpegTouchCell{1}; LpegTouchCell{2}; LpegTouchCell{3}; LpegTouchCell{4}; LpegTouchCell{5}; LpegTouchCell{6};...
    LpegTouchCell{7}; LpegTouchCell{8}; LpegTouchCell{9}; LpegTouchCell{10}; LpegTouchCell{11}; LpegTouchCell{12}]);
RLPegTouchAll=sort([RpegTouchCell{1}; RpegTouchCell{2}; RpegTouchCell{3}; RpegTouchCell{4}; RpegTouchCell{5}; RpegTouchCell{6};...
    RpegTouchCell{7}; RpegTouchCell{8}; RpegTouchCell{9}; RpegTouchCell{10}; RpegTouchCell{11}; RpegTouchCell{12};...
    LpegTouchCell{1}; LpegTouchCell{2}; LpegTouchCell{3}; LpegTouchCell{4}; LpegTouchCell{5}; LpegTouchCell{6};...
    LpegTouchCell{7}; LpegTouchCell{8}; LpegTouchCell{9}; LpegTouchCell{10}; LpegTouchCell{11}; LpegTouchCell{12}]);


RpegName=char('Rpeg1','Rpeg2','Rpeg3','Rpeg4','Rpeg5','Rpeg6','Rpeg7','Rpeg8','Rpeg9','Rpeg10','Rpeg11','Rpeg12');
LpegName=char('Lpeg1','Lpeg2','Lpeg3','Lpeg4','Lpeg5','Lpeg6','Lpeg7','Lpeg8','Lpeg9','Lpeg10','Lpeg11','Lpeg12');
RLpegName=char('Rpeg1','Rpeg2','Rpeg3','Rpeg4','Rpeg5','Rpeg6','Rpeg7','Rpeg8','Rpeg9','Rpeg10','Rpeg11','Rpeg12','Lpeg1','Lpeg2','Lpeg3','Lpeg4','Lpeg5','Lpeg6','Lpeg7','Lpeg8','Lpeg9','Lpeg10','Lpeg11','Lpeg12');
% RLpegName=char('Rpeg1','Lpeg1','Rpeg2','Lpeg2','Rpeg3','Lpeg3','Rpeg4','Lpeg4','Rpeg5','Lpeg5','Rpeg6','Lpeg6','Rpeg7','Lpeg7','Rpeg8','Lpeg8','Rpeg9','Lpeg9','Rpeg10','Lpeg10','Rpeg11','Lpeg11','Rpeg12','Lpeg12');

for n=1:12
    Rttm=RpegTouchTurnMatrix(:,n);
    MedianRtouch(n)=median(Rttm(Rttm~=0),1);
    Lttm=LpegTouchTurnMatrix(:,n);
    MedianLtouch(n)=median(Lttm(Lttm~=0),1);
end

RpegMedian=zeros(1,12);LpegMedian=zeros(1,12);
for n=1:12
    Rarray=RpegTimeArray2D_turn(:,n);
    Rarray(isnan(Rarray))=[];
    RpegMedian(n)=median(Rarray); 
    Larray=LpegTimeArray2D_turn(:,n);
    Larray(isnan(Larray))=[];
    LpegMedian(n)=median(Larray); 
end
if RpegMedian(12)>OneTurnTime*0.96
    RpegMedian=[RpegMedian(12) RpegMedian(1:11)];
    RpegTimeArray2Dm=[RpegTimeArray2D(:,12) RpegTimeArray2D(:,1:11)];
    RpegTimeArray2Dm_turn=[RpegTimeArray2D_turn(:,12) RpegTimeArray2D_turn(:,1:11)];
else
    RpegTimeArray2Dm=RpegTimeArray2D;
%     RpegTimeArray2Dm_turn=RpegTimeArray2D_turn;
end
if LpegMedian(12)>OneTurnTime*0.96
    LpegMedian=[LpegMedian(12) LpegMedian(1:11)];
    LpegTimeArray2Dm=[LpegTimeArray2D(:,12) LpegTimeArray2D(:,1:11)];
    LpegTimeArray2Dm_turn=[LpegTimeArray2D_turn(:,12) LpegTimeArray2D_turn(:,1:11)];
else
    LpegTimeArray2Dm= LpegTimeArray2D;
%     LpegTimeArray2Dm_turn=LpegTimeArray2D_turn;
end
    
    
    
% % % % % 
% % % % % 
% % % % % [S indR]=sort(MedianRtouch,'ascend');
% % % % % RpegNameSorted=RpegName(indR,:);
% % % % % % RpegMedianSorted=RpegMedian;
% % % % % % RpegMedianSorted=[RpegMedian(2:12) RpegMedian(1)];
% % % % % % RpegMedianSorted=RpegMedian(indR);
% % % % % % [S indL]=sort(MedianLtouch,'ascend');
% % % % % % LpegNameSorted=LpegName(indL,:);

RpegTouchMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),12);
LpegTouchMatrixSorted=zeros(length(LpegTouchMatrix(:,1)),12);
RpegTouchTurnMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),12);
LpegTouchTurnMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),12);
for n=1:12
    RpegTouchTurnSorted{n}=RpegTouchTurn{PegIndexR(n)};
    LpegTouchTurnSorted{n}=LpegTouchTurn{PegIndexL(n)};
    
    RpegTouchCellSorted{n}=RpegTouchCell{PegIndexR(n)};
    LpegTouchCellSorted{n}=LpegTouchCell{PegIndexL(n)};
    
    RpegTouchMatrixSorted(:,n)=RpegTouchMatrix(:,PegIndexR(n));
    LpegTouchMatrixSorted(:,n)=LpegTouchMatrix(:,PegIndexL(n));
%     n
%     indR(n)
    
    RpegTouchTurnMatrixSorted(:,n)=RpegTouchTurnMatrix(:,PegIndexR(n));
    LpegTouchTurnMatrixSorted(:,n)=LpegTouchTurnMatrix(:,PegIndexL(n));
end

Rt=RpegTouchTurnMatrixSorted(:);
Rt(Rt==0)=[];
RtouchHist=hist(Rt,500);
Lt=LpegTouchTurnMatrixSorted(:);
Lt(Lt==0)=[];
LtouchHist=hist(Lt,500);

RLtouchHist=[RtouchHist LtouchHist];

% figure
% plot(RtouchHist,'g');hold on
% plot(LtouchHist,'r');
% 
% figure
% plot(RLtouchHist);
% RLtouchHist
% % % 
% % % 
% % % for n=1:12
% % %     Rttm=RpegTouchTurnSorted{n};
% % %     if ~isempty(Rttm)
% % %         MedianRtouch2(n)=median(Rttm(Rttm~=0),1);
% % %     elseif n~=1
% % %         MedianRtouch2(n)=MedianRtouch2(n-1)+1;
% % %     elseif n==1
% % %         MedianRtouch2(n)=1;
% % %     end
% % %     Lttm=LpegTouchTurnSorted{n};
% % %     if ~isempty(Lttm)
% % %         MedianLtouch2(n)=median(Lttm(Lttm~=0),1);
% % %     elseif n~=1
% % %         MedianLtouch2(n)=MedianLtouch2(n-1)+1;
% % %     elseif n==1
% % %         MedianLtouch2(n)=1;
% % %     end
% % % end
% % % 
% % % R2=[RpegMedian(2:12) RpegMedian(1)];
% % % L2=[LpegMedian(2:12) LpegMedian(1)];
% % % for n=1:12
% % %     Dr(n)=abs(MedianRtouch2(n)-RpegMedian(n));
% % %     Dr2(n)=abs(MedianRtouch2(n)-R2(n));  
% % %     Dl(n)=abs(MedianLtouch2(n)-LpegMedian(n));
% % %     Dl2(n)=abs(MedianLtouch2(n)-L2(n)); 
% % % end
% % % Sr=sum(Dr<100);
% % % Sr2=sum(Dr2<100);
% % % Sl=sum(Dl<100);
% % % Sl2=sum(Dl2<100);
% % % if Sr<Sr2
% % %     RpegMedianSorted=R2;
% % %     RpegTimeArray2Dmod=[RpegTimeArray2D(:,2:12) RpegTimeArray2D(:,1)];
% % % else
% % %     RpegMedianSorted=RpegMedian;
% % %     RpegTimeArray2Dmod=RpegTimeArray2D;
% % % end
% % % if Sl<Sl2
% % %     LpegMedianSorted=L2;
% % %     LpegTimeArray2Dmod=[LpegTimeArray2D(:,2:12) LpegTimeArray2D(:,1)];
% % % else
% % %     LpegMedianSorted=LpegMedian;
% % %     LpegTimeArray2Dmod=LpegTimeArray2D;
% % % end
% % % % LpegMedianSorted=LpegMedian;%���͂��̂܂�

fig_TouchR=figure
for n=1:12
    subplot(12,1,n);
    hist(RpegTouchTurnSorted{n},round(OneTurnTime/10));axis([0 OneTurnTime 0 5]);
    text(100,6,RpegName(n,:));
    text(RpegMedian(n),2,'l','FontSize',16,'color',[0 1 0]);
end
if FigureSave==1;saveas(fig_TouchR,[DrName,' ','fig_TouchR.bmp']);end

fig_TouchL=figure
for n=1:12
    subplot(12,1,n);
    hist(LpegTouchTurnSorted{n},round(OneTurnTime/10));axis([0 OneTurnTime 0 5]);
    text(100,6,LpegName(n,:));
    text(LpegMedian(n),2,'l','FontSize',16,'color',[1 0 0]);
end
if FigureSave==1;saveas(fig_TouchL,[DrName,' ','fig_TouchL.bmp']);end


%�@0�̏ꍇ�͒��O�̃y�O�^�b�`�̒l�����Ă�������������24�A�̐}��`���ۂ̕��ёւ��̂��߂����Ɏg�p
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
RLpegTouchMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),24);
RLpegTouchTurnMatrixSorted=zeros(length(RpegTouchMatrix(:,1)),24);
for n=1:24
    RLpegTouchTurnSorted{n}=RLpegTouchTurn{ind(n)};
    RLpegTouchCellSorted{n}=RLpegTouchCell{ind(n)};
    RLpegTouchMatrixSorted(:,n)=RLpegTouchMatrix(:,ind(n));
    RLpegTouchTurnMatrixSorted(:,n)=RLpegTouchTurnMatrix(:,ind(n));
end
fig_TouchRL=figure('Position',[450 1 700 1115]);
for n=1:24
    subplot(24,1,n);
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


% ShowFig=2;
% if ShowFig==2%�P�̂Ƃ��A�y�O�p�^�[���ƃ^�b�`��F�ʂŕ\��
%     Cell_R=zeros(1,length(PTTMHistoCell_R{1}));Cell_L=zeros(1,length(PTTMHistoCell_L{1}));
%     fig_TMpegs=figure;hold on
%     Max=max([Rmax Lmax]);
%     axis([0 ceil(OneTurnTime/10) 0 Max+2]);
%     
%     for n=1:12;Cell_R=Cell_R+PTTMHistoCell_R{n};end%text(RmedianPTTM(n),Max+1,'l','FontSize',18,'g');end;
%     for n=1:12;Cell_L=Cell_L+PTTMHistoCell_L{n};end%text(LmedianPTTM(n),Max+2,'l','FontSize',18,'r');end;
% %     for n=1:12;plot(PTTMHistoCell_R{n},'g');end%text(RmedianPTTM(n),Max+1,'l','FontSize',18,'g');end;
% %     for n=1:12;plot(PTTMHistoCell_L{n},'r');end%text(LmedianPTTM(n),Max+2,'l','FontSize',18,'r');end;
%     plot(Cell_R,'g');
%     plot(Cell_L,'r');
%     for n=1:12
%         text(RmedianPTTM(n),Max-0.5,'l','FontSize',18,'color',[0 1 0]);
%         text(LmedianPTTM(n),Max,'l','FontSize',18,'color',[1 0 0]);
%         
%         text(RpegMedianSorted(n)/10,Max+1,'l','FontSize',16,'color',[0 1 1]);
%         text(LpegMedianSorted(n)/10,Max+1.5,'l','FontSize',16,'color',[1 0 1]);
%     end



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
    for n=1:12
        text(RmedianPTTM(n),Max-0.5,'l','FontSize',18,'color',[0 1 0]);
        text(LmedianPTTM(n),Max,'l','FontSize',18,'color',[1 0 0]);
        
        text(RpegMedian(n)/10,Max+1,'l','FontSize',16,'color',[0 1 1]);
        text(LpegMedian(n)/10,Max+1.5,'l','FontSize',16,'color',[1 0 1]);
    end
    
    hold off;
    if FigureSave==1;saveas(fig_TMpegs,[DrName,' ','TM_pegRL.bmp']);end
% end

% % % % % % % RpegMedian=zeros(1,12);
% % % % % % % LpegMedian=zeros(1,12);
% % % % % % % for n=1:12
% % % % % % %     RpegMedian(n)=median(RpegTouchTurn{n});%[RpegMedian median(RpegTouchCell{n})]%
% % % % % % %     LpegMedian(n)=median(LpegTouchTurn{n});%[LpegMedian median(LpegTouchCell{n})]%
% % % % % % % %     RpegTouchTurn{n}(RpegTouchTurn{n}<0)=[];
% % % % % % % %     LpegTouchTurn{n}(LpegTouchTurn{n}<0)=[];
% % % % % % % %     RpegMedian(n)=median(RpegTouchTurn{n}(RpegTouchTurn{n}>=0));%[RpegMedian median(RpegTouchCell{n})]%
% % % % % % % %     LpegMedian(n)=median(LpegTouchTurn{n}(LpegTouchTurn{n}>=0));%[LpegMedian median(LpegTouchCell{n})]%
% % % % % % % end




% 
% 
% RLpegMedian=[];%pegTouchCell��R,L�̏��Ō��݂ɕ��ׂ�B
% for n=1:12;RLpegMedian=[RLpegMedian RpegMedian(n) LpegMedian(n)];end%PegMedian��R,L�̏��Ō��݂ɕ��ׂ�B
% 
% for n=1:24;
%     if mod(n,2)==1;RLpegTouchCell{n}=RpegTouchCell{(n+1)/2};
%     else RLpegTouchCell{n}=LpegTouchCell{n/2};end
% end
% 
% %sort�ŕ��ёւ���ƐG���Ă��Ȃ��y�O���Ō���ɍs���Ă��܂��B�����ȊO�Ɋւ��ẮA�{���͂��ꂪ�������B
% % [S ind]=sort(RLpegMedian,'ascend');
% % RLpegNameSorted=RLpegName(ind,:);
% 
% %24�{�̃y�O�����ۂ̏��ԁiMedian)�ɕ��ёւ���B���E��RL�y�O���ƂɌ������߂�B
% change=1;
% while change==1
%     change=0;
%     for n=1:length(RLpegTouchCell)-1
%         %disp(RLpegMedian(n))
%         if RLpegMedian(n)>RLpegMedian(n+1)
%             temp=RLpegMedian(n);
%             RLpegMedian(n)=RLpegMedian(n+1);
%             RLpegMedian(n+1)=temp;
%             temp=0;
%             
%             tempC=RLpegTouchCell{n};
%             RLpegTouchCell{n}=RLpegTouchCell{n+1};
%             RLpegTouchCell{n+1}=tempC;
%             tempC=[];
%             
%             tempN=RLpegName(n,:);
%             RLpegName(n,:)=RLpegName(n+1,:);
%             RLpegName(n+1,:)=tempN;
%             tempN='';
%             
%             change=1;
%         end
%     end
% end
% RLpegName


