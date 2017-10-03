% zigzag_inv: returns an NxN block created by de-zigzagging through a (NxN)-element 1D array
function [block] = zigzag_inv(array)
    assert(numel(array)>0 && sqrt(numel(array))==floor(sqrt(numel(array))));
    
    idx = 1;
    block_size = sqrt(numel(array));
    
    block = zeros(block_size,block_size,class(array));
    
    for i=0:block_size*2-1
        j = max(0,i-block_size+1);
        while (j<=i &&  j<block_size)
            if mod(i,2)==0
                block(j*(block_size-1)+i+1) = array(idx);
            else
                block((i-j)*block_size+j+1) = array(idx);
            end
            j = j + 1;
            idx = idx + 1;
        end
        
    end
    
end
