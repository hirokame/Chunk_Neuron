function Both_RLt_Pattern_1_20200304

path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;

PositiveRLtouchPoint=zeros(1,11);
PositiveRLtouchFire=zeros(1,11);
NegativeRLtouchPoint=zeros(1,9);
NegativeRLtouchFire=zeros(1,9);

PositiveRLtouchUnit=[];
NegativeRLtouchUnit=[];
SumRtouchUnit=[];
SumRLtouchPointUnit=[];
SumRtouchPointUnit=[];
for i=1:length(LS(:,1))
    TrimFolder=strtrim(LS(i,:));
    if ~strcmp(TrimFolder,'.') && ~strcmp(TrimFolder,'..') && isempty(strfind(TrimFolder,'.mat')) && isempty(strfind(TrimFolder,'.bmp'));
       CdFolder=[path,'\',TrimFolder];
       cd(CdFolder);
       LS1=ls;
       for j=1:length(LS1(:,1))
           TrimFolder2=strtrim(LS1(j,:));
           if length(TrimFolder2)>18 && strcmp(TrimFolder2(end-17:end),'Both_LtRt_Unit.mat');
               load(TrimFolder2);               
              PositiveUnitRtLt=Positive_NegativeUnit(:,[1 2:11]);
              NegativeUnitRtLt=Positive_NegativeUnit(:,[1 12:19]);
              
               %Positive
               for x=1:length(PositiveUnitRtLt(:,1))
                   S=sum(PositiveUnitRtLt(423,[2:11]));
                   SumRLtouch=sum(PositiveUnitRtLt(x,[2:11]));
                   
                   if SumRLtouch==0;
                       PositiveRLtouchPoint(1)=PositiveRLtouchPoint(1)+1;
                       PositiveRLtouchFire(1)=PositiveRLtouchFire(1)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==1;
                       PositiveRLtouchPoint(2)=PositiveRLtouchPoint(2)+1;
                       PositiveRLtouchFire(2)=PositiveRLtouchFire(2)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==2;
                       PositiveRLtouchPoint(3)=PositiveRLtouchPoint(3)+1;
                       PositiveRLtouchFire(3)=PositiveRLtouchFire(3)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==3;
                       PositiveRLtouchPoint(4)=PositiveRLtouchPoint(4)+1;
                       PositiveRLtouchFire(4)=PositiveRLtouchFire(4)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==4;
                       PositiveRLtouchPoint(5)=PositiveRLtouchPoint(5)+1;
                       PositiveRLtouchFire(5)=PositiveRLtouchFire(5)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==5;
                       PositiveRLtouchPoint(6)=PositiveRLtouchPoint(6)+1;
                       PositiveRLtouchFire(6)=PositiveRLtouchFire(6)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==6;
                       PositiveRLtouchPoint(7)=PositiveRLtouchPoint(7)+1;
                       PositiveRLtouchFire(7)=PositiveRLtouchFire(7)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==7;
                       PositiveRLtouchPoint(8)=PositiveRLtouchPoint(8)+1;
                       PositiveRLtouchFire(8)=PositiveRLtouchFire(8)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==8;
                       PositiveRLtouchPoint(9)=PositiveRLtouchPoint(9)+1;
                       PositiveRLtouchFire(9)=PositiveRLtouchFire(9)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==9;
                       PositiveRLtouchPoint(10)=PositiveRLtouchPoint(10)+1;
                       PositiveRLtouchFire(10)=PositiveRLtouchFire(10)+PositiveUnitRtLt(x,1);
                   end
                   
                   if SumRLtouch==10;
                       PositiveRLtouchPoint(11)=PositiveRLtouchPoint(11)+1;
                       PositiveRLtouchFire(11)=PositiveRLtouchFire(11)+PositiveUnitRtLt(x,1);
                   end
                   
               end
               
               
               
               %Negative
               for x=1:length(NegativeUnitRtLt(:,1))
                   NegativeRLtouch=sum(NegativeUnitRtLt(x,[2:9]));
                   if NegativeRLtouch==-8;
                       NegativeRLtouchPoint(1)=NegativeRLtouchPoint(1)+1;              %%%%%PositiveとNegative の合計値が〇になるときの回数をどんどん足していく
                       NegativeRLtouchFire(1)=NegativeRLtouchFire(1)+NegativeUnitRtLt(x,1);  %%%%%PositiveとNegative の合計値が〇になるときの発火数をどんどん足していく
                   end
                   
                   if NegativeRLtouch==-7;
                       NegativeRLtouchPoint(2)=NegativeRLtouchPoint(2)+1;
                       NegativeRLtouchFire(2)=NegativeRLtouchFire(2)+NegativeUnitRtLt(x,1);
                   end
                   
                   if NegativeRLtouch==-6;
                       NegativeRLtouchPoint(3)=NegativeRLtouchPoint(3)+1;
                       NegativeRLtouchFire(3)=NegativeRLtouchFire(3)+NegativeUnitRtLt(x,1);
                   end
                   
                   if NegativeRLtouch==-5;
                       NegativeRLtouchPoint(4)=NegativeRLtouchPoint(4)+1;
                       NegativeRLtouchFire(4)=NegativeRLtouchFire(4)+NegativeUnitRtLt(x,1);
                   end
                   
                   if NegativeRLtouch==-4;
                       NegativeRLtouchPoint(5)=NegativeRLtouchPoint(5)+1;
                       NegativeRLtouchFire(5)=NegativeRLtouchFire(5)+NegativeUnitRtLt(x,1);
                   end
                   
                   if NegativeRLtouch==-3;
                       NegativeRLtouchPoint(6)=NegativeRLtouchPoint(6)+1;
                       NegativeRLtouchFire(6)=NegativeRLtouchFire(6)+NegativeUnitRtLt(x,1);
                   end
                   
                   if NegativeRLtouch==-2;
                       NegativeRLtouchPoint(7)=NegativeRLtouchPoint(7)+1;
                       NegativeRLtouchFire(7)=NegativeRLtouchFire(7)+NegativeUnitRtLt(x,1);
                   end
                   
                   if NegativeRLtouch==-1;
                       NegativeRLtouchPoint(8)=NegativeRLtouchPoint(8)+1;
                       NegativeRLtouchFire(8)=NegativeRLtouchFire(8)+NegativeUnitRtLt(x,1);
                   end
                   
                   if NegativeRLtouch==0;
                       NegativeRLtouchPoint(9)=NegativeRLtouchPoint(9)+1;
                       NegativeRLtouchFire(9)=NegativeRLtouchFire(9)+NegativeUnitRtLt(x,1);
                   end
                   
               end
               
               
              
               
               PositiveRLtouchFR=PositiveRLtouchFire./(PositiveRLtouchPoint*10);     %%%%%発火頻度に変換
               PositiveRLtouchUnit=[PositiveRLtouchUnit;PositiveRLtouchFR];          %%%%-8から10点までの発火頻度を保存
               
               NegativeRLtouchFR=NegativeRLtouchFire./(NegativeRLtouchPoint*10);     %%%%%発火頻度に変換
               NegativeRLtouchUnit=[NegativeRLtouchUnit;NegativeRLtouchFR];          %%%%-8から10点までの発火頻度を保存
               
%                SumRLtouchPointUnit=[SumRLtouchPointUnit;PositiveRLtouchPoint];      %%%%% 回数も保存
               
           end   
       end
    end
end


MeanPositiveRLtouchUnit=nanmean(PositiveRLtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdPositiveRLtouchUnit=nanstd(PositiveRLtouchUnit);

MeanNegativeRLtouchUnit=nanmean(NegativeRLtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdNegativeRLtouchUnit=nanstd(NegativeRLtouchUnit);

% MeanSumRLtouchPointUnit=mean(SumRLtouchPointUnit);

x=1:11;
Fig1=figure;
subplot(1,2,1);
bar(x,MeanPositiveRLtouchUnit,0.5);hold on
errorbar(x,MeanPositiveRLtouchUnit,StdPositiveRLtouchUnit,'o','MarkerSize',0.2);
set(gca,'xticklabel',{'0','1','2','3','4','5','6','7','8','9','10'});
title('MeanPositiveRLtouchUnit_Pattern_1');


subplot(1,2,2);
y=1:9
bar(y,MeanNegativeRLtouchUnit,0.5);hold on
errorbar(y,MeanNegativeRLtouchUnit,StdNegativeRLtouchUnit,'o','MarkerSize',0.2);
set(gca,'xticklabel',{'-8','-7','-6','-5','-4','-3','-2','-1','0'});
title('MeanNegativeRLtouchUnit_Pattern_1');

figname=['Both_LtRt_Pattern_1.bmp'];
cd(path)
saveas(Fig1,figname);


% figure
% subplot(1,2,1);
% bar(x,MeanSumRLtouchPointUnit,0.5);
% 
% subplot(1,2,2);
% bar(x,MeanSumRtouchPointUnit,0.5);
