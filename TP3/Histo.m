function [h] = Histo(img)
    h = zeros(3,32);
    img = double(img);
    
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            for k = 1:3
                h(k,floor(img(i,j,k)/8)+1) = ...
                    h(k,floor(img(i,j,k)/8)+1) + ...
                    1/(size(img,1)*size(img,2));
            end
        end
    end
    
end