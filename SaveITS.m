function SaveITS

global ITS fname tfile FLName dpath3
tfiletrim=strtrim(tfile);
fnametrim=strtrim(fname);
FLName
if strcmp(fnametrim(end-7),'C');
    OLD=cd;
    path=[dpath3,'\R_LPhaseFolder'];
    cd(path);
    FLname=[tfiletrim(1:end-2),fnametrim(1:end-4),'ITS'];
    ITS
    save(FLname,'ITS');

    cd(OLD);
end