function [VarMeansRL,VarSTDRL,CrossVarRL]=CrossPeg24ch20170728(RpegTouchTurn,LpegTouchTurn,RpegTouchMatrix,LpegTouchMatrix,PegTouchCell,Graph,duration,yhight,FTselect)
% Num_SmallVar ChunkLength ChunkEnd Sum_SmallVar ChunkValue

global OneTurnTime RefPeriod VarMeans VarSTD DrName CrossVar FigureSave fig_VarInvHist...
    fig_peglen fig_VM fig_CrossVar_CLmap fig_CrossVarInv_CLmap ShowFig Num_SmallVar ChunkLength ChunkEnd...
    TouchInterval TurnMarkerTime...
    RpegNameSorted LpegNameSorted RLpegNameSorted RpegTouchTurnSorted LpegTouchTurnSorted RLpegTouchTurnSorted RLpegTouchCellSorted ...
    RpegTouchCell LpegTouchCell RpegTouchTurn LpegTouchTurn RpegTouchMatrix LpegTouchMatrix RpegTouchTurnMatrix RLpegTouchTurnMatrix...
    RpegTouchMatrixSorted LpegTouchMatrixSorted RLpegTouchMatrixSorted...
    RpegTimeArray2D_turn LpegTimeArray2D_turn RpNum LpNum RpegMedian LpegMedian...
    fig_CrossVarRL fig_VM2 fig_CrossVar_CLmap fig_CrossVar_CLmap fig_CrossVar_CLmap2 fig_CrossVar

%%%%左右タッチ解析　20170726

% PegTouchCell=RLpegTouchCellSorted;
[CrossPegRL CrossVarRL VarMeansRL VarSTDRL]=CrossPegVar(RLpegTouchCellSorted);
figure
imagesc(CrossVarRL);title('CrossVarRL');
axis square;caxis([0 10000]);colormap jet;colorbar
figure
bar(VarMeansRL);hold on;errorbar(VarMeansRL,VarSTDRL,'k+');title('VarMeansRL');

[CrossPegR CrossVarR VarMeansR VarSTDR]=CrossPegVar(RpegTouchCell);
figure
imagesc(CrossVarR);title('CrossVarR');
axis square;caxis([0 10000]);colormap jet;colorbar
figure
bar(VarMeansR);hold on;errorbar(VarMeansR,VarSTDR,'k+');title('VarMeansR');

[CrossPegL CrossVarL VarMeansL VarSTDL]=CrossPegVar(LpegTouchCell);
figure
imagesc(CrossVarL);title('CrossVarL');
axis square;caxis([0 10000]);colormap jet;colorbar
figure
bar(VarMeansL);hold on;errorbar(VarMeansL,VarSTDL,'k+');title('VarMeansL');


% figure
% imagesc(CrossVarRL_tr);title('CrossVarRL_tr');
% axis square;caxis([0 20000]);colormap jet;colorbar






