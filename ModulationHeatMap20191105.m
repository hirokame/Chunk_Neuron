function ModulationHeatMaprelative20191105
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
MK=['CCSfigure'];
mkdir(MK);
CCS98=[];
CCSBgra=[];
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
            mod98CellName=[];
            modBgraCellName=[];
            CDFolder3=[CDFolder2,'\CellCell'];
            cd(CDFolder3)
            LSC=ls;
            for x=1:length(LSC(:,1));
                trimCellFolder=strtrim(LSC(x,:));
                if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                CDFolder5=[CDFolder3,'\',trimCellFolder];
                cd(CDFolder5)
                load('response.mat')
                %98でmodulationがみられた細胞名をmod98CellNameに保存
                if length(strfind(response,'mod98'))>0 ;
                   mod98CellName=[mod98CellName;trimCellFolder]; 
                end
                
                %Bgraでmodulationがみられた細胞名をmodBgraCellNameに保存
                if length(strfind(response,'modBgra'))>0 ;
                   modBgraCellName=[modBgraCellName;trimCellFolder]; 
                end
                end
            end
            
            
%             if ~isempty(mod98CellName);
            
            
            CDFolder4=[CDFolder2,'\CCSFolder'];
            cd(CDFolder4)
            LS4=ls;
            for k=1:length(LS4(:,1));
                file=strtrim(LS4(k,:));
                
                %%%%%%%%%%%%mod98CellNameにある細胞名のCCresultSpikeを保存する
                if ~isempty(mod98CellName)
                for x=1:length(mod98CellName(:,1))
                if length(file)>12 & strcmp(file((end-8):(end-4)),'_98__') & strcmp(file(4:12),mod98CellName(x,:));
                    load(file);
                    filename98=[trimFolder2,file(1:17),'.bmp'];
                    
                    
                    
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
                    CC98 = ifft(F);
                    CCS98=[CCS98;zscore(CC98)];
                    
                    
%                     figCCS98=figure;
%                     plotyy(linspace(0,1,BIN),CCresultSpike,linspace(0,1,BIN),zscore(CC98));
%                     
%                     
%                     
%                     %%%%%%%%figの保存%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Old=cd;
%                     cd([path,'\',MK]);
%                     saveas(figCCS98,filename98);
%                     cd(Old);
                end
                end
                end
                
                %%%%%%%%%%%%modBgraCellNameにある細胞名のCCresultSpikeを保存する
                if ~isempty(modBgraCellName)
                for y=1:length(modBgraCellName(:,1))
                if length(file)>12 & strcmp(file((end-8):(end-4)),'_Bgra') & strcmp(file(4:12),modBgraCellName(y,:));
                    load(file);
                    filenameBgra=[trimFolder2,file(1:17),'.bmp'];
                    
                    
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
                    CCBgra = ifft(F);
                    CCSBgra=[CCSBgra;zscore(CCBgra)];
                    
                    
%                     figCCSBgra=figure;
%                     plotyy(linspace(0,1,BIN),CCresultSpike,linspace(0,1,BIN),zscore(CCBgra));
%                     
%                     %%%%%%%%%%%%%%%%%%figの保存%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     Old=cd;
%                     cd([path,'\',MK]);
%                     saveas(figCCSBgra,filenameBgra);
%                     cd(Old);
                end
                end
                end
            end
            
%             end
            
            
            
        end
      end
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ヒートマップの作成％％％％％％％％％％％％％％％％％％％％

cd(path)
title1=['98modulation'];
title2=['Bgramodulation'];
h1=figure;
subplot(1,2,1);
h=image(CCS98,'CDataMapping','scaled');
xlabel(title1);
colorbar



subplot(1,2,2);
h=image(CCSBgra,'CDataMapping','scaled');
xlabel(title2);
colorbar
hh1=[title1,title2,'.bmp'];
saveas(h1,hh1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%phaseとintervalそれぞれ独立の並べ替え％％％％％％％％％％％％％％％％％％％％％％％％
CCS98Sort1=[];
CCSBgraSort1=[];
for i=1:length(CCS98(1,:))
    for j=1:length(CCS98(:,1))
        Row98=CCS98(j,:);
        [PeakRow98,IndexRow98]=findpeaks(Row98);
        if IndexRow98(1)==i;
        CCS98Sort1=[CCS98Sort1;Row98];
        end
    end
end

for i=1:length(CCSBgra(1,:))
    for j=1:length(CCSBgra(:,1))
        RowBgra=CCSBgra(j,:);
        [PeakRowBgra,IndexRowBgra]=findpeaks(RowBgra);
        if IndexRowBgra(1)==i;
        CCSBgraSort1=[CCSBgraSort1;RowBgra];
        end
    end
end
    
    
    
title3=['Sort1',title1];
title4=['Sort1',title2];
h2=figure;
subplot(1,2,1);
h=image(CCS98Sort1,'CDataMapping','scaled');
xlabel(title3);
colorbar


subplot(1,2,2);
h=image(CCSBgraSort1,'CDataMapping','scaled');
xlabel(title4);
colorbar
title('独立の並べ替え');
hh2=[title3,title4,'.bmp'];
saveas(h2,hh2);
OneTurnTimeSave20191113
ModulationHeatMapAbs20191105






function OneTurnTimeSave20191113

path=['C:\Users\C238\Desktop\CheetahWRLV20180729Part1'];
cd(path)
OneTurnTime98=[];
OneTurnTimebgra=[];
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
           LS3=ls;
           for k=1:length(LS3(:,1));
               trimFolder3=strtrim(LS3(k,:));
               if length(trimFolder3)>5 & strcmp(trimFolder3((end-4):(end)),'_98__');
                  CDFolder3=[CDFolder2,'\',trimFolder3];
                  cd(CDFolder3)
                  load('Bdata.mat')
                  OneTurnTime98=OneTurnTime;
               end
               if length(trimFolder3)>5 & strcmp(trimFolder3((end-4):(end)),'_Bgra');
                  CDFolder3=[CDFolder2,'\',trimFolder3];
                  cd(CDFolder3)
                  load('Bdata.mat')
                  OneTurnTimeBgra=OneTurnTime;
               end
           end
           CDFolder4=[CDFolder2,'\CellCell'];
           cd(CDFolder4)
           FLname=['OneTurnTime','.mat'];
           save(FLname,'OneTurnTime98','OneTurnTimeBgra');
            
        end
      end
   end
end

function ModulationHeatMapAbs20191105

path=['C:\Users\C238\Desktop\CheetahWRLV20180729Part1'];


cd(path)
CCS98=[];
CCSBgra=[];
% Folder=['Celldaydata'];
% mkdir(Folder)
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
            mod98CellName=[];
            modBgraCellName=[];
            CDFolder3=[CDFolder2,'\CellCell'];
            cd(CDFolder3)
            load('OneTurnTime.mat')
            Time98=OneTurnTime98;
            TimeBgra=OneTurnTimeBgra;
            LSC=ls;
            for x=1:length(LSC(:,1));
                trimCellFolder=strtrim(LSC(x,:));
                if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                CDFolder5=[CDFolder3,'\',trimCellFolder];
                cd(CDFolder5)
                load('response.mat')
                %98でmodulationがみられた細胞名をmod98CellNameに保存
                if 3900<Time98 & Time98<4100 & length(strfind(response,'mod98'))>0 ;
                   mod98CellName=[mod98CellName;trimCellFolder];
%                    Old=cd;
%                    CD=[path,'\Celldaydata'];
%                    cd(CD)
%                    Folder1=[trimFolder2,'/98'];
%                    mkdir(Folder1);
%                    cd(Old)
                end
                
                %Bgraでmodulationがみられた細胞名をmodBgraCellNameに保存
                if 3900<TimeBgra & TimeBgra<4100 & length(strfind(response,'modBgra'))>0 ;
                   modBgraCellName=[modBgraCellName;trimCellFolder]; 
%                    Old=cd;
%                    CD=[path,'\Celldaydata'];
%                    cd(CD)
%                    Folder1=[trimFolder2,'/Bgra'];
%                    mkdir(Folder1);
%                    cd(Old)
                end
                end
            end
            
            
            if ~isempty(mod98CellName);
            
            
            CDFolder4=[CDFolder2,'\CCSFolder'];
            cd(CDFolder4)
            LS4=ls;
            for k=1:length(LS4(:,1));
                file=strtrim(LS4(k,:));
                
                %mod98CellNameにある細胞名のCCresultSpikeを保存する
                if ~isempty(mod98CellName)
                for x=1:length(mod98CellName(:,1))
                if length(file)>12 & strcmp(file((end-8):(end-4)),'_98__') & strcmp(file(4:12),mod98CellName(x,:));
                    load(file);
%                     CC98=findpeaks(CCresultSpike,'MinPeakDistance',30);
                    %Low-Pass　filter 2Hzの抽出
                     Fs = 1000; % サンプリング周波数
                    t = linspace(0,1,1000); % 時間ベクトル
                    x = CCresultSpike; % 時間軸信号

                    F = fft(2*abs(x).^2);
                    f = Fs * [0:length(F)-1] / length(F);
                    F( f>2 & f< (Fs-2) ) = 0;
                    CC98 = ifft(F);
%                     figure
%                     plot(t,x,t,sqrt(CCS98));
                    CCS98=[CCS98;zscore(CC98)];
%                     fig98=figure
%                     plot(linspace(0,1,1000),CCresultSpike);
%                     Old=cd;
%                     CD1=[path,'\Celldaydata\',trimFolder2,'/98'];
%                     cd(CD1)
%                     Cellname98=mod98CellName(x,:);
%                     figname98=['98',Cellname98];
%                     saveas(fig98,figname98);
%                     cd(Old)
                end
                end
                end
                
                %modBgraCellNameにある細胞名のCCresultSpikeを保存する
                if ~isempty(modBgraCellName)
                for y=1:length(modBgraCellName(:,1))
                if length(file)>12 & strcmp(file((end-8):(end-4)),'_Bgra') & strcmp(file(4:12),modBgraCellName(y,:));
                    load(file);
%                     CCBgra=findpeaks(CCresultSpike,'MinPeakDistance',30);
                     Fs = 1000; % サンプリング周波数
                    t = linspace(0,1,1000); % 時間ベクトル
                    x = CCresultSpike; % 時間軸信号

                    F = fft(2*abs(x).^2);
                    f = Fs * [0:length(F)-1] / length(F);
                    F( f>2 & f< (Fs-2) ) = 0;
                    CCBgra = ifft(F);
%                     figure
%                     plot(t,x,t,sqrt(CCS98));

                    CCSBgra=[CCSBgra;zscore(CCBgra)];
%                     figBgra=figure
%                     plot(linspace(0,1,1000),CCresultSpike);
%                     Old=cd;
%                     CD1=[path,'\Celldaydata\',trimFolder2,'/Bgra'];
%                     cd(CD1)
%                     CellnameBgra=modBgraCellName(y,:);
%                     fignameBgra=['Bgra',CellnameBgra];
%                     saveas(figBgra,fignameBgra);
%                     cd(Old)
                end
                end
                end
            end
            
            end
            
            
            
        end
      end
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ヒートマップの作成％％％％％％％％％％％％％％％％％％％％

cd(path)
title5=['98modulation4s'];
title6=['Bgramodulation4s'];
h3=figure;
subplot(1,2,1);
h=image(CCS98,'CDataMapping','scaled');
xlabel(title5);
colorbar



subplot(1,2,2);
h=image(CCSBgra,'CDataMapping','scaled');
xlabel(title6);
colorbar
hh3=[title5,title6,'.bmp'];
saveas(h3,hh3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%phaseとintervalそれぞれ独立の並べ替え％％％％％％％％％％％％％％％％％％％％％％％％
CCS98Sort1=[];
CCSBgraSort1=[];
for i=1:length(CCS98(1,:))
    for j=1:length(CCS98(:,1))
        Row98=CCS98(j,:);
        [PeakRow98,IndexRow98]=findpeaks(Row98);
        if IndexRow98(1)==i;
        CCS98Sort1=[CCS98Sort1;Row98];
        end
    end
end

for i=1:length(CCSBgra(1,:))
    for j=1:length(CCSBgra(:,1))
        RowBgra=CCSBgra(j,:);
        [PeakRowBgra,IndexRowBgra]=findpeaks(RowBgra);
        if IndexRowBgra(1)==i;
        CCSBgraSort1=[CCSBgraSort1;RowBgra];
        end
    end
end
    
    
    
title7=['Sort1',title5];
title8=['Sort1',title6];
h4=figure;
subplot(1,2,1);
h=image(CCS98Sort1,'CDataMapping','scaled');
xlabel(title7);
colorbar


subplot(1,2,2);
h=image(CCSBgraSort1,'CDataMapping','scaled');
xlabel(title8);
colorbar
title('独立の並べ替え');
hh4=[title7,title8,'.bmp'];
saveas(h4,hh4);