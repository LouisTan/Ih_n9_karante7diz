function dct_block = DCT(block)

    m = size(block, 1);
    n = size(block, 2);
    dct_block = zeros(m,n);

    % c(w) function
    c = @(w) sqrt(((abs(w) > 1)*1+1) / n);

    % Define the x and y arrays for the DCT transformation
    x = repmat((1:m)',1,n);
    y = repmat(1:n,m,1);

    % Define the cosinus function used in the summation.
    cos_dct = @(x,u) cos(pi .* (2 .*(x - 1) + 1) .* (u - 1) ./ (2 .* n));

    % DCT transformation
    C = @(u,v) c(u) .* c(v) .* sum(sum(block .* cos_dct(x,u) .* cos_dct(y,v)));

    for u=1:n
        for v=1:m
            dct_block(u,v) = C(u,v);
        end
    end
end