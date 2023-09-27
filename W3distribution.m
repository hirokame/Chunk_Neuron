function W3distribution  

global RTroughlocsInterval LTroughlocsInterval LlocsInterval RlocsInterval W3distance LtWindowintervaL RtWindowintervaL

%%%%左足W3（絶対値が最も小さい）の検出
[InterbalLtouch IndexLtouch]=sort(abs(LlocsInterval),'ascend');
LtouchW3=LlocsInterval(IndexLtouch(1:5));   %%%%%%%W3のスパイクからの時間


[InterbalRtouch IndexRtouch]=sort(abs(RlocsInterval),'ascend');
RtouchW3=RlocsInterval(IndexRtouch(1:5));   %%%%%%%W3のスパイクからの時間


LtouchW3
RtouchW3


%%%%%%%%W3間の時間を記録
W3distance=abs(LtouchW3(1)-RtouchW3(1));


%%%%%%%Ltの中心付近の2つのウィンドウ間の距離
LtWindowintervaL=abs(LtouchW3(1)-LtouchW3(2));

%%%%%%%Rtの中心付近の2つのウィンドウ間の距離
RtWindowintervaL=abs(RtouchW3(1)-RtouchW3(2));

