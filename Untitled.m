% 左足反応cellウインドウ2個、右足反応cellウインドウ1個　Lウインドウ34、Rウインドウ１
WR3_90=0;
WL3_90=0;
WL4_90=0;
CountL0R0_90L23R2=0;
CountL1R0_90L23R2=0;
CountL2R0_90L23R2=0;
CountL0R1_90L23R2=0;
CountL1L2_90L23R2=0;
CountL1R1_90L23R2=0;
CountL2R1_90L23R2=0;
CountL1L2R1_90L23R2=0;
for n=1:(length(SpikeArrayWon))
    WR3_90=0;
    WL3_90=0;
    WL4_90=0;
    for i=1:(length(LpegTouchallWon))
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS2_90&SpikeArrayWon(n)+LWindowE2_90>LpegTouchallWon(i)
                WL3_90=1;
            end
            if  LpegTouchallWon(i)>SpikeArrayWon(n)+LWindowS3_90&SpikeArrayWon(n)+LWindowE3_90>LpegTouchallWon(i) 
                WL4_90=1;
            end
    end
    for j=1:(length(RpegTouchallWon))
        if  RpegTouchallWon(j)>SpikeArrayWon(n)+RWindowS2_90&SpikeArrayWon(n)+RWindowE2_90>RpegTouchallWon(j)
                WR3_90=1;
        end
    end
    
    if WL3_90==0 & WL4_90==0 & WR3_90==0
       CountL0R0_90L23R2=CountL0R0_90L23R2+1;
    end
    if WL3_90==1 & WL4_90==0 & WR3_90==0
       CountL1R0_90L23R2=CountL1R0_90L23R2+1;
    end
    if WL3_90==0 & WL4_90==1 & WR3_90==0
       CountL2R0_90L23R2=CountL2R0_90L23R2+1;
    end
    if WL3_90==0 & WL4_90==0 & WR3_90==1
       CountL0R1_90L23R2=CountL0R1_90L23R2+1;
    end
    if WL3_90==1 & WL4_90==1 & WR3_90==0
       CountL1L2_90L23R2=CountL1L2_90L23R2+1;
    end
    if WL3_90==1 & WL4_90==0 & WR3_90==1
       CountL1R1_90L23R2=CountL1R1_90L23R2+1;
    end
    if WL3_90==0 & WL4_90==1 & WR3_90==1
       CountL2R1_90L23R2=CountL2R1_90L23R2+1;
    end
    if WL3_90==1 & WL4_90==1 & WR3_90==1
       CountL1L2R1_90L23R2=CountL1L2R1_90L23R2+1;
    end
end
WcomL23R1_90=[CountL0R0_90L23R2,CountL1R0_90L23R2,CountL2R0_90L23R2,CountL0R1_90L23R2,CountL1L2_90L23R2,CountL1R1_90L23R2,CountL2R1_90L23R2,CountL1L2R1_90L23R2];
subplot(4,3,11);
bar(WcomL23R1_90)
xlabel('no L1 L2 R1 L1L2 L1R1 L2R1 L1L2R1')