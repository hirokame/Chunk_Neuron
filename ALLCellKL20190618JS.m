function ALLCellKL20190618

global EnveRLPhaseTM EnveCCresultSpikePro meanKldistDiff KldistSame dpath tfile

Oldcd=cd;
FR=[dpath,'CCSFolder'];
cd(FR);
LS=ls;
k=0;
KldistSame=[];
KldistDiff=[];
for k=1:length(LS(:,1))                                         %%%%�ق��̍זE�Ƃ̔�r
    cd(FR);
    FL=strtrim(LS(k,:));
    if length(FL)>2 && strcmp(FL(end-7:end-4),'98__');
        k=k+1;
        FL=char(FL(1:end-4));
        load(FL);
        CCresultSpike98=CCresultSpike;
C=sum(CCresultSpike98);
CCresultSpikePro=CCresultSpike98/C;
% ���ω��t�B���^�[
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgCCresultSpikePro = filter(coeff, 1, CCresultSpikePro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),CCresultSpikePro);
% ���
x = hilbert(avgCCresultSpikePro);
EnveCCresultSpikePro=abs(x);

if isnan(EnveRLPhaseTM)==0 & isnan(EnveCCresultSpikePro)==0;
dist=KLDiv(EnveRLPhaseTM,EnveCCresultSpikePro);
else
    dist=Inf;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  KlDiv�̕ۑ��@%%%%%%%%%%%%%%%%%%%%%%%
tfiletrim=strtrim(tfile);
if strcmp(tfiletrim(1:end-2),FL(4:end-5));
   KldistSame=[KldistSame dist]; 
else
   KldistDiff=[KldistDiff dist];
end
%%%%%%%%%%%%%%%%%%%

    end
end
meanKldistDiff=mean(KldistDiff);
cd(Oldcd);


