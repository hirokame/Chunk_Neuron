function VoltageAnalysis20170718
%Vは5msごとの記録?　最後にx5する必要あり %5ms bin
clear all;close all;
%1-12 left peg
%13-24 right peg
%25 floor
%26 spout

dpath='C:\Users\C238\Desktop';%\ICR_LearnCurve\161105_C8_Day1';
fname='14401_190121';

cd(dpath);
eval(['load ',fname,' -ascii']);
B=who;
eval(['TurnMarkerTime=',B{1},'(:,4);']);
TurnMarkerTime(TurnMarkerTime==0)=[];
eval(['load ',fname,'V.mat -ascii']);
A=eval(['X',fname,'V;']);%101_161105V

Fig=1;
NumFig=4;
p=0;

Range=[TurnMarkerTime(1),TurnMarkerTime(end)];
RangeT=round(Range./5);%5ms bin
TMT=round(TurnMarkerTime./5);

% TDmatrix=zeros(24,RangeT(2)-RangeT(1));
TouchMatrix=zeros(24,RangeT(2)-RangeT(1));
DetachMatrix=zeros(24,RangeT(2)-RangeT(1));

if Fig==1
    figure
end
FN=1;
for n=1:24
    n
    
    Value=A(n,RangeT(1)+1:RangeT(2));

    Max=max(Value);
    Min=min(Value);


    Thd=ones(1,RangeT(2)-RangeT(1))*(Max-Min)*0.65+Min;
    
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

%Drink   VoltageAnalysisDrink20170718より
for n=26
    
    Value=A(n,RangeT(1)+1:RangeT(2));

    Max=max(Value);
%     Min=min(Value);
    
    Mov=20;
    Mov2=50;
    MovV=zeros(1,RangeT(2)-RangeT(1));
    LocalMin=zeros(1,RangeT(2)-RangeT(1));
    for m=1:RangeT(2)-RangeT(1)-Mov2
        MovV(m)=sum(Value(m:m+Mov-1))/Mov;
%         MovV2(m)=sum(Value(m:m+Mov2-1))/Mov2;
        LocalMin(m)=min(Value(m:m+Mov2-1));
    end       
%     Max=max(Value)
%     Mean=mean(Value)
    
    Thd=min(mean(Value),(MovV+LocalMin)/2);%飲んでいないときのギザギザに反応しないように、閾値を平均以下に
%     Thd=(MovV+LocalMin)/2;

    MovV((RangeT(2)-RangeT(1))-Mov2+1:end)=MovV((RangeT(2)-RangeT(1))-Mov2);
    LocalMin((RangeT(2)-RangeT(1))-Mov2+1:end)=LocalMin((RangeT(2)-RangeT(1))-Mov2);
    Thd((RangeT(2)-RangeT(1))-Mov2+1:end)=Thd((RangeT(2)-RangeT(1))-Mov2);

    if Fig==1
        figure
%         subplot(NumFig,1,n)
        plot(Value);hold on
%         x=1:RangeT(2)-RangeT(1);
        plot(MovV,'g');
        plot(LocalMin,'m');
        zoom xon

        plot(Thd,'r');
        zoom xon
    end
    
    Comp=Value-Thd;
    Comp1=[Comp(1),Comp(1:end-1)];
    CC=Comp.*Comp1;%CCマイナスであれば、その項のCompでクロスが起きている。0の場合は、かすっただけかも
    CrossIdx=find(CC<=0);
    
    TDindex=zeros(1,RangeT(2)-RangeT(1));
    for m=CrossIdx
        if m-5>=1 && m+4<=length(TDindex)
            Scomp=sum(Comp(m-5:m-1))-sum(Comp(m:m+4));
            if Scomp>=0%前のほうが大
                TDindex(m)=1;%touch
            else
                TDindex(m)=-1;%detach
            end
        end
    end
    Zero=0;
    TDindexA=zeros(1,RangeT(2)-RangeT(1));
    for m=1:RangeT(2)-RangeT(1)
        if TDindex(m)==0
            Zero=Zero+1;
        elseif TDindex(m)==1
            if Zero>5
                TDindexA(m)=1;
            end
            Zero=0;
        end
    end

    if Fig==1
        a=(0:round(Max*1000))*0.001;
        TD1=find(TDindexA==1);
        for k=1:length(TDindexA(TDindexA==1))
            plot(ones(1,length(a))*TD1(k),a,'c');
            zoom xon
        end
    
        for k=1:length(TMT)
            plot(ones(1,length(a))*(TMT(k)-RangeT(1)),a,'k');
            zoom xon
        end
        axis([0 RangeT(2)-RangeT(1) 0 Max]);
    end
%     TDindexA
end
TouchTiming=zeros(24,length(TouchMatrix(1,:))*5);
DetachTiming=zeros(24,length(TouchMatrix(1,:))*5);
for n=1:24
    TempA=TouchMatrix(n,:);
    TempB=DetachMatrix(n,:);
    
    TempA2=zeros(1,length(TempA)*5);
    TempB2=zeros(1,length(TempA)*5);
    
    TempA2(5*find(TempA==1)-3)=1;%もとの時間(ms)に戻す
    TempB2(5*find(TempB==1)-3)=1;
    
    TouchTiming(n,:)=TempA2;
    DetachTiming(n,:)=TempB2;
end
DrinkTiming=zeros(1,length(TouchMatrix(1,:))*5);
DrinkTiming(5*find(TDindexA==1)-3)=1;
% eval(['save ',fname,' TouchTiming DetachTiming DrinkTiming -append;']);
    
    
    
    
    

