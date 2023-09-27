function Cov_analysis24ch(RLpegTouchCell,RpegMedian1,LpegMedian1,TurnMarkerTime1,RLpegName1,RLpegMedian1)

%Turnごとの接触時間一覧表を作成
%1回転に一つの値のみ。一つもないときはNaNをいれる。
%TMからのPegのMedianを基準に1000ms以上離れたモノは除く
% Cell=RLpegTouchCell;TurnMarkerTime=TurnMarkerTime1;RLpegName=RLpegName1;RLpegMedian=RLpegMedian1;%LpegTouchCell=LpegTouchCell1;RLpegTouchCell=RLpegTouchCell1;RpegMedian=RpegMedian1;LpegMedian=LpegMedian1;
%disp('Cell=');disp(Cell{1});
%TouchMatrix:横方向、Rpeg1,Lpeg1,...,Rpeg12,Lpeg12.縦方向、回転(試行)数
%TouchMatrix=zeros(length(TurnMarkerTime)-1,24);
global OneTurnTime WaterOnArray WaterOffArray CrossVar CrossVarInv_2...
    CovInterval_3 CoefInterval_3 CovInterval_5 CoefInterval_5 DrName...
    Prod_Int_dev_abs_Mean_3 Prod_Int_dev_abs_Var_3 Prod_Int_dev_abs_Mean_5 Prod_Int_dev_abs_Var_5...
    PegVar VarNextPeg Cov3scatter Cov5scatter fig_CovInt3 fig_CovInt5 fig_CovInt3_ConstAx fig_CovInt5_ConstAx FigureSave...
    RpegNameSorted LpegNameSorted RLpegNameSorted RpegTouchTurnSorted LpegTouchTurnSorted RLpegTouchTurnSorted RLpegTouchCellSorted ...
    RpegTouchCell LpegTouchCell  RpegTouchTurn LpegTouchTurn RpegTouchMatrix LpegTouchMatrix RpegTouchTurnMatrix RLpegTouchTurnMatrix...
    RpegTouchMatrixSorted LpegTouchMatrixSorted RLpegTouchMatrixSorted RpegMedianSorted LpegMedianSorted...
    RpegTouchTurnMatrixSorted LpegTouchTurnMatrixSorted RLpegTouchTurnMatrixSorted

% Cell=RLpegTouchCellSorted;

TurnMarkerTime=TurnMarkerTime1;

RpegTouchMatrixSorted(RpegTouchMatrixSorted==0)=NaN;
LpegTouchMatrixSorted(LpegTouchMatrixSorted==0)=NaN;

% RpegTouchMatrix(RpegTouchMatrix==0)=NaN;
% LpegTouchMatrix(LpegTouchMatrix==0)=NaN;

RpegTouchMatrix=RpegTouchMatrixSorted;
LpegTouchMatrix=LpegTouchMatrixSorted;
%
ShiftR= [RpegTouchMatrix(1:end-1,2:12) RpegTouchMatrix(1:end-1,12:end)]-RpegTouchMatrix(1:end-1,:);
ShiftL= [LpegTouchMatrix(1:end-1,2:12) LpegTouchMatrix(1:end-1,12:end)]-LpegTouchMatrix(1:end-1,:);

MinusR=zeros(1,length(ShiftR(1,:)));MinusL=zeros(1,length(ShiftL(1,:)));
for n=1:12
    R=ShiftR(:,n);
    if median(R(~isnan(R)))<0
        MinusR(n)=1;
    end
    L=ShiftL(:,n);
    if median(L(~isnan(L)))<0
        MinusL(n)=1;
    end
end


RpegTouchModified=[RpegTouchMatrix(1:end-1,find(MinusR==1)) RpegTouchMatrix(2:end,find(MinusR==0))];
LpegTouchModified=[LpegTouchMatrix(1:end-1,find(MinusL==1)) LpegTouchMatrix(2:end,find(MinusL==0))];

RshiftMatrix=zeros(length(RpegTouchModified(:,1))-1,12,12);
LshiftMatrix=zeros(length(LpegTouchModified(:,1))-1,12,12);

for n=1:12
    if n~=12
        RshiftMatrix(:,:,n)= [RpegTouchModified(1:end-1,n+1:12) RpegTouchModified(2:end,1:n)]-RpegTouchModified(1:end-1,:);
        LshiftMatrix(:,:,n)= [LpegTouchModified(1:end-1,n+1:12) LpegTouchModified(2:end,1:n)]-LpegTouchModified(1:end-1,:);
    elseif n==12
        RshiftMatrix(:,:,n)= -RpegTouchModified(1:end-1,:)+RpegTouchModified(2:end,:);
        LshiftMatrix(:,:,n)= -LpegTouchModified(1:end-1,:)+LpegTouchModified(2:end,:);
    end
end

LenR=length(RshiftMatrix(:,1,1));
LenL=length(LshiftMatrix(:,1,1));
for n=1:12
    Rarray=RshiftMatrix(:,n,1);
    Larray=LshiftMatrix(:,n,1);
    Rarray(isnan(Rarray))=[];
    Larray(isnan(Larray))=[];
    if length(Rarray)>LenR*0.4
        Mean1R(n)=mean(Rarray);
    end
    if length(Larray)>LenL*0.4
        Mean1L(n)=mean(Larray);
    end
end
figure
subplot(2,1,1)
bar(Mean1R);
subplot(2,1,2)
bar(Mean1L);
title('Next touch (1 cycle)');
Mean1R




