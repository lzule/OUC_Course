%% Eg 1 单频正弦信号
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
% iDFT逆变换将频域转换到时域,并绘制时域图
[xn,t2] = iDFT(X_m,X_phi,ts);
hold on
plot(t,x,'r--')
legend('恢复的时域信号','原始时域信号')

%% Eg 2 含有直流分量的单频正弦信号
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
% iDFT逆变换将频域转换到时域,并绘制时域图
[xn,t2] = iDFT(X_m,X_phi,ts);
hold on
plot(t,x,'r--')
legend('恢复的时域信号','原始时域信号')


%% Eg 3 正弦复合信号
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
% iDFT逆变换将频域转换到时域,并绘制时域图
[xn,t2] = iDFT(X_m,X_phi,ts);
hold on
plot(t,x,'r--')
legend('恢复的时域信号','原始时域信号')


%% Eg 4 含有随机干扰的正弦信号
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
% iDFT逆变换将频域转换到时域,并绘制时域图
[xn,t2] = iDFT(X_m,X_phi,ts);
hold on
plot(t,x,'r--')
legend('恢复的时域信号','原始时域信号')





%% Eg 5 实际案例
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
% iDFT逆变换将频域转换到时域,并绘制时域图
[xn,t2] = iDFT(X_m,X_phi,ts);
hold on
plot(t,x,'r--')
legend('恢复的时域信号','原始时域信号')

