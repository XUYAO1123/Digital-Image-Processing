% 指数变换
function NewIMage = exp_enhance(~, image, a, b, c)
    NewIMage = power(b, c * (image - a)) - 1;
    NewIMage = uint8(max(0, min(255, NewIMage)));
end