% % RLpegName=RLpegName1;% RLpegMedian=RLpegMedian1;%LpegTouchCell=LpegTouchCell1;RLpegTouchCell=RLpegTouchCell1;RpegMedian=RpegMedian1;LpegMedian=LpegMedian1;
% RLpegMedian=sort([RpegMedianSorted LpegMedianSorted],'ascend');

% % % % TouchMatrix=RpegTouchMatrixSorted;
% % % % TouchMatrix(TouchMatrix==0)=NaN;
% % % % 
% % % % NaNpeg=zeros(1,length(TouchMatrix(1,:)));
% % % % for n=1:length(TouchMatrix(1,:))
% % % %     Array=TouchMatrix(:,n);
% % % %     if sum(isnan(Array))>length(TouchMatrix(:,1))
% % % %         NaNpeg(n)=1;
% % % %     end
% % % % end
% % % % for n=1:length(TouchMatrix(1,:))
% % % %     if NaNpeg(n)==1
% % % %         skip=1;
% % % %     else
% % % %         skip=0;
% % % %     end
% % % %     for m=1:length(TouchMatrix(:,1))-1
% % % %         if n<=10 
% % % %             DiffMatrix(m,n)=TouchMatrix(m,n+1+skip)-TouchMatrix(m,n);
% % % %         elseif n==11 && skip==1
% % % %             DiffMatrix(m,11)=TouchMatrix(m+1,1)-TouchMatrix(m,11);
% % % %         elseif n==12 && skip==0
% % % %             DiffMatrix(m,12)=TouchMatrix(m+1,1)-TouchMatrix(m,12);
% % % %         elseif n==11 && skip==0
% % % %             DiffMatrix(m,11)=TouchMatrix(m,12)-TouchMatrix(m,11);
% % % %         elseif n==12 && skip==1
% % % %             DiffMatrix(m,12)=TouchMatrix(m+1,2)-TouchMatrix(m,12);
% % % %         end
% % % %     end
% % % % end

% % % % 
% % % % TouchMatrixTurn=zeros(length(TurnMarkerTime)-1,length(TouchMatrix(1,:)));%最後の列に、次試行の最初のペグまでの時間を含む。
% % % % TouchMatrix=zeros(length(TurnMarkerTime)-1,length(TouchMatrix(1,:)));
% % % % TouchVector=[];
% % % % 
% % % % for n=1:length(TurnMarkerTime)-1
% % % %     for m=1:length(Cell)
% % % %         %A=RLpegTouchCell{m}(TurnMarkerTime(n)<RLpegTouchCell{m}&RLpegTouchCell{m}<TurnMarkerTime(n+1));
% % % %         A=Cell{m}(RLpegMedian(m)-2000<Cell{m}-TurnMarkerTime(n) & Cell{m}-TurnMarkerTime(n)<RLpegMedian(m)+2000);%RLpegMedianはタッチのタイミング中央値　24本順序調整済
% % % %         if isempty(A)==0
% % % %             TouchMatrixTurn(n,m)=A(1)-TurnMarkerTime(n);
% % % %             TouchMatrix(n,m)=A(1);
% % % %             %TouchVector=[TouchVector A(1)];
% % % %         elseif isempty(A)
% % % %             TouchMatrixTurn(n,m)=NaN;
% % % %             TouchMatrix(n,m)=NaN;
% % % %             %TouchVector=[TouchVector NaN];
% % % %         end        
% % % %     end
% % % %     
% % % %     B=Cell{1}(RLpegMedian(1)-2000<Cell{1}-TurnMarkerTime(n+1) & Cell{1}-TurnMarkerTime(n+1)<RLpegMedian(1)+2000);%TurnMarkerTime(n+1)<Cell{1} &
% % % %     %else B=Cell{1}(TurnMarkerTime(n)+OneTurnTime<Cell{1} & Cell{1}<TurnMarkerTime(n+2) & RLpegMedian(1)-900<Cell{1}-TurnMarkerTime(n+1) & Cell{1}-TurnMarkerTime(n+1)<RLpegMedian(1)+900);
% % % %     if isempty(B)==0
% % % %         TouchMatrixTurn(n,13)=B(1)-TurnMarkerTime(n);
% % % %     elseif isempty(B)
% % % %         TouchMatrixTurn(n,13)=NaN;
% % % %     end      
% % % % end
% % % % 
% % % % % TouchMatrix;
% % % % %disp('TouchMatrixTurn=');disp(TouchMatrixTurn);
% % % % %TouchMatrixTurn=TouchMatrixplus1(:,1:length(TouchMatrixplus1(1,:))-1);%TouchMatrixには最後のペグから次試行の最初のペグまでの時間は含まない。
% % % % 
% % % % %NaNの削除と残ったペグ名の表示----------------------------
% % % % %後で、NaNが一定数以上入っている列を全部Infに変換。
% % % % %pegnum=[];%消えずに残ったペグの順番。ペグ番号とは異なる
% % % % omitpeg=[];
% % % % for n=1:length(TouchMatrix(1,:))%列の削除。カウントの少ないペグは捨てる。
% % % %     if sum(isfinite(TouchMatrix(:,n)))<15 %sum(isnan(TouchMatrix(:,n)))>length(TurnMarkerTime)*0.75%%%ここを可変にするとよいかも.この値を１に近づけると解析できるペグ数は増えるがサンプル数が減る。...
% % % %                                           %%%逆に0に近づけると解析できるペグ数は減るがサンプル数は増え、信頼性は上がる。
% % % %         TouchMatrix(:,n)=Inf;
% % % %         omitpeg=[omitpeg n];
% % % %     %else pegnum=[pegnum n];
% % % %     end
% % % % end
% % % % 
% % % % % disp('pegnum=');disp(pegnum);
% % % % % disp('<Rpeg:1-12,Lpeg:13-24> RLpegNum((pegnum))=');disp(RLpegNum((pegnum)));%RLpegNumはRとLのペグをMedian時間の早い順に並べた順番
% % % % % RLpeg={'Rpeg1','Rpeg2','Rpeg3','Rpeg4','Rpeg5','Rpeg6','Rpeg7','Rpeg8','Rpeg9','Rpeg10','Rpeg11','Rpeg12',...
% % % % %     'Lpeg1','Lpeg2','Lpeg3','Lpeg4','Lpeg5','Lpeg6','Lpeg7','Lpeg8','Lpeg9','Lpeg10','Lpeg11','Lpeg12'};
% % % % % RLpegName=RLpeg(RLpegNum(pegnum))%これでペグの名前が表示される
% % % % %disp(RLpeg(RLpegNum));
% % % % % n=1;
% % % % % while  n<=length(TouchMatrix(:,1))%行の削除。NaNのある行を削除
% % % % %     if any(isnan(TouchMatrix(n,:)))==1;TouchMatrixTurn(n,:)=[];n=n-1;end
% % % % % %     if any(isnan(TouchMatrix(n,:)))==1;TouchMatrixTurn(n,:)=0;end
% % % % %     n=n+1;
% % % % % end
% % % % disp('TouchMatrix=');disp(TouchMatrix); %-------------------------------------------------------

