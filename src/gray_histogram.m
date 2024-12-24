%灰度直方图
function histogram = gray_histogram(~, image)
    histogram = zeros(256, 1);
    [height, width] = size(image);

    for x = 1:width
        for y = 1:height
            pixelValue = image(y, x) + 1;	
            histogram(pixelValue) = histogram(pixelValue) + 1;
        end
    end
end