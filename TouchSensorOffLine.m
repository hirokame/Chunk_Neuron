function TouchSensorOffLine
clear all;close all;

% load 11501_150807V.mat -ASCII;
load 11701_150807V.mat -ASCII;A=X11701_150807V;%A
% load 11701_150826V.mat -ASCII;A=X11701_150826V;%B

% A=X11701_150807V;
% A=X11701_150826V;

Len=length(A(1,:));
MovingAverage=2;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MAA=zeros(MovingAverage*2,Len+MovingAverage*2);
MA=zeros(size(A));
for m=1:length(A(:,1))
    for n=1:MovingAverage*2
        MAA(n,n:n+Len-1)=A(m,:);
    end
    SumMAA=sum(MAA);
    MA(m,:)=SumMAA(MovingAverage+1:Len+MovingAverage)/(MovingAverage*2);
end
A=MA;

Duration=10000:22500;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
plot(A(1,Duration),'b');hold on%zoom xon;%
% figure
plot(A(13,Duration),'r');hold on
% figure
plot(A(2,Duration),'c');hold on%zoom xon
% figure
plot(A(14,Duration),'m');zoom xon

Length=300;

A1=A(1,:);
A2=A(13,:);
OverLay1=zeros(100,Length);
OverLay2=zeros(100,Length);
OnTouch=0;
k=1;
for n=20:length(A1)-Length
    if A1(n)<0.03 && A1(n-1)>0.03
        if OnTouch<0
            OverLay1(k,:)=A1(n-20:n+Length-21);
            k=k+1;
            OnTouch=200;
        end
    end
    OnTouch=OnTouch-1;
end
OnTouch=0;
k=1;
for n=20:length(A2)-Length
    if A2(n)<0.03 && A2(n-1)>0.03
        if OnTouch<0
            OverLay2(k,:)=A2(n-20:n+Length-21);
            k=k+1;
            OnTouch=200;
        end
    end
    OnTouch=OnTouch-1;
end

% OverLay

figure
for n=1:50%length(OverLay(:,1))
    plot(OverLay1(n,:));hold on
end
zoom xon
figure
for n=1:50%length(OverLay(:,1))
    plot(OverLay2(n,:));hold on
end
zoom xon

