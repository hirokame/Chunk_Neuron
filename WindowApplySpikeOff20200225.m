function WindowApplySpikeOff20200225(RorL)

global RtouchSpikeOffUnit LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu ...
    RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu LtStep4SpikeOffKaisuu RtStep4SpikeOffKaisuu ...
    LtStep3SpikeOffKaisuu RtStep3SpikeOffKaisuu

%%%%%%%%LtouchSpikeffUnitの場合分け
if ~isempty(strfind(RorL, 'L'));
LtPositiveSpikeOffKaisuu=zeros(1,6);
LtStep4SpikeOffKaisuu=zeros(1,5);
LtStep3SpikeOffKaisuu=zeros(1,10);

%%%%%%%Positive
LtouchPositive5windowPoint=LtouchSpikeOffUnit(:,(1:5));%%%% Positiveだけ抜き出す
for i=1:length(LtouchPositive5windowPoint(:,1))
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,1]);
       LtPositiveSpikeOffKaisuu(6)=LtPositiveSpikeOffKaisuu(6)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,1]) || all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,0]) ;
       LtPositiveSpikeOffKaisuu(5)=LtPositiveSpikeOffKaisuu(5)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,1]) || all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,0])...
            || all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,0]); 
       LtPositiveSpikeOffKaisuu(4)=LtPositiveSpikeOffKaisuu(4)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,0,0,0]) || all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,0,0]) || all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,0])...
            || all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,1]);  
       LtPositiveSpikeOffKaisuu(3)=LtPositiveSpikeOffKaisuu(3)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,0,0,0,0]) || all(LtouchPositive5windowPoint(i,(1:5))==[0,1,0,0,0]) || all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,0,0])...
            || all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,0]) || all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,1]);   
       LtPositiveSpikeOffKaisuu(2)=LtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,0]);
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
    
    
    %%%ここからStep4の解析
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,1]);
       LtStep4SpikeOffKaisuu(1)=LtStep4SpikeOffKaisuu(1)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,0,1,1,1]);
       LtStep4SpikeOffKaisuu(2)=LtStep4SpikeOffKaisuu(2)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,0,1,1]);
       LtStep4SpikeOffKaisuu(3)=LtStep4SpikeOffKaisuu(3)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,1]);
       LtStep4SpikeOffKaisuu(4)=LtStep4SpikeOffKaisuu(4)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,0]);
       LtStep4SpikeOffKaisuu(5)=LtStep4SpikeOffKaisuu(5)+1;
    end
    
    %%%ここからStep3の解析
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,1]);
       LtStep3SpikeOffKaisuu(1)=LtStep3SpikeOffKaisuu(1)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,1,0,1,1]);
       LtStep3SpikeOffKaisuu(2)=LtStep3SpikeOffKaisuu(2)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,0,1]);
       LtStep3SpikeOffKaisuu(3)=LtStep3SpikeOffKaisuu(3)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,0]); 
       LtStep3SpikeOffKaisuu(4)=LtStep3SpikeOffKaisuu(4)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,0,0,1,1]);
       LtStep3SpikeOffKaisuu(5)=LtStep3SpikeOffKaisuu(5)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,0,1,0,1]);
       LtStep3SpikeOffKaisuu(6)=LtStep3SpikeOffKaisuu(6)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,0,1,1,0]);
       LtStep3SpikeOffKaisuu(7)=LtStep3SpikeOffKaisuu(7)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,0,0,1]);
       LtStep3SpikeOffKaisuu(8)=LtStep3SpikeOffKaisuu(8)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,0,1,0]);
       LtStep3SpikeOffKaisuu(9)=LtStep3SpikeOffKaisuu(9)+1;
    end
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,0]);
       LtStep3SpikeOffKaisuu(10)=LtStep3SpikeOffKaisuu(10)+1;
    end
