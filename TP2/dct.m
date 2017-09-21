% dct: computes the discrete cosinus tranform of a matrix
function [block_dct] = dct(block)
    assert(numel(block)>0 && size(block,1)==size(block,2) && mod(size(block,1),2)==0);
    block_dct = zeros(size(block));

    % @@@@ TODO (do not use built-in functions here!)
    
end