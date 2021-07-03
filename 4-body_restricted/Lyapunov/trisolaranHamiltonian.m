function H = trisolaranHamiltonian(t, y)

w = 1/sqrt(sqrt(3));

r1 = sqrt((x-1).^2+(y.^2));
r2 = sqrt((x+1/2).^2+(y-sqrt(3)/2).^2);
r3 = sqrt((x+1/2).^2+(y+sqrt(3)/2).^2);

H = (1/2)*(px.^2 + py.^2) + w.*y.*px - w.*x.*py - 1./r1 - 1./r2 - 1./r3; 

end
