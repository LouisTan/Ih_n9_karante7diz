% zigzag: returns a (NxN)-element 1D array created by zig-zagging through a NxN block
function [array] = zigzag(block)
    assert(numel(block)>0 && size(block,1)==size(block,2));
    array = zeros(size(block,1)*size(block,2),1,class(block));
    
    % @@@@ TODO (fill array)

end
