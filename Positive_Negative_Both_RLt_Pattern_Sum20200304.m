function Positive_Negative_Both_RLt_Pattern_Sum20200304

path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;

SumRLtouchPoint=zeros(1,19);
SumRLtouchFire=zeros(1,19);
X=[];

SumRLtouchUnit=[];
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
              
               
               for x=1:length(Positive_NegativeUnit(:,1))
                   SumRLtouch=sum(Positive_NegativeUnit(x,[2:19]));
%                    S=Positive_NegativeUnit(423,[2:19]);
%                    Sum=sum(Positive_NegativeUnit(423,[2:19]));
                   if SumRLtouch==-8;
                       SumRLtouchPoint(1)=SumRLtouchPoint(1)+1;              %%%%%PositiveとNegative の合計値が〇になるときの回数をどんどん足していく
                       SumRLtouchFire(1)=SumRLtouchFire(1)+Positive_NegativeUnit(x,1);  %%%%%PositiveとNegative の合計値が〇になるときの発火数をどんどん足していく
                   end
                   
                   if SumRLtouch==-7;
                       SumRLtouchPoint(2)=SumRLtouchPoint(2)+1;
                       SumRLtouchFire(2)=SumRLtouchFire(2)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==-6;
                       SumRLtouchPoint(3)=SumRLtouchPoint(3)+1;
                       SumRLtouchFire(3)=SumRLtouchFire(3)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==-5;
                       SumRLtouchPoint(4)=SumRLtouchPoint(4)+1;
                       SumRLtouchFire(4)=SumRLtouchFire(4)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==-4;
                       SumRLtouchPoint(5)=SumRLtouchPoint(5)+1;
                       SumRLtouchFire(5)=SumRLtouchFire(5)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==-3;
                       SumRLtouchPoint(6)=SumRLtouchPoint(6)+1;
                       SumRLtouchFire(6)=SumRLtouchFire(6)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==-2;
                       SumRLtouchPoint(7)=SumRLtouchPoint(7)+1;
                       SumRLtouchFire(7)=SumRLtouchFire(7)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==-1;
                       SumRLtouchPoint(8)=SumRLtouchPoint(8)+1;
                       SumRLtouchFire(8)=SumRLtouchFire(8)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==0;
                       SumRLtouchPoint(9)=SumRLtouchPoint(9)+1;
                       SumRLtouchFire(9)=SumRLtouchFire(9)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==1;
                       SumRLtouchPoint(10)=SumRLtouchPoint(10)+1;
                       SumRLtouchFire(10)=SumRLtouchFire(10)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==2;
                       SumRLtouchPoint(11)=SumRLtouchPoint(11)+1;
                       SumRLtouchFire(11)=SumRLtouchFire(11)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==3;
                       SumRLtouchPoint(12)=SumRLtouchPoint(12)+1;
                       SumRLtouchFire(12)=SumRLtouchFire(12)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==4;
                       SumRLtouchPoint(13)=SumRLtouchPoint(13)+1;
                       SumRLtouchFire(13)=SumRLtouchFire(13)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==5;
                       SumRLtouchPoint(14)=SumRLtouchPoint(14)+1;
                       SumRLtouchFire(14)=SumRLtouchFire(14)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==6;
                       SumRLtouchPoint(15)=SumRLtouchPoint(15)+1;
                       SumRLtouchFire(15)=SumRLtouchFire(15)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==7;
                       SumRLtouchPoint(16)=SumRLtouchPoint(16)+1;
                       SumRLtouchFire(16)=SumRLtouchFire(16)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==8;
                       SumRLtouchPoint(17)=SumRLtouchPoint(17)+1;
                       SumRLtouchFire(17)=SumRLtouchFire(17)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==9;
                       SumRLtouchPoint(18)=SumRLtouchPoint(18)+1;
                       SumRLtouchFire(18)=SumRLtouchFire(18)+Positive_NegativeUnit(x,1);
                   end
                   
                   if SumRLtouch==10;
                       SumRLtouchPoint(19)=SumRLtouchPoint(19)+1;
                       SumRLtouchFire(19)=SumRLtouchFire(19)+Positive_NegativeUnit(x,1);
                       X=[X x];
                   end
                   
               end
               
               
               
              
               
               SumRLtouchFR=SumRLtouchFire./(SumRLtouchPoint*10);     %%%%%発火頻度に変換
               
               SumRLtouchUnit=[SumRLtouchUnit;SumRLtouchFR];          %%%%-8から10点までの発火頻度を保存
               
               SumRLtouchPointUnit=[SumRLtouchPointUnit;SumRLtouchPoint];      %%%%% 回数も保存
               
           end   
       end
    end
end


MeanSumRLtouchUnit=nanmean(SumRLtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdSumRLtouchUnit=nanstd(SumRLtouchUnit);

MeanSumRLtouchPointUnit=mean(SumRLtouchPointUnit);

x=1:19;
Fig1=figure;
bar(x,MeanSumRLtouchUnit,0.5);hold on
errorbar(x,MeanSumRLtouchUnit,StdSumRLtouchUnit,'o','MarkerSize',0.2);
set(gca,'xticklabel',{'-8','-7','-6','-5','-4','-3','-2','-1','0','1','2','3','4','5','6','7','8','9','10'});
title('MeanSumRLtouchUnit_Pattern_Sum');


figname=['Both_LtRt_Pattern_Sum.bmp'];
cd(path)
saveas(Fig1,figname);


% figure
% subplot(1,2,1);
% bar(x,MeanSumRLtouchPointUnit,0.5);
% 
% subplot(1,2,2);
% bar(x,MeanSumRtouchPointUnit,0.5);
