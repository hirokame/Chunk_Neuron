function [TouchTiming DetachTiming DrinkTiming]=VoltageAnalysis20170719(dpath,fname,Fig)
%Vファイルからタッチを抽出　Dataloadボタンのなかで呼び出される。
%TouchTiming, DetachTiming, DrinkTiming　縦がCh,横が記録時間長msの行列を返す


%Vは”おおよそ”5msごとの記録　最後にx5する必要あり %5ms bin
global TurnMarkerTime StartTime FinishTime OnWater
% clear all;close all;
%1-12 left peg
%13-24 right peg
%25 floor
%26 spout

% dpath='C:\Users\B133\Desktop\ICR_LearnCurve\161105_C8_Day1';
% fname='101_161105';

% cd(dpath);
% eval(['load ',fname,' -ascii']);
% B=who;
% eval(['TurnMarkerTime=',B{1},'(:,4);']);
% TurnMarkerTime(TurnMarkerTime==0)=[];
eval(['load ',dpath,fname(1:end-4),'V.mat -ascii']);
A=eval(['X',fname(1:end-4),'V;']);

Ratio=FinishTime/length(A(1,:));

Fig=1;
NumFig=4;
p=2;

% Range=[TurnMarkerTime(1),TurnMarkerTime(end)];
Range=[StartTime FinishTime];
RangeT=round(Range./Ratio);%5ms bin
TMT=round(TurnMarkerTime./Ratio);

% TDmatrix=zeros(24,RangeT(2)-RangeT(1));
TouchMatrix=zeros(24,RangeT(2)-RangeT(1));
DetachMatrix=zeros(24,RangeT(2)-RangeT(1));

if Fig==1
    figure
end
FN=1;
for n=1:24
    
    Value=A(n,RangeT(1)+1:RangeT(2));

    Max=max(Value);
    Min=min(Value);


    Thd=ones(1,RangeT(2)-RangeT(1))*(Max-Min)*0.55+Min;
    
    if Fig==1 %&& n<=NumFig
        if n==1+p || n==2+p || n==13+p || n==14+p
        subplot(NumFig,1,FN)
        plot(Value);hold on
        x=1:RangeT(2)-RangeT(1);
        plot(x,Thd,'r');
        end
    end
    
    Comp=Value-Thd;
    Comp1=[Comp(1),Comp(1:end-1)];
    CC=Comp.*Comp1;%CCマイナスであれば、その項のCompでクロスが起きている。0の場合は、かすっただけかも
    CrossIdx=find(CC<=0);
    
    TDindex=zeros(1,RangeT(2)-RangeT(1));
    Touch=zeros(1,RangeT(2)-RangeT(1));
    Detach=zeros(1,RangeT(2)-RangeT(1));
    for m=CrossIdx
        if m-10>=1 && m+10<=length(TDindex)
            ScorePre=sum(Comp(m-5:m-1));
            ScorePost=sum(Comp(m+1:m+5));
            MinSP=min(min(Value(m-10:m-1)),min(Value(m+1:m+10)));
            if ScorePre>=0 && ScorePost>=0 
            else
                if MinSP<(Thd(1)-Thd(1)/10)

                    if (ScorePre-ScorePost)>=0%前のほうが大
                        TDindex(m)=1;%touch
                    else
                        TDindex(m)=-1;%detach
                    end
                end
            end
        end
    end
    Zero=0;
    TDindexA=zeros(1,RangeT(2)-RangeT(1));
    for m=1:RangeT(2)-RangeT(1);
        if TDindex(m)==0
            Zero=Zero+1;
        elseif TDindex(m)==1
            if Zero>400
                TDindexA(m)=1;
            end
            Zero=0;
        end
    end
    for m=RangeT(2)-RangeT(1):-1:1
        if TDindex(m)==0
            Zero=Zero+1;
        elseif TDindex(m)==-1
            if Zero>400
                TDindexA(m)=-1;
            end
            Zero=0;
        end
    end
%     TDmatrix(n,:)=TDindexA;
    Touch(find(TDindexA==1))=1;
    Detach(find(TDindexA==-1))=1;
    TouchMatrix(n,:)=Touch;
    DetachMatrix(n,:)=Detach;
    
    if Fig==1 %&& n<=NumFig
        if n==1+p || n==2+p || n==13+p || n==14+p
            a=(0:round(Max*1000))*0.001;
            TD1=find(TDindexA==1);
            for k=1:length(TDindexA(TDindexA==1))
                plot(ones(1,length(a))*TD1(k),a,'c');
                zoom xon
            end
            TD2=find(TDindexA==-1);
            for k=1:length(TDindexA(TDindexA==-1))
                plot(ones(1,length(a))*TD2(k),a,'m');
                zoom xon
            end
            

            for k=1:length(TMT)
                plot(ones(1,length(a))*(TMT(k)-RangeT(1)),a,'k');
                zoom xon
            end
            axis([0 RangeT(2)-RangeT(1) 0 Max]);
            FN=FN+1;
        end
        
        
    end
end
% TDmatrix
% TouchMatrix
sum(TouchMatrix,2)
% DetachMatrix
sum(DetachMatrix,2)
length(TurnMarkerTime)

