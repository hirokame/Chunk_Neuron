function RLphase
global  ACresult ACresultW CCresultDrinkOn SpikeArray RpegTouchallWon LpegTouchallWon TurnMarkerTime RmedianPTTM RpegMedian LmedianPTTM LpegMedian...
    RpNum LpNum  OneTurnTime CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2
bin=20;
phase1R=zeros(1,bin);
phase2R=zeros(1,bin);
phase1L=zeros(1,bin);
phase2L=zeros(1,bin);

for i=1:length(RpegTouchallWon)-1
    for j=1:length(SpikeArray)-1
        intervalR=0;
        if RpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<RpegTouchallWon(i+1);
            intervalR=RpegTouchallWon(i+1)-RpegTouchallWon(i);
            if (locsP1time<intervalR && intervalR<locsP1time2) || (locsP1time2<intervalR && intervalR<locsP1time);
                binarray1R=linspace(RpegTouchallWon(i),RpegTouchallWon(i+1),bin+1);
                for k=1:length(phase1R)-1
                    if binarray1R(k)<SpikeArray(j)&&SpikeArray(j)<binarray1R(k+1);
                        phase1R(k)=phase1R(k)+1;
                    end
                end
            else
                binarray2R=linspace(RpegTouchallWon(i),RpegTouchallWon(i+1),bin+1);
                for k=1:length(phase2R)-1
                    if binarray2R(k)<SpikeArray(j)&&SpikeArray(j)<binarray2R(k+1);
                        phase2R(k)=phase2R(k)+1;
                    end
                end
            end 
        end
    end
end
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray)-1
        intervalL=0;
        if LpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<LpegTouchallWon(i+1);
            intervalL=LpegTouchallWon(i+1)-LpegTouchallWon(i);
            if (locsP2time<intervalL && intervalL<locsP2time2) || (locsP2time2<intervalL && intervalL<locsP2time);
                binarray1L=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin+1);
                for k=1:length(phase1L)-1
                    if binarray1L(k)<SpikeArray(j)&&SpikeArray(j)<binarray1L(k+1);
                        phase1L(k)=phase1L(k)+1;
                    end
                end
            else
                 binarray2L=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin+1);
                 for k=1:length(phase2L)-1
                    if binarray2L(k)<SpikeArray(j)&&SpikeArray(j)<binarray2L(k+1);
                        phase2L(k)=phase2L(k)+1;
                    end
                end
            end
            
        end
    end
end

figure
subplot(2,2,1)
plot(linspace(0,1,bin),phase1R);
ylabel('interval');
subplot(2,2,2)
plot(linspace(0,1,bin),phase1L);
subplot(2,2,3)
plot(linspace(0,1,bin),phase2R);
xlabel('Left');
ylabel('no interval');
subplot(2,2,4)
plot(linspace(0,1,bin),phase2L);
xlabel('Right')



                   
            
         
            
            