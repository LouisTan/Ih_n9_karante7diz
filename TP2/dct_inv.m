% dct_inv: computes the inverse discrete cosinus tranform of a matrix
function [block] = dct_inv(block_dct)
    assert(numel(block_dct)>0 && size(block_dct,1)==size(block_dct,2) && mod(size(block_dct,1),2)==0);
    block = zeros(size(block_dct),'uint8');

    % @@@@ TODO (do not use built-in functions here!)
    
end