end
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%スパイクが当てはまった時のPositiveウィンドのfigure
% FRfigure=figure;
% subplot(2,2,1)
% PositiveFiringRate=LtPositiveHistogramXaxis./(LtPositiveSpikeOffKaisuu*10);
% bar(PositiveFiringRate); %%%%%発火頻度に直す
% title('SpikeOnPositiveFiringRateLt')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%Negative
% LtNegativeSpikeOffKaisuu=zeros(1,5);
% RtNegativeHistogramXaxis=zeros(1,5); %%%%% Negativeヒストグラムを作成する際の発火頻度（初期値ゼロ）5要素（0個、どれか1つ、連続２つだけ、連続3つ、連続4つ）
% LtouchNegative5windowPoint=[LtouchSpikeOffUnit(:,(6:9))];%%%% 発火数とNegativeだけ抜き出す
% 
% 
% 
% for i=1:length(LtouchNegative5windowPoint(:,1))
%     if all(LtouchNegative5windowPoint(i,(1:4))==[-1,-1,-1,-1]);
% %%%%4連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeSpikeOffKaisuu(5)=LtNegativeSpikeOffKaisuu(5)+1;
%     end
%     
%     if all(LtouchNegative5windowPoint(i,(1:4))==[0,-1,-1,-1]) | all(LtouchNegative5windowPoint(i,(1:4))==[-1,-1,-1,0]) ;%%%%3連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeSpikeOffKaisuu(4)=LtNegativeSpikeOffKaisuu(4)+1;
%     end
%     
%     if all(LtouchNegative5windowPoint(i,(1:4))==[0,0,-1,-1]) | all(LtouchNegative5windowPoint(i,(1:4))==[0,-1,-1,0])...
%             | all(LtouchNegative5windowPoint(i,(1:4))==[-1,-1,0,0]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeSpikeOffKaisuu(3)=LtNegativeSpikeOffKaisuu(3)+1;
%     end
%     
%     if all(LtouchNegative5windowPoint(i,(1:4))==[-1,0,0,0]) | all(LtouchNegative5windowPoint(i,(1:4))==[0,-1,0,0]) | all(LtouchNegative5windowPoint(i,(1:4))==[0,0,-1,0])...
%             | all(LtouchNegative5windowPoint(i,(1:4))==[0,0,0,-1]);                           %%%% 1連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeSpikeOffKaisuu(2)=LtNegativeSpikeOffKaisuu(2)+1;
%     end
%     
%     if all(LtouchNegative5windowPoint(i,(1:4))==[0,0,0,0]);    %%%% 0連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeSpikeOffKaisuu(1)=LtNegativeSpikeOffKaisuu(1)+1;
%     end
% end

% %%%%%%%%%%%%%LtNegativeウィンドウに当てはまった発火頻度を表示
% subplot(2,2,2)
% NegativeFiringRate=RtNegativeHistogramXaxis./(LtNegativeSpikeOffKaisuu*10)
% bar(NegativeFiringRate); %%%%%発火頻度に直す
% title('SpikeOnNegativeFiringRateLt')
% 




%%%%%% Rtouch %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%RtouchSpikeOnUnitのfigure作成
if ~isempty(strfind(RorL, 'R'));
RtPositiveSpikeOffKaisuu=zeros(1,6);
RtStep4SpikeOffKaisuu=zeros(1,5);
RtStep3SpikeOffKaisuu=zeros(1,10);

%%%%%%%Positive
RtouchPositive5windowPoint=RtouchSpikeOffUnit(:,(1:5));
for i=1:length(RtouchPositive5windowPoint(:,1))
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,1]);
       RtPositiveSpikeOffKaisuu(6)=RtPositiveSpikeOffKaisuu(6)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,1]) | all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,0]) ;
       RtPositiveSpikeOffKaisuu(5)=RtPositiveSpikeOffKaisuu(5)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,1]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,0]);
       RtPositiveSpikeOffKaisuu(4)=RtPositiveSpikeOffKaisuu(4)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,1]);
       RtPositiveSpikeOffKaisuu(3)=RtPositiveSpikeOffKaisuu(3)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,0,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,0,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,1]);
       RtPositiveSpikeOffKaisuu(2)=RtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,0]);
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
    
    
    %%%ここからStep4の解析
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,1]);
       RtStep4SpikeOffKaisuu(1)=RtStep4SpikeOffKaisuu(1)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,0,1,1,1]);
       RtStep4SpikeOffKaisuu(2)=RtStep4SpikeOffKaisuu(2)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,0,1,1]);
       RtStep4SpikeOffKaisuu(3)=RtStep4SpikeOffKaisuu(3)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,1]);
       RtStep4SpikeOffKaisuu(4)=RtStep4SpikeOffKaisuu(4)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,0]);
       RtStep4SpikeOffKaisuu(5)=RtStep4SpikeOffKaisuu(5)+1;
    end
    
    %%%ここからStep3の解析
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,1]);
       RtStep3SpikeOffKaisuu(1)=RtStep3SpikeOffKaisuu(1)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,1,0,1,1]);
       RtStep3SpikeOffKaisuu(2)=RtStep3SpikeOffKaisuu(2)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,0,1]);
       RtStep3SpikeOffKaisuu(3)=RtStep3SpikeOffKaisuu(3)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,0]); 
       RtStep3SpikeOffKaisuu(4)=RtStep3SpikeOffKaisuu(4)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,0,0,1,1]);
       RtStep3SpikeOffKaisuu(5)=RtStep3SpikeOffKaisuu(5)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,0,1,0,1]);
       RtStep3SpikeOffKaisuu(6)=RtStep3SpikeOffKaisuu(6)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,0,1,1,0]);
       RtStep3SpikeOffKaisuu(7)=RtStep3SpikeOffKaisuu(7)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,0,0,1]);
       RtStep3SpikeOffKaisuu(8)=RtStep3SpikeOffKaisuu(8)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,0,1,0]);
       RtStep3SpikeOffKaisuu(9)=RtStep3SpikeOffKaisuu(9)+1;
    end
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,0]);
       RtStep3SpikeOffKaisuu(10)=RtStep3SpikeOffKaisuu(10)+1;
    end
