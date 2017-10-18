% conv_rgb2ycbcr: converts an 8-bit-depth RGB image to Y'CbCr format using optional 4:2:0 subsampling
function [Y, Cb, Cr] = conv_rgb2ycbcr(RGB, subsample)
    assert(numel(RGB)>0 && size(RGB,3)==3);
    %Y = zeros(size(RGB,1),size(RGB,2),'uint8');
    img_s = size(RGB,1);
    
    %4:4:2
    %On n'a besoin que de l'information d'un pixel sur deux pour obtenir
    %les valeurs de Cb et Cr
    if subsample
        R = double(RGB(1:2:img_s,1:2:img_s,1));
        G = double(RGB(1:2:img_s,1:2:img_s,2));
        B = double(RGB(1:2:img_s,1:2:img_s,3));
    %4:4:4  
    else
        R = double(RGB(:,:,1));
        G = double(RGB(:,:,2));
        B = double(RGB(:,:,3));
    end
    
    Y = double(.299*R + 0.587*G + 0.114*B);
    Cb = double(128 + 0.564*(B - Y));
    Cr = double(128 + 0.713*(R - Y));
    
    %Pour recalculer la luminance sans perte
    if subsample
        R = double(RGB(:,:,1));
        G = double(RGB(:,:,2));
        B = double(RGB(:,:,3));
    end
    
    Y = double(0.299*R + 0.587*G + 0.114*B);
end