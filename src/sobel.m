function NewImage = sobel(~, f, T)
    [m, n] = size(f);
    NewImage = zeros(m, n);

    for i = 2:m-1
        for j = 2:n-1
            % 计算Sobel梯度
            Gx = f(i-1, j-1) + 2*f(i, j-1) + f(i+1, j-1) - f(i-1, j+1) - 2*f(i, j+1) - f(i+1, j+1);
            Gy = f(i+1, j-1) + 2*f(i+1, j) + f(i+1, j+1) - f(i-1, j-1) - 2*f(i-1, j) - f(i-1, j+1);
            NewImage(i, j) = abs(Gx) + abs(Gy);

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