TouchMatrix=RLpegTouchMatrixSorted;
TouchMatrixTurn=RLpegTouchTurnMatrixSorted;

TouchMatrix(TouchMatrix==0)=NaN;
TouchMatrixTurn(TouchMatrixTurn==0)=NaN;

%NaNの削除と残ったペグ名の表示----------------------------
%後で、NaNが一定数以上入っている列を全部Infに変換。
%pegnum=[];%消えずに残ったペグの順番。ペグ番号とは異なる
omitpeg=[];
for n=1:length(TouchMatrix(1,:))%列の削除。カウントの少ないペグは捨てる。
    if sum(isfinite(TouchMatrix(:,n)))<15 %sum(isnan(TouchMatrix(:,n)))>length(TurnMarkerTime)*0.75%%%ここを可変にするとよいかも.この値を１に近づけると解析できるペグ数は増えるがサンプル数が減る。...
                                          %%%逆に0に近づけると解析できるペグ数は減るがサンプル数は増え、信頼性は上がる。
        TouchMatrix(:,n)=Inf;
        omitpeg=[omitpeg n];
    %else pegnum=[pegnum n];
    end
end


TT=TouchMatrix';
TouchVector=TT(:);
TouchVector=TouchVector';
TouchVector=[TouchVector [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]];

%NaNがあってもWaterOnが連続であれば良いのではないか。WaterOn連続型
%CorrcoefではなくてCovにする。相関係数ではなくて、共分散にする。これが小さな値を取る部分で学習が進んでいたのではないか。
%24x24の表示にする。
MeanNextPeg=zeros(1,length(TouchMatrix(1,:)));
VarNextPeg=zeros(1,length(TouchMatrix(1,:)));
CovInterval_3=zeros(1,length(TouchMatrix(1,:)));
Prod_Int_dev__abs_Mean_3=zeros(1,length(TouchMatrix(1,:)));
Prod_Int_dev_abs_Var_3=zeros(1,length(TouchMatrix(1,:)));
% CoefInterval_3=zeros(1,length(TouchMatrix(1,:)));
% Prod_Int_dev_Mean_3=zeros(1,length(TouchMatrix(1,:)));
% Prod_Int_dev_absMean_3=zeros(1,length(TouchMatrix(1,:)));
% Prod_Int_dev_Var_3=zeros(1,length(TouchMatrix(1,:)));
% Diff_Int_dev_absMean_3=zeros(1,length(TouchMatrix(1,:)));
% Diff_Int_dev_Var_3=zeros(1,length(TouchMatrix(1,:)));
%（前一つ、後一つの予備）連続する４つの接触があれば、その中央二つに関してInterval,Covを求める。
%TouchMatrixをTurnごとに区切らずに全部連結。TouchVector
%TouchMatrix

%TouchVector=reshape(TouchMatrix,(length(TurnMarkerTime)+2)*length(TouchMatrix(1,:)),1)%連結して一列に
%TouchVector(TouchVector==0)=[];
%CovInterval=zeros(1,length(TouchMatrix(1,:)));

SctTitle={'1-2 x 2-3' '2-3 x 3-4' '3-4 x 4-5' '4-5 x 5-6' '5-6 x 6-7' '6-7 x 7-8' '7-8 x 8-9' '8-9 x 9-10' '9-10 x 10-11' '10-11 x 11-12'...
    '11-12 x 12-13' '12-13 x 13-14' '13-14 x 14-15' '14-15 x 15-16' '15-16 x 16-17' '16-17 x 17-18' '17-18 x 18-19' '18-19 x 19-20'...
    '19-20 x 20-21' '20-21 x 21-22' '21-22 x 22-23' '22-23 x 23-24' '23-24 x 24-1' '24-1 x 1-2'};
Cov3scatter=figure('Position',[1 1 1400 975]);

