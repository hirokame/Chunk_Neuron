function [AutoCo]=AutoCorr(Array,duration,Direction)%bin��hist�O���t�ׂ̍����i�������j
%�������̏ꍇ�A�S�̂�duration�̒����ɂȂ�悤�ɂ��Ă���B
Array(Array==0)=[];%Excel����f�[�^�𒼂Ɏ����Ă��Ă���ꍇ�A0�Ŗ��߂��Ă��邱�Ƃ�����
Array=sort(Array);

AutoCo=[];
if Direction==1 %�Е���
    for n=1:length(Array)
        A=Array(((Array-Array(n))<duration)&((Array-Array(n))>0)&(Array-Array(n))~=0)-Array(n);
        %disp(A);
        AutoCo=[AutoCo;A];
    end
else
    for n=1:length(Array)
        A=Array(((Array-Array(n))<duration/2)&((Array-Array(n))>-duration/2)&(Array-Array(n))~=0)-Array(n);
        %disp(A);
        AutoCo=[AutoCo;A];
    end
end
AutoCo(AutoCo==0)=[];


% AutoCo=[];
% for n=1:length(Array)
%     for m=n+1:length(Array)
%         A=(Array(m)-Array(n));
%         if A<1000
%             AutoCo=[AutoCo A];
%             %break
%         end
%     end
% end

% figure
% hist(AutoCo,100);title('AutoCorr');