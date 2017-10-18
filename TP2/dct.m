% dct: computes the discrete cosinus tranform of a matrix
function [block_dct] = dct(block)
    assert(numel(block)>0 && size(block,1)==size(block,2) && mod(size(block,1),2)==0);
    %block_dct = zeros(size(block));
    block_dct = [];
    block_size = size(block,1);
        
    %Choisis la racine selon w 
    function [r_w] = racine(w)
        if w == 1
            r_w = sqrt(1/block_size);
        else
            r_w = sqrt(2/block_size);
        end
    end
    
    %Calcule l'interieur des cosinus dans la formule donnee
    function [c_w] = cosinus(k,w)
        c_w = cos(pi*(2*(k - 1)+1)*(w-1)/(2*block_size));
    end
    
    
    for u=1:block_size
        for v=1:block_size
            %C(u).C(v) dans la formule
            cst = racine(u)*racine(v);
            somme = 0;
            %Double somme
            for i=1:block_size
                for j=1:block_size
                    somme = somme + block(i,j)*cosinus(i,u)*cosinus(j,v);
                end
            end
            %C(u,v)
            block_dct(u,v) = cst.*somme;
            
        end
    end
    %block_dct = dct2(block);
end