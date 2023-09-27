function RLTouchPhase190513
%左足のタッチの間にスパイクがあったとき左足のタッチの中でどこに右タッチがあったか
global  SpikeArray RpegTouchall LpegTouchall TurnMarkerTime OneTurnTime OnWater fname tfile R_LPhaseindex



% cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
% dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% % data=load([dpath '15103_190313_98__'],'-ascii');
% dpath3
% load 11941_170607_C7__\Bdata


%WaterOnのときのみのRpegTouchall
    if ~isempty(RpegTouchall)
        RTWon=ones(1,length(RpegTouchall));
        for k=1:length(RpegTouchall)
            if OnWater(RpegTouchall(k))==0
                RTWon(k)=0;
            end
        end
        RpegTouchallWon=RpegTouchall.*RTWon;
        RpegTouchallWon(RpegTouchallWon==0)=[];
        RpegTouchallWoff=RpegTouchall.*not(RTWon);
        RpegTouchallWoff(RpegTouchallWoff==0)=[];
    else
        RpegTouchallWon=0;
        RpegTouchallWoff=0;
    end
%WaterOnのときのみのLpegTouchall
    if ~isempty(LpegTouchall)
        LTWon=ones(1,length(LpegTouchall));
        for k=1:length(LpegTouchall)
            if OnWater(LpegTouchall(k))==0
                LTWon(k)=0;
            end
        end
        LpegTouchallWon=LpegTouchall.*LTWon;
        LpegTouchallWon(LpegTouchallWon==0)=[];
        LpegTouchallWoff=LpegTouchall.*not(LTWon);
        LpegTouchallWoff(LpegTouchallWoff==0)=[];
    else
        LpegTouchallWon=0;
        LpegTouchallWoff=0;
    end



bin1=20;
phaseR_L=zeros(1,bin1);
for i=1:length(LpegTouchallWon)-1
    for x=1:length(SpikeArray)
    if LpegTouchallWon(i)<SpikeArray(x) && LpegTouchallWon(i+1)>SpikeArray(x)
    for j=1:length(RpegTouchallWon)-1
        if LpegTouchallWon(i)<RpegTouchallWon(j)&&RpegTouchallWon(j)<LpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayR_L=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);   %%タッチ間をbin1の数に分割
           for k=1:length(phaseR_L)-1
               if binarrayR_L(k)<RpegTouchallWon(j)&&RpegTouchallWon(j)<binarrayR_L(k+1);  %%どのビンでスパイクがあったか
                   phaseR_L(k)=phaseR_L(k)+1;
               end
           end
        end
    end
    end
    end
end

linR_L=linspace(0,1,bin1+1);
s=figure;
plot(linR_L(1:length(phaseR_L)),phaseR_L);
figname=[tfile(1:end-2), 'phaseR_L','.bmp'];
saveas(s,figname);
close;

R_LPhaseCell=[phaseR_L;linR_L(1:length(phaseR_L))];

[MR_L locsMR_L]=max(phaseR_L);

R_LPhaseindex=R_LPhaseCell(2,locsMR_L);





