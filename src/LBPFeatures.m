% LBP特征提取函数
function lbpImage = LBPFeatures(~, image)
    [rows, cols] = size(image);
    lbpImage = zeros(rows, cols, 'uint8'); 
    for i = 2:rows-1
        for j = 2:cols-1
            center = image(i, j);
            binaryPattern = [image(i-1, j-1) >= center, image(i-1, j) >= center, image(i-1, j+1) >= center, ...
                             image(i, j+1) >= center, image(i+1, j+1) >= center, image(i+1, j) >= center, ...
                             image(i+1, j-1) >= center, image(i, j-1) >= center];
            lbpImage(i, j) = bi2de(binaryPattern, 'left-msb');
        end
    end
end