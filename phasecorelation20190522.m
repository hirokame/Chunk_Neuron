function phasecorelation20190522

cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\RtInLtFolder');

LS=ls;
RtInLtPhaseArray98=[];
RtInLtPhaseArrayCx=[];

for i=1:length(LS(:,1))
    RtInLtPhaseFL=strtrim(LS(i,:));
    if length(RtInLtPhaseFL)>2 && strcmp(RtInLtPhaseFL(end-7:end-4),'98__');
        FL=char(RtInLtPhaseFL(1:end-4));
        load(FL);
        RtInLtPhaseArray98=RtInLtPhaseArray;
    elseif length(RtInLtPhaseFL)>2 && strcmp(RtInLtPhaseFL(end-7),'C');
        FL=RtInLtPhaseFL(1:end-4);
        load(FL);
        RtInLtPhaseArrayCx=[RtInLtPhaseArrayCx;RtInLtPhaseArray];
    end
end
RtInLtPhaseArray98
RtInLtPhaseArrayCx


colorArray=[[1 0 0];[0 1 0];[0 0 1];[0 1 1];[1 0 1];[0 0 0];[1 1 0]];

x=figure
for j=1:length(RtInLtPhaseArrayCx(:,1))
    scatter(RtInLtPhaseArray98,RtInLtPhaseArrayCx(j,:),[],colorArray(j,:));hold on
end
xlabel('98 phase');
ylabel('complex phase');

Y_RLPhaseindexArrayCx=[];
for j=1:length(RtInLtPhaseArrayCx(:,1))
    Y_RLPhaseindexArrayCx=[Y_RLPhaseindexArrayCx [RtInLtPhaseArrayCx(j,:);RtInLtPhaseArray98]];
end
axis([0 1 0 max(max(RtInLtPhaseArrayCx(1,:)),max(RtInLtPhaseArrayCx(2,:)))]);


deleteIndex=[];
for i=1:length(Y_RLPhaseindexArrayCx(1,:))
    I=isnan(Y_RLPhaseindexArrayCx(:,i));
    if length(find(I==1))>0;
        deleteIndex=[deleteIndex i];
    end
end
Y_RLPhaseindexArrayCx(:,deleteIndex)=[];
p = polyfit(Y_RLPhaseindexArrayCx(2,:),Y_RLPhaseindexArrayCx(1,:),1);
yfit = polyval(p,Y_RLPhaseindexArrayCx(2,:));

plot(Y_RLPhaseindexArrayCx(2,:),yfit);
hold off
yresid = Y_RLPhaseindexArrayCx(1,:) - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(Y_RLPhaseindexArrayCx(1,:))-1) * var(Y_RLPhaseindexArrayCx(1,:));
rsq = 1 - SSresid/SStotal
rsq 
figname=['RtInLt'];
saveas(x,figname);