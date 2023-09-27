
function NewArray=MovWindow(Array,Mbin)

%moving average
%Mbin‚Í•Ğ‘¤‚Ì“®‚©‚·window”A‚R‚Ìê‡A3,2,1,0,1,2,3‚Æ7window‚É‚È‚éB
NewArray=zeros(1,length(Array));

for n=1:length(Array)

    if n-Mbin<=0
        NewArray(n)=(sum(Array(1:n+Mbin))+Array(1)*(abs(n-Mbin)+1))/(Mbin*2+1);
    elseif n+Mbin>length(Array)
        NewArray(n)=(sum(Array(n-Mbin:end))+Array(end)*(n-length(Array)+Mbin))/(Mbin*2+1);
    else
        NewArray(n)=sum(Array(n-Mbin:n+Mbin))/(Mbin*2+1);
    end

end



% for n=Mbin+1:length(Array)-Mbin-1
% %     for m=-Mbin:1:Mbin
%         if m<=0
%         NewArray(n)=sum(NewArray(n-Mbin:n+Mbin))/(Mbin*2+1);
% %         NewArray(n)=NewArray(n)+Array(n+m);
% %     end
% end
% NewArray(Mbin+1:length(Array)-Mbin-1)=NewArray(Mbin+1:length(Array)-Mbin-1)/(Mbin*2+1);
% 
% for n=1:Mbin
%     for m=1:n
%         NewArray(n)=NewArray(n)+Array(m);
%     end
%     NewArray(n)=NewArray(n)/n;
% %     NewArray(n)=Array(n);
% end
% for n=length(Array)-Mbin:length(Array)
%     for m=1:n
%         NewArray(n)=NewArray(n)+Array(m);
%     end
%     NewArray(n)=NewArray(n)/n;
% end

    
    
    

