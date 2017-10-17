% dct_inv: computes the inverse discrete cosinus tranform of a matrix
function [block] = dct_inv(block_dct)
    assert(numel(block_dct)>0 && size(block_dct,1)==size(block_dct,2) && mod(size(block_dct,1),2)==0);
    %block = zeros(size(block_dct),'uint8');
    block = [];
    block_size = 8;

    function [r_w] = racine(w)
        if w == 1
            r_w = sqrt(1./block_size);
        else
            r_w = sqrt(2./block_size);
        end
    end

    function [c_w] = cosinus(k,w)
        c_w = cos( (pi*(2*k +1)*w) / (2*block_size) );
    end

    for u=1:block_size
        for v=1:block_size
            somme = 0;
            for i=1:block_size
                for j=1:block_size
                    somme = somme + racine(u)*racine(v)*block_dct(u,v)*cosinus(i,u)*cosinus(j,v);
                end
            end
            block(i,j) = somme;

        end
    end
    block = idct2(block_dct);
end