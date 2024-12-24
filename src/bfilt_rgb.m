% 双边滤波
function NewImage = bfilt_rgb(~, image, w, sigma_s, sigma_r)
    image = im2double(image);

    [X, Y] = meshgrid(-w:w, -w:w);

    % 计算空间权重
    Gs = exp(-(X.^2 + Y.^2) / (2 * sigma_s^2));

    dim = size(image);
    NewImage = zeros(dim);

    for i = 1:dim(1)
        for j = 1:dim(2)
            % 确定作用区域的边界
            mni = max(i - w, 1);
            mxi = min(i + w, dim(1));
            mnj = max(j - w, 1);
            mxj = min(j + w, dim(2));
            % 提取该区域的源图像值赋给 I
            I = image(mni:mxi, mnj:mxj, :); 
            % 计算灰度临近权值
            Gr = exp(-(sum((I - image(i, j, :)).^2, 3)) / (2 * sigma_r^2));
            % W 为 Gr 和 Gs 的乘积, 计算加权平均并赋值给新图像
            W = Gr .* Gs((mni:mxi) - i + w + 1, (mnj:mxj) - j + w + 1);
            NewImage(i, j, :) = sum(sum(W .* I, 1), 2) / sum(W(:));
        end
    end
end