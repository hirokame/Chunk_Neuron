function R_LPhase190513
%左足のタッチの間にスパイクがあったとき左足のタッチの中でどこに右タッチがあったか
%Cxと98で相関を見る
cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\R_LPhaseFolder');
LS=ls;
R_LPhaseindexArray98=[];
R_LPhaseindexArrayCx=[];

for i=1:length(LS(:,1))
    R_LPhaseFL=strtrim(LS(i,:));
    if length(R_LPhaseFL)>2 && strcmp(R_LPhaseFL(end-7:end-4),'98__');
        FL=char(R_LPhaseFL(1:end-4));
        load(FL);
        R_LPhaseindexArray98=R_LPhaseindexArray;
    elseif length(R_LPhaseFL)>2 && strcmp(R_LPhaseFL(end-7),'C');
        FL=R_LPhaseFL(1:end-4);
        load(FL);
        R_LPhaseindexArrayCx=[R_LPhaseindexArrayCx;R_LPhaseindexArray];
    end
end

R_LPhaseindexArray98
R_LPhaseindexArrayCx

x=figure
for j=1:length(R_LPhaseindexArrayCx(:,1))
    scatter(R_LPhaseindexArray98,R_LPhaseindexArrayCx(j,:));hold on
end
axis([0 max(R_LPhaseindexArray98*1.2) 0 max(max(R_LPhaseindexArrayCx(1,:)),max(R_LPhaseindexArrayCx(2,:)))*1.2]);


Y_RLPhaseindexArrayCx=[];
for j=1:length(R_LPhaseindexArrayCx(:,1))
    Y_RLPhaseindexArrayCx=[Y_RLPhaseindexArrayCx [R_LPhaseindexArrayCx(j,:);R_LPhaseindexArray98]];
end



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
figname=['R_LPhase','.bmp'];
saveas(x,figname);