function angle = calculateAngle(m1, m2)
    % 计算两条直线之间的夹角
    % 输入：
    %   m1 - 第一条直线的斜率
    %   m2 - 第二条直线的斜率
    % 输出：
    %   angle - 两条直线之间的夹角，单位为度

    % 使用 atan 和 abs 计算夹角的弧度
    radian = atan(abs((m2 - m1) / (1 + m1 * m2)));

    % 将弧度转换为度
    angle = radian * (180 / pi);

    % 输出夹角
%     fprintf('两条直线的夹角为 %.2f 度\n', angle);
end
