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
hold on

%inital
y = 0;
x_range = linspace(-0.8, -0.5, 20);
px_range = linspace(0, 2, 50);
py_range = linspace(-2, 2, 50);

tol = 1e-8;

%error
reltol = 1e-8;
abstol = 1e-8;
optscond = odeset('RelTol',reltol,'AbsTol',abstol,'Events',@triEventsFcnCond);
tspan = [0 100];

for i = x_range
    disp(i)
    
    for j = px_range
        
        for k = py_range
            
            ic = [i; 0; j; k;];

           
            [~, y, ~, ye, ~] = ode45(@(t, y)  ODEsystem(t, y), tspan, ic, optscond);
            if (size(ye, 1) >= 1)
                tru = 1;
            else
                tru = 0;
                disp(size(ye, 1) >= 1)
                disp(ye);
                plot(y(:, 1), y(:, 2));
                disp('Hamiltonian:')
                disp(H0)
                disp('ic:')
                disp(ic);
                hold off
                break
            end
            
        end
    if (tru == 0)
        break
    end

    end
if (tru == 0)
    break
end

end

    