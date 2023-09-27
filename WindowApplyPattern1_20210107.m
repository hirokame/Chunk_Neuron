function WindowApplyPattern1_20210107

global RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit LtPositiveSpikeOnKaisuuP1 RtPositiveSpikeOnKaisuuP1...
    LtPositiveHistogramXaxisP1 RtPositiveHistogramXaxisP1 LtPositiveFiringRateP1 RtPositiveFiringRateP1

LtPositiveSpikeOnKaisuuP1=zeros(1,2);%%%%%%%ウィンドウに何回当てはまったか
LtPositiveHistogramXaxisP1=zeros(1,2);  %%%%% Positiveヒストグラムを作成する際の発火頻度（初期値ゼロ）２要素（2個以下、3個以上）
%%%%%%Ltouch
%%%%%positive
LtouchPositive5windowPointSpikeOnP1=LtouchSpikeOnUnit(:,(1:6));%%%% 発火数とPOsitiveだけ抜き出す
for i=1:length(LtouchPositive5windowPointSpikeOnP1(:,1))
    IndexSpikeOnPositive=find(LtouchPositive5windowPointSpikeOnP1(i,(2:6))==1);
    
    
    if length(IndexSpikeOnPositive)==5;  %%%%%ウィンドウに当てはまった回数が5回の場合
        LtPositiveSpikeOnKaisuuP1(2)=LtPositiveSpikeOnKaisuuP1(2)+1;
        LtPositiveHistogramXaxisP1(2)=LtPositiveHistogramXaxisP1(2)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==4;  %%%%%ウィンドウに当てはまった回数が4回の場合
        LtPositiveSpikeOnKaisuuP1(2)=LtPositiveSpikeOnKaisuuP1(2)+1;
        LtPositiveHistogramXaxisP1(2)=LtPositiveHistogramXaxisP1(2)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==3;  %%%%%ウィンドウに当てはまった回数が3回の場合
        LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
        LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==2;  %%%%%ウィンドウに当てはまった回数が2回の場合
        LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
        LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==1;  %%%%%ウィンドウに当てはまった回数が1回の場合
        LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
        LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==0;  %%%%%ウィンドウに当てはまった回数が0回の場合
        LtPositiveSpikeOnKaisuuP1(1)=LtPositiveSpikeOnKaisuuP1(1)+1;
        LtPositiveHistogramXaxisP1(1)=LtPositiveHistogramXaxisP1(1)+LtouchPositive5windowPointSpikeOnP1(i,1);
    end
end

LtPositiveSpikeOffKaisuuP1=zeros(1,2);
%%%%%%%Positive  Spikeoff
LtouchPositive5windowPointSpikeOffP1=LtouchSpikeOffUnit(:,(1:5));%%%% Positiveだけ抜き出す
for i=1:length(LtouchPositive5windowPointSpikeOffP1(:,1))
    IndexSpikeOffPositive=find(LtouchPositive5windowPointSpikeOffP1(i,(1:5))==1);
    
    if length(IndexSpikeOffPositive)==5;   %%%%ウィンドウに当てはまった回数が5回の場合
       LtPositiveSpikeOffKaisuuP1(2)=LtPositiveSpikeOffKaisuuP1(2)+1;
    end
    
    if  length(IndexSpikeOffPositive)==4;%%%%ウィンドウに当てはまった回数が4回の場合
        LtPositiveSpikeOffKaisuuP1(2)=LtPositiveSpikeOffKaisuuP1(2)+1;
    end
    
    if length(IndexSpikeOffPositive)==3;%%%%ウィンドウに当てはまった回数が3回の場合 
       LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==2;%%%%ウィンドウに当てはまった回数が2回の場合 
       LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==1;%%%%ウィンドウに当てはまった回数が1回の場合 
       LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==0;%%%%ウィンドウに当てはまった回数が0回の場合 
       LtPositiveSpikeOffKaisuuP1(1)=LtPositiveSpikeOffKaisuuP1(1)+1;
    end
end

