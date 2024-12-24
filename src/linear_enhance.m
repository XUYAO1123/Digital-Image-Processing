% 线性变换
function NewIMage = linear_enhance(~, image, alpha)
    NewIMage = tan(alpha/180*pi) * double(image);
    NewIMage = uint8(max(0, min(255, NewIMage)));
end