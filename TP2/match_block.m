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

    block_size = 16;
    search_region_size = 60;
    block_nb = search_region_size - block_size + 1;

    lineMSE = [];
    blockMSE = [];

    out_dir = [];
    out_eqm = 9999999;
    %num = 0;
    %p => rangees, m =>colonnes, n => itererateur du 'bloc'
    p = 0;
    n = 1;
    m = 0;
    for i = 1:power(block_nb, 2)
        
        for j = 1:block_size
            for k = 1:block_size
                lineMSE(k) = search_region((k-1)*search_region_size + n + ...
                    m*search_region_size + p);
                
            blockMSE_pos = search_region_pos;
            
            end
            blockMSE(j,:) = lineMSE;
            lineMSE = [];
            n = n + 1;

        end
        blockMSE = uint8(blockMSE);
        blockMSE_pos = blockMSE_pos + [p m];
        erreur = MSE(block, blockMSE);
            
        if erreur < out_eqm
            out_eqm = erreur;
            out_dir = blockMSE_pos - block_pos;
        end
        
        m = m + 1;
        n = 1;
        
        if m == block_nb
            m = 0;
            p = p + 1;
        end
        
        blockMSE = [];
        %num = num + 1;
    end

end

