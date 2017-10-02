% dct: computes the discrete cosinus tranform of a matrix
function [block_dct] = dct(block)
assert(numel(block)>0 && size(block,1)==size(block,2) && mod(size(block,1),2)==0);
%block_dct = zeros(size(block));
block_dct = [];
block_size = 8;

    function [r_w] = racine(w)
        if w == 1
            r_w = 1./sqrt(block_size);
        else
            r_w = 2./sqrt(block_size);
        end
    end

    function [c_w] = cosinus(k,w)
        c_w = cos( (pi*(2*k +1)*w) / (2*block_size) );
    end

    for u=1:block_size
        for v=1:block_size
            cst = racine(u)*racine(v);
            somme = 0;
            for i=1:block_size
                for j=1:block_size
                    somme = somme + cst*block(i,j)*cosinus(i,u)*cosinus(j,v);
                end
            end
            block_dct(u,v) = somme;

        end
    end

end