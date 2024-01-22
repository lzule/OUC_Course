%% Eg 1 单频正弦信号(整数周期采样)
ts = 0.01;
t = 0:ts:1;
A = 1.5;       % 幅值  
f = 2;         % 频率
w = 2*pi*f;    % 角频率
phi = pi/3;    % 初始相位 
x = A*cos(w*t+phi);   % 时域信号
figure
plot(t,x)
xlabel('时间/s')
ylabel('时域信号x(t)')
% DFT变换将时域转换到频域,并绘制频谱图
[f,X_m,X_phi] = DFT(x,ts);

%% Eg 2 单频正弦信号(非整数周期采样)
ts = 0.01;
t = 0:ts:1;
A = 1.5;       % 幅值  
f = 1.5;         % 频率
w = 2*pi*f;    % 角频率
phi = pi/3;    % 初始相位 
x = A*cos(w*t+phi);   % 时域信号
figure
plot(t,x)
xlabel('时间/s')
ylabel('时域信号x(t)')
% DFT变换将时域转换到频域,并绘制频谱图
[f,X_m,X_phi] = DFT(x,ts);

% 单频正弦信号(非整数周期采样) 采样长度增加
ts = 0.01;
t = 0:ts:4.1;
A = 1.5;       % 幅值  
f = 1.5;         % 频率
w = 2*pi*f;    % 角频率
phi = pi/3;    % 初始相位 
x = A*cos(w*t+phi);   % 时域信号
figure
plot(t,x)
xlabel('时间/s')
ylabel('时域信号x(t)')
% DFT变换将时域转换到频域,并绘制频谱图
[f,X_m,X_phi] = DFT(x,ts);

%% Eg 3 含有直流分量的单频正弦信号
ts = 0.01;
t = 0:ts:1;
A = 1.5;       % 幅值  
f = 5;         % 频率
w = 2*pi*f;    % 角频率
phi = pi/6;    % 初始相位 
x = 0.5 + A*cos(w*t+phi);   % 时域信号,带有直流偏移0.5
figure
plot(t,x)
xlabel('时间/s')
ylabel('时域信号x(t)')
% DFT变换将时域转换到频域,并绘制频谱图
[f,X_m,X_phi] = DFT(x,ts);


%% Eg 4 正弦复合信号
ts = 0.01;
t = 0:ts:2;
A = [1.5 1 0.5 0.2];    % 幅值  
f = [3 6 9 15];         % 频率
w = 2*pi*f;             % 角频率
phi = (1:4)*pi/4;       % 初始相位 
x = -0.5 + A(1)*cos(w(1)*t+phi(1)) + A(2)*cos(w(2)*t+phi(2)) + A(3)*cos(w(3)*t+phi(3)) + A(4)*cos(w(4)*t+phi(4));     % 时域信号
figure
plot(t,x)
xlabel('时间/s')
ylabel('时域信号x(t)')
% DFT变换将时域转换到频域,并绘制频谱图
[f,X_m,X_phi] = DFT(x,ts);

%% Eg 5 含有随机干扰的正弦信号
ts = 0.01;
t = 0:ts:2;
A = [1 0.5];    % 幅值  
f = [3 10];         % 频率
w = 2*pi*f;             % 角频率
phi = (1:2)*pi/3;       % 初始相位 
x =  A(1)*cos(w(1)*t+phi(1)) + A(2)*cos(w(2)*t+phi(2)) + 0.8*(rand(size(t))-0.5);     % 时域信号
figure
plot(t,x)
xlabel('时间/s')
ylabel('时域信号x(t)')
% DFT变换将时域转换到频域,并绘制频谱图
[f,X_m,X_phi] = DFT(x,ts);


%% Eg 5 去除正弦信号中的随机干扰
% 频域转换时域方式2：从正弦信号的频率-幅值和频率相位关系恢复
x0 =  A(1)*cos(w(1)*t+phi(1)) + A(2)*cos(w(2)*t+phi(2));      % 无随机干扰信号  
x4 = 0;
for ii = 1:length(f)
  w0 = 2*pi*f(ii);
  if abs(X_m(ii)) > 0.2
      x4 = x4 + X_m(ii)*cos(w0*t+X_phi(ii)*pi/180);
  end
end
figure
plot(t,x0,t,x,'r--',t,x4,'k-.')
legend('无干扰原始信号','有干扰原始信号','恢复时域信号')


%% Eg 6 实际案例
load data
ts = 0.001;
x = Jsd;
t = [0:length(x)-1]*ts;
figure
plot(t,x)
xlabel('时间/s')
ylabel('时域信号x(t)')
% DFT变换将时域转换到频域,并绘制频谱图
[f,X_m,X_phi] = DFT(x,ts);