RtPositiveSpikeOnKaisuuP1=zeros(1,2);%%%%%%%ウィンドウに何回当てはまったか
RtPositiveHistogramXaxisP1=zeros(1,2);  %%%%% Positiveヒストグラムを作成する際の発火頻度（初期値ゼロ）６要素（0個、1個、2個、3個、4個、5個）
%%%%%%Rtouch
%%%%%positive
RtouchPositive5windowPointSpikeOnP1=RtouchSpikeOnUnit(:,(1:6));%%%% 発火数とPOsitiveだけ抜き出す
for i=1:length(RtouchPositive5windowPointSpikeOnP1(:,1))
    IndexSpikeOnPositive=find(RtouchPositive5windowPointSpikeOnP1(i,(2:6))==1);
    if length(IndexSpikeOnPositive)==5;  %%%%%ウィンドウに当てはまった回数が5回の場合
        RtPositiveSpikeOnKaisuuP1(2)=RtPositiveSpikeOnKaisuuP1(2)+1;
        RtPositiveHistogramXaxisP1(2)=RtPositiveHistogramXaxisP1(2)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==4;  %%%%%ウィンドウに当てはまった回数が4回の場合
        RtPositiveSpikeOnKaisuuP1(2)=RtPositiveSpikeOnKaisuuP1(2)+1;
        RtPositiveHistogramXaxisP1(2)=RtPositiveHistogramXaxisP1(2)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==3;  %%%%%ウィンドウに当てはまった回数が3回の場合
        RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
        RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==2;  %%%%%ウィンドウに当てはまった回数が2回の場合
        RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
        RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==1;  %%%%%ウィンドウに当てはまった回数が1回の場合
        RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
        RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
    
    if length(IndexSpikeOnPositive)==0;  %%%%%ウィンドウに当てはまった回数が0回の場合
        RtPositiveSpikeOnKaisuuP1(1)=RtPositiveSpikeOnKaisuuP1(1)+1;
        RtPositiveHistogramXaxisP1(1)=RtPositiveHistogramXaxisP1(1)+RtouchPositive5windowPointSpikeOnP1(i,1);
    end
end

RtPositiveSpikeOffKaisuuP1=zeros(1,2);
%%%%%%%Positive  Spikeoff
RtouchPositive5windowPointSpikeOffP1=RtouchSpikeOffUnit(:,(1:5));%%%% POsitiveだけ抜き出す
for i=1:length(RtouchPositive5windowPointSpikeOffP1(:,1))
    IndexSpikeOffPositive=find(RtouchPositive5windowPointSpikeOffP1(i,(1:5))==1);
    
    if length(IndexSpikeOffPositive)==5;   %%%%ウィンドウに当てはまった回数が5回の場合
       RtPositiveSpikeOffKaisuuP1(2)=RtPositiveSpikeOffKaisuuP1(2)+1;
    end
    
    if  length(IndexSpikeOffPositive)==4;%%%%ウィンドウに当てはまった回数が4回の場合
        RtPositiveSpikeOffKaisuuP1(2)=RtPositiveSpikeOffKaisuuP1(2)+1;
    end
    
    if length(IndexSpikeOffPositive)==3;%%%%ウィンドウに当てはまった回数が3回の場合 
       RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==2;%%%%ウィンドウに当てはまった回数が2回の場合 
       RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==1;%%%%ウィンドウに当てはまった回数が1回の場合 
       RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
    end
    
    if length(IndexSpikeOffPositive)==0;%%%%ウィンドウに当てはまった回数が0回の場合 
       RtPositiveSpikeOffKaisuuP1(1)=RtPositiveSpikeOffKaisuuP1(1)+1;
    end
end

LtPositiveFiringRateP1=LtPositiveHistogramXaxisP1./((LtPositiveSpikeOnKaisuuP1+LtPositiveSpikeOffKaisuuP1)*10);
RtPositiveFiringRateP1=RtPositiveHistogramXaxisP1./((RtPositiveSpikeOnKaisuuP1+RtPositiveSpikeOffKaisuuP1)*10);
