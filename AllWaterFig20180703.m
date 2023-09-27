function AllWaterFig20180703(CrossCoWonCellClean,CrossCoWoffCellClean,NumWonC,NumWoffC,SubP,WORD,m)%,WaterFigA)
global OnSize bin fname SpikeName CleanInterval FigureSave
%CleanWater
    
% for m=1:OnSize(2)
    OnAll=[];OffAll=[];
    for n=1:OnSize(1)
        OnAll=[OnAll; CrossCoWonCellClean{n,m}];
        OffAll=[OffAll; CrossCoWoffCellClean{n,m}];
    end
    OnAll(OnAll==-5000)=[];OnAll(OnAll==5000)=[];
    OffAll(OffAll==-5000)=[];OffAll(OffAll==5000)=[];
    OnAll=[-5000; OnAll; 5000];
    OffAll=[-5000; OffAll; 5000];

% eval(['global WaterFigA',int2str(m)]);
%     eval(['figure(WaterFigA',int2str(m),')']);
    subplot(5,1,SubP);
    if sum(NumWonC)~=0 && sum(NumWoffC)~=0
        CCresultWon=hist(OnAll,bin)/sum(NumWonC);
        CCresultWon=MovWindow(CCresultWon,10);
%         subplot(3,6,5:6);
        plot(linspace(1,10000,bin),CCresultWon,'color','b');hold on
%         axis([0 10000 0 max(CCresultWon)*1.1]);
%         xlabel(['/WaterOn(',int2str(length(WaterOnArrayOriginal)),')']);

        CCresultWoff=hist(OffAll,bin)/sum(NumWoffC);
        CCresultWoff=MovWindow(CCresultWoff,10);
%         subplot(3,6,5:6);
        plot(linspace(1,10000,bin),CCresultWoff,'color','r');
        axis([0 10000 0 max(max(CCresultWon),max(CCresultWoff))*1.1]);
        xlabel([WORD,', /WaterOn(',int2str(sum(NumWonC)),'), /WaterOff(',int2str(sum(NumWoffC)),'),CleanInterval=',int2str(CleanInterval)]);
    
    elseif sum(NumWonC)~=0
        CCresultWon=hist(OnAll,bin)/sum(NumWonC);
        CCresultWon=MovWindow(CCresultWon,10);
        plot(linspace(1,10000,bin),CCresultWon,'color','b');
        axis([0 10000 0 max(CCresultWon)*1.1]);
        xlabel([WORD,', /WaterOn(',int2str(sum(NumWonC)),'),CleanInterval=',int2str(CleanInterval)]);
    elseif sum(NumWoffC)~=0
        CCresultWoff=hist(OffAll,bin)/sum(NumWoffC);
        CCresultWoff=MovWindow(CCresultWoff,10);
%         subplot(3,6,5:6);
        plot(linspace(1,10000,bin),CCresultWoff,'color','r');
        axis([0 10000 0 max(CCresultWoff)*1.1]);
        xlabel([WORD,', /WaterOff(',int2str(sum(NumWoffC)),'),CleanInterval=',int2str(CleanInterval)]);
    end
% if SubP==5
% %     FigName=[SpikeName{m},' AllWater.bmp'];%char(strcat({S1},{' '},{S2},{' '},{S3},{' '},{S4},{' '},{S5},{' '},{S6},{S7},{' '},{S8},{' '},{S9},{' '},{S10},{'.bmp'}));
% %     if FigureSave==1
% %         eval(['saveas(WaterFigA',int2str(m),',FigName);']);
% %     end
% end
% end