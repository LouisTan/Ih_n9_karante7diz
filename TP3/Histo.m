function [h] = Histo(image)
    h = zeros(3,32);
    
    for i = 1:size(image,1)
        for j = 1:size(image,2)
            for k = 1:3
                h(k,floor(image(i,j,k)/8)+1) = ...
                    h(k,floor(image(i,j,k)/8)+1) + ...
                    1/(size(image,1)*size(image,2));
            end
        end
    end
    
end