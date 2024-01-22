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
%     subplot(3, 3, (plot_i-1)*3+1)
%     plot(1:N, data(1:N))
%     xlabel('采样点')
%     ylabel('V')
%     title('电机电压')
    S_y = zeros([fix(length(data)/N)*N, 1]); % 存储总的功率谱
    S_y_mean = zeros([fix(N/2), 1]);         % 存储总的功率谱平均值
    S_x_mean = (0:(length(S_y_mean)-1)).*2;  % S_y_mean的横坐标
    S_x = zeros([fix(length(data)/N)*N, 1]); % 存储对应S_y的横坐标
    for j=1:fix(length(data)/N)
        [f,X_m,X_phi] = DFT(data(((j-1)*N+1):j*N), sam_tim, N, 0); % 进行离散傅里叶单边变换
        S = (X_m.^2)/N; % 计算功率谱S-f
        S_y((j-1)*N/2+1:j*N/2) = S;
        S_x((j-1)*N/2+1:j*N/2) = f;
        S_y_mean = S_y_mean + S;
    end
%     subplot(9, 3, (plot_i-1)*3+2)
%     scatter(S_x, S_y, '.'); % 平均功率谱
%     xlabel('Hz')
%     ylabel('V^2/Hz')
%     title('功率谱-频率')
    subplot(3, 3, plot_i)
    S_x_mean = f;
    plot(S_x_mean, S_y_mean/i); % 平均功率谱
    xlabel('Hz')
    ylabel('V^2/Hz')
    legend(strcat('缠绕程度—', num2str(i)))
    title('功率谱-频率')
end
%% req_2：使用不同的信号长度，绘制功率谱，并观察区别；
for i=20:10:100
    figure_i = (i)/10;
    data_name = strcat('data', num2str(i));
    data = eval(data_name);  % 获取变量数据
    figure(figure_i)
    for N=1000:1000:5000
        plot_i = N/1000;
        S_y = zeros([fix(length(data)/N)*N, 1]); % 存储总的功率谱
        S_y_mean = zeros([fix(N/2), 1]);         % 存储总的功率谱平均值
        S_x_mean = (0:(length(S_y_mean)-1)).*2;  % S_y_mean的横坐标
        S_x = zeros([fix(length(data)/N)*N, 1]); % 存储对应S_y的横坐标
        for j=1:fix(length(data)/N)
            [f,X_m,X_phi] = DFT(data(((j-1)*N+1):j*N), sam_tim, N, 0); % 进行离散傅里叶单边变换
            S = (X_m.^2)/N; % 计算功率谱S-f
            S_y((j-1)*N/2+1:j*N/2) = S;
            S_x((j-1)*N/2+1:j*N/2) = f;
            S_y_mean = S_y_mean + S;
        end
        subplot(2, 5, plot_i)
        scatter(S_x, S_y, '.'); % 功率谱
        title(strcat('N=', num2str(N)))
        subplot(2, 5, 5 + plot_i)
        S_x_mean = f;
        plot(S_x_mean, S_y_mean/i); % 平均功率谱
        title(strcat('N=', num2str(N)))
    end
end
%% req_3：向信号中添加噪声，观察功率谱的区别
%local config
N = 500; % 计算的随机序列长度
data_name = strcat('data', num2str(20)); % data20
data = eval(data_name);  % 获取变量数据
figure(figure_i+1)
% 绘制无噪声情况
plot_i = 1;
[f,X_m,X_phi] = DFT(data(1:N), sam_tim, N, 0); % 进行离散傅里叶单边变换
S = (X_m.^2)/N; % 计算功率谱S-f
subplot(2, 5, plot_i)
scatter(S_x, S_y, '.'); % 功率谱
title(strcat('平均功率谱 无噪声'))
subplot(2, 5, 5 + plot_i)
plot(S_x_mean, S_y_mean/i); % 平均功率谱
title(strcat('平均功率谱 无噪声'))
% 加入不同信噪比的高斯白噪声信号
for nsr=0.05:0.2:0.8
    plot_i = fix(nsr/0.2) + 2;
    data_with_noise = awgn(data, nsr);
    S_y = zeros([fix(length(data_with_noise)/N)*N, 1]); % 存储总的功率谱
    S_y_mean = zeros([fix(N/2), 1]);         % 存储总的功率谱平均值
    S_x_mean = (0:(length(S_y_mean)-1)).*2;  % S_y_mean的横坐标
    S_x = zeros([fix(length(data_with_noise)/N)*N, 1]); % 存储对应S_y的横坐标
    for j=1:fix(length(data_with_noise)/N)
        [f,X_m,X_phi] = DFT(data_with_noise(((j-1)*N+1):j*N), sam_tim, N, 0); % 进行离散傅里叶单边变换
        S = (X_m.^2)/N; % 计算功率谱S-f
        S_y((j-1)*N/2+1:j*N/2) = S;
        S_x((j-1)*N/2+1:j*N/2) = f;
        S_y_mean = S_y_mean + S;
    end
    subplot(2, 5, plot_i)
    scatter(S_x, S_y, '.'); % 功率谱
    title(strcat('white gauss nsr=', num2str(nsr)))
    subplot(2, 5, 5 + plot_i)
    plot(S_x_mean, S_y_mean/i); % 平均功率谱
    title(strcat('white gauss nsr=', num2str(nsr)))
end
% 绘制无噪声情况
figure(figure_i+2)
plot_i = 1;
[f,X_m,X_phi] = DFT(data(1:N), sam_tim, N, 0); % 进行离散傅里叶单边变换
S = (X_m.^2)/N; % 计算功率谱S-f
subplot(2, 5, plot_i)
scatter(S_x, S_y, '.'); % 功率谱
title(strcat('平均功率谱 无噪声'))
subplot(2, 5, 5 + plot_i)
plot(S_x_mean, S_y_mean/i); % 平均功率谱
title(strcat('平均功率谱 无噪声'))
% 加入不同分布的高斯随机噪声
for mes=0.1:3:12
    plot_i = fix(mes/3)+2;
    data_with_noise = data + randn(size(data));
    S_y = zeros([fix(length(data_with_noise)/N)*N, 1]); % 存储总的功率谱
    S_y_mean = zeros([fix(N/2), 1]);         % 存储总的功率谱平均值
    S_x_mean = (0:(length(S_y_mean)-1)).*2;  % S_y_mean的横坐标
    S_x = zeros([fix(length(data_with_noise)/N)*N, 1]); % 存储对应S_y的横坐标
    for j=1:fix(length(data_with_noise)/N)
        [f,X_m,X_phi] = DFT(data_with_noise(((j-1)*N+1):j*N), sam_tim, N, 0); % 进行离散傅里叶单边变换
        S = (X_m.^2)/N; % 计算功率谱S-f
        S_y((j-1)*N/2+1:j*N/2) = S;
        S_x((j-1)*N/2+1:j*N/2) = f;
        S_y_mean = S_y_mean + S;
    end
    subplot(2, 5, plot_i)
    scatter(S_x, S_y, '.'); % 功率谱
    title(strcat('random gauss mes=', num2str(mes)))
    subplot(2, 5, 5 + plot_i)
    S_x_mean = f;
    plot(S_x_mean, S_y_mean/i); % 平均功率谱
    title(strcat('平均功率谱 random gauss mes=', num2str(mes)))
end