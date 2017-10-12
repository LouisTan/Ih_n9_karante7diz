% decoup: reformats a 2D image (i.e. always single channel) to a block array
function [blocks] = decoup(img,block_size)
    if ~exist('block_size','var')
        block_size = 8;
    end
    assert(numel(img)>0 && mod(size(img,1),block_size)==0 && mod(size(img,2),block_size)==0);
    
    %512x512 ou 256x256. La taille des images est un multiple de block_size
    img_s = size(img);
    
    %'blocks' contients plusieurs 'bloc' qui continnent des 'line'. soit
    %des tableaux horizontaux de N elements, ou N = bloc_size
    blocks_nb = img_s(1)*img_s(2)/power(block_size,2);
    blocks = [];
    line = [];
    bloc = [];
    
    %p => rangees, m =>colonnes, n => itererateur du 'bloc'
    p = 0;
    n = 1;
    m = 0;
    for i = 1:blocks_nb
        for j = 1:block_size
            for k = 1:block_size
                %Avec (k-1)*img_s(1) on va chercher la colonne
                %Avec m*img_s(1)*block_size on va chercher le prochain
                %      bloc a droite
                %Avec p*block_size on va chercher la rangee
                line(k) = img((k-1)*img_s(1) + n + m*img_s(1)*block_size + p*block_size);
            end
            bloc(j,:) = line;
            line = [];
            n = n + 1;
       
        end
        blocks(:,:,i) = bloc;
        m = m + 1;
        n = 1;
        
        %Lorsque qu'une largeur de l'image a ete traitee:
        if m == img_s(2)/block_size
            m = 0;
            p = p + 1;
        end
  
    end
    
end