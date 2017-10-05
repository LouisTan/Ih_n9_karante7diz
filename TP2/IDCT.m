function idct_block = IDCT(dct_block)
    
    m = size(dct_block, 1);
    n = size(dct_block, 2);
    idct_block = zeros(m,n);
    
    % c(w) function
    c = @(w) sqrt(((abs(w) > 1)*1+1) / n);
    
    % Define the x and y arrays for the DCT transformation
    u = repmat((1:m)',1,n);
    v = repmat(1:n,m,1);

    % Define the cosinus function used in the summation.
    cos_dct = @(x,u) cos(pi .* (2 .*(x - 1) + 1) .* (u - 1) ./ (2 .* n));

    % DCT transformation
    F = @(x,y) sum(sum(c(u) .* c(v) .* dct_block .* cos_dct(x,u) .* cos_dct(y,v)));
    
    for x=1:m
        for y=1:n
            idct_block(x,y) = F(x,y);
        end
    end
end