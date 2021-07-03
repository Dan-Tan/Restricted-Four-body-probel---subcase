function dydt = ODEsystem(t,y)

w = 1/sqrt(sqrt(3));

dydt = zeros(4,1);

r1 = sqrt((y(1)-1).^2+(y(2)).^2);
r2 = sqrt((y(1)+1/2).^2+(y(2)-sqrt(3)/2).^2);
r3 = sqrt((y(1)+1/2).^2+(y(2)+sqrt(3)/2).^2);

%y(1) - x, y(2) - y, y(3) - px, y(4) - py

dydt(1) = y(3)+w*y(2); %dxdt
dydt(2) = y(4)-w*y(1); %dydt
dydt(3) = w*y(4)-(y(1)-1)/r1^3 - (y(1)+1/2)/r2^3 - (y(1)+1/2)/(r3^3); %dpxdt
dydt(4) = -y(2)/r1^3 - (y(2)-sqrt(3)/2)/r2^3 - (y(2)+sqrt(3)/2)/(r3^3)-w*y(3);%dpydt

end