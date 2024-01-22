function [f,X_m,X_phi] = DFT(xn,ts,N,drawflag)
% [f,X_m,X_phi] = DFT(xn,ts,N,drawflag) 离散序列的快速傅里叶变换，时域转换为频域
% 输入  xn为离散序列 为向量  
%       ts为序列的采样时间/s
%       N为FFT变换的点数，默认为xn的长度  
%       drawflag为绘图标识位，取0时不绘图，其余非0值时绘图，默认为绘图
% 输出 f为频率向量
%      X_m为幅值向量
%      X_phi为相位向量，单位为°
% 注意计算出来的0频分量(直流分量应该除以2)  直流分量的符号应结合相位图来确定


if nargin == 2
    N = length(xn);
    drawflag = 1;
elseif  nargin == 3
    drawflag = 1;
end

if  isempty(N)
    N = length(xn);
end


Xk = fft(xn,N);         % FFT变换
fs = 1/ts;              % 采样频率 HZ
X_m = abs(Xk)*2/N;      % 幅值量化变换
X_phi = angle(Xk);      % 相位
Nn = floor((N-1)/2);    % 变换后有用的点数-1
f = (0:Nn)*fs/N ;       % 横坐标 频率HZ
X_m = X_m(1:Nn+1);      % 幅值(仅取有用点Nn+1个点)
X_phi = X_phi(1:Nn+1);  % 相位(仅取有用点Nn+1个点)
% X_phi = unwrap(X_phi);  % 去除相位的间断点(仅在出图时作用)
X_phi = X_phi*180/pi;   % 化成°单位

% 直流分量处理
X_m(1) = X_m(1)/2;      % 注意计算出来的0频分量(直流分量应该除以2)

if drawflag ~= 0        
    figure
    subplot(211)
    plot(f,X_m)
    title('DFT的频率-幅值图');
    xlabel('频率/HZ');ylabel('幅值');
    grid on

    subplot(212)
    plot(f,X_phi)
    title('DFT的频率-相位图');
    xlabel('频率/HZ');ylabel('相位/°');
    grid on
end
