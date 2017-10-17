% conv_ycbcr2rgb: converts an 8-bit-depth YCbCr image to RGB format considering optional 4:2:0 subsampling
function [RGB] = conv_ycbcr2rgb(Y, Cb, Cr, subsample)
    assert(numel(Y)>0 && size(Y,3)==1 && numel(Cb)>0 && size(Cb,3)==1  && numel(Cr)>0 && size(Cr,3)==1);
    assert(~subsample || (size(Y,1)/2==size(Cb,1) && size(Y,1)/2==size(Cr,1) && size(Y,2)/2==size(Cb,2) && size(Y,2)/2==size(Cr,2)));
    assert(subsample || (isequal(size(Y),size(Cb)) && isequal(size(Y),size(Cr))));
    %RGB = zeros([size(Y,1) size(Y,2) 3],'uint8');
    img_s = size(Y,1);
    
    Cb_1 = [];
    Cr_1 = [];
    
    Cb_2 = [];
    Cr_2 = [];
    
    n = 0;
    m = 1;
    
    %4:4:2
    if subsample
        for j=1:2:img_s
            for k=1:2:img_s
                Cb_1(k) = Cb(n*img_s/2 + m);
                Cb_1(k + 1) = Cb(n*img_s/2 + m);
                
                Cr_1(k) = Cr(n*img_s/2 + m);
                Cr_1(k + 1) = Cr(n*img_s/2 + m);
                
                m = m + 1;
            end
            Cb_2(:,j) = Cb_1;
            Cb_2(:,j+1) = Cb_1;
            
            Cr_2(:,j) = Cr_1;
            Cr_2(:,j+1) = Cr_1;
            
            n = n + 1;
            m = 1;
        end
        
        Cb = double(Cb_2);
        Cr = double(Cr_2);
        Y = double(Y);
    end
    
    RGB(:,:,1) = Y + 1.402*(Cr - 128);
    RGB(:,:,2) = Y - 0.714*(Cr - 128) - 0.344*(Cb - 128);
    RGB(:,:,3) = Y + 1.773*(Cb - 128);

end