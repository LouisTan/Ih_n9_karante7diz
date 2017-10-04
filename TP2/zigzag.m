% zigzag: returns a (NxN)-element 1D array created by zig-zagging through a NxN block
function [array] = zigzag(block)
    assert(numel(block)>0 && size(block,1)==size(block,2));
    %array = zeros(size(block,1)*size(block,2),1,class(block));
    array = [];
    block_size = 8;
    
    for i = 0:block_size*2-1
        j = max(0,i-block_size+1);
        while (j <= i && j < block_size)
            if mod(i,2) == 0
                array(end+1) = block(j*(block_size-1)+i+1);
            else
                array(end+1) = block((i-j)*block_size+j+1);
            end
            j = j+1;
            
        end
    end
end
