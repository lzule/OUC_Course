clear;clc;
%% 定义全局参数，TEM波，为了视觉效果，参数取值均为1
e0 = 1e-9/(4*pi*3*3); % 真空介电常数
u0 = 4*pi*1e-7; % 真空磁导率
er = 1; % 相对介电常数
ur = 1; % 相对磁介质
t = 1:0.05:20; % 时间
y = 0:0.2:25; % 传播距离
w = 1; % 角频率
k = 1; % 相位常数
Ezm = 1; % 电场Z方向最大幅值
theta_z= 0; % Z方向相位
nita = 1; % sqrt((u0*ur)/(e0*er))
%% 计算得到电磁场的传播公式，普通的传播
% 定义电场表达式，电磁波传播方向为y方向
Ez_f = @(t, y) Ezm*cos(w*t - k*y + theta_z);
Hx_f = @(t, y) Ezm/nita*cos(w*t - k*y + theta_z);
%% 制作出动画，普通电磁波的传播，三维图
[yc, zc, xc] = cylinder(1, 500);
xc= xc*25;
filename = 'norm_e_b.gif';
fps = 30;
h = figure(1);
for t_iter = t
    clf
    set(h, 'render', 'painter', 'color', 'w');
    set(gca,'XDir','reverse');        %将x轴方向设置为反向(从右到左递增)。
    set(gca,'YDir','reverse');        %将y轴方向设置为反向(从右到左递增)。
    set(gca,'XAxisLocation','origin'); 
    set(gca,'YAxisLocation','origin');
    %添加四条命令，隐藏坐标轴
    ax=gca;
    ax.XAxis.Visible='off';
    ax.YAxis.Visible='off';
    ax.ZAxis.Visible='off';
    surface(yc, xc, zc, 'facecolor', 'none', 'edgecolor', 'red', ... 
    'edgealpha', 0.02); % 绘制一层薄纱，增加图像效果
    hold on
    view(-68.2840, 29.2732)  % 确定观看角度
    % 绘制三个轴，显示传播方向
    quiver3(0, 0, 0, 0, 28, 0, ...
        0, 'k', 'linewidth', 1, 'maxhead', 0.04)
    quiver3(0, 0, 0, 1, 0, 0, ...
        0, 'k', 'linewidth', 1, 'maxhead', 0.04)
    quiver3(0, 0, 0, 0, 0, 1, ...
        0, 'k', 'linewidth', 1, 'maxhead', 0.04)
    % 计算电场和磁场分布
    Ez = Ez_f(t_iter, y);
    Hx = Hx_f(t_iter, y);
    line(zeros(size(y)), y, Ez, 'color', 'r', 'linewidth', 2); % 将分布散点连成线，便于观看
    quiver3(zeros(size(y)), y, zeros(size(y)), zeros(size(y)), zeros(size(y)), Ez,...
        0, 'k', 'linewidth', 1, 'maxhead', 0.005, 'Color', [1, 0, 0]); % 绘制三维箭头，表示电场大小

    line(Hx, y, zeros(size(y)), 'color', 'b', 'linewidth', 2); % 将分布散点连成线，便于观看
    quiver3(zeros(size(y)), y, zeros(size(y)), Hx, zeros(size(y)), zeros(size(y)),...
        0, 'k', 'linewidth', 1, 'maxhead', 0.005, 'Color', [0, 0, 1]); % 绘制三维箭头，表示磁场大小
    pause(0.001)
    % 保存为gif文件
    drawnow
    frame = getframe(h);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,32);
    if t_iter == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1/fps);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1/fps);
    end
end
%% 真空中电磁场的正常传播
[X, Y] = meshgrid(-20:0.1:20);
% 进行绘制
filename = 'spread_e_b.gif';
fps = 30;
h = figure(2);
for t_iter = t
    clf
    hold on
    view(0, 90)
    Ez = Ez_f(t_iter, Y);
    scatter(X(:), Y(:), [], Ez(:)); % 散点图绘制
%     pcolor(X, Y, Ez); % 另外一种画法，散点图效果最好
    colormap(jet); % 增加色度
    colorbar;
    axis equal
    %添加四条命令，隐藏坐标轴
    ax=gca;
    ax.XAxis.Visible='off';
    ax.YAxis.Visible='off';
    ax.ZAxis.Visible='off';
    axis image off
    pause(0.01)
    % 保存为gif文件
    drawnow
    frame = getframe(h);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,32);
    if t_iter == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1/fps);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1/fps);
    end
end
%% 加入各项异性材料的介电常数后，电磁场的传播，查看隐身效果（首先看圆柱形的）
% 坐标变换函数获取坐标值
[X, Y] = meshgrid(-20:0.1:20);
[x, y, z] = transformate_cycle(X, Y, zeros(size(X)), 5, 10); % transformate_cycle为坐标变换函数，进行坐标变换
% 进行绘制
filename = 'spread_e_b_cycle.gif';
fps = 30;
h = figure(3);
for t_iter = t
    clf
    hold on
    view(0, 90)  % 顶视图查看
    Ez = Ez_f(t_iter, Y);
    scatter(x(:), y(:), [], Ez(:), '.');
%     pcolor(x, y, Ez);
    colormap(jet);
    colorbar;
    axis equal
    %添加四条命令，隐藏坐标轴
    ax=gca;
    ax.XAxis.Visible='off';
    ax.YAxis.Visible='off';
    ax.ZAxis.Visible='off';
    axis image off
    pause(0.01)
    % 保存为gif文件
    drawnow
    frame = getframe(h);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,32);
    if t_iter == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1/fps);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1/fps);
    end
end