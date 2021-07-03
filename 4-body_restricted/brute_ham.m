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

% params
w = 1/sqrt(sqrt(3));

%tolerance for solver
reltol = 1e-8;
abstol = 1e-8;
opts = odeset('RelTol',reltol,'AbsTol',abstol,'Events',@triEventsFcn);
optscond = odeset('RelTol',reltol,'AbsTol',abstol,'Events',@triEventsFcnCond);
tol = 1e-2;
error = 1e-8;
tspan = [0 100];

% Fix the Hamiltonian
H0 = -1;

y0 = 0;

x_range = linspace(-1, 0, 100);
px_range = linspace(0, 1.5, 1000);

for i = x_range
    disp(i)
    counter = 0;
    
    for j = px_range
        
        py = w*i + sqrt(w^2 * i^2 - 2 * (0.5 * j.^2 - gravSum(i, y0)-H0));
        tru = 0;
        [~, ~, ~, ye, ~] = ode45(@(t, y)  ODEsystem(t, y), tspan, ic, optscond);
        if (size(ye, 1) >= 1)
            tru = 1;
        else
            tru = 0;
            plot(y(:, 1), y(:, 2));
            hold off
            break
        end
              
        
        ic = [i;y0;j;py];
        %disp(trisolarisHamiltonian(i, 0, j, py));
        if (tru == 0)
            [t, y, te, ye, ie] = ode45(@(t, y)  ODEsystem(t, y), tspan, ic, opts);
            d = size(ye, 1);
        else
            id = 1;
        end

       
        val = 10;
       
        if (id ~= 1)
            for n = 2:id
                q1t = ye(n, 1);
                q2t = ye(n, 2);
                p1t = ye(n, 3);
                p2t = ye(n, 4);
                valt = sqrt((q1t - i)^2 + (q2t)^2 + (p1t - j)^2 + (p2t - py)^2);
                if val > valt
                    val = valt;
                    q1 = q1t;
                    q2 = q2t;
                    p1 = p1t;
                    p2 = p2t;
                end
            end
        end





        if (val < tol)
            
            plot(y(:, 1), y(:, 2));
            scatter(ye(:, 1), ye(:, 2), 'o');
            hold off
            disp(size(q1))
            disp(val);
            disp(q1);
            disp(i);
            disp(p1);
            disp(j);
            disp(p2);
            disp(py);

            break
        end 
    end
if (val < tol)
    break
end    
end
