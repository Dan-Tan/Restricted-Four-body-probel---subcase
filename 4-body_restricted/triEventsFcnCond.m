function [value,isterminal,direction] = triEventsFcnCond(t,y)
value(1) = 1;
r = 0.6;
% event happens when q2 = 0
if (sqrt((y(1) - 1)^2 + y(2)^2) < r || sqrt(y(1)^2 + y(2)^2) > 2)
    value(1) = 0;
end
if (sqrt((y(1) + 1/2)^2 + (y(2)-sqrt(3)/2)^2) < r)
    value(1) = 0;  
end
if (sqrt((y(1) + 1/2)^2 + (y(2)+sqrt(3)/2)^2) < r)
    value(1) = 0;
end


isterminal(1) = 1;
% theta changes from negative to positive
direction(1) = 0;

end
