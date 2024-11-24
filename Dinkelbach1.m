clc,clear;
close all;
s=rng(0);

N = 10;
A1 = rand(N,N) +1i*rand(N,N);
A1 = A1*A1';
A1 = (A1 + A1')/2;

A2 = rand(N,N) +1i*rand(N,N);
A2 = A2*A2';
A2 = (A2 + A2')/2;
% b = rand(N,2) +1i*rand(N,2);
c = rand(2,1);


x0 = rand(N,1)+1i*rand(N,1);
x0 = x0/norm(x0);
iter_num = 100;
eta = zeros(iter_num,1);
eta(1) = 0;
for iter = 1:iter_num
    cvx_begin  quiet
    variable x(N,1) complex
    maximize (real(x0'*A1*x0+x0'*A1*(x-x0))+c(1)-eta(iter)*(quad_form(x, A2)+c(2)))
    subject to
        norm(x)<=1
    cvx_end
    eta(iter+1) = real((x'*A1*x+c(1))/(x'*A2*x+c(2)));
    x0=x;
    if abs(eta(iter+1)-eta(iter))<=1e-3
        break
    end
    iter
end

figure
plot(eta(2: iter),'b-o','linewidth',1)
grid on
