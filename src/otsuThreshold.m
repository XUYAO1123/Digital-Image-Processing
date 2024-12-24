% OTSU阈值计算函数
function level = otsuThreshold(~, I)
    counts = imhist(I);
    total = sum(counts);
    sumB = 0;
    wB = 0;
    maximum = 0.0;
    sum1 = dot(0:255, counts);
    for ii = 1:256
        wB = wB + counts(ii);
        if wB == 0
            continue;
        end
        wF = total - wB;
        if wF == 0
            break;
        end
        sumB = sumB + (ii - 1) * counts(ii);
        mB = sumB / wB;
        mF = (sum1 - sumB) / wF;
        between = wB * wF * (mB - mF) ^ 2;
        if between >= maximum
            level = ii - 1;
            maximum = between;
        end
    end
end