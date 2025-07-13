function plot_points_and_lines(x1, y1, lines, radii)
    % plot_points_and_lines 在同一个图中绘制点和相应的直线
    %
    % 输入参数:
    %   x1 - n x 1 的向量，存储 x 坐标
    %   y1 - n x 1 的向量，存储 y 坐标
    %   lines - n x 2 的矩阵，第一列为斜率，第二列为截距

    figure; % 创建一个新图窗口
    hold on; % 保持当前图形

    % 遍历每一行来画出直线和点
    for i = 1:length(x1)
        % 提取直线的斜率和截距
        slope = lines(i, 1);
        intercept = lines(i, 2);

        % 定义 x 范围用于绘制直线
        x_range = linspace(x1(i)-radii(i), x1(i)+radii(i), 100);

        % 根据直线方程计算 y 值
        y_range = slope * x_range + intercept;

        % 绘制直线
        plot(x_range, y_range, 'b-', 'LineWidth', 1.5);
    end

    % 绘制点
    plot(x1, y1, 'r*');

    xlabel('X');
    ylabel('Y');
    title('Points and their corresponding lines');
    grid on; % 添加网格线
    hold off; % 释放图形
end
