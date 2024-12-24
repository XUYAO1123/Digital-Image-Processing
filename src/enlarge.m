function enlargedImage = enlarge(~, input_image, sx, sy)
    [height, width, channels] = size(input_image);
    newWidth = width * sx;
    newHeight = height * sy;
    newWidth = floor(newWidth);
    newHeight = floor(newHeight);
    enlargedImage = uint8(zeros(newHeight, newWidth, channels));
    % 双线性插值
    for x = 1:newWidth
        for y = 1:newHeight
            
            px = x / sx;
            py = y / sy;
            
            % 寻找四个最近的像素
            x1 = max(1, floor(px));
            x2 = min(x1 + 1, width);
            y1 = max(1, floor(py));
            y2 = min(y1 + 1, height);
            
            % 计算插值权重
            a = px - x1;
            b = py - y1;
            
            for c = 1:channels
                pixelValue = (1 - a) * (1 - b) * double(input_image(y1, x1, c)) + ...
                             a * (1 - b) * double(input_image(y1, x2, c)) + ...
                             (1 - a) * b * double(input_image(y2, x1, c)) + ...
                             a * b * double(input_image(y2, x2, c));
                enlargedImage(y, x, c) = uint8(round(pixelValue));
            end
        end
    end
end