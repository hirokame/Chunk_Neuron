function Pattern=PegPattrn(fname)

Name=fname(end-7:end-4);

if strcmp(Name,'A___');
    Pattern=1;
elseif strcmp(Name,'B___');
    Pattern=2;
elseif strcmp(Name,'98__');
    Pattern=3;
elseif strcmp(Name,'89__');
    Pattern=4;
elseif strcmp(Name,'Agra');
    Pattern=5;
elseif strcmp(Name,'Bgra');
    Pattern=6;
elseif strcmp(Name,'C3__');
    Pattern=7;
elseif strcmp(Name,'C7__');
    Pattern=8;
elseif strcmp(Name,'C9__');
    Pattern=9;
elseif strcmp(Name,'C10_');
    Pattern=10;
elseif strcmp(Name,'C3+');
    Pattern=11;
elseif strcmp(Name,'C7+_');
    Pattern=12;
elseif strcmp(Name,'C9+_');
    Pattern=13;
elseif strcmp(Name,'C10+');
    Pattern=14;
else
    Pattern=99;
end
    