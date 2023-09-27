function [X_real,Ximag]=DFT_(x_real,x_imag,dft_size)

X_real=zeros(1,dft_size);
X_imag=zeros(1,dft_size);
for k=1:dft_size,
    for n=1:dft_size,
        w_real=cos(2*pi*(k-1)*(n-1)/dft_size);
        w_imag=-sin(2*pi*(k-1)*(n-1)/dft_size);
        X_real(k)=X_real(k)+w_real*x_real(n)-w_imag*x_imag(n);
        X_imag(k)=X_imag(k)+w_real*x_imag(n)-w_imag*x_real(n);
    end
end