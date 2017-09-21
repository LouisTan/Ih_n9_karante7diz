% match_block: finds the best match for a block in a given image region by minimizing mean squared error (EQM)
function [out_dir, out_eqm] = match_block(block, block_pos, search_region, search_region_pos)
% output values :
%     out_dir : 2d displacement (offset) vector between block_pos and the newly found block's top-left corner (in [row,col] format)
%     out_eqm : mean quadratic error for the block given by the above offset vector
% input values:
%     block : square image block taken from the image to encode
%     block_pos : 2d position vector of the top-left corner of 'block' in the original image coordinate frame (in [row,col] format)
%     search_region : full image region to search for correspondences
%     search_region_pos : 2d position vector of the top-left corner of 'search_region' in the original image coordinate frame (in [row,col] format)

    assert(numel(block)>0 && isequal(class(block),'uint8') && size(block,1)==size(block,2) && size(block,3)==1);
    block_size = size(block,1);
    assert(numel(search_region)>0 && isequal(class(search_region),'uint8') && size(search_region,3)==1);
    assert(block_pos(1)>=0 && block_pos(2)>=0 && search_region_pos(1)>=0 && search_region_pos(2)>=0);
    assert(block_pos(1)<search_region_pos(1)+size(search_region,1)-block_size+1 && block_pos(2)<search_region_pos(2)+size(search_region,2)-block_size+1);
    
    out_dir = [0,0]; % this is the direction vector to fill; it should sometimes also contain negative values! (note: the correction testbench expects an output in the [row,col] format!)

    % @@@@ TODO (hint: make sure operations around borders wont crash your implementation!)
    % note1: top-left corner of image is x,y=<0,0> origin; therefore...
    %     - if the best matched block is to the left of the input block location (given by oBlockPos), the output vector value in x MUST be negative
    %     - if the best matched block is above of the input block location (given by oBlockPos), the output vector value in y MUST be negative
    % note2: DO NOT USE MATLAB BUILT-IN FUNCTIONS HERE! primitives are ok however... (e.g. min/max/...)

end

