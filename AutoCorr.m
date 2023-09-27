function [AutoCo]=AutoCorr(Array,duration,Direction)%binはhistグラフの細かさ（分割数）
%両方向の場合、全体でdurationの長さになるようにしている。
Array(Array==0)=[];%Excelからデータを直に持ってきている場合、0で埋められていることがある
Array=sort(Array);

AutoCo=[];
if Direction==1 %片方向
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