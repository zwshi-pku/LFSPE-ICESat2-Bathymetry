function plot_points_and_line(x1, y1, lines, radii)
% 提取直线的斜率和截距
slope = lines(1);
intercept = lines(2);

% 定义 x 范围用于绘制直线
x_range = linspace(x1-radii, x1+radii, 100);

% 根据直线方程计算 y 值
y_range = slope * x_range + intercept;

% 绘制直线
plot(x_range, y_range, 'b-', 'LineWidth', 1.5);
end
