function Positive_Negative_RLt_Sum20201208

path=['C:\Users\C238\Desktop\touchcellLtRt_Hirokane'];
cd(path);

LS=ls;

SumLtouchPoint=zeros(1,10);
SumLtouchFire=zeros(1,10);
SumRtouchPoint=zeros(1,10);
SumRtouchFire=zeros(1,10);

SumLtouchUnit=[];
SumRtouchUnit=[];
SumLtouchPointUnit=[];
SumRtouchPointUnit=[];
for i=1:length(LS(:,1))
    TrimFolder=strtrim(LS(i,:));
    if ~strcmp(TrimFolder,'.') && ~strcmp(TrimFolder,'..') && isempty(strfind(TrimFolder,'.mat')) && isempty(strfind(TrimFolder,'.bmp'));
       CdFolder=[path,'\',TrimFolder];
       cd(CdFolder);
       LS1=ls;
       for j=1:length(LS1(:,1))
           TrimFolder2=strtrim(LS1(j,:));
           if length(TrimFolder2)>22 && strcmp(TrimFolder2(end-21:end),'SpikeOnOffRtLtUnit.mat');
               load(TrimFolder2);
               LtouchUnit=[LtouchSpikeOnUnit;[zeros(length(LtouchSpikeOffUnit(:,1)),1) LtouchSpikeOffUnit]]; %%%% SpikeOffUnitの前列に発火数列を追加してSpikeOnUnitと連結。SpikeOff時の発火数をゼロに設定
               RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1)),1) RtouchSpikeOffUnit]];
              
               
               %Ltouch
               for x=1:length(LtouchUnit(:,1))
                   SumLtouch=sum(LtouchUnit(x,[2:10]));
                   
                   if SumLtouch==-4;
                       SumLtouchPoint(1)=SumLtouchPoint(1)+1;              %%%%%PositiveとNegative の合計値が〇になるときの回数をどんどん足していく
                       SumLtouchFire(1)=SumLtouchFire(1)+LtouchUnit(x,1);  %%%%%PositiveとNegative の合計値が〇になるときの発火数をどんどん足していく
                   end
                   
                   if SumLtouch==-3;
                       SumLtouchPoint(2)=SumLtouchPoint(2)+1;
                       SumLtouchFire(2)=SumLtouchFire(2)+LtouchUnit(x,1);
                   end
                   
                   if SumLtouch==-2;
                       SumLtouchPoint(3)=SumLtouchPoint(3)+1;
                       SumLtouchFire(3)=SumLtouchFire(3)+LtouchUnit(x,1);
                   end
                   
                   if SumLtouch==-1;
                       SumLtouchPoint(4)=SumLtouchPoint(4)+1;
                       SumLtouchFire(4)=SumLtouchFire(4)+LtouchUnit(x,1);
                   end
                   
                   if SumLtouch==0;
                       SumLtouchPoint(5)=SumLtouchPoint(5)+1;
                       SumLtouchFire(5)=SumLtouchFire(5)+LtouchUnit(x,1);
                   end
                   
                   if SumLtouch==1;
                       SumLtouchPoint(6)=SumLtouchPoint(6)+1;
                       SumLtouchFire(6)=SumLtouchFire(6)+LtouchUnit(x,1);
                   end
                   
                   if SumLtouch==2;
                       SumLtouchPoint(7)=SumLtouchPoint(7)+1;
                       SumLtouchFire(7)=SumLtouchFire(7)+LtouchUnit(x,1);
                   end
                   
                   if SumLtouch==3;
                       SumLtouchPoint(8)=SumLtouchPoint(8)+1;
                       SumLtouchFire(8)=SumLtouchFire(8)+LtouchUnit(x,1);
                   end
                   
                   if SumLtouch==4;
                       SumLtouchPoint(9)=SumLtouchPoint(9)+1;
                       SumLtouchFire(9)=SumLtouchFire(9)+LtouchUnit(x,1);
                   end
                   
                   if SumLtouch==5;
                       SumLtouchPoint(10)=SumLtouchPoint(10)+1;
                       SumLtouchFire(10)=SumLtouchFire(10)+LtouchUnit(x,1);
                   end
               end
               
               
               
               %Rtouch
                for x=1:length(RtouchUnit(:,1))
                   SumRtouch=sum(RtouchUnit(x,[2:10]));
                   if SumRtouch==-4;
                       SumRtouchPoint(1)=SumRtouchPoint(1)+1;
                       SumRtouchFire(1)=SumRtouchFire(1)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==-3;
                       SumRtouchPoint(2)=SumRtouchPoint(2)+1;
                       SumRtouchFire(2)=SumRtouchFire(2)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==-2;
                       SumRtouchPoint(3)=SumRtouchPoint(3)+1;
                       SumRtouchFire(3)=SumRtouchFire(3)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==-1;
                       SumRtouchPoint(4)=SumRtouchPoint(4)+1;
                       SumRtouchFire(4)=SumRtouchFire(4)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==0;
                       SumRtouchPoint(5)=SumRtouchPoint(5)+1;
                       SumRtouchFire(5)=SumRtouchFire(5)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==1;
                       SumRtouchPoint(6)=SumRtouchPoint(6)+1;
                       SumRtouchFire(6)=SumRtouchFire(6)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==2;
                       SumRtouchPoint(7)=SumRtouchPoint(7)+1;
                       SumRtouchFire(7)=SumRtouchFire(7)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==3;
                       SumRtouchPoint(8)=SumRtouchPoint(8)+1;
                       SumRtouchFire(8)=SumRtouchFire(8)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==4;
                       SumRtouchPoint(9)=SumRtouchPoint(9)+1;
                       SumRtouchFire(9)=SumRtouchFire(9)+RtouchUnit(x,1);
                   end
                   
                   if SumRtouch==5;
                       SumRtouchPoint(10)=SumRtouchPoint(10)+1;
                       SumRtouchFire(10)=SumRtouchFire(10)+RtouchUnit(x,1);
                   end
                end
               
               SumLtouchFR=SumLtouchFire./(SumLtouchPoint*10);     %%%%%発火頻度に変換
               SumRtouchFR=SumRtouchFire./(SumRtouchPoint*10);
                
               
               
               SumLtouchUnit=[SumLtouchUnit;SumLtouchFR];          %%%%-4から5点までの発火頻度を保存
               SumRtouchUnit=[SumRtouchUnit;SumRtouchFR];  
               SumLtouchPointUnit=[SumLtouchPointUnit;SumLtouchPoint];      %%%%% 回数も保存
               SumRtouchPointUnit=[SumRtouchPointUnit;SumRtouchPoint];
           end   
       end
    end
