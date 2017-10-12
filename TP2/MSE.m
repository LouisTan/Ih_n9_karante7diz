%https://www.mathworks.com/matlabcentral/answers/231932-is-this-how-to-calculate-mean-square-error-for-two-images
function MSE = MSE(lena, image_new)
    [M, N] = size(lena);
    error = lena - (image_new);
    MSE = sum(sum(error .* error)) / (M * N);
end