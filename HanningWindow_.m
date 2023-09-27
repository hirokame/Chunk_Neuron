function w=HanningWindow_(window_size)
w=zeros(1,window_size);
if mod(window_size,2)==0
    for n=1:window_size,
        w(n)=0.5-0.5*cos(2*pi*(n-1)/window_size);
    end 
else
    for n=1:window_size,
        w(n)=0.5-0.5*cos(2*pi*(n-0.5)/window_size);
    end 
end

