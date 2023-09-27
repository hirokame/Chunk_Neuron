function cellclassify20190712

global  ACresult ACresultW CCresultDrinkOn SpikeArray RpegTouchallWon LpegTouchallWon TurnMarkerTime RmedianPTTM RpegMedian LmedianPTTM LpegMedian...
    RpNum LpNum  OneTurnTime CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 fname tfile WaterOnArrayOriginal A1 A2 WaterOnPoint WaterOffPoint...
    A1Rt A2Lt AAC ADon ClassifyFL fig_spike TotalTime frequencyPksLt pksA1Rt MeanpksA1Rt pksA2Lt MeanpksA2Lt...
    qMaxFRratio qMinFRratio WaterOffArrayOriginal...
    pksP1 locsP1 pksP2 locsP2 dpath CCresultRtouchWon CCresultLtouchWon...
    MaxADon MaxA1Rt MaxA2Lt Wokaisu Woffkaisu  ratio DiffDon  WaterOnPointstd WaterOnPointmean WaterOffPointmean WaterOffPointstd...
    RtCells LtCells DonCells WonCells WoffCells MaxZ MaxZR MaxZL MaxZWoff MaxZWon DiffMaxMinR DiffMaxMinL AFreq ZFreq...
    Woffhpost1000 Wonhpre1000 Woffhpost2000 Wonhpre2000 Woffhpost3000 Wonhpre3000 dpath3 Freq Wonhpost1000 Woffhpre1000 Woffhpre2000 Wonhpost2000 Woffhpre3000 Wonhpost3000...
    mensekiR mensekiL SpikePerTouchWoff...
    MaxA1Rt_count MaxZR_count MaxA2Lt_count MaxZL_count MaxADon_count MaxZ_count LtRsq RtRsq Ltbeta Rtbeta LtRsq_P1 RtRsq_P1 Ltbeta_P1 Rtbeta_P1...
    ZFreq_Int_dist ZFreq_Ph_dist ZFreq_Int_dist_All ZFreq_Ph_dist_All beta_dist Rsq_dist beta_P1_dist Rsq_P1_dist beta_dist_All Rsq_dist_All beta_P1_dist_All Rsq_P1_dist_All

