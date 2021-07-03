function [value,isterminal,direction] = triEventsFcn(t,y)

% event happens when q2 = 0
value(1) = y(2);
isterminal(1) = 1;
% theta changes from negative to positive
direction(1) = +1;

end
