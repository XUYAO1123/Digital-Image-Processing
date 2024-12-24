
function equalImage = equalization(~, rgbImage)
    
    histgram = imhist(rgbImage);
    [h, w] = size(rgbImage);
    equalImage = zeros(h, w, 'uint8');
    s = zeros(256);
    s(1) = histgram(1);
    % 计算累积直方图
    for t=2:256
        s(t) = s(t-1) + histgram(t);
    end
    
    for x = 1:w
        for y = 1:h
            equalImage(y,x) = uint8(255*s(rgbImage(y,x)+1)/(w*h));
        end
    end
end