cd(dpath3)
dpath=[dpath3,'\'];
LSt=ls;
Folder=['CellCell'];
if not(exist(Folder,'dir'))
    mkdir(Folder)
end

for i=1:length(LSt(:,1))
    tFL=strtrim(LSt(i,:));
    if length(tFL)>2;
        if tFL(end-1:end)=='.t'
            cd(Folder)
            tFolder=[tFL(1:end-2)];
            if not(exist(tFolder,'dir'))
                mkdir(tFolder);
            end
            cdFolder=[dpath,'ParameterFolder'];
            cd(cdFolder)
            LS=ls;
            for j=1:length(LS(:,1))
                if strcmp(LS(j,(1:9)),tFolder);
                    load(LS(j,:))
                    FLName=[LS(j,:)];
                    cdFolder2=[dpath,Folder,'\',tFolder];
                    cd(cdFolder2)
                    save(FLName,'DiffMaxMinR','DiffMaxMinL','Freq','Wokaisu','Woffkaisu','WaterOnPointmean','WaterOffPointmean','ratio','MaxA1Rt','MaxA2Lt','locsP1'...
                        ,'pksP2','locsP2','MaxZR','MaxZL','MaxADon','DiffDon','MaxZ','WaterOnPointstd','WaterOffPointstd','MaxZWon','MaxZWoff','StepFreqR','StepFreqL'...
                        ,'A1RtStepFreq','A2LtStepFreq','AFreq','ZFreq','Woffhpost1000','Wonhpre1000','Woffhpost2000','Wonhpre2000','Woffhpost3000','Wonhpre3000','mensekiR','mensekiL'...
                        ,'Woffhpre1000','Wonhpost1000','Woffhpre2000','Wonhpost2000','Woffhpre3000','Wonhpost3000','SpikePerTouchWoff'...
                        ,'LtRsq', 'RtRsq', 'Ltbeta', 'Rtbeta', 'LtRsq_P1', 'RtRsq_P1', 'Ltbeta_P1', 'Rtbeta_P1');
                    
                    cd(cdFolder)
                end
            end
            cd(dpath3)
        end
    end
end


path=[dpath,'CellCell'];


M=['_98__'];
response=[];
cd(path)
LS=ls;

%%%%%%% Threshold %%%%%%%%
Cell_th = 0.5;    % 0.5 for MSN
MaxZR_th = 18;     % 17 for MSN
MaxA1Rt_th = 0.2; % 0.2 for MSN
MaxZL_th = 20;     % 18 for MSN
MaxA2Lt_th = 0.4; % 0.4 for MSN
Beta_th = 0.15;
Rsq_th = 0.8;
%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:length(LS(:,1))
    response=[];
    FreqArray=[];
    trimLS=strtrim(LS(k,:));
    if length(trimLS)>4 && ~strcmp(trimLS(end-3:end),'.mat');
        cd(trimLS)
        LScell=ls;
        
        %%%×–E‚²‚Æ‚É‚·‚×‚Ä‚Ìƒpƒ^[ƒ“‚ð’Ê‚µ‚Äƒgƒbƒv‚ÌZscore(spectrum)‹L˜^‚·‚éB
        MaxA1Rt_top=0;
        MaxZR_top=0;
        MaxA2Lt_top=0;
        MaxZL_top=0;
        MaxADon_top=0;
        MaxZ_top=0;
        ZFreq_Ph=0;
        ZFreq_Int=0;
        ZFreq_Ph_All=0;
        ZFreq_Int_All=0;
        
        beta_top=0;
        Rsq_top=0;
        beta_P1_top=0;
        Rsq_P1_top=0;
        beta_top_All=0;
        Rsq_top_All=0;
        beta_P1_top_All=0;
        Rsq_P1_top_All=0;
        
        for l=1:length(LScell(:,1))
            file=strtrim(LScell(l,:));
            if length(file)>12;
                load(file)
                if Freq>Cell_th;
                    path;   %% ƒ}ƒEƒXAƒZƒbƒVƒ‡ƒ““ú
                    trimLS; %% ×–E”Ô†
                    file;   %% ƒpƒ^[ƒ“(.mat)
                    
                    MaxA1Rt_top=max([MaxA1Rt_top,MaxA1Rt]);
                    MaxZR_top=max([MaxZR_top,MaxZR]);
                    MaxA2Lt_top=max([MaxA2Lt_top,MaxA2Lt]);
                    MaxZL_top=max([MaxZL_top,MaxZL]);
                    MaxADon_top=max([MaxADon_top,MaxADon]);
                    MaxZ_top=max([MaxZ_top,MaxZ]);
                    
                    if isempty(strfind(response,'Cell'));
                        response=[response 'Cell'];
                    end
                    if strcmp(file(end-8:end-4),M);
                        if MaxZR>MaxZR_th && MaxA1Rt>MaxA1Rt_th && isempty(strfind(response,'Rt'));
                            response=[response 'Rt'];
                        end
                        if MaxZL>MaxZL_th && MaxA2Lt>MaxA2Lt_th && isempty(strfind(response,'Lt'));
                            response=[response 'Lt'];
                        end
                        
                        if MaxZ>10 && MaxADon>0.1 && isempty(strfind(response,'Don'));
                            response=[response 'Don'];
                        end
                        
                    end
                    
                    if SpikePerTouchWoff>0.2 && (Wonhpre1000==1 || Wonhpost1000==1) && Wokaisu>15 && isempty(strfind(response,'Won'));
                        response=[response 'Won'];
                    end
                    if SpikePerTouchWoff>0.2 && (Woffhpost1000==1 || Woffhpre1000==1) && Wokaisu>15 && isempty(strfind(response,'Woff'));
                        response=[response 'Woff'];
                    end
                    
                end
            end
        end
        MaxA1Rt_count = [MaxA1Rt_count MaxA1Rt_top];
        MaxZR_count = [MaxZR_count MaxZR_top];
        MaxA2Lt_count = [MaxA2Lt_count MaxA2Lt_top];
        MaxZL_count = [MaxZL_count MaxZL_top];
        MaxADon_count = [MaxADon_count MaxADon_top];
        MaxZ_count = [MaxZ_count MaxZ_top];
        for l=1:length(LScell(:,1))
            file=strtrim(LScell(l,:));
            if length(file)>12;
                if strcmp(file(end-8:end-4),'_98__');
                    load(file)
                    if ~isempty(strfind(response,'Rt')) || ~isempty(strfind(response,'Lt'));
                        if ZFreq>1.8;
                            response=[response 'mod98'];
                        end
                        ZFreq_Ph=max([ZFreq_Ph,ZFreq]);  %% 98‘–s’†‚ÌZscore‚ðŠi”[
                    end
                    if Freq>Cell_th;
                        ZFreq_Ph_All=max([ZFreq_Ph_All,ZFreq]); %% Touch×–E‚ÉŒÀ‚ç‚¸Zscore‚ðŠi”[
                    end
                end
                if strcmp(file(end-8:end-4),'_Bgra');
                    load(file)
                    if ~isempty(strfind(response,'Rt')) || ~isempty(strfind(response,'Lt'));
                        if ZFreq>1.6;
                            response=[response 'modBgra'];
                        end
                        ZFreq_Int=max([ZFreq_Int,ZFreq]);  % Bgra‘–s’†‚ÌZscore‚ðŠi”[
                    end
                    if Freq>Cell_th;
                        ZFreq_Int_All=max([ZFreq_Int_All,ZFreq]); % Touch×–E‚ÉŒÀ‚ç‚¸Zscore‚ðŠi”[(×–E‚Ì”­‰Î•p“x‚Ì‚Ý‚Íl—¶‚É“ü‚ê‚é)
                    end
                end
                
                %%%Complex‚ÅRepeat‚Ì‰ðÍ
                if strcmp(file(end-8:end-7),'_C');
                    load(file)
                    if ~isempty(strfind(response,'Rt')) || ~isempty(strfind(response,'Lt'));
                        if (abs(Rtbeta)+abs(RtRsq)) > (abs(Ltbeta)+abs(LtRsq))
                            maxbeta=Rtbeta;
                            maxRsq=RtRsq;
                        else
                            maxbeta=Ltbeta;
                            maxRsq=LtRsq;
                        end
                        if (abs(Rtbeta_P1)+abs(RtRsq_P1)) > (abs(Ltbeta_P1)+abs(LtRsq_P1))
                            maxbeta_P1=Rtbeta_P1;
                            maxRsq_P1=RtRsq_P1;
                        else
                            maxbeta_P1=Ltbeta_P1;
                            maxRsq_P1=LtRsq_P1;
                        end
                        
                        beta_top=max([beta_top, maxbeta]); %% ¶‰E‚Ì‘å‚«‚¢‚Ù‚¤‚Ìbeta
                        Rsq_top=max([Rsq_top, maxRsq]);  %% ¶‰E‚Ì‘å‚«‚¢‚Ù‚¤‚ÌRsq
                        beta_P1_top=max([beta_P1_top, maxbeta_P1]);
                        Rsq_P1_top=max([Rsq_P1_top, maxRsq_P1]);
                        
                        if (maxbeta>Beta_th && maxRsq>Rsq_th);
                            response=[response 'Rep'];
                        end
                    end
                    if Freq>Cell_th;   %% Touch×–E‚ÉŒÀ‚ç‚¸Ši”[
                        if (abs(Rtbeta)+abs(RtRsq)) > (abs(Ltbeta)+abs(LtRsq))
                            maxbeta=Rtbeta;
                            maxRsq=RtRsq;
                        else
                            maxbeta=Ltbeta;
                            maxRsq=LtRsq;
                        end
                        if (abs(Rtbeta_P1)+abs(RtRsq_P1)) > (abs(Ltbeta_P1)+abs(LtRsq_P1))
                            maxbeta_P1=Rtbeta_P1;
                            maxRsq_P1=RtRsq_P1;
                        else
                            maxbeta_P1=Ltbeta_P1;
                            maxRsq_P1=LtRsq_P1;
                        end
                        
                        beta_top_All=max([beta_top_All, maxbeta]); %% ¶‰E‚Ì‘å‚«‚¢‚Ù‚¤‚Ìbeta
                        Rsq_top_All=max([Rsq_top_All, maxRsq]);  %% ¶‰E‚Ì‘å‚«‚¢‚Ù‚¤‚ÌRsq
                        beta_P1_top_All=max([beta_P1_top_All, maxbeta_P1]);
                        Rsq_P1_top_All=max([Rsq_P1_top_All, maxRsq_P1]);
                    end
                end
                
            end
        end
        
        if not(ZFreq_Ph==0)
            ZFreq_Ph_dist = [ZFreq_Ph_dist ZFreq_Ph];
        end
        if not(ZFreq_Int==0)
            ZFreq_Int_dist = [ZFreq_Int_dist ZFreq_Int];
        end
        if not(ZFreq_Ph_All==0)
            ZFreq_Ph_dist_All = [ZFreq_Ph_dist_All ZFreq_Ph_All];
        end
        if not(ZFreq_Int_All==0)
            ZFreq_Int_dist_All = [ZFreq_Int_dist_All ZFreq_Int_All];
        end
        
        beta_dist = [beta_dist beta_top];
        Rsq_dist = [Rsq_dist Rsq_top];
        beta_P1_dist = [beta_P1_dist beta_P1_top];
        Rsq_P1_dist = [Rsq_P1_dist Rsq_P1_top];
        beta_dist_All = [beta_dist_All beta_top_All];
        Rsq_dist_All = [Rsq_dist_All Rsq_top_All];
        beta_P1_dist_All = [beta_P1_dist_All beta_P1_top_All];
        Rsq_P1_dist_All = [Rsq_P1_dist_All Rsq_P1_top_All];
        
        filename=['response'];
        save(filename,'response');
    end
    cd(path)
end
cd(path)
Cells=0;
Rtcount=0;
Ltcount=0;
RtLtcount=0;
Touchcount=0;
Woncount=0;
Woffcount=0;
WonWoffcount=0;
Doncount=0;
WoDoncount=0;
tDoncount=0;
Wotcount=0;
tWoDoncount=0;
modBgracount=0;
mod98count=0;
repcount=0;
Bgra98count=0;
rep98count=0;
repBgracount=0;
rhythmcount_mt3=0;
LSF=ls;
for i=1:length(LSF(:,1))
    Folder=strtrim(LSF(i,:));
    if length(Folder)>4 && ~strcmp(Folder(end-3:end),'.mat');
        cd(Folder);
        LS=ls;
        for j=1:length(LS(:,1))
            FL=strtrim(LS(j,:));
            if strcmp(FL,'response.mat');
                load(FL);
                if ~isempty(strfind(response,'Cell'));
                    Cells=Cells+1;
                end
                if ~isempty(strfind(response,'Rt'));
                    Rtcount=Rtcount+1;
                end
                if ~isempty(strfind(response,'Lt'));
                    Ltcount=Ltcount+1;
                end
                if ~isempty(strfind(response,'RtLt'));
                    RtLtcount=RtLtcount+1;
                end
                if ~isempty(strfind(response,'Rt')) || ~isempty(strfind(response,'Lt'));
                    Touchcount=Touchcount+1;
                end
                if ~isempty(strfind(response,'Won'));
                    Woncount=Woncount+1;
                end
                if ~isempty(strfind(response,'Woff'));
                    Woffcount=Woffcount+1;
                end
                if ~isempty(strfind(response,'WonWoff'));
                    WonWoffcount=WonWoffcount+1;
                end
                if ~isempty(strfind(response,'Don'));
                    Doncount=Doncount+1;
                end
                if ~isempty(strfind(response,'Wo')) && ~isempty(strfind(response,'Don'));
                    WoDoncount=WoDoncount+1;
                end
                if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Don'));
                    tDoncount=tDoncount+1;
                end
                if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Wo'));
                    Wotcount=Wotcount+1;
                end
                if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Wo')) && ~isempty(strfind(response,'Don'));
                    tWoDoncount=tWoDoncount+1;
                end
                if ~isempty(strfind(response,'modBgra'));
                    modBgracount=modBgracount+1;
                end
                if ~isempty(strfind(response,'mod98'));
                    mod98count=mod98count+1;
                end
                if ~isempty(strfind(response,'Rep'));
                    repcount=repcount+1;
                end
                if (~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'mod98')))
                    Bgra98count=Bgra98count+1;
                end
                if (~isempty(strfind(response,'mod98')) && ~isempty(strfind(response,'Rep')))
                    rep98count=rep98count+1;
                end
                if (~isempty(strfind(response,'Rep')) && ~isempty(strfind(response,'modBgra')))
                    repBgracount=repBgracount+1;
                end
                if ~isempty(strfind(response,'mod98')) && ~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'Rep'));
                    rhythmcount_mt3=rhythmcount_mt3+1;
                end
            end         
        end
    end
    cd(path)
end
cd(path)
filename=['count'];
disp('Rhythmmmmmmm!!!!')
rhythmcount_mt1 = modBgracount + mod98count + repcount - Bgra98count - rep98count - repBgracount + rhythmcount_mt3;
rhythmcount_mt2 = Bgra98count + rep98count + repBgracount - 2*rhythmcount_mt3;

save(filename,'Rtcount','Ltcount','RtLtcount','Touchcount','Woncount','Woffcount','WonWoffcount','Doncount','WoDoncount','tDoncount','Wotcount'...
    ,'tWoDoncount','modBgracount','mod98count','repcount','Bgra98count','rep98count','repBgracount','rhythmcount_mt1','rhythmcount_mt2','rhythmcount_mt3','Cells');