end
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%スパイクが当てはまった時のPositiveウィンドのfigure
% subplot(2,2,3)
% PositiveFiringRate=RtPositiveHistogramXaxis./(RtPositiveSpikeOffKaisuu*10)
% bar(PositiveFiringRate); %%%%%発火頻度に直す
% title('SpikeOnPositiveFiringRateRt')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%Negative
% RtNegativeSpikeOffKaisuu=zeros(1,5);
% RtNegativeHistogramXaxis=zeros(1,5); %%%%% Negativeヒストグラムを作成する際の発火頻度（初期値ゼロ）5要素（0個、どれか1つ、連続２つだけ、連続3つ、連続4つ）
% RtouchNegative5windowPoint=[RtouchSpikeOffUnit(:,(6:9))];%%%% 発火数とNegativeだけ抜き出す
% 
% 
% 
% for i=1:length(RtouchNegative5windowPoint(:,1))
%     if all(RtouchNegative5windowPoint(i,(1:4))==[-1,-1,-1,-1]);
% %%%%4連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeSpikeOffKaisuu(5)=RtNegativeSpikeOffKaisuu(5)+1;
%     end
%     
%     if all(RtouchNegative5windowPoint(i,(1:4))==[0,-1,-1,-1]) | all(RtouchNegative5windowPoint(i,(1:4))==[-1,-1,-1,0]) ;%%%%3連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeSpikeOffKaisuu(4)=RtNegativeSpikeOffKaisuu(4)+1;
%     end
%     
%     if all(RtouchNegative5windowPoint(i,(1:4))==[0,0,-1,-1]) | all(RtouchNegative5windowPoint(i,(1:4))==[0,-1,-1,0])...
%             | all(RtouchNegative5windowPoint(i,(1:4))==[-1,-1,0,0]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeSpikeOffKaisuu(3)=RtNegativeSpikeOffKaisuu(3)+1;
%     end
%     
%     if all(RtouchNegative5windowPoint(i,(1:4))==[-1,0,0,0]) | all(RtouchNegative5windowPoint(i,(1:4))==[0,-1,0,0]) | all(RtouchNegative5windowPoint(i,(1:4))==[0,0,-1,0])...
%             | all(RtouchNegative5windowPoint(i,(1:4))==[0,0,0,-1]);                           %%%% 1連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeSpikeOffKaisuu(2)=RtNegativeSpikeOffKaisuu(2)+1;
%     end
%     
%     if all(RtouchNegative5windowPoint(i,(1:4))==[0,0,0,0]);    %%%% 0連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeSpikeOffKaisuu(1)=RtNegativeSpikeOffKaisuu(1)+1;
%     end
% end


% subplot(2,2,4)
% NegativeFiringRate=RtNegativeHistogramXaxis./(LtNegativeSpikeOffKaisuu*10)
% bar(NegativeFiringRate); %%%%%発火頻度に直す
% title('SpikeOnNegativeFiringRateRt')

% %%%%%%%%figの保存%%%%%%%%%%%%%%%%%%
% figname=['FRfigureRtLt.bmp'];
% saveas(FRfigure,figname);