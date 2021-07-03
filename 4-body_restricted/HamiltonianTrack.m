% set the relative error
reltol = 1e-8;
% generate ODE solving options
abstol = 1e-8;
opts = odeset('RelTol',reltol);
lp = 4;
pert = 0;
x0 = -0.825;
y_0 = 0;
px0 = -1.295;
H0 = -1;

y0 = [sols(lp, 1)+pert sols(lp, 2)+pert (-1)*w * sols(lp, 2) w * sols(lp, 1)];
%y0 = [x0 y_0 px0 w*x0 + sqrt(w^2 * x0^2 + 2 * (0.5 * px0.^2 + gravSum(x0, y_0)-H0))];


tspan = [0 100]; 
[t,y] = ode45(@(t, y) ODEsystem(t, y),tspan,y0,opts);

H45 = trisolarisHamiltonian(y(:, 1), y(:, 2), y(:, 3), y(:, 4));

plot(t, H45)
hold on
[t, y] = ode15s(@(t, y) ODEsystem(t, y),tspan,y0,opts);

H15 = trisolarisHamiltonian(y(:, 1), y(:, 2), y(:, 3), y(:, 4));
plot(t, H15)

[t, y] = ode113(@(t, y) ODEsystem(t, y),tspan,y0,opts);

H113 = trisolarisHamiltonian(y(:, 1), y(:, 2), y(:, 3), y(:, 4));
plot(t, H113)

[t, y] = ode23s(@(t, y) ODEsystem(t, y),tspan,y0,opts);

H23 = trisolarisHamiltonian(y(:, 1), y(:, 2), y(:, 3), y(:, 4));
plot(t, H23)

xlabel('t')
ylabel('H')
title('Change in the Hamiltonian for a range of ODE solvers')

legend('45', '15s', '113', '23s')
hold off