for n=1:length(TouchMatrix(1,:))%3本ペグ解析
    Intervals=[1,1];
    incr=1;
    for m=1:length(TurnMarkerTime)
        add_1=1;add_2=1;

        if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1))==1;add_1=add_1+1;end%Infの列（ペグ）を飛ばす。3本続けてInfで５７ないことを前提としている。。。
        if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1))==1;add_1=add_1+1;end
        
        if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2))==1;add_2=add_2+1;end%Infの列（ペグ）を飛ばす。3本続けてInfで５７ないことを前提としている。。。
        if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2))==1;add_2=add_2+1;end
        
        if isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n))==1 & isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1))==1 & isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2))==1 &TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2)~=0;
            %disp(Intervals);
            Intervals(incr,1)=TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1)-TouchVector((m-1)*length(TouchMatrix(1,:))+n);
            Intervals(incr,2)=TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2)-TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1);
            incr=incr+1;
            %disp(Intervals);
        end
    end
    
    Intervals_Mean=[(Intervals(:,1)-mean(Intervals(:,1))),(Intervals(:,2)-mean(Intervals(:,2)))];
    
    %disp(Intervals);
    if length(Intervals(:,1))<15
        MeanNextPeg(n)=NaN;
        VarNextPeg(n)=NaN;
        CovInterval_3(n)=NaN;
        Prod_Int_dev_abs_Mean_3(n)=NaN;
        Prod_Int_dev_abs_Var_3(n)=NaN;        
%         CoefInterval_3(n)=NaN;
%         Prod_Int_dev_Mean_3(n)=NaN;
%         Prod_Int_dev_absMean_3(n)=NaN;
%         Prod_Int_dev_Var_3(n)=NaN;
%         Diff_Int_dev_absMean_3(n)=NaN;
%         Diff_Int_dev_Var_3(n)=NaN;
    else
        MeanNextPeg(n)=mean(Intervals(:,1));
        VarNextPeg(n)=var(Intervals(:,1));
                
        CovM=cov(Intervals(:,1),Intervals(:,2));%ペグ間時間で補正しない場合。
        %CovM=cov(Intervals(:,1)/(mean(Intervals(:,1))),Intervals(:,2)/mean(Intervals(:,2)));%ペグ間時間で補正　%CORRCOEF(Intervals(:,1),Intervals(:,2))/(Mean(Intervals(:,1))^length(Intervals(:,1))*Mean(Intervals(:,2))^length(Intervals(:,2)))
        
        CovInterval_3(n)=CovM(1,2);
%         CoefM=corrcoef(Intervals(:,1),Intervals(:,2));        
%         CoefInterval_3(n)=CoefM(1,2);

%         Int_dev=[(Intervals(:,1)-mean(Intervals(:,1)))/mean(Intervals(:,1)),(Intervals(:,2)-mean(Intervals(:,2)))/mean(Intervals(:,2))];
%         Prod_Int_dev=prod(Int_dev,2);%2は次元２の方向で掛け算すること
%         Prod_Int_dev_Mean_3(n)=mean(Prod_Int_dev);
%         Prod_Int_dev_absMean_3(n)=mean(abs(Prod_Int_dev));
%         Prod_Int_dev_Var_3(n)=var(Prod_Int_dev);
        
        Int_dev_abs=[abs((Intervals(:,1)-mean(Intervals(:,1)))),abs((Intervals(:,2)-mean(Intervals(:,2))))];
        Prod_Int_dev_abs=prod(Int_dev_abs,2);%2は次元２の方向で掛け算すること
        Prod_Int_dev_abs_Mean_3(n)=mean(Prod_Int_dev_abs);
        Prod_Int_dev_abs_Var_3(n)=var(Prod_Int_dev_abs);
        
%         Diff_Int_dev=diff(Int_dev,1,2);%１は隣の要素と引き算すること、２は次元２の方向で引き算すること
%         Diff_Int_dev_absMean_3(n)=mean(abs(Diff_Int_dev));
%         Diff_Int_dev_Var_3(n)=var(Diff_Int_dev);
    end
    subplot(4,6,n)
    scatter(Intervals_Mean(:,1),Intervals_Mean(:,2),'ro');title(SctTitle{n});axis([-500 500 -500 500]);
end
if FigureSave==1;saveas(Cov3scatter,[DrName,' ','Cov3scatter.bmp']);end
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% CovInterval_5=zeros(1,length(TouchMatrix(1,:)));
% Prod_Int_dev__abs_Mean_5=zeros(1,length(TouchMatrix(1,:)));
% Prod_Int_dev_abs_Var_5=zeros(1,length(TouchMatrix(1,:)));

% % % CoefInterval_5=zeros(1,length(TouchMatrix(1,:)));
% % % Prod_Int_dev_Mean_5=zeros(1,length(TouchMatrix(1,:)));
% % % Prod_Int_dev_absMean_5=zeros(1,length(TouchMatrix(1,:)));
% % % Prod_Int_dev_Var_5=zeros(1,length(TouchMatrix(1,:)));
% % % Diff_Int_dev_absMean_5=zeros(1,length(TouchMatrix(1,:)));
% % % Diff_Int_dev_Var_5=zeros(1,length(TouchMatrix(1,:)));

