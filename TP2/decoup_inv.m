% decoup_inv: reconstructs a 2D image (i.e. always single channel) from a block array
function [img] = decoup_inv(blocks,img_size)
    assert(numel(blocks)>0 && size(blocks,1)==size(blocks,2));
    block_size = size(blocks,1);
    assert(numel(img_size)==2 && img_size(1)*img_size(2)>0 && mod(img_size(1),block_size)==0 && mod(img_size(2),block_size)==0);
    %img = zeros(img_size,'uint8');
    n = img_size(1)/size(blocks,1);
    m = 0;
    img = [];
    
    for j = 1:n
        line = [];
        for k = 1:n
            m = m + 1;
            line = [line blocks(:,:,m)];
        end
        img = [img ; line];
    end
end
