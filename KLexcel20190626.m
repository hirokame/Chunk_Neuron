function KLexcel20190626

global dpath dpath3

% cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
% dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');

cd(dpath3);

sameKLmean=[];
diffKLmean=[];
sameKLpost=[];
diffKLpost=[];
sameKLpre=[];
diffKLpre=[];
sameKLLtRt=[];
diffKLLtRt=[];
sameKLRtLt=[];
diffKLRtLt=[];


h=ls;
for n=1:length(h(:,1))
    KLMatrix=[];
    sameKLmean=[];
    diffKLmean=[];
    sameKLpost=[];
    diffKLpost=[];
    sameKLpre=[];
    diffKLpre=[];
    sameKLLtRt=[];
    diffKLLtRt=[];
    sameKLRtLt=[];
    diffKLRtLt=[];
    TrimStrB=strtrim(h(n,:));
    if length(TrimStrB)>2 && ~strcmp(TrimStrB(1:5),'Event');
    if strcmp(TrimStrB(end-3:end),'.mat')
    if ~strcmp(TrimStrB(end-4:end),'V.mat')
    FLName=[dpath,TrimStrB(1:length(TrimStrB)-4)];
    cd(FLName);
    KLDIV=[FLName,'\KLDIV'];
    cd(KLDIV);
    KLfolder=[KLDIV,'\KL',TrimStrB(1:length(TrimStrB)-4)];
    cd(KLfolder);
    LS1=ls;
    for i=1:length(LS1(:,1))
        FL=strtrim(LS1(i,:));
        if length(FL)>2;
            load(FL);
            sameKLmean=[sameKLmean KldistSame];
            diffKLmean=[diffKLmean meanKldistDiff];
        end
    end
    prepost=[FLName,'\prepost'];
    cd(prepost);
    posttouch=[prepost,'\posttouchKL'];
    cd(posttouch);
    LS2=ls;
    for i=1:length(LS2(:,1))
        FL=strtrim(LS2(i,:));
        if length(FL)>2;
            load(FL);
            sameKLpost=[sameKLpost KldistSame];
            diffKLpost=[diffKLpost meanKldistDiff];
        end
    end
    
    cd(prepost);
    pretouch=[prepost,'\pretouchKL'];
    cd(pretouch);
    LS3=ls;
    for i=1:length(LS3(:,1))
        FL=strtrim(LS3(i,:));
        if length(FL)>2;
            load(FL);
            sameKLpre=[sameKLpre KldistSame];
            diffKLpre=[diffKLpre meanKldistDiff];
        end
    end
    
    
    
    RtInLt=[FLName,'\RtInLttimeFolder'];
    cd(RtInLt);
    LtRt=[RtInLt,'\Lt-RtTime'];
    cd(LtRt);
    LS4=ls;
    for i=1:length(LS4(:,1))
        FL=strtrim(LS4(i,:));
        if length(FL)>2;
            load(FL);
            sameKLLtRt=[sameKLLtRt KldistSame];
            diffKLLtRt=[diffKLLtRt meanKldistDiff];
        end
    end
    
    cd(RtInLt);
    RtLt=[RtInLt,'\Rt-LtTime'];
    cd(RtLt);
    LS5=ls;
    for i=1:length(LS5(:,1))
        FL=strtrim(LS5(i,:));
        if length(FL)>2;
            load(FL);
            sameKLRtLt=[sameKLRtLt KldistSame];
            diffKLRtLt=[diffKLRtLt meanKldistDiff];
        end
    end
    cd(FLName);
    KLMatrix=[[sameKLmean;diffKLmean];[sameKLpost;diffKLpost];[sameKLpre;diffKLpre];[sameKLLtRt;diffKLLtRt];[sameKLRtLt;diffKLRtLt]];

    filename=[TrimStrB(1:length(TrimStrB)-4),'KLdist.xlsx'];

    xlswrite(filename,KLMatrix);
    
    
    end
    end
    end
end
% cd(FLName);
% KLMatrix=[[sameKLmean;diffKLmean];[sameKLpost;diffKLpost];[sameKLpre;diffKLpre];[sameKLLtRt;diffKLLtRt];[sameKLRtLt;diffKLRtLt]];
% 
% filename=['KLdist.xlsx'];
% 
% xlswrite(filename,KLMatrix);


