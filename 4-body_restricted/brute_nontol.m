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
x = cos(theta);
y = sin(theta);
x = x+1;
plot(x, y);
hold on
x = x-1.5;
y = y + sqrt(3)/2;
plot(x, y);
y = y - sqrt(3);
plot(x, y);
axis equal
hold on

% params
w = 1/sqrt(sqrt(3));

%tolerance for solver
reltol = 1e-8;
abstol = 1e-8;
opts = odeset('RelTol',reltol,'AbsTol',abstol,'Events',@triEventsFcn);
optscond = odeset('RelTol',reltol,'AbsTol',abstol,'Events',@triEventsFcnCond);

error = 1e-8;
tspan = [0 100];

% Fix the Hamiltonian
h_range = linspace(-1.7, -1, 40);

y0 = 0;

x_range = linspace(0, 0.4, 40);
px_range = linspace(-2, 2, 100);

counter = 0;
for H0 = h_range
    disp(counter)
    counter = counter + 1;
    disp(H0)
    for i = x_range

        for j = px_range

            py = w*i + sqrt(w^2 * i^2 - 2 * (0.5 * j.^2 - gravSum(i, y0)-H0 + w * y0 * j));
            ic = [i;y0;j;py;];

            [~, y, ~, ye, ~] = ode15s(@(t, y)  ODEsystem(t, y), tspan, ic, optscond);
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
