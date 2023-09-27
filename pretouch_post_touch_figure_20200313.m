function pretouch_post_touch_figure_20200313


path=['G:\CheetahWRLV20200121\119\2017-6-7_20-8-33 11901-51_0\11941_170607_C7__'];
cd(path)
CDFolder2=['G:\CheetahWRLV20200121\119\2017-6-7_20-8-33 11901-51_0'];
tfile=['Sc4_SS_01.t'];

SpikeArray=GetSpikeAll(CDFolder2,tfile);

file=['Bdata.mat'];
                        load(file);
                        SpikeArray=GetSpikeAll(CDFolder2,tfile);
                        SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                        %WaterOnのときのみのスパイク
                        if ~isempty(SpikeArray)
                        SpikeWon=ones(1,length(SpikeArray));
                        for k=1:length(SpikeArray)
                            if OnWater(SpikeArray(k))==0
                                SpikeWon(k)=0;
                            end
                        end
                        SpikeArrayWon=SpikeArray.*SpikeWon;
                        SpikeArrayWon(SpikeArrayWon==0)=[];
                        
                        end
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
                        
                        
%%%pretouch

bin=20;
OnestepSpikeArray2R=[];
OnestepSpikeArrayAll2R=[];
for i=1:length(RpegTouchallWon)-1
    OnestepSpikeArray2R=[];
    OnestepSpikeArray2R=SpikeArrayWon(RpegTouchallWon(i)<SpikeArrayWon & SpikeArrayWon<RpegTouchallWon(i+1));
    OnestepSpikeArray2R=OnestepSpikeArray2R-RpegTouchallWon(i);
    OnestepSpikeArrayAll2R=[OnestepSpikeArrayAll2R,OnestepSpikeArray2R];
end
OnestepSpikeArrayAll2R=OnestepSpikeArrayAll2R(OnestepSpikeArrayAll2R<800);

phaseR=hist(OnestepSpikeArrayAll2R,bin);


OnestepSpikeArray2L=[];
OnestepSpikeArrayAll2L=[];
for i=1:length(LpegTouchallWon)-1
    OnestepSpikeArray2L=[];
    OnestepSpikeArray2L=SpikeArrayWon(LpegTouchallWon(i)<SpikeArrayWon & SpikeArrayWon<LpegTouchallWon(i+1));
    OnestepSpikeArray2L=OnestepSpikeArray2L-LpegTouchallWon(i);
    OnestepSpikeArrayAll2L=[OnestepSpikeArrayAll2L,OnestepSpikeArray2L];
end
OnestepSpikeArrayAll2L=OnestepSpikeArrayAll2L(OnestepSpikeArrayAll2L<800);

M=max(OnestepSpikeArrayAll2L);
phaseL=hist(OnestepSpikeArrayAll2L,bin);


figpre=figure;%off
subplot(2,1,1)%off
plot(linspace(0,1,length(phaseR)),phaseR,'color','b');
subplot(2,1,2)
plot(linspace(0,1,length(phaseL)),phaseL,'color','r');%off


%%%%%%posttouch

bin=20;
OnestepSpikeArrayR=[];
OnestepSpikeArrayAllR=[];
for i=1:length(RpegTouchallWon)-1
    OnestepSpikeArrayR=[];
    OnestepSpikeArrayR=SpikeArrayWon(RpegTouchallWon(i)<SpikeArrayWon & SpikeArrayWon<RpegTouchallWon(i+1));
    OnestepSpikeArrayR=OnestepSpikeArrayR-RpegTouchallWon(i+1);
    OnestepSpikeArrayAllR=[OnestepSpikeArrayAllR,OnestepSpikeArrayR];
end

% edges=linspace(0,500,bin+1);

OnestepSpikeArrayAllR=OnestepSpikeArrayAllR(OnestepSpikeArrayAllR>-800);

phaseR=hist(OnestepSpikeArrayAllR,bin);





OnestepSpikeArrayL=[];
OnestepSpikeArrayAllL=[];
for i=1:length(LpegTouchallWon)-1
    OnestepSpikeArrayL=[];
    OnestepSpikeArrayL=SpikeArrayWon(LpegTouchallWon(i)<SpikeArrayWon & SpikeArrayWon<LpegTouchallWon(i+1));
    OnestepSpikeArrayL=OnestepSpikeArrayL-LpegTouchallWon(i+1);
    OnestepSpikeArrayAllL=[OnestepSpikeArrayAllL,OnestepSpikeArrayL];
end

OnestepSpikeArrayAllL=OnestepSpikeArrayAllL(OnestepSpikeArrayAllL>-800);

M=max(OnestepSpikeArrayAllL);
phaseL=hist(OnestepSpikeArrayAllL,bin);
                       
figpost=figure;%off
subplot(2,1,1)%off
plot(linspace(0,1,length(phaseR)),phaseR,'color','b');
subplot(2,1,2)
plot(linspace(0,1,length(phaseL)),phaseL,'color','r');%off


fignamepre=['pre-element',tfile(1:end-2),'.bmp'];
fignamepost=['post-element',tfile(1:end-2),'.bmp'];

cd('C:\Users\C238\Desktop\terashita\figure');

saveas(figpre,fignamepre);
saveas(figpost,fignamepost);
                        