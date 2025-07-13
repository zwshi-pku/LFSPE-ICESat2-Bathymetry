function adjusted_x = adjust_intervals(x, interval)
    % 目标间隔
    if isempty(interval)
        interval = 0.7
    end

    % 初始化调整后的数组
    adjusted_x = x;  % 从原始数据复制

    % 获取所有唯一的非零值，保持顺序
    unique_values = unique(x(x ~= 0), 'stable');
    
    % 按照0.7的间隔标准化非零值
    for i = 1:length(unique_values)
        target_value = (i) * interval;
        adjusted_x(x == unique_values(i)) = target_value;
    end
end
