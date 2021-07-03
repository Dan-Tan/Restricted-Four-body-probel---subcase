
close all
% create a grid from x in [-3,3], y in [-3,3]
theta = linspace(0, 2*3.14159, 100);
x = 0.6 * cos(theta);
y = 0.6 * sin(theta);
x = x+1;
plot(x, y);
hold on
x = x-1.5;
y = y + sqrt(3)/2;
plot(x, y);
y = y - sqrt(3);
plot(x, y);
centers = [1 0; -1/2 sqrt(3)/2; -1/2 -sqrt(3)/2;]
scatter(centers(:, 1), centers(:, 2), 'o')
axis equal
w = 1/sqrt(sqrt(3));

% set the relative error
reltol = 1e-8;
% generate ODE solving options
abstol = 1e-8;
opts = odeset('RelTol',reltol,'Abstol', abstol);
lp = 3;

x0 = 0.3795;
y_0 = 0;
px0 = 0.0202;
H0 = -1.6897;
py0 = w*x0 + sqrt(w^2 * x0^2 - 2 * (0.5 * px0.^2 - gravSum(x0, y_0)-H0));
disp(py0)
y0 = [sols(lp, 1)+pert sols(lp, 2)+pert (-1)*w * sols(lp, 2) w * sols(lp, 1)];
%y0 = [x0;y_0;px0;py0;];
%y0 = [0.3795;0;0.0202;2.0680;];

tspan = [0 100]; 
[t,y] = ode15s(@(t, y) ODEsystem(t, y),tspan,y0,opts);


plot(y(:,1),y(:,2), '.')
hold off

