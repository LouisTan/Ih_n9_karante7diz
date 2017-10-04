% decoup_inv: reconstructs a 2D image (i.e. always single channel) from a block array
function [img] = decoup_inv(blocks,img_size)
    assert(numel(blocks)>0 && size(blocks,1)==size(blocks,2));
    block_size = size(blocks,1);
    assert(numel(img_size)==2 && img_size(1)*img_size(2)>0 && mod(img_size(1),block_size)==0 && mod(img_size(2),block_size)==0);
    %img = zeros(img_size,'uint8');

    blocks_nb = size(blocks,3);
    
    bloc_1 = [];
    bloc_2 = [];
    bloc_3 = [];
    bloc_4 = [];
    bloc_5 = [];
    bloc_6 = [];
    bloc_7 = [];
    bloc_8 = [];

    for i = 1:blocks_nb
        switch(mod(i,8))
        case 1 
            bloc_1 = vertcat(bloc_1,blocks(:,:,i));
        case 2 
            bloc_2 = vertcat(bloc_2,blocks(:,:,i));
        case 3 
            bloc_3 = vertcat(bloc_3,blocks(:,:,i));
        case 4
            bloc_4 = vertcat(bloc_4,blocks(:,:,i));
        case 5 
            bloc_5 = vertcat(bloc_5,blocks(:,:,i));
        case 6 
            bloc_6 = vertcat(bloc_6,blocks(:,:,i));
        case 7 
            bloc_7 = vertcat(bloc_7,blocks(:,:,i));
        case 0 
            bloc_8 = vertcat(bloc_8,blocks(:,:,i));
        otherwise
            fprintf('Entree invalide\n' );
        end
    end
    
    img = horzcat(bloc_1,bloc_2,bloc_3,bloc_4,bloc_5,bloc_6,bloc_7,bloc_8);
    img = reshape(img,[512,512]);
    
end