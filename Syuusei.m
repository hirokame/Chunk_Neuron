function Syuusei
PositiveTouchesPointArray=zeros(1,6);

FRCVLPWTouches=[];
FRCVRPWTouches=[];

cd('C:\Users\C238\Desktop\touchcellLtRt_terashita\38');
LS1=ls;
       for j=1:length(LS1(:,1))
           TrimFolder2=strtrim(LS1(j,:));
           if length(TrimFolder2)>22 && strcmp(TrimFolder2(end-21:end),'SpikeOnOffRtLtUnit.mat');
               load(TrimFolder2);
load(TrimFolder2);
               
%                LtouchPosiNegaTimeUnit
%                RtouchPosiNegaTimeUnit
               %Ltouch
               PositiveLtouchUnit=LtouchPosiNegaTimeUnit(:,[2:6]);
               
               
               TouchesLtouchPosiTimeUnit=[];   %%%%%%5回タッチしたときの配列を保存
               for x=1:length(LtouchPosiNegaTimeUnit(:,1))
                   LtouchesTime=LtouchPosiNegaTimeUnit(x,[2:10]);
                   LtouchesNum=LtouchesTime(LtouchesTime~=0);
                   if length(LtouchesNum)==5;
                       TouchesLtouchPosiTimeUnit=[TouchesLtouchPosiTimeUnit;LtouchPosiNegaTimeUnit(x,:)];
                   end
               end
               
               TouchesLtouchPosiTimeUnitUnique=unique(TouchesLtouchPosiTimeUnit(:,[2:10]),'rows');
               
               for x=1:length(TouchesLtouchPosiTimeUnitUnique(:,1))
                   TargetUnit=[];
                  for y=1:length(TouchesLtouchPosiTimeUnit(:,1))
                      if TouchesLtouchPosiTimeUnitUnique(x,:)==TouchesLtouchPosiTimeUnit(y,[2:10]);
                         TargetUnit=[TargetUnit;TouchesLtouchPosiTimeUnit(y,:)]; 
                      end
                  end
                  TargetFR=sum(TargetUnit(:,1))/(length(TargetUnit(:,1))*10);  %%%%%%%それぞれのタッチパターンにおける発火頻度
                  
                  TargetPositiveArray=TouchesLtouchPosiTimeUnitUnique(x,[1:6]);     %%%%%%%PWにタッチした時刻の配列
                  PositiveTouchesNum=length(TargetPositiveArray(TargetPositiveArray~=0));%%%%%それぞれのタッチパターンにおけるPWのタッチ数（これをもとにグラフ作成）
                  
                  TargetAllTouchesArray=TouchesLtouchPosiTimeUnitUnique(x,:);
                  AllTouchTimeArray=sort(TargetAllTouchesArray(TargetAllTouchesArray~=0),'ascend');
                  
                  TimeDifference=diff(AllTouchTimeArray);
                  CVLtouch=var(TimeDifference)/mean(TimeDifference);
                  
                  
                  FRCVLPWTouches=[FRCVLPWTouches;[TargetFR CVLtouch PositiveTouchesNum]];
               end
               
               
               %Rtouch
               PositiveRtouchUnit=RtouchPosiNegaTimeUnit(:,[2:6]);
               
               
               TouchesRtouchPosiTimeUnit=[];   %%%%%%5回タッチしたときの配列を保存
               for x=1:length(RtouchPosiNegaTimeUnit(:,1))
                   RtouchesTime=RtouchPosiNegaTimeUnit(x,[2:10]);
                   RtouchesNum=RtouchesTime(RtouchesTime~=0);
                   if length(RtouchesNum)==5;
                       TouchesRtouchPosiTimeUnit=[TouchesRtouchPosiTimeUnit;RtouchPosiNegaTimeUnit(x,:)];
                   end
               end
               
               TouchesRtouchPosiTimeUnitUnique=unique(TouchesRtouchPosiTimeUnit(:,[2:10]),'rows');
               
               for x=1:length(TouchesRtouchPosiTimeUnitUnique(:,1))
                  for y=1:length(TouchesRtouchPosiTimeUnit(:,1))
                      A=TouchesRtouchPosiTimeUnitUnique(x,:);
                      B=TouchesRtouchPosiTimeUnit(y,[2:10]);
                      if A==B;
                         TargetUnit=[TargetUnit;TouchesRtouchPosiTimeUnit(y,:)]; 
                      end
                  end
                  TargetFR=sum(TargetUnit(:,1))/(length(TargetUnit(:,1))*10);  %%%%%%%それぞれのタッチパターンにおける発火頻度
                  
                  TargetPositiveArray=TouchesRtouchPosiTimeUnitUnique(x,[1:6]);     %%%%%%%PWにタッチした時刻の配列
                  PositiveTouchesNum=length(TargetPositiveArray(TargetPositiveArray~=0));%%%%%それぞれのタッチパターンにおけるPWのタッチ数（これをもとにグラフ作成）
                  
                  TargetAllTouchesArray=TouchesRtouchPosiTimeUnitUnique(x,:);
                  AllTouchTimeArray=sort(TargetAllTouchesArray(TargetAllTouchesArray~=0),'ascend');
                  
                  TimeDifference=diff(AllTouchTimeArray);
                  CVRtouch=var(TimeDifference)/mean(TimeDifference);
                  
                  
                  FRCVRPWTouches=[FRCVRPWTouches;[TargetFR CVRtouch PositiveTouchesNum]];
               end
           end
       end