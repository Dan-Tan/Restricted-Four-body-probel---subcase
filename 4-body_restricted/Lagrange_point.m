
% create a grid from x in [-3,3], y in [-3,3]
x = linspace(-3,3,100);
y = linspace(-3,3,100);
[X,Y] = meshgrid(x,y);

% compute the potential V
V = u(X,Y);
figure;

% plot V, linspace(-3,-1,100) means we only show values in [-3, -1] with
% 100 contour steps
contourf(x,y,V, linspace(-5,-1,100));
axis equal
hold on

% Find Lagrange point from gradV=0, given some initial guess
% set the relative error and absolute
reltol = 1e-8;
abstol = 1e-8;
opts = odeset('RelTol',reltol, 'Abstol', abstol);

guesses = [0, 0; 0.2121 0.3939; -0.4545 0; 0.2121 -0.3333; -1 1.788; -1 -1.788; ...
    2.03 0; 0.8182 -1.424; -1.667 0;0.8182 1.424;];
disp(size(guesses));
for i = 1:10
    a = [guesses(i, 1) guesses(i, 2)];
    x = fsolve(@vfun, a, opts);
    sols(i, 1) = x(1);
    sols(i, 2) = x(2);
end
scatter(sols(1, 1), sols(1, 2),15,'filled', 'white');
scatter(sols(2:4, 1), sols(2:4, 2),15,'filled', 'red');
scatter(sols(5:7, 1), sols(5:7, 2),15,'filled', 'black');
scatter(sols(8:10, 1), sols(8:10, 2),15,'filled', 'blue');
hold off
disp(sols)