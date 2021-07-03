function V = gravSum(x,y)

r1 = sqrt((x-1)^2+(y^2));
r2 = sqrt((x+1/2)^2+(y-sqrt(3)/2)^2);
r3 = sqrt((x+1/2)^2+(y+sqrt(3)/2)^2);

V = 1/r1 + 1/r2 + 1/r3;

end
