function meanfigure
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
load('FiringRate_TouchCountData.mat');

RtRepeat5TouchSpike4FR_BinMeanArray=[];
RtRepeat5TouchSpike4FR_BinStdArray=[];
RtRepeat5TouchSpike4FR_BinArray
for d=1:5
    RtRepeat5TouchSpike4FR_BinMeanArray=[RtRepeat5TouchSpike4FR_BinMeanArray mean(RtRepeat5TouchSpike4FR_BinArray(:,d))];
    RtRepeat5TouchSpike4FR_BinStdArray=[RtRepeat5TouchSpike4FR_BinStdArray std(RtRepeat5TouchSpike4FR_BinArray(:,d))/sqrt(length(RtRepeat5TouchSpike4FR_BinArray(:,d)))];
end
fig2=figure;
y=1:5;
bar(y,RtRepeat5TouchSpike4FR_BinMeanArray)
AverageFR=sum(RtRepeat5TouchSpike4FR_BinMeanArray)/length(RtRepeat5TouchSpike4FR_BinMeanArray);
AverageStd=sum(RtRepeat5TouchSpike4FR_BinStdArray)/length(RtRepeat5TouchSpike4FR_BinStdArray);
set(gca,'xticklabel',{'1234','2345','1235','1245','1345'});
hold on
errorbar(y,RtRepeat5TouchSpike4FR_BinMeanArray,RtRepeat5TouchSpike4FR_BinStdArray,'o')
hold off
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
figname=['LtSpike1FR_BinAverageLtRt','.bmp'];
saveas(fig2,figname);
close(fig2);