% Cov5scatter=figure('Position',[1 1 1400 975]);
% for n=1:length(TouchMatrix(1,:))%5本ペグ解析
%     Intervals=[1,1];
%     incr=1;
%     for m=1:length(TurnMarkerTime)
%         add_1=1;add_2=1;add_3=1;add_4=1;
% 
%         if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1))==1;add_1=add_1+1;break;end%この列は計算のスタート地点。ここがInfであればその列は計算しない。
%         %ここの前、nの列はInfでも良い。したがって、すぐ下でisnan(TouchVector((m-1)*length(TouchMatrix(1,:))+n))==0としている。
%         %if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1))==1;add_1=add_1+1;end
%         
%         if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2))==1;add_2=add_2+1;end%Infの列（ペグ）を飛ばす。3本続けてInfで５７ないことを前提としている。。。
%         if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2))==1;add_2=add_2+1;end
%         
%         if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2+add_3))==1;add_3=add_3+1;end
%         if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2+add_3))==1;add_3=add_3+1;end
%         
%         if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2+add_3+add_4))==1;add_4=add_4+1;end
%         if isinf(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2+add_3+add_4))==1;add_4=add_4+1;end
%         
%         if isnan(TouchVector((m-1)*length(TouchMatrix(1,:))+n))==0 & isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1))==1 & isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2))==1 & isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2+add_3))==1 & isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2+add_3+add_4))==1 &TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2+add_3+add_4)~=0;%isnan(TouchVector((m-1)*length(TouchMatrix(1,:))+n+1))==0 & isnan(TouchVector((m-1)*length(TouchMatrix(1,:))+n+2))==0 & isnan(TouchVector((m-1)*length(TouchMatrix(1,:))+n+3))==0 &
% 
% 
%             %if isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+1))==1 & isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+2))==1 & isfinite(TouchVector((m-1)*length(TouchMatrix(1,:))+n+3))==1
%                 Intervals(incr,1)=TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2)-TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1);
%                 Intervals(incr,2)=TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2+add_3)-TouchVector((m-1)*length(TouchMatrix(1,:))+n+add_1+add_2);
%                 incr=incr+1;
%                 %disp(Intervals);
%             %end
%         end        
%     end
%     %Intervals(Intervals(==10000)=[]
%     
% %     m1=mean(Intervals(:,1))
% %     m2=mean(Intervals(:,2))
% 
%     Intervals_Mean=[(Intervals(:,1)-mean(Intervals(:,1))),(Intervals(:,2)-mean(Intervals(:,2)))];%[(Intervals(:,1)-mean(Intervals(:,1)))/mean(Intervals(:,1)),(Intervals(:,2)-mean(Intervals(:,2)))/mean(Intervals(:,2))]
%     
%     if length(Intervals(:,1))<15
%         CovInterval_5(n)=NaN;
%         
%         Prod_Int_dev_abs_Mean_5(n)=NaN;
%         Prod_Int_dev_abs_Var_5(n)=NaN;
% %         CoefInterval_5(n)=NaN;
% %         Prod_Int_dev_Mean_5(n)=NaN;
% %         Prod_Int_dev_absMean_5(n)=NaN;
% %         Prod_Int_dev_Var_5(n)=NaN;
% %         Diff_Int_dev_absMean_5(n)=NaN;
% %         Diff_Int_dev_Var_5(n)=NaN;
%     else
%         CovM=cov(Intervals(:,1),Intervals(:,2));%ペグ間時間で補正しない場合
%         %CovM=cov(Intervals(:,1)/(mean(Intervals(:,1))),Intervals(:,2)/mean(Intervals(:,2)));%ペグ間時間で補正する場合　%/(Mean(Intervals(:,1))^length(Intervals(:,1))*Mean(Intervals(:,2))^length(Intervals(:,2)))
%         CovInterval_5(n)=CovM(1,2);
% %         CoefM=corrcoef(Intervals(:,1),Intervals(:,2));
% %         CoefInterval_5(n)=CoefM(1,2);
%         
% %         Int_dev=[(Intervals(:,1)-mean(Intervals(:,1)))/mean(Intervals(:,1)),(Intervals(:,2)-mean(Intervals(:,2)))/mean(Intervals(:,2))];
% %         Prod_Int_dev=prod(Int_dev,2);%2は次元２の方向で掛け算すること
% %         Prod_Int_dev_Mean_5(n)=mean(Prod_Int_dev);
% %         Prod_Int_dev_absMean_5(n)=mean(abs(Prod_Int_dev));
% %         Prod_Int_dev_Var_5(n)=var(Prod_Int_dev);
%         Int_dev_abs=[abs((Intervals(:,1)-mean(Intervals(:,1)))),abs((Intervals(:,2)-mean(Intervals(:,2))))];
%         %Int_dev_abs=[abs((Intervals(:,1)-mean(Intervals(:,1)))/mean(Intervals(:,1))),abs((Intervals(:,2)-mean(Intervals(:,2)))/mean(Intervals(:,2)))];%[abs((Intervals(:,1)-mean(Intervals(:,1)))),abs((Intervals(:,2)-mean(Intervals(:,2))))];%
%         Prod_Int_dev_abs=prod(Int_dev_abs,2);%2は次元２の方向で掛け算すること
%         Prod_Int_dev_abs_Mean_5(n)=mean(Prod_Int_dev_abs);
%         Prod_Int_dev_abs_Var_5(n)=var(Prod_Int_dev_abs);
% %        
% %         Diff_Int_dev=diff(Int_dev,1,2);%１は隣の要素と引き算すること、２は次元２の方向で引き算すること
% %         Diff_Int_dev_absMean_5(n)=mean(abs(Diff_Int_dev));
% %         Diff_Int_dev_Var_5(n)=var(Diff_Int_dev);
%         
%     end
%     %disp('Intervals=');disp(n);disp(Intervals);
%     
%     if n==length(TouchMatrix(1,:));subplot(4,6,1);
%     else subplot(4,6,n+1);end
%     scatter(Intervals_Mean(:,1),Intervals_Mean(:,2),'bo');axis([-500 500 -500 500]);
%     if n==length(TouchMatrix(1,:));title('1-2-3');else title(SctTitle{n+1});end
% end
% if FigureSave==1;saveas(Cov5scatter,[DrName,' ','Cov5scatter.bmp']);end
% 
% CovInterval_5=[CovInterval_5(length(TouchMatrix(1,:))) CovInterval_5(1:23)];
% 
% Prod_Int_dev_abs_Mean_5=[Prod_Int_dev_abs_Mean_5(length(TouchMatrix(1,:))) Prod_Int_dev_abs_Mean_5(1:23)];
% Prod_Int_dev_abs_Var_5=[Prod_Int_dev_abs_Var_5(length(TouchMatrix(1,:))) Prod_Int_dev_abs_Var_5(1:23)];
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% CoefInterval_5=[CoefInterval_5(length(TouchMatrix(1,:))) CoefInterval_5(1:23)];
% Prod_Int_dev_Mean_5=[Prod_Int_dev_Mean_5(length(TouchMatrix(1,:))) Prod_Int_dev_Mean_5(1:23)];
% Prod_Int_dev_absMean_5=[Prod_Int_dev_absMean_5(length(TouchMatrix(1,:))) Prod_Int_dev_absMean_5(1:23)];
% Prod_Int_dev_Var_5=[Prod_Int_dev_Var_5(length(TouchMatrix(1,:))) Prod_Int_dev_Var_5(1:23)];
% Diff_Int_dev_absMean_5=[Diff_Int_dev_absMean_5(length(TouchMatrix(1,:))) Diff_Int_dev_absMean_5(1:23)];
% Diff_Int_dev_Var_5=[Diff_Int_dev_Var_5(length(TouchMatrix(1,:))) Diff_Int_dev_Var_5(1:23)];

%-------------------------------------------------------------------
CutOffLimit=15;
PegVar=zeros(1,length(TouchMatrix(1,:)));
for n=1:length(TouchMatrixTurn(1,:))   
    A=TouchMatrixTurn(:,n);
    for m=1:length(A);
        if isnan(A(m))==1;A(m)=0;end;
    end
    
    A(A==0)=[];
    Mdn=median(A);
    Mn=mean(A);
    for m=1:length(A);
        if A(m)>Mdn+1000 | A(m)<Mdn-1000;A(m)=0;end;
    end
    A(A==0)=[];
    if length(A)>CutOffLimit %数が少ない場合は計算しない。
        PegVar(n)=var(A);   
    else
        PegVar(n)=NaN;%本当に数値が０になる場合と区別したほうが良い?
    end    
end
%------------------------------------------------------------------

% VarNextPeg=CrossVar(2,:);

fig_CovInt3=figure('Position',[1 1 1400 975]);
% subplot(4,1,1),bar(PegVar);
% for n=1:length(PegVar);if isnan(PegVar(n))==1;text(n,0,'X');end;end
% title('Var /Peg');
% subplot(4,1,2),bar(VarNextPeg);
% for n=1:length(VarNextPeg);if isnan(VarNextPeg(n))==1;text(n,0,'X');end;end
% title('Var NextPeg');
% subplot(4,1,3),bar(CovInterval_3);
% title('Cov/3pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(4,1,4),bar(Prod_Int_dev_abs_Mean_3);
% title('Prod_abs_Int Mean/3pegs');
% for n=omitpeg;text(n,0,'X');end
% if FigureSave==1;saveas(fig_CovInt3,[DrName,' ','CovIntervals3.bmp']);end

subplot(2,1,1),bar(CovInterval_3);
title('Cov/3pegs');
for n=omitpeg;text(n,0,'X');end
% axis([0 25 -10000 1000]);
axis off;
subplot(2,1,2),bar(CovInterval_3);
for n=omitpeg;text(n,0,'X');end
% title('Prod_abs_Int Mean/3pegs');
% for n=omitpeg;text(n,0,'X');end
if FigureSave==1;saveas(fig_CovInt3,[DrName,' ','CovIntervals3.bmp']);end

% fig_CovInt5=figure('Position',[1 1 1400 975]);
% subplot(4,1,1),bar(PegVar);
% for n=1:length(PegVar);if isnan(PegVar(n))==1;text(n,0,'X');end;end
% title('Var /Peg');
% subplot(4,1,2),bar(VarNextPeg);
% for n=1:length(VarNextPeg);if isnan(VarNextPeg(n))==1;text(n,0,'X');end;end
% title('Var NextPeg');
% subplot(4,1,3),bar(CovInterval_5);
% title('Cov/5pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(4,1,4),bar(Prod_Int_dev_abs_Mean_5);
% title('Prod_abs_Int Mean/5pegs');
% for n=omitpeg;text(n,0,'X');end
% if FigureSave==1;saveas(fig_CovInt5,[DrName,' ','CovIntervals5.bmp']);end


fig_CovInt3_ConstAx=figure('Position',[1 1 1400 975]);
subplot(5,1,1),bar(MeanNextPeg);%axis([0 25 0 10000]);
for n=1:length(MeanNextPeg);if isnan(MeanNextPeg(n))==1;text(n,0,'X');end;end
title('Mean to NextPeg');
subplot(5,1,2),bar(PegVar);%axis([0 25 0 10000]);
for n=1:length(PegVar);if isnan(PegVar(n))==1;text(n,0,'X');end;end
title('Var /Peg');
subplot(5,1,3),bar(VarNextPeg);%axis([0 25 0 10000]);
for n=1:length(VarNextPeg);if isnan(VarNextPeg(n))==1;text(n,0,'X');end;end
title('Var NextPeg');
subplot(5,1,4),bar(CovInterval_3);%axis([0 25 -20000 5000]);
title('Cov/3pegs');
for n=omitpeg;text(n,0,'X');end
subplot(5,1,5),bar(Prod_Int_dev_abs_Mean_3);%axis([0 25 0 20000]);
title('Prod abs Int Mean/3pegs');
for n=omitpeg;text(n,0,'X');end
if FigureSave==1;saveas(fig_CovInt3_ConstAx,[DrName,' ','CovIntervals3_ConstAx.bmp']);end

% fig_CovInt5_ConstAx=figure('Position',[1 1 1400 975]);
% subplot(4,1,1),bar(PegVar);axis([0 25 0 10000]);
% for n=1:length(PegVar);if isnan(PegVar(n))==1;text(n,0,'X');end;end
% title('Var /Peg');
% subplot(4,1,2),bar(VarNextPeg);axis([0 25 0 10000]);
% for n=1:length(VarNextPeg);if isnan(VarNextPeg(n))==1;text(n,0,'X');end;end
% title('Var NextPeg');
% subplot(4,1,3),bar(CovInterval_5);axis([0 25 -20000 5000]);
% title('Cov/5pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(4,1,4),bar(Prod_Int_dev_abs_Mean_5);axis([0 25 0 20000]);
% title('Prod abs Int Mean/5pegs');
% for n=omitpeg;text(n,0,'X');end
% if FigureSave==1;saveas(fig_CovInt5_ConstAx,[DrName,' ','CovIntervals5_ConstAx.bmp']);end



% %------------------------------------
% fig_CovInt=figure('Position',[1 1 1400 975]);
% subplot(2,1,1),bar(CovInterval_3);
% title('Cov/3pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(2,1,2),bar(CovInterval_5);
% title('Cov/5pegs');
% for n=omitpeg;text(n,0,'X');end
% saveas(fig_CovInt,[DrName,' ','CovIntervals.bmp']);
% 
% fig_Prod3_abs_Int=figure('Position',[1 1 1400 975]);
% subplot(2,1,1),bar(Prod_Int_dev_abs_Mean_3);
% title('Prod_abs_Int Mean/3pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(2,1,2),bar(Prod_Int_dev_abs_Var_3);
% title('Prod_abs_Int Var/3pegs');
% for n=omitpeg;text(n,0,'X');end
% saveas(fig_Prod3_abs_Int,[DrName,' ','Prod3_abs_Intervals.bmp']);
% 
% fig_Prod5_abs_Int=figure('Position',[1 1 1400 975]);
% subplot(2,1,1),bar(Prod_Int_dev_abs_Mean_5);
% title('Prod_abs_Int Mean/5pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(2,1,2),bar(Prod_Int_dev_abs_Var_5);
% title('Prod_abs_Int Var/5pegs');
% for n=omitpeg;text(n,0,'X');end
% saveas(fig_Prod5_abs_Int,[DrName,' ','Prod5_abs_Intervals.bmp']);
% %------------------------------------


% fig_CoefInt=figure('Position',[1 1 1400 975]);
% subplot(2,1,1),bar(CoefInterval_3);
% title('CorrCoef/3pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(2,1,2),bar(CoefInterval_5);
% title('CorrCoef/5pegs');
% for n=omitpeg;text(n-1,0,'X');end
% saveas(fig_CoefInt,[DrName,' ','CorrCoefIntervals.bmp']);
% 
% fig_Prod3Int=figure('Position',[1 1 1400 975]);
% subplot(3,1,1),bar(Prod_Int_dev_Mean_3);
% title('ProdInt Mean/3pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(3,1,2),bar(Prod_Int_dev_absMean_3);
% title('ProdInt absMean/3pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(3,1,3),bar(Prod_Int_dev_Var_3);
% title('ProdInt Var/3pegs');
% for n=omitpeg;text(n,0,'X');end
% saveas(fig_Prod3Int,[DrName,' ','Prod3Intervals.bmp']);
% 
% fig_Prod5Int=figure('Position',[1 1 1400 975]);
% subplot(3,1,1),bar(Prod_Int_dev_Mean_5);
% title('ProdInt Mean/5pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(3,1,2),bar(Prod_Int_dev_absMean_5);
% title('ProdInt absMean/5pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(3,1,3),bar(Prod_Int_dev_Var_5);
% title('ProdInt Var/5pegs');
% for n=omitpeg;text(n,0,'X');end
% saveas(fig_Prod5Int,[DrName,' ','Prod5Intervals.bmp']);
% 
% fig_Diff3Int=figure('Position',[1 1 1400 975]);
% subplot(2,1,1),bar(Diff_Int_dev_absMean_3);
% title('DiffInt Mean/3pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(2,1,2),bar(Diff_Int_dev_Var_3);
% title('DiffInt Var/3pegs');
% for n=omitpeg;text(n,0,'X');end
% saveas(fig_Diff3Int,[DrName,' ','Diff3Intervals.bmp']);
% 
% fig_Diff5Int=figure('Position',[1 1 1400 975]);
% subplot(2,1,1),bar(Diff_Int_dev_absMean_5);
% title('DiffInt Mean/5pegs');
% for n=omitpeg;text(n,0,'X');end
% subplot(2,1,2),bar(Diff_Int_dev_Var_5);
% title('DiffInt Var/5pegs');
% for n=omitpeg;text(n,0,'X');end
% saveas(fig_Diff5Int,[DrName,' ','Diff5Intervals.bmp']);



%length(TouchVector)

% %NaNの削除と残ったペグ名の表示----------------------------
% %後で、NaNが一定数以上入っている列を全部Infに変換。
% 
% 
% pegnum=[];%消えずに残ったペグの順番。ペグ番号とは異なる
% for n=1:length(TouchMatrix(1,:))%列の削除。カウントの少ないペグは捨てる。
%     if sum(isnan(TouchMatrix(:,n)))>length(TurnMarkerTime)*0.8%%%ここを可変にするとよいかも.この値を１に近づけると解析できるペグ数は増えるがサンプル数が減る。...
%                                                               %%%逆に0に近づけると解析できるペグ数は減るがサンプル数は増え、信頼性は上がる。
%                                                               %2
%                                                               %081002の場合は0.4のみうまくいく。
%         TouchMatrix(:,n)=Inf;
%         n=n-1;
%     else pegnum=[pegnum n];
%     end
% end
% %disp(TouchMatrix);
% disp('pegnum=');disp(pegnum);
% disp('<Rpeg:1-12,Lpeg:13-length(TouchMatrix(1,:))> RLpegNum((pegnum))=');disp(RLpegNum((pegnum)));%RLpegNumはRとLのペグをMedian時間の早い順に並べた順番
% RLpeg={'Rpeg1','Rpeg2','Rpeg3','Rpeg4','Rpeg5','Rpeg6','Rpeg7','Rpeg8','Rpeg9','Rpeg10','Rpeg11','Rpeg12',...
%     'Lpeg1','Lpeg2','Lpeg3','Lpeg4','Lpeg5','Lpeg6','Lpeg7','Lpeg8','Lpeg9','Lpeg10','Lpeg11','Lpeg12'};
% RLpegName=RLpeg(RLpegNum(pegnum))%これでペグの名前が表示される
%disp(RLpeg(RLpegNum));
% n=1;
% while  n<=length(TouchMatrix(:,1))%行の削除。NaNのある行を削除
%     if any(isnan(TouchMatrix(n,:)))==1;TouchMatrixTurn(n,:)=[];n=n-1;end
% %     if any(isnan(TouchMatrix(n,:)))==1;TouchMatrixTurn(n,:)=0;end
%     n=n+1;
% end
% disp('TouchMatrix=');disp(TouchMatrix); %-------------------------------------------------------

% %TouchMatrixTurnの共分散行列^--------------------------------
% CovTouchMatrix=zeros(length(TouchMatrix),length(TouchMatrix));
% CovTouchMatrix=corrcoef(TouchMatrix)
% fig_CovTouch=figure('Position',[1 1 1400 975]);
% bar3(CovTouchMatrix);
% title('CovTouchMatrix=corrcoef(TouchMatrix)');
% zlabel(RLpegName);
% saveas(fig_CovTouch,'CovTouch.bmp');


% %-------------------------------------------------------
% %Interval Analysis Type.A すべての組み合わせ
% for n=1:length(TouchMatrix(1,:))
%     IntervalMatrix=zeros(length(TouchMatrix(:,1)),length(TouchMatrix(1,:)));
%     disp('Interval Analysis, Peg=');
%     RLpegName(n)
%     for m=1:length(TouchMatrix(:,1))
%         for k=1:length(TouchMatrix(1,:))
%             IntervalMatrix(m,k)=TouchMatrix(m,n)-TouchMatrix(m,k);
%             if k>n
%                 IntervalMatrix(m,k)=-TouchMatrix(m,n)+TouchMatrix(m,k);
%             elseif k<n
%                 IntervalMatrix(m,k)=TouchMatrix(m,n)-TouchMatrix(m,k);
%             end
%         end
%     end
%     disp('IntervalMatrix=');disp(IntervalMatrix);
%     IntervalMatrix(:,n)=[];
%     disp('corrcoef(IntervalMatrix)=');disp(corrcoef(IntervalMatrix));
%     figure
%     bar3(corrcoef(IntervalMatrix));
%     title(RLpegName(n));%RLpegName(n),'corrcoef(IntervalMatrix)');
% end

% %Interval Analysis Type.B 隣のペグだけ　
% %注意＜NaNの割合が少ないペグだけの解析であって、peg1から順に並んでいるわけではない＞　例peg2-peg3,peg4-peg7,peg14-peg16
% IntervalMatrix=zeros(length(TouchMatrix(:,1))-1,length(TouchMatrix(1,:))-1);
% for m=1:length(TouchMatrix(:,1))-1
%     for n=1:length(TouchMatrix(1,:))-1
%         IntervalMatrix(m,n)=-TouchMatrix(m,n)+TouchMatrix(m,n+1);
%     end    
% end
% %disp('IntervalMatrix=');disp(IntervalMatrix);
% %IntervalMatrix(:,n)=[];
% CovIntervalMatrix=corrcoef(IntervalMatrix)
% fig_CovInterval=figure('Position',[1 1 1400 975]);
% bar3(CovIntervalMatrix);
% title('CovTouchMatrix=corrcoef(IntervalMatrix)');
% zlabel(RLpegName);
% saveas(fig_CovInterval,'CovInterval.bmp');