% % % % % 
% % % % % %%%%左右タッチ解析　元来のもの
% % % % % combination=zeros(length(PegTouchCell)*length(PegTouchCell),2);
% % % % % for n=1:length(PegTouchCell)
% % % % %     k=1;
% % % % %     for m=1:length(PegTouchCell)
% % % % %         combination((n-1)*length(PegTouchCell)+m,1)=n;
% % % % %         if (n+m-1<=length(PegTouchCell));
% % % % %             combination((n-1)*length(PegTouchCell)+m,2)=n+m-1;
% % % % %         else
% % % % %             combination((n-1)*length(PegTouchCell)+m,2)=k;
% % % % %             k=k+1;
% % % % %         end
% % % % %     end
% % % % % end
% % % % % 
% % % % % if length(PegTouchCell)==12
% % % % %     CrossCell=cell(1,144);
% % % % %     CrossCellLimited=cell(1,144);
% % % % % elseif length(PegTouchCell)==24
% % % % %     CrossCell=cell(1,576);
% % % % %     CrossCellLimited=cell(1,576);
% % % % % else
% % % % %     CrossCell=cell(1,576);
% % % % %     CrossCellLimited=cell(1,576);
% % % % % end
% % % % %     
% % % % % lenCrossCellLimited=zeros(1,length(CrossCellLimited));
% % % % % for n=1:(length(PegTouchCell)*length(PegTouchCell))
% % % % %     for m=1:length(PegTouchCell{combination(n,1)})%数列１の要素すべてについて
% % % % %         if length(PegTouchCell{combination(n,1)})<10
% % % % %             Interval=0; 
% % % % %             CrossCell{n}=[CrossCell{n};Interval];
% % % % %         else
% % % % %             Interval=(PegTouchCell{combination(n,2)}(PegTouchCell{combination(n,1)}(m)<PegTouchCell{combination(n,2)}...
% % % % %                 &PegTouchCell{combination(n,1)}(m)>PegTouchCell{combination(n,2)}-duration)...
% % % % %                 -PegTouchCell{combination(n,1)}(m));
% % % % %             CrossCell{n}=[CrossCell{n};Interval];
% % % % %             %CrossCellLimited{n}=[CrossCellLimited{n};Interval];
% % % % %             md=mod(n,length(PegTouchCell))/length(PegTouchCell)*OneTurnTime;%当該ペグがパターン周期のどの辺か
% % % % %             if md>0
% % % % %                 if (md-OneTurnTime*0.5)<Interval&Interval<(md+OneTurnTime*0.5)%当該ペグの部位から前後半周期ずつに限定して集録
% % % % %                     CrossCellLimited{n}=[CrossCellLimited{n};Interval];
% % % % %                 end
% % % % %             else
% % % % %                 if OneTurnTime*0.5<Interval&Interval<OneTurnTime*1.5
% % % % %                     CrossCellLimited{n}=[CrossCellLimited{n};Interval];
% % % % %                 end
% % % % %             end
% % % % %             lenCrossCellLimited(n)=length(CrossCellLimited{n});
% % % % %         end
% % % % %     end
% % % % % end    
% % % % % 
% % % % % %途中でマウスが止まったときなど、大きな値がでることがある。これを除く。
% % % % % temp=[];
% % % % % for n=1:length(CrossCellLimited)
% % % % %     temp=CrossCellLimited{n};
% % % % %     temp(temp>median(temp)+1000 | temp<median(temp)-1000)=[];
% % % % %     CrossCellLimited{n}=temp;
% % % % % end
% % % % % 
% % % % % TouchInterval=reshape(CrossCellLimited,24,24);
% % % % % 
% % % % % if Graph==1%グラフを全部表示する場合。ラジオボタンの値が受け渡されたもの。
% % % % %     CrossHisto=zeros(1000,length(PegTouchCell)*length(PegTouchCell));
% % % % %     for n=1:length(CrossCellLimited)
% % % % %         for p=1:1000
% % % % %             %disp(p*(duration*0.01));
% % % % %             CrossHisto(p,n)=length(CrossCellLimited{n}((p-1)*(duration*0.001)<CrossCellLimited{n}&CrossCellLimited{n}<=p*(duration*0.001))); 
% % % % %         end
% % % % %     end
% % % % % 
% % % % %     %peg1からのペグｎまでのヒストグラムを表示する場合
% % % % %     for a=1:1 %length(PegTouchCell), 1はPeg1から、２はPeg2から
% % % % %         figure
% % % % % %         title(int2str(a));
% % % % %         for n=1:12 %12より多いと小さすぎるので、13以降はオミット
% % % % %             %subplot(6,1,n);hist(CrossCellLimited{n+a*12},columns);axis([0 duration 0 yhight])
% % % % %             subplot(12,1,n);bar(CrossHisto(:,n+(a-1)*(length(PegTouchCell))));axis off%([0 1000 0 yhight*0.3])%12より多いと小さすぎるので、13以降はオミット
% % % % %         end
% % % % %         figure
% % % % %         for n=13:24 %12より多いと小さすぎるので、13以降はオミット
% % % % %             %subplot(6,1,n);hist(CrossCellLimited{n+a*12},columns);axis([0 duration 0 yhight])
% % % % %             subplot(12,1,n-12);bar(CrossHisto(:,n+(a-1)*(length(PegTouchCell))));axis off%([0 1000 0 yhight*0.3])%12より多いと小さすぎるので、13以降はオミット
% % % % %         end
% % % % %     end
% % % % % 
% % % % %     %ペグ1-24から12本目のペグまでのヒストグラム
% % % % %     figure
% % % % %     for a=1:24 
% % % % %         subplot(12,2,a);bar(CrossHisto(:,12+(a-1)*(length(PegTouchCell))));axis([0 1000 0 yhight*0.3]) 
% % % % %   
% % % % %     end
% % % % %     
% % % % % end
% % % % % %disp('CrossCellLimited=');disp(CrossCellLimited);
% % % % % disp('length(CrossCellLimited))=');
% % % % % disp(length(CrossCellLimited));
% % % % % disp('length(CrossCellLimited(CrossCellLimited<5))=');
% % % % % disp(length(lenCrossCellLimited(lenCrossCellLimited<5)));
% % % % % disp('length(CrossCellLimited(CrossCellLimited<10))=');
% % % % % disp(length(lenCrossCellLimited(lenCrossCellLimited<10)));
% % % % % % disp('length(CrossCellLimited(CrossCellLimited<20))=');
% % % % % % disp(length(lenCrossCellLimited(lenCrossCellLimited<20)));
% % % % % disp('mean(lenCrossCellLimited)=');
% % % % % disp(mean(lenCrossCellLimited));
% % % % % disp('median(lenCrossCellLimited)=');
% % % % % disp(median(lenCrossCellLimited));
% % % % % % disp('mode(lenCrossCellLimited)=');
% % % % % % disp(mode(lenCrossCellLimited));
% % % % % 
% % % % % %CutOffLimit---------------------------------------------------------------
% % % % % if FTselect==1;CutOffLimit=10;%1stのみ解析する場合
% % % % % elseif FTselect==2;CutOffLimit=15;%All touchを解析する場合
% % % % % end
% % % % % 
% % % % % % for n=1:length(CrossCellLimited);for m=1:length(CrossCellLimited{n});if CrossCellLimited{n}(m)>4500;disp(n);disp(m);disp(CrossCellLimited{n}(m));end;end;end
% % % % % 
% % % % % CrossVar=zeros(length(PegTouchCell),length(PegTouchCell));
% % % % % CrossVarInv=zeros(length(PegTouchCell),length(PegTouchCell));
% % % % % a=1;b=1;
% % % % % for n=1:length(CrossCellLimited)   
% % % % %     %mean(CrossCell{n})
% % % % %     if length(CrossCellLimited{n})>CutOffLimit %数が少ない場合は計算しない。
% % % % %         CrossVar(a,b)=var(CrossCellLimited{n});   
% % % % %     else
% % % % %         CrossVar(a,b)=0;%本当に数値が０になる場合と区別したほうが良い?
% % % % %     end    
% % % % %     a=a+1;
% % % % %     if a==(length(PegTouchCell)+1);a=1;b=b+1;end
% % % % % end
% % % % % 
% % % % % CovMeans=zeros(1,length(PegTouchCell));
% % % % % VarMeans=zeros(1,length(PegTouchCell));
% % % % % VarSTD=zeros(1,length(PegTouchCell));
% % % % % for n=1:length(PegTouchCell)
% % % % %     CC=CrossVar(n,:);
% % % % %     CCnonzero=CC(CC~=0);
% % % % %     %VarMeans(n)=sum(CC)/length(CC(CC~=0));
% % % % %     VarMeans(n)=sum(CCnonzero)/length(CCnonzero);
% % % % %     VarSTD(n)=std(CCnonzero)/sqrt(length(CCnonzero));
% % % % % end
% % % % % 
% % % % % % VAR=[];
% % % % % % for n=1:24
% % % % % %     if  length(TouchInterval{12,n})>10
% % % % % %         VAR=[VAR var(TouchInterval{12,n})];
% % % % % %     end
% % % % % % end
% % % % % % VarMeaN=mean(VAR)
% % % % % 
% % % % % 
% % % % % %disp(CovMeans);
% % % % % 
% % % % %     fig_VM=figure%('Position',[1 1 1400 975]);
% % % % %     bar(VarMeans);
% % % % %     hold on
% % % % %     errorbar(VarMeans,VarSTD,'k+');
% % % % %     if FigureSave==1;saveas(fig_VM,[DrName,' ','VarMeans.bmp']);end
% % % % % % end
% % % % % 
% % % % % if ShowFig==1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ペグ毎の分散、精度など、
% % % % %     fig_CrossVar_CLmap=figure%('Position',[1 1 1400 975]);%%%%%%%%
% % % % %     imagesc(CrossVar);
% % % % %     axis square
% % % % %     
% % % % % %     ST=sort(CrossVar(:),'descend');
% % % % % %     Max=ST(round(24*24/10))*2
% % % % % %     Max=ST(round(24*24/10))*2.5
% % % % % %     caxis([0 Max]);%
% % % % %     
% % % % %     
% % % % % %     caxis([0 max(max(CrossVar))*1.2]);%
% % % % %     caxis([0 25000]);%
% % % % %     colormap jet
% % % % %     colorbar
% % % % %     if FigureSave==1;saveas(fig_CrossVar_CLmap,[DrName,' ','CrossVar_CLmap.bmp']);end%%%%%%
% % % % %     hold off
% % % % % % % % % %     fig_CrossVar=figure
% % % % % % % % % %     bar3(CrossVar);axis([1 25 1 25 0 15000]);
% % % % % figure
% % % % % imagesc(CrossVar);
% % % % %     axis square
% % % % %     
% % % % % 
% % % % %     Max=max(max(CrossVar(:)));
% % % % %     caxis([0 Max]);%
% % % % %     
% % % % %     
% % % % % %     caxis([0 max(max(CrossVar))*1.2]);%
% % % % % %     caxis([0 25000]);%
% % % % %     colormap jet
% % % % %     colorbar
% % % % % end
% % % % % 
% % % % % 
% % % % % %%%%左右タッチ解析　元来のもの ここまで
% % % % % 
% % % % % %%%%左右別　タッチ解析　ここから
% % % % % for A=1:2
% % % % %     if A==1
% % % % %         PegTouchCell=RpegTouchCell;
% % % % %     elseif A==2
% % % % %         PegTouchCell=LpegTouchCell;        
% % % % %     end
% % % % % 
% % % % %     combination=zeros(length(PegTouchCell)*length(PegTouchCell),2);
% % % % %     for n=1:length(PegTouchCell)
% % % % %         k=1;
% % % % %         for m=1:length(PegTouchCell)
% % % % %             combination((n-1)*length(PegTouchCell)+m,1)=n;
% % % % %             if (n+m-1<=length(PegTouchCell));
% % % % %                 combination((n-1)*length(PegTouchCell)+m,2)=n+m-1;
% % % % %             else
% % % % %                 combination((n-1)*length(PegTouchCell)+m,2)=k;
% % % % %                 k=k+1;
% % % % %             end
% % % % %         end
% % % % %     end
% % % % % 
% % % % %     % if length(PegTouchCell)==12
% % % % %         CrossCell=cell(1,144);
% % % % %         CrossCellLimited=cell(1,144);
% % % % %     % elseif length(PegTouchCell)==24
% % % % %     %     CrossCell=cell(1,576);
% % % % %     %     CrossCellLimited=cell(1,576);
% % % % %     % end
% % % % % 
% % % % %     lenCrossCellLimited=zeros(1,length(CrossCellLimited));
% % % % %     for n=1:(length(PegTouchCell)*length(PegTouchCell))
% % % % %         for m=1:length(PegTouchCell{combination(n,1)})%数列１の要素すべてについて
% % % % %             if length(PegTouchCell{combination(n,1)})<10
% % % % %                 Interval=0; 
% % % % %                 CrossCell{n}=[CrossCell{n};Interval];
% % % % %             else
% % % % %                 Interval=(PegTouchCell{combination(n,2)}(PegTouchCell{combination(n,1)}(m)<PegTouchCell{combination(n,2)}...
% % % % %                     &PegTouchCell{combination(n,1)}(m)>PegTouchCell{combination(n,2)}-duration)...
% % % % %                     -PegTouchCell{combination(n,1)}(m));
% % % % %                 CrossCell{n}=[CrossCell{n};Interval];
% % % % %                 %CrossCellLimited{n}=[CrossCellLimited{n};Interval];
% % % % %                 md=mod(n,length(PegTouchCell))/length(PegTouchCell)*OneTurnTime;%当該ペグがパターン周期のどの辺か
% % % % %                 if md>0
% % % % %                     if (md-OneTurnTime*0.5)<Interval&Interval<(md+OneTurnTime*0.5)%当該ペグの部位から前後半周期ずつに限定して集録
% % % % %                         CrossCellLimited{n}=[CrossCellLimited{n};Interval];
% % % % %                     end
% % % % %                 else
% % % % %                     if OneTurnTime*0.5<Interval&Interval<OneTurnTime*1.5
% % % % %                         CrossCellLimited{n}=[CrossCellLimited{n};Interval];
% % % % %                     end
% % % % %                 end
% % % % %                 lenCrossCellLimited(n)=length(CrossCellLimited{n});
% % % % %             end
% % % % %         end
% % % % %     end    
% % % % % 
% % % % %     %途中でマウスが止まったときなど、大きな値がでることがある。これを除く。
% % % % %     temp=[];
% % % % %     for n=1:length(CrossCellLimited)
% % % % %         temp=CrossCellLimited{n};
% % % % %         temp(temp>median(temp)+1000 | temp<median(temp)-1000)=[];
% % % % %         CrossCellLimited{n}=temp;
% % % % %     end
% % % % % 
% % % % %     TouchInterval=reshape(CrossCellLimited,12,12);
% % % % %     % TouchInterval=reshape(CrossCellLimited,24,24);
% % % % % 
% % % % %     if Graph==1%グラフを全部表示する場合。ラジオボタンの値が受け渡されたもの。
% % % % %         CrossHisto=zeros(1000,length(PegTouchCell)*length(PegTouchCell));
% % % % %         for n=1:length(CrossCellLimited)
% % % % %             for p=1:1000
% % % % %                 %disp(p*(duration*0.01));
% % % % %                 CrossHisto(p,n)=length(CrossCellLimited{n}((p-1)*(duration*0.001)<CrossCellLimited{n}&CrossCellLimited{n}<=p*(duration*0.001))); 
% % % % %             end
% % % % %         end
% % % % % 
% % % % %         %peg1からのペグｎまでのヒストグラムを表示する場合
% % % % %         for a=1:1 %length(PegTouchCell), 1はPeg1から、２はPeg2から
% % % % %             figure
% % % % %     %         title(int2str(a));
% % % % %             for n=1:12 %12より多いと小さすぎるので、13以降はオミット
% % % % %                 %subplot(6,1,n);hist(CrossCellLimited{n+a*12},columns);axis([0 duration 0 yhight])
% % % % %                 subplot(12,1,n);bar(CrossHisto(:,n+(a-1)*(length(PegTouchCell))));axis off%([0 1000 0 yhight*0.3])%12より多いと小さすぎるので、13以降はオミット
% % % % %             end
% % % % %             figure
% % % % %             for n=13:24 %12より多いと小さすぎるので、13以降はオミット
% % % % %                 %subplot(6,1,n);hist(CrossCellLimited{n+a*12},columns);axis([0 duration 0 yhight])
% % % % %                 subplot(12,1,n-12);bar(CrossHisto(:,n+(a-1)*(length(PegTouchCell))));axis off%([0 1000 0 yhight*0.3])%12より多いと小さすぎるので、13以降はオミット
% % % % %             end
% % % % %         end
% % % % % 
% % % % %         %ペグ1-24から12本目のペグまでのヒストグラム
% % % % %         figure
% % % % %         for a=1:12 
% % % % %             subplot(12,2,a);bar(CrossHisto(:,12+(a-1)*(length(PegTouchCell))));axis([0 1000 0 yhight*0.3]) 
% % % % %         end
% % % % %     end
% % % % %     %disp('CrossCellLimited=');disp(CrossCellLimited);
% % % % %     disp('length(CrossCellLimited))=');
% % % % %     disp(length(CrossCellLimited));
% % % % %     disp('length(CrossCellLimited(CrossCellLimited<5))=');
% % % % %     disp(length(lenCrossCellLimited(lenCrossCellLimited<5)));
% % % % %     disp('length(CrossCellLimited(CrossCellLimited<10))=');
% % % % %     disp(length(lenCrossCellLimited(lenCrossCellLimited<10)));
% % % % %     disp('mean(lenCrossCellLimited)=');
% % % % %     disp(mean(lenCrossCellLimited));
% % % % %     disp('median(lenCrossCellLimited)=');
% % % % %     disp(median(lenCrossCellLimited));
% % % % % 
% % % % % 
% % % % %     %CutOffLimit---------------------------------------------------------------
% % % % %     if FTselect==1;CutOffLimit=10;%1stのみ解析する場合
% % % % %     elseif FTselect==2;CutOffLimit=15;%All touchを解析する場合
% % % % %     end
% % % % % 
% % % % %     CrossVar=zeros(length(PegTouchCell),length(PegTouchCell));
% % % % %     % CrossVarInv=zeros(length(PegTouchCell),length(PegTouchCell));
% % % % %     a=1;b=1;
% % % % %     for n=1:length(CrossCellLimited)   
% % % % %         %mean(CrossCell{n})
% % % % %         if length(CrossCellLimited{n})>CutOffLimit %数が少ない場合は計算しない。
% % % % %             CrossVar(a,b)=var(CrossCellLimited{n});   
% % % % %         else
% % % % %             CrossVar(a,b)=0;%本当に数値が０になる場合と区別したほうが良い?
% % % % %         end    
% % % % %         a=a+1;
% % % % %         if a==(length(PegTouchCell)+1);a=1;b=b+1;end
% % % % %     end
% % % % % 
% % % % %     CovMeans=zeros(1,length(PegTouchCell));
% % % % %     VarMeansHalf=zeros(1,length(PegTouchCell));
% % % % %     VarSTDHalf=zeros(1,length(PegTouchCell));
% % % % %     for n=1:length(PegTouchCell)
% % % % %         CC=CrossVar(n,:);
% % % % %         CCnonzero=CC(CC~=0);
% % % % %         %VarMeansHalf(n)=sum(CC)/length(CC(CC~=0));
% % % % %         VarMeansHalf(n)=sum(CCnonzero)/length(CCnonzero);
% % % % %         VarSTDHalf(n)=std(CCnonzero)/sqrt(length(CCnonzero));
% % % % %     end
% % % % % 
% % % % %     if A==1
% % % % %         VarMeans_R=VarMeansHalf;
% % % % %         VarSTD_R=VarSTDHalf;
% % % % %         CrossVar_R=CrossVar;
% % % % %     elseif A==2
% % % % %         VarMeans_L=VarMeansHalf; 
% % % % %         VarSTD_L=VarSTDHalf;    
% % % % %         CrossVar_L=CrossVar;
% % % % %         
% % % % %         fig_VM2=figure;%('Position',[1 1 1400 975]);
% % % % %         
% % % % %         MAX=max(max(VarMeans_R+VarSTD_R),max(VarMeans_L+VarSTD_L));
% % % % %         
% % % % %         if ~isnan(MAX)
% % % % %         
% % % % %         subplot(1,2,1);
% % % % %         bar(VarMeans_L);axis([0 13 0 MAX]);
% % % % %         hold on
% % % % %         errorbar(VarMeans_L,VarSTD_L,'k+');title('Left');
% % % % %         subplot(1,2,2);
% % % % %         bar(VarMeans_R);axis([0 13 0 MAX]);
% % % % %         hold on
% % % % %         errorbar(VarMeans_R,VarSTD_R,'k+');title('Right');
% % % % %         
% % % % %         end
% % % % %         
% % % % %         if FigureSave==1;saveas(fig_VM2,[DrName,' ','VarMeans2.bmp']);end
% % % % % 
% % % % % 
% % % % %         if ShowFig==1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ペグ毎の分散、精度など、
% % % % %             fig_CrossVar_CLmap2=figure%('Position',[1 1 1400 975]);%%%%%%%%
% % % % %             subplot(1,2,1);
% % % % %             imagesc(CrossVar_L);title('Left');
% % % % %             axis square
% % % % %             caxis([0 max(max(CrossVar_L))]);%
% % % % %             colormap jet
% % % % %             colorbar
% % % % % %             imagesc(CrossVar_R);
% % % % % %             axis square
% % % % % %             caxis([0 max(max(CrossVar_R))]);%
% % % % % %             colormap jet
% % % % % %             colorbar
% % % % %             subplot(1,2,2);
% % % % %             imagesc(CrossVar_R);
% % % % %             axis square
% % % % %             caxis([0 max(max(CrossVar_R))]);%
% % % % %             colormap jet
% % % % %             colorbar
% % % % %             title('Right');
% % % % % %             imagesc(CrossVar_L);title('L');
% % % % % %             axis square
% % % % % %             caxis([0 max(max(CrossVar_L))]);%
% % % % % %             colormap jet
% % % % % %             colorbar
% % % % %             if FigureSave==1;saveas(fig_CrossVar_CLmap2,[DrName,' ','CrossVar_CLmap2.bmp']);end%%%%%%
% % % % %             hold off
% % % % %             
% % % % %             
% % % % % % % % % %             fig_CrossVarRL=figure;
% % % % % % % % % %             subplot(1,2,1);
% % % % % % % % % %             bar3(CrossVar_L);axis([1 13 1 13 0 15000]);title('Left');
% % % % % % % % % %             subplot(1,2,2);
% % % % % % % % % %             bar3(CrossVar_R);axis([1 13 1 13 0 15000]);title('Right');
% % % % % % % % % %             if FigureSave==1;saveas(fig_CrossVarRL,[DrName,' ','CrossVarRL.fig']);end
% % % % % 
% % % % % %             CrossVarInv=(1000./CrossVar);
% % % % % 
% % % % % %             %色で表示
% % % % % %             CrossVarInv_2=CrossVarInv;%色分けでInfが最高値になってしまうので、Infに0を当てはめる
% % % % % % 
% % % % % %             CrossVarInv_2(CrossVarInv_2==inf)=0;
% % % % % % 
% % % % % %             fig_CrossVarInv_CLmap2=figure('Position',[1 1 1400 975]);%%%%%%%%
% % % % % %             imagesc(CrossVarInv_2);
% % % % % %             axis square
% % % % % %             caxis([0 1.6]);
% % % % % %             colormap jet
% % % % % %             colorbar
% % % % % %             saveas(fig_CrossVarInv_CLmap,[DrName,' ','CrossVarInv_CLmap2.bmp']);%%%%%%
% % % % %         end
% % % % %     end
% % % % % end


