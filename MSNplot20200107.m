function MSNplot20200107

path=['G:\CheetahWRLV20200121'];
cd(path)
load('widthPtoT.mat');

X(:,1)=X(:,1)*1/32;
X(:,2)=X(:,2)*1/32;

X

fig1=figure;
sz=25;
scatter(X(:,1),X(:,2),sz,'k','o');hold on
xlabel('Half Peak Width (ms)')
ylabel('Peak to Trough (ms)')


ThresholdWidth=5*1/32;
ThresholdPtoT=10*1/32;
MSN=[];
ITN=[];
FSI=[];
for i=1:length(X(:,1));
    if X(i,1)>ThresholdWidth && X(i,2)>ThresholdPtoT;
       MSN=[MSN;X(i,:)]; 
    elseif X(i,1)<ThresholdWidth && X(i,2)<ThresholdPtoT;
        FSI=[FSI;X(i,:)];
    else
        ITN=[ITN;X(i,:)];
    end
end
MSN
length(MSN(:,1))
length(ITN(:,1))
length(FSI(:,1))
length(X(:,1))

scatter(MSN(:,1),MSN(:,2),sz,'r','filled','o','MarkerEdgeColor','w');
scatter(FSI(:,1),FSI(:,2),sz,'b','filled','o','MarkerEdgeColor','w');
figureFolder=['C:\Users\C238\Desktop\terashita\figure'];
cd(figureFolder)
figname=['MSNFSI.bmp'];
saveas(fig1,figname);
