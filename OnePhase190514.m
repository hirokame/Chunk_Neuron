function OnePhase190514
%ƒ^ƒbƒ`ŠÔ‚ÌˆÊ‘Š‚É‚Â‚¢‚ÄCx‚Æ98‘ŠŠÖ‚ðŒ©‚é
cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\OnePhaseFolder');
LS=ls;
OnePhaseLindexArray98=[];
OnePhaseRindexArray98=[];
OnePhaseLindexArrayCx=[];
OnePhaseRindexArrayCx=[];

for i=1:length(LS(:,1))
    OnePhaseFL=strtrim(LS(i,:));
    if length(OnePhaseFL)>2 && strcmp(OnePhaseFL(end-7:end-4),'98__');
        FL=char(OnePhaseFL(1:end-4));
        load(FL);
        OnePhaseLindexArray98=OnePhaseLindexArray;
        OnePhaseRindexArray98=OnePhaseRindexArray;
    elseif length(OnePhaseFL)>2 && strcmp(OnePhaseFL(end-7),'C');
        FL=OnePhaseFL(1:end-4);
        load(FL);
        OnePhaseLindexArrayCx=[OnePhaseLindexArrayCx;OnePhaseLindexArray];
        OnePhaseRindexArrayCx=[OnePhaseRindexArrayCx;OnePhaseRindexArray];
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OnePhaseLindexArray98
OnePhaseLindexArrayCx

fig1=figure
for j=1:length(OnePhaseLindexArrayCx(:,1))
    scatter(OnePhaseLindexArray98,OnePhaseLindexArrayCx(j,:));hold on
end
% axis([0 600 0 max(LinterindexArrayCx)*1.1]);



Y_OnePhaseLindexArrayCx=[];
for j=1:length(OnePhaseLindexArrayCx(:,1))
    Y_OnePhaseLindexArrayCx=[Y_OnePhaseLindexArrayCx [OnePhaseLindexArrayCx(j,:);OnePhaseLindexArray98]];
end
deleteIndex=[];
for i=1:length(Y_OnePhaseLindexArrayCx(1,:))
    I=isnan(Y_OnePhaseLindexArrayCx(:,i));
    if length(find(I==1))>0;
        deleteIndex=[deleteIndex i];
    end
end
Y_OnePhaseLindexArrayCx(:,deleteIndex)=[];
p = polyfit(Y_OnePhaseLindexArrayCx(2,:),Y_OnePhaseLindexArrayCx(1,:),1);
yfit = polyval(p,Y_OnePhaseLindexArrayCx(2,:));

plot(Y_OnePhaseLindexArrayCx(2,:),yfit);
hold off
yresid = Y_OnePhaseLindexArrayCx(1,:) - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(Y_OnePhaseLindexArrayCx(1,:))-1) * var(Y_OnePhaseLindexArrayCx(1,:));
rsq = 1 - SSresid/SStotal
rsq 
figname1=['OnephaseL','.bmp'];
saveas(fig1,figname1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fig2=figure
for j=1:length(OnePhaseRindexArrayCx(:,1))
    scatter(OnePhaseRindexArray98,OnePhaseRindexArrayCx(j,:));hold on
end
% axis([0 600 0 max(LinterindexArrayCx)*1.1]);



Y_OnePhaseRindexArrayCx=[];
for j=1:length(OnePhaseRindexArrayCx(:,1))
    Y_OnePhaseRindexArrayCx=[Y_OnePhaseRindexArrayCx [OnePhaseRindexArrayCx(j,:);OnePhaseRindexArray98]];
end
deleteIndex=[];
for i=1:length(Y_OnePhaseRindexArrayCx(1,:))
    I=isnan(Y_OnePhaseRindexArrayCx(:,i));
    if length(find(I==1))>0;
        deleteIndex=[deleteIndex i];
    end
end
Y_OnePhaseRindexArrayCx(:,deleteIndex)=[];
p = polyfit(Y_OnePhaseRindexArrayCx(2,:),Y_OnePhaseRindexArrayCx(1,:),1);
yfit = polyval(p,Y_OnePhaseRindexArrayCx(2,:));

plot(Y_OnePhaseRindexArrayCx(2,:),yfit);
hold off
yresid = Y_OnePhaseRindexArrayCx(1,:) - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(Y_OnePhaseRindexArrayCx(1,:))-1) * var(Y_OnePhaseRindexArrayCx(1,:));
rsq = 1 - SSresid/SStotal
rsq 
figname2=['OnephaseR','.bmp'];
saveas(fig2,figname2);