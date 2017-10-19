% decoup: reformats a 2D image (i.e. always single channel) to a block array
function [blocks] = decoup(img,block_size)
    if ~exist('block_size','var')
        block_size = 8;
    end
    assert(numel(img)>0 && mod(size(img,1),block_size)==0 && mod(size(img,2),block_size)==0);
    
    img_s = size(img);
    blocks_nb = img_s(1)*img_s(2)/power(block_size,2);
    
    % blocks : 8x8xn
    % bloc : 8x8
    % line : 8
    blocks = [];
    bloc = [];
    line = [];
    % (k-1) * img_s(1)          => changement de colonne
    % p * block_size            => changement de rangee
    % m * img_s(1) * block_size => bloc de droite
    % n                         => itererateur de line
    n = 1;
    m = 0;
    p = 0;
    for i = 1:blocks_nb
        for j = 1:block_size
            for k = 1:block_size
                
                line(k) = img((k-1)*img_s(1) + ...
                          n + ...
                          m*img_s(1)*block_size + ...
                          p*block_size);
            end
            bloc(j,:) = line;
            line = [];
            n = n + 1;
       
        end
        blocks(:,:,i) = bloc;
        m = m + 1;
        n = 1;
        
        %Lorsque qu'une largeur de l'image a ete traitee on remet m a zero
        if m == img_s(2)/block_size
            m = 0;
            p = p + 1;
        end
    end
end