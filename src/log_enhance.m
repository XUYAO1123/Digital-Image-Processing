% 对数变换
function NewIMage = log_enhance(~, image, c)
    NewIMage = c * log(1 + double(image));
    NewIMage = uint8(max(0, min(255, NewIMage)));
end