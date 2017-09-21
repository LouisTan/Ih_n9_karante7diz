% conv_ycbcr2rgb: converts an 8-bit-depth YCbCr image to RGB format considering optional 4:2:0 subsampling
function [RGB] = conv_ycbcr2rgb(Y, Cb, Cr, subsample)
    assert(numel(Y)>0 && size(Y,3)==1 && numel(Cb)>0 && size(Cb,3)==1  && numel(Cr)>0 && size(Cr,3)==1);
    assert(~subsample || (size(Y,1)/2==size(Cb,1) && size(Y,1)/2==size(Cr,1) && size(Y,2)/2==size(Cb,2) && size(Y,2)/2==size(Cr,2)));
    assert(subsample || (isequal(size(Y),size(Cb)) && isequal(size(Y),size(Cr))));
    RGB = zeros([size(Y,1) size(Y,2) 3],'uint8');

    % @@@@ TODO (do not use built-in functions here!)

end