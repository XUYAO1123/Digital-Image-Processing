function NewImage = laplacian(~, f, T)
    [m, n] = size(f);
    NewImage = zeros(m, n);

    for i = 2:m-1
        for j = 2:n-1
            % 计算Laplacian梯度
            NewImage(i, j) = 4 * f(i, j) - f(i-1, j) - f(i+1, j) - f(i, j-1) - f(i, j+1);

            % 阈值处理
            if NewImage(i, j) < T
                NewImage(i, j) = 0;
            else
                NewImage(i, j) = 255;
            end
        end
    end
    NewImage = uint8(NewImage);
end