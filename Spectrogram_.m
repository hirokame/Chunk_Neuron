function [Ps,time,frequency]=Spectrogram_(s,fs,window_size,shift_size,w)

dft_size=window_size;
length_s=length(s);
nframe=floor(((length_s-window_size)/shift_size)+1);   % �S�t���[����:shift����DFT����window_size�Ō��܂�
x=zeros(1,window_size);
% w=HanningWindow_(window_size);   % ���֐�
Ps=zeros(dft_size/2+1,nframe);

for frame=1:nframe,
    offset=shift_size*(frame-1);
    for n=1:window_size,
        x(n)=s(offset+n)*w(n);   % shift�����ʒu����window_size�܂ł�signal
    end
    X=fft(x,dft_size);
    for k=1:dft_size/2+1,
        Ps(k,frame)=abs(X(k)).^2; % Power Spectrum
    end
end

time=zeros(1,nframe);

for frame=1:nframe,
    time(frame)=(frame-1)*shift_size/fs;
end

frequency=zeros(1,dft_size/2+1);

for k=1:dft_size/2+1,
    frequency(k)=(k-1)*fs/dft_size;
end

       