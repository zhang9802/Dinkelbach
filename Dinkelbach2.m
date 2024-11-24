
clc,clear;
close all;

iter_max = 20;
x = zeros(1,iter_max+1);
eta = zeros(1,iter_max+1);
x(1) = rand(1);
eta(1) = rand(1);

for iter=1:iter_max
% update x
    cvx_begin quiet
    variable x1
    maximize (x1-eta(iter)*(sum_square_abs(x1)+1))
    subject to
    x1>=0
    cvx_end
    x(iter+1)=x1;
    
 % update eta
 eta(iter+1) = x(iter+1)/(x(iter+1)^2+1);
    
    
 iter   
end
figure
plot(eta(1:iter),'b-o','linewidth',1.5);
grid on
xlabel('iteration number')
grid on
box on
ylabel('objective value');
