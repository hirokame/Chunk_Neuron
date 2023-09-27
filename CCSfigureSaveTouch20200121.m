function CCSfigureSaveTouch20200121
% Fs = 1000; % サンプリング周波数
% t = 0:1/Fs:1; % 時間ベクトル
% x = sin(2*pi*5*t) .* sin(2*pi*100*t); % 時間軸信号
% 
% F = fft(2*abs(x).^2);
% f = Fs * [0:length(F)-1] / length(F);
% F( f>10 & f< (Fs-10) ) = 0;
% y = ifft(F);
% plot(t,x,t,sqrt(y))
path=['C:\Users\C238\Desktop\CheetahWRLV20180729Part1'];

cd(path)
MK1=['CCSfigure-Rt'];
MK2=['CCSfigure-Lt'];
MK3=['CCSfigure-RLt'];
mkdir(MK1);
mkdir(MK2);
mkdir(MK3);
CCSRt=[];
CCSLt=[];
CCSRLt=[];
ITSRALL=[];
ITSLALL=[];

BIN=1000;
LS1=ls;
for i=1:length(LS1(:,1))
   trimFolder=strtrim(LS1(i,:));
   if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && length(trimFolder)<5;
       CDFolder=[path,'\',trimFolder];
      cd(CDFolder);
      LS2=ls;
      for j=1:length(LS2(:,1))
        trimFolder2=strtrim(LS2(j,:));
        if length(trimFolder2)>4 & ~strcmp(trimFolder2(end-3:end),'.mat');
            CDFolder2=[CDFolder,'\',trimFolder2];
            cd(CDFolder2)
            RTouchCellName=[];
            LTouchCellName=[];
            RLTouchCellName=[];
            LSLS=ls;
            complexcount=0;
            for t=1:length(LSLS(:,1))
                trim=strtrim(LSLS(t,:));
                if length(trim)>4 && strcmp(trim(end-3:end),'.mat') && strcmp(trim(end-7),'C');
                   complexcount=complexcount+1; 
                end
            end
            if complexcount>1;
            CDFolder3=[CDFolder2,'\CellCell'];
            cd(CDFolder3)
            LSC=ls;
            for x=1:length(LSC(:,1));
                trimCellFolder=strtrim(LSC(x,:));
                if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                CDFolder5=[CDFolder3,'\',trimCellFolder];
                cd(CDFolder5)
                load('response.mat')
                %Rtに反応した細胞名をRtouchNameに保存
                if length(strfind(response,'Rt'))>0 ;
                   RTouchCellName=[RTouchCellName;trimCellFolder]; 
                end
                
                %Ltに反応した細胞名をLTouchCellNameに保存
                if length(strfind(response,'Lt'))>0 ;
                   LTouchCellName=[LTouchCellName;trimCellFolder]; 
                end
                
                %RtLtの両方に反応した細胞名をRLTouchCellNameに保存
                if length(strfind(response,'Lt'))>0 && length(strfind(response,'Rt'))>0;
                   RLTouchCellName=[RLTouchCellName;trimCellFolder]; 
                end
                
                end
            end
            
            
%             if ~isempty(mod98CellName);
            
            
            CDFolder4=[CDFolder2,'\CCSFolder'];
            cd(CDFolder4)
            LS4=ls;
            for k=1:length(LS4(:,1));
                file=strtrim(LS4(k,:));
                
                %%%%%%%%%%%%RTouchCellNameにある細胞名のCCresultSpikeを保存する
                if ~isempty(RTouchCellName)
                for x=1:length(RTouchCellName(:,1))
                if length(file)>12 & strcmp(file((end-8):(end-4)),'_98__') & strcmp(file(4:12),RTouchCellName(x,:));
                    load(file);
                    filenameRt=[trimFolder2,file(1:17),'.bmp'];
                    
                    
                    
%                     Old=cd;
%                     cd([path,'\',MK]);
%                     saveas(figCCS98,filename98);
%                     cd(Old);
%                     CC98=findpeaks(CCresultSpike,'MinPeakDistance',30);



                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Low-Pass　filter 2Hzの抽出%%%%%%%%%%%%%%%%%%%%%%%                     
                     Fs = 1000; % サンプリング周波数
                    t = linspace(0,1,1000); % 時間ベクトル
                    x = CCresultSpike; % 時間軸信号

                    F = fft(2*abs(x).^2);
                    f = Fs * [0:length(F)-1] / length(F);
                    F( f>2 & f< (Fs-2) ) = 0;
                    CCRt = ifft(F);
                    CCSRt=[CCSRt;zscore(CCRt)];
                    
                    
                    figCCSRt=figure;
                    plotyy(linspace(0,1,BIN),CCresultSpike,linspace(0,1,BIN),zscore(CCRt));
                    
                    
                    
                    %%%%%%%%figの保存%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    Old=cd;
                    cd([path,'\',MK1]);
                    saveas(figCCSRt,filenameRt);
                    cd(Old);
                end
                end
                end
                
                %%%%%%%%%%%%LTouchCellNameにある細胞名のCCresultSpikeを保存する
                if ~isempty(LTouchCellName)
                for y=1:length(LTouchCellName(:,1))
                if length(file)>12 & strcmp(file((end-8):(end-4)),'_98__') & strcmp(file(4:12),LTouchCellName(y,:));
                    load(file);
                    filenameLt=[trimFolder2,file(1:17),'.bmp'];
                    
                    
%                     Old=cd;
%                     cd([path,'\',MK]);
%                     saveas(figCCSBgra,filenameBgra);
%                     cd(Old);
%                     CCBgra=findpeaks(CCresultSpike,'MinPeakDistance',30);


                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Low-Pass　filter 2Hzの抽出%%%%%%%%%%%%%%%%%%%%%%%                     
                     Fs = 1000; % サンプリング周波数
                    t = linspace(0,1,1000); % 時間ベクトル
                    x = CCresultSpike; % 時間軸信号

                    F = fft(2*abs(x).^2);
                    f = Fs * [0:length(F)-1] / length(F);
                    F( f>2 & f< (Fs-2) ) = 0;
                    CCLt = ifft(F);
                    CCSLt=[CCSLt;zscore(CCLt)];
                    
                    
                    figCCSLt=figure;
                    plotyy(linspace(0,1,BIN),CCresultSpike,linspace(0,1,BIN),zscore(CCLt));
                    
                    %%%%%%%%%%%%%%%%%%figの保存%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    Old=cd;
                    cd([path,'\',MK2]);
                    saveas(figCCSLt,filenameLt);
                    cd(Old);
                end
                end
                end
                
                
                %%%%%%%%%%%%RLTouchCellNameにある細胞名のCCresultSpikeを保存する
                if ~isempty(RLTouchCellName)
                for y=1:length(RLTouchCellName(:,1))
                if length(file)>12 & strcmp(file((end-8):(end-4)),'_98__') & strcmp(file(4:12),RLTouchCellName(y,:));
                    load(file);
                    filenameRLt=[trimFolder2,file(1:17),'.bmp'];
                    
                    
%                     Old=cd;
%                     cd([path,'\',MK]);
%                     saveas(figCCSBgra,filenameBgra);
%                     cd(Old);
%                     CCBgra=findpeaks(CCresultSpike,'MinPeakDistance',30);


                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Low-Pass　filter 2Hzの抽出%%%%%%%%%%%%%%%%%%%%%%%                     
                     Fs = 1000; % サンプリング周波数
                    t = linspace(0,1,1000); % 時間ベクトル
                    x = CCresultSpike; % 時間軸信号

                    F = fft(2*abs(x).^2);
                    f = Fs * [0:length(F)-1] / length(F);
                    F( f>2 & f< (Fs-2) ) = 0;
                    CCRLt = ifft(F);
                    CCSRLt=[CCSRLt;zscore(CCRLt)];
                    
                    
                    figCCSRLt=figure;
                    plotyy(linspace(0,1,BIN),CCresultSpike,linspace(0,1,BIN),zscore(CCRLt));
                    
                    %%%%%%%%%%%%%%%%%%figの保存%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    Old=cd;
                    cd([path,'\',MK3]);
                    saveas(figCCSRLt,filenameRLt);
                    cd(Old);
                end
                end
                end
            end
            
            
            
            
            end
%             end
            
            
            
        end
      end
   end
end
