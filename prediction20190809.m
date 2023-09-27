function prediction20190809
%それぞれの仮説における書くピークのずれと包絡線のJSDをまとめて統計検定(脚どりに反応した細胞だけで)
%CheetahWRLV20190703はCheetahWRLV20180729の中から98or89とcomplexを走った日だけを抜き出したFolder
path=['C:\Users\C238\CheetahWRLV20220213'];


cd(path)

Xerror=[];
Envedist=[];



LS1=ls;
for i=1:length(LS1(:,1))
    trimFolder=strtrim(LS1(i,:));
    if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') & isempty(strfind(trimFolder,'.bmp')) & ~strcmp(trimFolder,'CCSfigure') & isempty(strfind(trimFolder,'.fig'))...
            & isempty(strfind(trimFolder,'.mat')) && isempty(strfind(trimFolder,'.xlsx'));
        CDFolder=[path,'\',trimFolder];
        cd(CDFolder);
        LS2=ls;
        for j=1:length(LS2(:,1))
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4;
                CDFolder2=[CDFolder,'\',trimFolder2];
                cd(CDFolder2)
                TouchCellName=[];
                CDFolder3=[CDFolder2,'\CellCell2'];
                cd(CDFolder3)
                LSC=ls;
                for x=1:length(LSC(:,1));
                    trimCellFolder=strtrim(LSC(x,:));
                    if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                        CDFolder5=[CDFolder3,'\',trimCellFolder];
                        cd(CDFolder5)
                        load('response.mat')
                        if length(strfind(response,'MSN'))>0;
                            if length(strfind(response,'Rt'))>0 | length(strfind(response,'Lt'))>0;
                                TouchCellName=[TouchCellName;trimCellFolder];
                            end
                        end
                    end
                end

                if ~isempty(TouchCellName);
                    CDFolder4=[CDFolder2,'\predict'];
                    cd(CDFolder4)
                    LS4=ls;
                    for k=1:length(LS4(:,1));
                        trimFile1=strtrim(LS4(k,:));
                        for y=1:length(TouchCellName(:,1))
                            if length(trimFile1)>4 && strcmp(trimFile1(end-7),'C') && strcmp(trimFile1(1:9),TouchCellName(y,:));
                                load(trimFile1)
                                Xerror=[Xerror;XerrorArray];
                                Envedist=[Envedist;EnvedistArray];
                            end
                        end
                    end
                end
            end
        end
    end
end

length(Xerror(:,1))


figure
boxplot(Xerror);
title('Xerror');

figure
boxplot(Envedist);
title('Envedist');


[p1,tbl1,stats1] = anova1(Xerror);
[p2,tbl2,stats2] = anova1(Envedist);
p1
p2
stats1
stats2
PeakErrorfig=figure;
[c1,m1,h1,nms1] = multcompare(stats1);%tukey-kramer検定
xlabel('PeakError C');
JSDfig=figure;
[c2,m2,h2,nms2] = multcompare(stats2);%%tukey-kramer検定
xlabel('JSD C');

cd(path)
figname1=['PeakErrorC','.bmp'];
figname2=['JSDC', '.bmp'];

saveas(PeakErrorfig,figname1);
saveas(JSDfig,figname2);

MeansXerror= getfield(stats1,'means') ;
errXerror=std(Xerror,'omitnan')/sqrt(length(Xerror(:,1)));
MeansEnvedist=getfield(stats2,'means') ;
errEnvedist=std(Envedist,'omitnan')/sqrt(length(Envedist(:,1)));


% statfigXerror=figure;
% bar(MeansXerror,0.5);
% statfigEnvedist=figure;
% bar(MeansEnvedist,0.5);

x=1:6;
statfigXerror=figure;
bar(x,MeansXerror,0.5);hold on
errorbar(x,MeansXerror,errXerror,'o','MarkerSize',0.2);

statfigEnvedist=figure;
bar(x,MeansEnvedist,0.5);hold on
errorbar(x,MeansEnvedist,errEnvedist,'o','MarkerSize',0.2);


figname3=['statfigXerror','.bmp'];
figname4=['statfigEnvedist', '.bmp'];

saveas(statfigXerror,figname3);
saveas(statfigEnvedist,figname4);




