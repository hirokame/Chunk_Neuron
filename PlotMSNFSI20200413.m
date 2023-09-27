function PlotMSNFSI20200413

clear all;close all;
path=['G:\CheetahWRLV20200411'];
cd(path)
load widthPtoT

% X=[AllCellwidth.' AllCellPtoT.'];

AllCellwidth = X(:,1); 
AllCellPtoT =X(:,2);

thresholdwidth=5;
thresholdPtoT=10;

[idxMSN,S1]=find(AllCellwidth>thresholdwidth & AllCellPtoT>thresholdPtoT);
[idxFSI,S2]=find(AllCellwidth<=thresholdwidth & AllCellPtoT<=thresholdPtoT);

fig1=figure;
plot(X(:,1),X(:,2),'k.','MarkerSize',6)
hold on
plot(X(idxMSN,1),X(idxMSN,2),'r.','MarkerSize',12)
hold on
plot(X(idxFSI,1),X(idxFSI,2),'b.','MarkerSize',12)


% Old2=cd;
% Folder=[dpath3,'\CellCell\',trimtfile(1:end-2)];
% cd(Folder)
% load('response.mat');
% if ~isempty(strfind(response,'MSN'))
%    response=erase(response,'MSN'); 
% end
% if isempty(strfind(response,'MSN'));
if meanwidth>thresholdwidth && meanPtoT>thresholdPtoT;
   response=[response,'MSN'];
end 
if meanwidth<thresholdwidth && meanPtoT<thresholdPtoT;
   response=[response,'FSI']; 
end
if isempty(strfind(response,'FSI')) && isempty(strfind(response,'MSN'));
    response=[response,'ITN'];
end
% end
filename=['response'];
save(filename,'response');
cd(Old2)