end


MeanSumLtouchUnit=nanmean(SumLtouchUnit);
StdSumLtouchUnit=nanstd(SumLtouchUnit);

MeanSumRtouchUnit=nanmean(SumRtouchUnit);
StdSumRtouchUnit=nanstd(SumRtouchUnit);

MeanSumLtouchPointUnit=mean(SumLtouchPointUnit);
MeanSumRtouchPointUnit=mean(SumRtouchPointUnit);

x=1:10;
Fig1=figure;
subplot(1,2,1);
bar(x,MeanSumLtouchUnit,0.5);hold on
errorbar(x,MeanSumLtouchUnit,StdSumLtouchUnit,'o','MarkerSize',0.2);
set(gca,'xticklabel',{'-4','-3','-2','-1','0','1','2','3','4','5'});
title('MeanSumLtouchUnit_Pattern_Sum');


subplot(1,2,2);
bar(x,MeanSumRtouchUnit,0.5);hold on
errorbar(x,MeanSumRtouchUnit,StdSumRtouchUnit,'o','MarkerSize',0.2);
set(gca,'xticklabel',{'-4','-3','-2','-1','0','1','2','3','4','5'});
title('MeanSumRtouchUnit_Pattern_Sum');

figname=['LtRt_PatternSum.bmp'];
cd(path)
saveas(Fig1,figname);


figure
subplot(1,2,1);
bar(x,MeanSumLtouchPointUnit,0.5);

subplot(1,2,2);
bar(x,MeanSumRtouchPointUnit,0.5);