% % % % % %Drink   VoltageAnalysisDrink20170718より
% % % % % for n=26
% % % % %     
% % % % %     Value=A(n,RangeT(1)+1:RangeT(2));
% % % % % 
% % % % %     Max=max(Value);
% % % % % %     Min=min(Value);
% % % % %     
% % % % %     Mov=20;
% % % % %     Mov2=50;
% % % % %     MovV=zeros(1,RangeT(2)-RangeT(1));
% % % % %     LocalMin=zeros(1,RangeT(2)-RangeT(1));
% % % % %     for m=1:RangeT(2)-RangeT(1)-Mov2
% % % % %         MovV(m)=sum(Value(m:m+Mov-1))/Mov;
% % % % % %         MovV2(m)=sum(Value(m:m+Mov2-1))/Mov2;
% % % % %         LocalMin(m)=min(Value(m:m+Mov2-1));
% % % % %     end       
% % % % % %     Max=max(Value)
% % % % % %     Mean=mean(Value)
% % % % %     
% % % % %     Thd=min(mean(Value),(MovV+LocalMin)/2);%飲んでいないときのギザギザに反応しないように、閾値を平均以下に
% % % % % %     Thd=(MovV+LocalMin)/2;
% % % % % 
% % % % %     MovV((RangeT(2)-RangeT(1))-Mov2+1:end)=MovV((RangeT(2)-RangeT(1))-Mov2);
% % % % %     LocalMin((RangeT(2)-RangeT(1))-Mov2+1:end)=LocalMin((RangeT(2)-RangeT(1))-Mov2);
% % % % %     Thd((RangeT(2)-RangeT(1))-Mov2+1:end)=Thd((RangeT(2)-RangeT(1))-Mov2);
% % % % % 
% % % % %     if Fig==1
% % % % %         figure
% % % % % %         subplot(NumFig,1,n)
% % % % %         plot(Value);hold on
% % % % % %         x=1:RangeT(2)-RangeT(1);
% % % % %         plot(MovV,'g');
% % % % %         plot(LocalMin,'m');
% % % % %         zoom xon
% % % % % 
% % % % %         plot(Thd,'r');
% % % % %         zoom xon
% % % % %     end
% % % % %     
% % % % %     Comp=Value-Thd;
% % % % %     Comp1=[Comp(1),Comp(1:end-1)];
% % % % %     CC=Comp.*Comp1;%CCマイナスであれば、その項のCompでクロスが起きている。0の場合は、かすっただけかも
% % % % %     CrossIdx=find(CC<=0);
% % % % %     
% % % % %     TDindex=zeros(1,RangeT(2)-RangeT(1));
% % % % %     for m=CrossIdx
% % % % %         if m-5>=1 && m+4<=length(TDindex)
% % % % %             Scomp=sum(Comp(m-5:m-1))-sum(Comp(m:m+4));
% % % % %             if Scomp>=0%前のほうが大
% % % % %                 TDindex(m)=1;%touch
% % % % %             else
% % % % %                 TDindex(m)=-1;%detach
% % % % %             end
% % % % %         end
% % % % %     end
% % % % %     Zero=0;
% % % % %     TDindexA=zeros(1,RangeT(2)-RangeT(1));
% % % % %     for m=1:RangeT(2)-RangeT(1)
% % % % %         if TDindex(m)==0
% % % % %             Zero=Zero+1;
% % % % %         elseif TDindex(m)==1
% % % % %             if Zero>5
% % % % %                 TDindexA(m)=1;
% % % % %             end
% % % % %             Zero=0;
% % % % %         end
% % % % %     end
% % % % % 
% % % % %     if Fig==1
% % % % %         a=(0:round(Max*1000))*0.001;
% % % % %         TD1=find(TDindexA==1);
% % % % %         for k=1:length(TDindexA(TDindexA==1))
% % % % %             plot(ones(1,length(a))*TD1(k),a,'c');
% % % % %             zoom xon
% % % % %         end
% % % % %     
% % % % %         for k=1:length(TMT)
% % % % %             plot(ones(1,length(a))*(TMT(k)-RangeT(1)),a,'k');
% % % % %             zoom xon
% % % % %         end
% % % % %         axis([0 RangeT(2)-RangeT(1) 0 Max]);
% % % % %     end
% % % % % %     TDindexA
% % % % % end
% % % % % Ratio2=FinishTime/length(TDindexA);
% % % % % TouchTiming=zeros(24,FinishTime);%round(length(TouchMatrix(1,:))*Ratio));
% % % % % DetachTiming=zeros(24,FinishTime);%round(length(TouchMatrix(1,:))*Ratio));

Offset=FinishTime-round(Ratio*length(TDindexA));
for n=1:24
    TempA=TouchMatrix(n,:);
    TempB=DetachMatrix(n,:);
    
    TempA2=zeros(1,FinishTime);%round(length(TempA)*Ratio));
    TempB2=zeros(1,FinishTime);%round(length(TempA)*Ratio));
    
    TempA2(Offset+round(Ratio*find(TempA==1))-3)=1;%もとの時間(ms)に戻す
    TempB2(Offset+round(Ratio*find(TempB==1))-3)=1;
%     sum(TempA2)
%     sum(TempB2)
    TempA2=TempA2.*OnWater;%WaterOnのときのTouchだけ採用
    TempB2=TempB2.*OnWater;%WaterOnのときのTouchだけ採用
%     sum(TempA2)
%     sum(TempB2)
    TouchTiming(n,:)=TempA2;
    DetachTiming(n,:)=TempB2;
end
% DrinkTiming=zeros(1,round(length(TouchMatrix(1,:))*Ratio));
% DrinkTiming(round(Ratio*find(TDindexA==1))-3)=1;

DrinkTiming=zeros(1,FinishTime);
DrinkTiming(Offset+round(Ratio*find(TDindexA==1))-3)=1;
% Ratio*length(TDindexA)
% eval(['save ',fname,' TouchTiming DetachTiming DrinkTiming -append;']);
    
    
    
    
    

