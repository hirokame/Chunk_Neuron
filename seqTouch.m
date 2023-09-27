function seqTouch
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
load('seqTouch.mat');
Ltseq5TouchFRMeanArray=[];
Ltseq5TouchFRStdArray=[];
Rtseq5TouchFRMeanArray=[];
Rtseq5TouchFRStdArray=[];
for a=1:6
   Ltseq5TouchFRMeanArray=[Ltseq5TouchFRMeanArray mean(Ltseq5TouchFRArray(:,a))];
   Ltseq5TouchFRStdArray=[Ltseq5TouchFRStdArray std(Ltseq5TouchFRArray(:,a))];
   
   Rtseq5TouchFRMeanArray=[Rtseq5TouchFRMeanArray mean(Rtseq5TouchFRArray(:,a))];
   Rtseq5TouchFRStdArray=[Rtseq5TouchFRStdArray std(Rtseq5TouchFRArray(:,a))];
end
fig1=figure;
y=1:6;
bar(y,Ltseq5TouchFRMeanArray)
set(gca,'xticklabel',{'5seq','5only','7seq','7only','9seq','9only'});
hold on
errorbar(y,Ltseq5TouchFRMeanArray,Ltseq5TouchFRStdArray,'o')
hold off
cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
figname=['seqTouchFRAverageLtRt','.bmp'];
saveas(fig1,figname);
close(fig1);

fig1=figure;
y=1:6;
bar(y,Rtseq5TouchFRMeanArray)
set(gca,'xticklabel',{'5seq','5only','7seq','7only','9seq','9only'});
hold on
errorbar(y,Rtseq5TouchFRMeanArray,Rtseq5TouchFRStdArray,'o')
hold off

cd('C:\Users\C238\Desktop\touchcellLtRt_matsuda');
figname=['seqTouchFRAverageLtRt','.bmp'];
saveas(fig1,figname);
close(fig1);