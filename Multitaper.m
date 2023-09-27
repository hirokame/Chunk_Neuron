N=100;W=0.05;

% for i=repmat(1:N,N,1);
for i=1:N
%     A=2*W*sinc(2*W*(i-i'));
    for j=1:N
        A=2*W*sinc(2*W*(i-j));
    end    
end

[V,D]=eig(A);

figure(1)
for k=1:5
    subplot(5,1,k)
    plot(V(:,N-k+1))
end

figure(2)
plot(diag(D))