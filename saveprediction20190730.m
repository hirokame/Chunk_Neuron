function saveprediction20190730
%予測値と実測値を比較してピークのずれと包絡線のJSDの値の平均を配列（仮説6個分）にしてpredictフォルダに保存
global meanXaxiserror1 Envedist1 meanXaxiserror2 Envedist2 meanXaxiserror3 Envedist3 meanXaxiserror4 Envedist4 meanXaxiserror5 Envedist5 tfile...
    meanXaxiserror6 Envedist6 FLName dpath3
OLD=cd;
XerrorArray=[meanXaxiserror1 meanXaxiserror2 meanXaxiserror3 meanXaxiserror4 meanXaxiserror5 meanXaxiserror6];
EnvedistArray=[Envedist1 Envedist2 Envedist3 Envedist4 Envedist5 Envedist6];


prediction=[XerrorArray;EnvedistArray];

trimtfile=strtrim(tfile);

filename=[trimtfile(1:(end-2)),'prediction20190730',FLName((end-4):end)];


cd(dpath3)
Folder=['predict'];
mkdir(Folder);
CD=[dpath3,'\',Folder];
cd(CD)
save(filename,'XerrorArray','EnvedistArray');

cd(OLD)