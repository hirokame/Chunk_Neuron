function Intervalcorelation20190527

cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\LtIntervalFolder');

LS=ls;
LtIntervalArrayBgra=[];
LtIntervalArrayCx=[];

for i=1:length(LS(:,1))
    LtIntervalFL=strtrim(LS(i,:));
    if length(LtIntervalFL)>2 && strcmp(LtIntervalFL(end-7:end-4),'Bgra');
        FL=char(LtIntervalFL(1:end-4));
        load(FL);
        LtIntervalArrayBgra=LtIntervalArray;
    elseif length(LtIntervalFL)>2 && strcmp(LtIntervalFL(end-7),'C');
        FL=LtIntervalFL(1:end-4);
        load(FL);
        LtIntervalArrayCx=[LtIntervalArrayCx;LtIntervalArray];
    end
end
LtIntervalArrayBgra
LtIntervalArrayCx


colorArray=[[1 0 0];[0 1 0];[0 0 1];[0 1 1];[1 0 1];[0 0 0];[1 1 0]];

x=figure
for j=1:length(LtIntervalArrayCx(:,1))
    scatter(LtIntervalArrayBgra,LtIntervalArrayCx(j,:),[],colorArray(j,:));hold on
end
xlabel('Bgra phase');
ylabel('complex phase');

Y_LtIntervalArrayCx=[];
for j=1:length(LtIntervalArrayCx(:,1))
    Y_LtIntervalArrayCx=[Y_LtIntervalArrayCx [LtIntervalArrayCx(j,:);LtIntervalArrayBgra]];
end
axis([0 max(LtIntervalArrayBgra)*1.2 0 max(max(LtIntervalArrayCx(1,:)),max(LtIntervalArrayCx(2,:)))]);


deleteIndex=[];
for i=1:length(Y_LtIntervalArrayCx(1,:))
    I=isnan(Y_LtIntervalArrayCx(:,i));
    if length(find(I==1))>0;
        deleteIndex=[deleteIndex i];
    end
end
Y_LtIntervalArrayCx(:,deleteIndex)=[];
p = polyfit(Y_LtIntervalArrayCx(2,:),Y_LtIntervalArrayCx(1,:),1);
yfit = polyval(p,Y_LtIntervalArrayCx(2,:));

plot(Y_LtIntervalArrayCx(2,:),yfit);
hold off
yresid = Y_LtIntervalArrayCx(1,:) - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(Y_LtIntervalArrayCx(1,:))-1) * var(Y_LtIntervalArrayCx(1,:));
rsq = 1 - SSresid/SStotal
rsq 
figname=['CCInterval','.bmp'];
saveas(x,figname);