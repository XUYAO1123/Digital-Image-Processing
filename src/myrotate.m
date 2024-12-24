function rotatedImage = myrotate(~, input_image, deg)
    [height, width, ~] = size(input_image);

    % 旋转中心
    center_x = width / 2;
    center_y = height / 2;

    % 旋转矩阵
    rotation_matrix = [cosd(deg), -sind(deg); sind(deg), cosd(deg)];

    rotatedImage = uint8(zeros(height, width, 3));

    % 计算旋转后图像的位置
    for y = 1:height
        for x = 1:width
            % 在原始图像中的坐标
            pcoord = rotation_matrix * ([x - center_x; y - center_y]) + [center_x; center_y];
            px = pcoord(1);
            py = pcoord(2);

            % 双线性插值
            x1 = floor(px);
            x2 = ceil(px);
            y1 = floor(py);
            y2 = ceil(py);

            if x1 >= 1 && x2 <= width && y1 >= 1 && y2 <= height
                Q11 = input_image(y1, x1, :);
                Q12 = input_image(y2, x1, :);
                Q21 = input_image(y1, x2, :);
                Q22 = input_image(y2, x2, :);

                x_diff = px - x1;
                y_diff = py - y1;

                interpolated_pixel = (1 - x_diff) * (1 - y_diff) * double(Q11) + ...
                    x_diff * (1 - y_diff) * double(Q21) + ...
                    (1 - x_diff) * y_diff * double(Q12) + ...
                    x_diff * y_diff * double(Q22);

                rotatedImage(y, x, :) = uint8(interpolated_pixel);
            end
        end
    end
end
