% conv_rgb2ycbcr: converts an 8-bit-depth RGB image to Y'CbCr format using optional 4:2:0 subsampling
function [Y, Cb, Cr] = conv_rgb2ycbcr(RGB, subsample)
    assert(numel(RGB)>0 && size(RGB,3)==3);
    Y = zeros(size(RGB,1),size(RGB,2),'uint8');
    
    R = RGB(:,:,1);
    G = RGB(:,:,2);
    B = RGB(:,:,3);
    
    img_s = size(RGB);
    
    RGB_420 = [];
    
    p = 1:img_s(3);
    n = 1:2:img_s(1);
    m = 1:2:img_s(2);
    
    z = 1;
    for k = p
        y = 1;
        for j = m
            x = 1;
            for i = n
                RGB_420(x,y,z) = RGB(i,j,k);
                x = x + 1;
            end
        y = y + 1;    
        end
    z = z + 1;
    end

    disp(RGB_test);
            
    
    
%     %4:4:4
%     if subsample
%         Cb = zeros(...,'uint8');
%         Cr = zeros(...,'uint8');
%         
%     %4:2:0   
%     else
%         Cb = zeros(...,'uint8');
%         Cr = zeros(...,'uint8');   
%     end
end