% decoup: reformats a 2D image (i.e. always single channel) to a block array
function [blocks] = decoup(img,block_size)
    if ~exist('block_size','var')
        block_size = 8;
    end
    assert(numel(img)>0 && mod(size(img,1),block_size)==0 && mod(size(img,2),block_size)==0);
    
    % @@@@ TODO (fill blocks)
    % blocks = zeros(...,'uint8');
    % ...

end