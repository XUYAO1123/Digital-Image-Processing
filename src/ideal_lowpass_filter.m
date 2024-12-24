% 理想低通滤波
function NewImage = ideal_lowpass_filter(~, noise_image, d0)
    [rows, cols, channels] = size(noise_image);
    NewImage = zeros(rows, cols, channels);
    NewImage = uint8(NewImage);
    for c = 1:channels
        % 获取当前通道的灰度图像
        grayscale_channel = noise_image(:, :, c);
         % 进行傅里叶变换并中心化
        FftImage=fftshift(fft2(double(grayscale_channel)));
        [N,M]=size(FftImage);
        filtered_channel=zeros(N,M);
        % 计算频谱中心
        r1=floor(M/2);r2=floor(N/2);
        for x = 1:M
            for y = 1:N
                % 计算频率距离
                d = sqrt((x - r1)^2 + (y - r2)^2);
                % 应用理想低通滤波器
                if d <= d0
                    h = 1; % 低频保留
                else
                    h = 0; % 高频滤除
                end
                % 滤波
                filtered_channel(y, x) = h * FftImage(y, x);
            end
        end
        % 逆傅里叶变换并转换为实数
        filtered_channel=real(ifft2(ifftshift(filtered_channel)));
        filtered_channel=uint8(filtered_channel);
        NewImage(:,:,c)=filtered_channel;
    end
end