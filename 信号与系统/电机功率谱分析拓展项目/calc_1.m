clear;clc
load data.mat
%% global config
sam_f = 1000; % 采样频率
sam_tim = 1/sam_f; % 采样时间间隔
%% local config
N = 500; % 计算的随机序列长度,
%% req_1：编写程序，绘制不同程度缠绕干扰下，电机电压的功率谱，并观察区别；
figure(1)
for i=20:10:100
    plot_i = (i-10)/10;
    data_name = strcat('data', num2str(i));
    data = eval(data_name);  % 获取变量数据
    [f,X_m,X_phi] = DFT(data(1:N), sam_tim, N, 0); % 进行离散傅里叶单边变换
    S = (X_m.^2)/N; % 计算功率谱S-f
    subplot(3, 3, plot_i)
    plot(f, S)
    xlabel('Hz')
    ylabel('功率谱密度 V^2/Hz')
    title('功率谱密度')
    legend(strcat('缠绕程度—', num2str(i)))
end
%% req_2：使用不同的信号长度，绘制功率谱，并观察区别；
for i=20:10:100
    figure_i = (i)/10;
    data_name = strcat('data', num2str(i));
    data = eval(data_name);  % 获取变量数据
    figure(figure_i)
    for N=1000:1000:6000
        plot_i = N/1000;
        [f,X_m,X_phi] = DFT(data(1:N), sam_tim, N, 0); % 进行离散傅里叶单边变换
        S = (X_m.^2)/N; % 计算功率谱S-f
        subplot(2, 3, plot_i)
        plot(f, S);
        title(strcat('功率谱密度 N=', num2str(N)))
        xlabel('Hz')
        ylabel('V^2/Hz')
        legend(strcat('缠绕程度—', num2str(i)))
    end
end
%% req_3：向信号中添加噪声，观察功率谱的区别
%local config
N = 500; % 计算的随机序列长度
level = 20;
data_name = strcat('data', num2str(level)); % data20
data = eval(data_name);  % 获取变量数据
figure(figure_i+1)
% 绘制无噪声情况
plot_i = 1;
[f,X_m,X_phi] = DFT(data(1:N), sam_tim, N, 0); % 进行离散傅里叶单边变换
S = (X_m.^2)/N; % 计算功率谱S-f
subplot(2, 3, plot_i)
plot(f, S); % 平均功率谱
title(strcat('平均功率谱 无噪声'))
legend(strcat('缠绕程度—', num2str(level)))
% 加入不同信噪比的高斯白噪声信号
for nsr=0.05:0.2:0.85
    plot_i = fix(nsr/0.2) + 2;
    data_with_noise = awgn(data, nsr);
    [f,X_m,X_phi] = DFT(data_with_noise(1:N), sam_tim, N, 0); % 进行离散傅里叶单边变换
    S = (X_m.^2)/N; % 计算功率谱S-f
    subplot(2, 3, plot_i)
    plot(f, S); % 平均功率谱
    title(strcat('平均功率谱 white gauss nsr=', num2str(nsr)))
    legend(strcat('缠绕程度—', num2str(level)))
end
figure(figure_i+2)
% 绘制无噪声情况
plot_i = 1;
[f,X_m,X_phi] = DFT(data(1:N), sam_tim, N, 0); % 进行离散傅里叶单边变换
S = (X_m.^2)/N; % 计算功率谱S-f
subplot(2, 3, plot_i)
plot(f, S); % 平均功率谱
title(strcat('平均功率谱 无噪声'))
legend(strcat('缠绕程度—', num2str(level)))
% 加入不同分布的高斯随机噪声
for mes=0.1:3:15
    plot_i = fix(mes/3)+2;
    data_with_noise = data + randn(size(data));
    [f,X_m,X_phi] = DFT(data_with_noise(1:N), sam_tim, N, 0); % 进行离散傅里叶单边变换
    S = (X_m.^2)/N; % 计算功率谱S-f
    subplot(2, 3, plot_i)
    plot(f, S); % 平均功率谱
    title(strcat('平均功率谱 random gauss mes=', num2str(mes)))
    legend(strcat('缠绕程度—', num2str(level)))
end