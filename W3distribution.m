function W3distribution  

global RTroughlocsInterval LTroughlocsInterval LlocsInterval RlocsInterval W3distance LtWindowintervaL RtWindowintervaL

%%%%����W3�i��Βl���ł��������j�̌��o
[InterbalLtouch IndexLtouch]=sort(abs(LlocsInterval),'ascend');
LtouchW3=LlocsInterval(IndexLtouch(1:5));   %%%%%%%W3�̃X�p�C�N����̎���


[InterbalRtouch IndexRtouch]=sort(abs(RlocsInterval),'ascend');
RtouchW3=RlocsInterval(IndexRtouch(1:5));   %%%%%%%W3�̃X�p�C�N����̎���


LtouchW3
RtouchW3


%%%%%%%%W3�Ԃ̎��Ԃ��L�^
W3distance=abs(LtouchW3(1)-RtouchW3(1));


%%%%%%%Lt�̒��S�t�߂�2�̃E�B���h�E�Ԃ̋���
LtWindowintervaL=abs(LtouchW3(1)-LtouchW3(2));

%%%%%%%Rt�̒��S�t�߂�2�̃E�B���h�E�Ԃ̋���
RtWindowintervaL=abs(RtouchW3(1)-RtouchW3(2));

