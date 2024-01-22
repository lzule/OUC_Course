function [xn,t] = iDFT(X_m,X_phi,ts,drawflag)
% [xn,t] = iDFT(X_m,X_phi,ts) 离散序列的快速傅里叶逆变换，频域转换为时域
% 输入 X_m为幅值向量
%      X_phi为相位向量，单位为°
%      ts为序列的采样时间/s
%      drawflag为绘图标识位，取0时不绘图，其余非0值时绘图，默认为绘图
% 输出  xn为离散序列向量
%       t为与xn对应的时间向量
% 注意计算出来的0频分量在进行ifft计算时，幅值应乘以2
% By ZFS@wust  2020
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans

if nargin == 3
    drawflag = 1;
end


X_m(1) = 2*X_m(1);                     % 注意计算出来的0频分量在进行ifft计算时，幅值应乘以2


Nn = length(X_m) - 1;                  % 频谱的点数
N = 2*Nn + 1;
X_phi = X_phi*pi/180;                  % 化成弧度单位
X_m = X_m*N/2;                         % 幅值量化变换
X_m(Nn+2:N) = X_m(end:-1:2);           % 单边频谱延拓为双边
X_phi(Nn+2:N) = -X_phi(end:-1:2);      % 单边频谱延拓为双边
Xk = X_m .* exp( 1j*X_phi );           % 幅值和相位构造复数序列

xn = real(ifft(Xk));                   % 时域离散信号
t = 0:ts:ts*(N-1);                     % 时间

if drawflag ~= 0
    
    figure
    plot(t,xn)
    title('iDFT恢复的时域图');
    xlabel('时间/s');ylabel('幅值');
    
end