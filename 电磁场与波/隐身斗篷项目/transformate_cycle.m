function [x, y, z] = transformate_cycle(x0, y0, z0, a, b)
    if nargin == 3
        a = 1;
        b = 2;
    end
    theta0 = atan(y0./x0) + pi*(x0<0);
    r0 = sqrt(x0.^2 + y0.^2);
    theta = theta0;
    r = (b-a)./b.*r0 + a;
    x = r.*cos(theta).*(r0 < b) + x0.*(r0>=b);
    y = r.*sin(theta).*(r0 < b) + y0.*(r0>=b);
    z = z0;
end