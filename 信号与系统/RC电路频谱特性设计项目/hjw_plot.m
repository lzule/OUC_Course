%% 定义变量
r1 = 10000;
r2 = 10000;
c1 = 5.305e-9;
c2 = 159e-9;
Ui = 0;
Uo = 0;
%% 定义函数h(jw)
syms w real;
U0 = 1j*w*c2*r2/(1 - w^2*c1*c2*r1*r2 + 1j*w*c1*r1 + 1j*w*c2*r2 + 1j*w*c2*r1) * Ui;
h_jw_ = 1j*w*c2*r2/(1 - w^2*c1*c2*r1*r2 + 1j*w*c1*r1 + 1j*w*c2*r2 + 1j*w*c2*r1);
figure(1)
fplot(abs(h_jw_), [0, 100000], Color='black', LineWidth=2)
axis([0, 100000, 0, 1])
title('幅频特性')
ylabel('|H(jw)|')
xlabel('w')

figure(2)
fplot(rad2deg(angle(h_jw_)), [0, 100000], Color='black', LineWidth=2)
axis([0, 100000, -90, 90])
title('相频特性')
ylabel('φ(w)')
xlabel('w')
