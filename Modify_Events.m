function [OriginalArray1,OriginalArray2,ModifiedArray1,ModifiedArray2]=Modify_Events(WaterOnArrayOriginal,WaterOffArrayOriginal, StartTime, FinishTime, EventName)
%���Ƃ���WaterEvents�̂��߂ɍ쐬�����̂ŕϐ���water�֌W�ɂȂ��Ă��邪�A����Event�ɂ��g�p�BFloorTouch,Drink,,,

%WaterOnArray�́A�ŏ��ƍŌ��f�[�^�����Ȃǂ��C���������̂ɂȂ�B
WaterOnArray=WaterOnArrayOriginal;
WaterOffArray=WaterOffArrayOriginal;

if StartTime==0;StartTime=1;end

% % %�f�[�^�����ׂ�0�̏ꍇ�B
% if WaterOnArray(1)==0;WaterOnArray(1)=StartTime;end
% if
% WaterOffArray(1)==0;WaterOffArray(1)=FinishTime;WaterOffArray=sort(WaterOffArray);end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%�ŏ�����Ō�܂ň���ł����ꍇ�B
% if WaterOnArray(1)==0 & WaterOffArray(1)==0;WaterOnArray(1)=StartTime;WaterOffArray(1)=FinishTime;end %data(1,3)�͏I���^�C��

WaterOnArrayOriginal(WaterOnArrayOriginal==0)=[];
WaterOffArrayOriginal(WaterOffArrayOriginal==0)=[];
WaterOnArrayOriginal=WaterOnArrayOriginal(WaterOnArrayOriginal>StartTime & WaterOnArrayOriginal<FinishTime);
WaterOffArrayOriginal=WaterOffArrayOriginal(WaterOffArrayOriginal>StartTime & WaterOffArrayOriginal<FinishTime);
% disp(EventName);
% length(WaterOnArrayOriginal)
% length(WaterOffArrayOriginal)

OriginalArray1=WaterOnArrayOriginal;
OriginalArray2=WaterOffArrayOriginal;

WaterOnArray(WaterOnArray==0)=[];
WaterOffArray(WaterOffArray==0)=[];

WaterOnArray(WaterOnArray<StartTime)=[];
WaterOffArray(WaterOffArray<StartTime)=[];

WaterOnArray(WaterOnArray>FinishTime)=[];
WaterOffArray(WaterOffArray>FinishTime)=[];

%�ŏ�����Ō�܂ň���ł����ꍇ�ȂǁA��z��ɂȂ��Ă��܂����ꍇ�̏��u
if isempty(WaterOnArray);WaterOnArray(1)=StartTime;end
if isempty(WaterOffArray);WaterOffArray(1)=FinishTime;end

%�X�^�[�g���Ɉ���ł��āA�r���ŗ��ꂽ�ꍇ�B
if WaterOnArray(1)>WaterOffArray(1)
    WaterOnArray=[StartTime;WaterOnArray];
end

% FinishTime
% WaterOnArray(end)
% WaterOffArray(end)

%�I�����Ɉ���ł����ꍇ
if WaterOnArray(end)>WaterOffArray(end) & WaterOnArray(end)<FinishTime
    WaterOffArray=[WaterOffArray;FinishTime];
end

% for n=1:min(length(WaterOnArray),length(WaterOffArray))
%    if WaterOnArray(n)>WaterOffArray(n);
%        disp(['!!! Strange Event at' int2str(WaterOnArray(n))]);
%        WaterOffArray=sort([WaterOffArray;(WaterOnArray(n)+1)]);
% %        disp([int2str(WaterOnArray(n)) 'erased']);
%    end
% end

n=1;
for n=1:min(length(WaterOnArray),length(WaterOffArray))
    if WaterOffArray(n)-WaterOnArray(n)<10 & WaterOffArray(n)>WaterOnArray(n);WaterOnArray(n)=-1;WaterOffArray(n)=-1;end
    n=n+1;
end
WaterOnArray(WaterOnArray==-1)=[];WaterOffArray(WaterOffArray==-1)=[];

%�Z��WaterOff���Ԃ��폜����Ƃ��Ɏg�p
% for n=length(WaterOffArray):-1:2;
%     if WaterOnArray(n)+20>WaterOffArray(n);WaterOnArray(n)=0;WaterOffArray(n)=0;end
% end

ModifiedArray1=WaterOnArray;
ModifiedArray2=WaterOffArray;
% ModifiedArray=[WaterOnArray;WaterOffArray]
