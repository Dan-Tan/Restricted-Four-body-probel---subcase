% Example 7.2
%clear all
%close all

figure



% set the time span
tspan = [0, 1];
% here we set both error
reltol = 1e-13;
abstol = 1e-13;
% generate ODE solving options
opts = odeset('RelTol',reltol,'AbsTol',abstol);
lp = 7;
w = 1/sqrt(sqrt(3));
% set initial conditions [t1,t2,p1,p2,dt1,dt2,dp1,dp2]
%ic=[sols(lp, 1); sols(lp, 2);0-w*sols(lp, 2);w*sols(lp, 1);0;0;0;0.1];
%above ic for easily testing stability of lagrange points in sols variable
ic = [0.38;0;0;2.0733;0;0;0;1];

% interval for normalization
tau = 1;
% the number of normalizations
N = 1000;

% di and lambda
di = zeros([0,N+1]);
lambda = di;

di(1) = 1;
lambda(1) = di(1)/tau;

% solve the ODE N times
for i = 1:N
    
    disp(i)

    [t,y] = ode15s(@(t,y) triODEL(t,y), tspan, ic, opts);
    % extract dy
    dy = y(end,5:8);
    % compute di
    di(i+1) = sqrt(sum(dy.^2));
    lambda(i+1) = sum(log(di(1:i+1)))/(i*tau);
    
    ic = y(end,:);
    ic(5:8) = ic(5:8)/di(i+1);

end

plot(lambda(2:end));
hold on
xlabel('N');
ylabel('\lambda');


figure
ic=[0.38;0;0;2.0733;0;0;0;1];
[t1,y1] = ode15s(@(t,y) triODEL(t,y), [0,20], ic, opts);
ic=[0.38;0;0;2.0733+0.001;0;0;0;1];
[t2,y2] = ode15s(@(t,y) triODEL(t,y), [0,20], ic, opts);

plot(t1,y1(:,4),'b-',t2,y2(:,4),'r--');
ylabel('p_y');
xlabel('t');