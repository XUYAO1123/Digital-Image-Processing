
function hogFeatures = HOGFeatures(~, image)
    % Sobel算子计算梯度
    Gx = [-1 0 1; -2 0 2; -1 0 1];
    Gy = Gx';
    gradX = conv2(double(image), Gx, 'same');
    gradY = conv2(double(image), Gy, 'same');
    
    % 计算梯度幅值和方向
    magnitude = sqrt(gradX.^2 + gradY.^2);
    angle = atan2(gradY, gradX);
    
    % 将角度转换为0到180度
    angle = angle * (180 / pi);
    angle(angle < 0) = angle(angle < 0) + 180;
    
    % 分块计算HOG特征
    cellSize = 8;
    [rows, cols] = size(image);
    hogFeatures = zeros(rows, cols);
    for i = 1:cellSize:rows-cellSize
        for j = 1:cellSize:cols-cellSize
            blockMag = magnitude(i:i+cellSize-1, j:j+cellSize-1);
            blockAngle = angle(i:i+cellSize-1, j:j+cellSize-1);
            hist = zeros(1, 9);
            for k = 1:cellSize
                for l = 1:cellSize
                    bin = floor(blockAngle(k, l) / 20) + 1;
                    if bin > 9
                        bin = 9;
                    end
                    hist(bin) = hist(bin) + blockMag(k, l);
                end
            end
            % 将直方图值放入特征图中
            hogFeatures(i:i+cellSize-1, j:j+cellSize-1) = sum(hist);
        end
    end

    hogFeatures = uint8(255 * mat2gray(hogFeatures));
end