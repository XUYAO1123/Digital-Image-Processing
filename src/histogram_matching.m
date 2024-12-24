function mapping_table = histogram_matching(app, input_histogram, target_histogram)
    % 获取累积直方图
    input_cumulative = cumsum(input_histogram) / sum(input_histogram);
    target_cumulative = cumsum(target_histogram) / sum(target_histogram);

    % 映射表
    mapping_table = zeros(256, 1, 'uint8');
    
    % 进行直方图匹配
    for i = 1:256
        [~, index] = min(abs(target_cumulative - input_cumulative(i)));
        mapping_table(i) = index - 1;
    end
end