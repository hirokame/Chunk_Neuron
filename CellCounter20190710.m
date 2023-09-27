function CellCounter20190710

cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\11931_170607_98___Classify');

LS=ls;
Rtcount1=0;
Ltcount1=0;
RLtcount1=0;
Doncount1=0;
Woncount1=0;
Woffcount1=0;

Rtcount2=0;
Ltcount2=0;
RLtcount2=0;
Doncount2=0;
Woncount2=0;
Woffcount2=0;

Rtcount3=0;
Ltcount3=0;
RLtcount3=0;
Doncount3=0;
Woncount3=0;
Woffcount3=0;

for i=1:length(LS(:,1))
    FL=strtrim(LS(i,:));
    if length(FL)>4 && strcmp(FL(end-4),'1');
    Rtcount1=Rtcount1+length(strfind(FL,'Rt'));
    Ltcount1=Ltcount1+length(strfind(FL,'Lt'));
    RLtcount1=RLtcount1+length(strfind(FL,'RtLt'));
    Doncount1=Doncount1+length(strfind(FL,'Don'));
    end
    if length(FL)>4 && strcmp(FL(end-4),'2');
        Rtcount2=Rtcount2+length(strfind(FL,'Rt'));
        Ltcount2=Ltcount2+length(strfind(FL,'Lt'));
        RLtcount2=RLtcount2+length(strfind(FL,'RtLt'));
        Doncount2=Doncount2+length(strfind(FL,'Don'));
    end
    if length(FL)>4 && strcmp(FL(end-4),'3');
        Rtcount3=Rtcount3+length(strfind(FL,'Rt'));
        Ltcount3=Ltcount3+length(strfind(FL,'Lt'));
        RLtcount3=RLtcount3+length(strfind(FL,'RtLt'));
        Doncount3=Doncount3+length(strfind(FL,'Don'));
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\11941_170607_C7___Classify');
for i=1:length(LS(:,1))
    FL=strtrim(LS(i,:));
    if length(FL)>4 && strcmp(FL(end-4),'1');
    Woncount1=Woncount1+length(strfind(FL,'Won'));
    Woffcount1=Woffcount1+length(strfind(FL,'Woff'));
    end
    if length(FL)>4 && strcmp(FL(end-4),'2');
        Woncount2=Woncount1+length(strfind(FL,'Won'));
        Woffcount2=Woffcount1+length(strfind(FL,'Woff'));
    end
    if length(FL)>4 && strcmp(FL(end-4),'3');
        Woncount3=Woncount3+length(strfind(FL,'Won'));
        Woffcount3=Woffcount3+length(strfind(FL,'Woff'));
    end
end
Rtcount1
Ltcount1
RLtcount1
Doncount1
Woncount1
Woffcount1

Rtcount2
Ltcount2
RLtcount2
Doncount2
Woncount2
Woffcount2

Rtcount3
Ltcount3
RLtcount3
Doncount3
Woncount3
Woffcount3

