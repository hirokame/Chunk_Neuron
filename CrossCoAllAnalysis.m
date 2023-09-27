function CrossCoAllAnalysis

cd('C:\Users\B133_2\Desktop\CheetahData\2018-1-15_15-54-39 4301');
load 4301_180115
% load PeakTrough 
TetrodeNum
PeakMatrix
N=[];

RRp_peak=[];
B=[];
StdRRpPeak=[];
N=size(PeakMatrix);
U=N(1);
M=4;
PeakRp=[U,U];
U
DiffMaxMinRpArray
 SameT_RRppeak=[];
 SameT_RRptrough=[];
 DifT_RRppeak=[];
 DifT_RRptrough=[];
% for n=1:U
%     SpikeArray1=SpikeCell{n};
%     figure
%     for m=1:U
%         if DiffMaxMinRpArray(n)>=M && DiffMaxMinRpArray(m)>=M;
%             SpikeArray2=SpikeCell{m};
%             bin=500;
%             [CrossCoSp1Sp2]=CrossCorr(SpikeArray1',SpikeArray2,5000,0,TurnMarkerTime);%SpikeArray2‚ªbase
%             CCresultSp1Sp2=hist(CrossCoSp1Sp2,bin)/length(SpikeArray2);
%             CCresultSp1Sp2=MovWindow(CCresultSp1Sp2,5);
%             PeakRp(n,m)=PeakMatrix(n,m);
%             if n>m && TetrodeNum(n)==TetrodeNum(m)
%                 SameT_RRppeak=[SameT_RRppeak PeakMatrix(n,m)];
%                 SameT_RRptrough=[SameT_RRptrough TroughMatrix(n,m)];
%                 n
%                 m
%                 SameT_RRppeak
%             elseif n>m && TetrodeNum(n)~=TetrodeNum(m)
%                 DifT_RRppeak=[DifT_RRppeak PeakMatrix(n,m)];
%                 DifT_RRptrough=[DifT_RRptrough TroughMatrix(n,m)];
%             end
%             
%             plot(CCresultSp1Sp2,'Color',Colors(TetrodeNum(m),:),'LineWidth',3);hold on
%         elseif DiffMaxMinRpArray(n)<M || DiffMaxMinRpArray(m)<M
%             PeakRp(n,m)=0;
%         
%         end
%         
%     end
% end
% PeakRp
% SameT_RRppeak
% %BSp=triu(SameT_RRppeak);
% %BSt=triu(SameT_RRptrough);
% %BDs=triu(DifT_RRppeak);
% %BDt=triu(DifT_RRPtrough);
% %BSp=BSp(:);
% %BSt=BSt(:);
% %BDs=BDs(:);
% %BDt=BDt(:);
% %B=B(:);
% %B(B==0)=[];
% %BSp
% %BSt
% %BDs
% %BDt=BDt(:);
% %B
% 
% StdSameRRpPeak=std(abs(SameT_RRppeak-50.5))
% StdDifRRpPeak=std(abs(DifT_RRppeak-50.5))
% StdSameRRpTrough=std(abs(SameT_RRptrough-50.5))
% StdDifRRpTrough=std(abs(DifT_RRptrough-50.5))
% 

PeakRt=[U,U];
SameT_RRtpeak=[];
 SameT_RRttrough=[];
 DifT_RRtpeak=[];
 DifT_RRttrough=[];
 RythmPeakMatrix=[];
for n=1:U
    SpikeArray1=SpikeCell{n};
    figure
    for m=1:U
        if (DiffMaxMinRArray(n)>=M && DiffMaxMinRArray(m)>=M && DiffMaxMinRArray(n)~=Inf && DiffMaxMinRArray(m)~=Inf) || (DiffMaxMinLArray(n)>=M && DiffMaxMinLArray(m)>=M && DiffMaxMinLArray(n)~=Inf && DiffMaxMinLArray(m)~=Inf);
            SpikeArray2=SpikeCell{m};
            bin=500;
            [CrossCoSp1Sp2]=CrossCorr(SpikeArray1',SpikeArray2,5000,0,TurnMarkerTime);%SpikeArray2‚ªbase
            CCresultSp1Sp2=hist(CrossCoSp1Sp2,bin)/length(SpikeArray2);
            CCresultSp1Sp2=MovWindow(CCresultSp1Sp2,5);
            PeakRt(n,m)=PeakMatrix(n,m);
            if n==m
                plot(CCresultSp1Sp2,'Color',[1 1 1],'LineWidth',0.1);
                break;
            end
            if n>m && TetrodeNum(n)==TetrodeNum(m)
                SameT_RRtpeak=[SameT_RRtpeak PeakMatrix(n,m)];
                SameT_RRttrough=[SameT_RRttrough TroughMatrix(n,m)];
                figure;
                plot(CCresultSp1Sp2,'Color',Colors(TetrodeNum(m),:),'LineWidth',3);
            elseif n>m && TetrodeNum(n)~=TetrodeNum(m)
                DifT_RRtpeak=[DifT_RRtpeak PeakMatrix(n,m)];
                DifT_RRttrough=[DifT_RRttrough TroughMatrix(n,m)];
%                 figure;
%                 plot(CCresultSp1Sp2,'Color',Colors(TetrodeNum(m),:),'LineWidth',3);
            end
            if m>=2 && TetrodeNum(m)~=TetrodeNum(m-1)
                figure;
                plot(CCresultSp1Sp2,'Color',Colors(TetrodeNum(m),:),'LineWidth',3);
            end
            
            if PeakMatrix(n,m)==98
                PeakMatrix
            end
            
                n
                m
                SameT_RRtpeak
                SameT_RRttrough
                DifT_RRtpeak
                DifT_RRttrough
             RythmPeakMatrix=[RythmPeakMatrix PeakMatrix(n,m)]
            plot(CCresultSp1Sp2,'Color',Colors(TetrodeNum(m),:),'LineWidth',3);hold on
            
        elseif DiffMaxMinRArray(n)<M || DiffMaxMinRArray(m)<M
            PeakRt(n,m)=0;
        
        end
        
    end
end
% for n=1:U
%     SpikeArray1=SpikeCell{n};
%     figure
%     for m=1:U
%         if DiffMaxMinRArray(n)<=M && DiffMaxMinRArray(m)<=M && DiffMaxMinRArray(n)~=Inf && DiffMaxMinRArray(m)~=Inf && DiffMaxMinLArray(n)<=M && DiffMaxMinLArray(m)<=M && DiffMaxMinLArray(n)~=Inf && DiffMaxMinLArray(m)~=Inf;
%             SpikeArray2=SpikeCell{m};
%             bin=500;
%             [CrossCoSp1Sp2]=CrossCorr(SpikeArray1',SpikeArray2,5000,0,TurnMarkerTime);%SpikeArray2‚ªbase
%             CCresultSp1Sp2=hist(CrossCoSp1Sp2,bin)/length(SpikeArray2);
%             CCresultSp1Sp2=MovWindow(CCresultSp1Sp2,5);
%             PeakRt(n,m)=PeakMatrix(n,m);
%             if n>m && TetrodeNum(n)==TetrodeNum(m)
%                 SameT_RRtpeak=[SameT_RRtpeak PeakMatrix(n,m)];
%                 SameT_RRttrough=[SameT_RRttrough TroughMatrix(n,m)];
%                
%             elseif n>m && TetrodeNum(n)~=TetrodeNum(m)
%                 DifT_RRtpeak=[DifT_RRtpeak PeakMatrix(n,m)];
%                 DifT_RRttrough=[DifT_RRttrough TroughMatrix(n,m)];
%             end
% %             RythmPeakMatrix=[RythmPeakMatrix PeakMatrix(n,m)]
%             plot(CCresultSp1Sp2,'Color',Colors(TetrodeNum(m),:),'LineWidth',3);hold on
% %         elseif DiffMaxMinRArray(n)<M || DiffMaxMinRArray(m)<M
% %             PeakRt(n,m)=0;
% %         
%         end
%         
%     end
% end
% RythmPeakMatrix
StdSameRRtPeak=mean(abs(SameT_RRtpeak-30.5))
StdDifRRtPeak=mean(abs(DifT_RRtpeak-30.5))
StdSameRRtTrough=mean(abs(SameT_RRttrough-30.5))
StdDifRRtTrough=mean(abs(DifT_RRttrough-30.5))

save PeakTrough PeakMatrix TroughMatrix SameT_peak SameT_trough...
    DifT_peak DifT_trough DiffMaxMinRpArray DiffMaxMinLpArray DiffMaxMinRArray DiffMaxMinLArray
