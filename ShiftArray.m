function [ShiftedArray]=ShiftArray(Array,TurnMarkerTime)
% global OneTurnTime

Array(Array==0)=[];%Excel����f�[�^�𒼂Ɏ����Ă��Ă���ꍇ�A0�Ŗ��߂��Ă��邱�Ƃ�����

%Array��TurnMarker�Ő؂����ď���
ShiftedArray=[];
for n=1:length(TurnMarkerTime)-1
    
    tempArray=Array(Array>TurnMarkerTime(n)&Array<TurnMarkerTime(n+1)); %-TurnMarkerTime(n);
    ShiftPoint=rand(1)*(TurnMarkerTime(n+1)-TurnMarkerTime(n))+TurnMarkerTime(n);%Trial���̃����_���ɑI�񂾓_
    PreShift=tempArray(tempArray<ShiftPoint)+(TurnMarkerTime(n+1)-ShiftPoint);%ShiftPoint���O�̂��̂�����
    PostShift=tempArray(tempArray>ShiftPoint)+(TurnMarkerTime(n)-ShiftPoint);%ShiftPoint�����̂��̂�O��
    Shifted=[PostShift; PreShift];
    ShiftedArray=[ShiftedArray; Shifted];
end
    
%     tempArray=tempArray*(TurnMarkerTime(n+1)-TurnMarkerTime(n))/OneTurnTime%�Ptrial�̎��Ԃ�OneTurnTime�ɐ��K��

%     if Gsmooth==1;tempArray=instantArray(tempArray,10);end
