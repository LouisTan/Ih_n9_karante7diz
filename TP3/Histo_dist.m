function [d] = hist_dist(hist, hist1)
    d = [];
    
    for i = 1:size(hist,1)
        for j = 1:size(hist,2)
            d(i) = power(hist(i,j)-hist1(i,j),2);
        end
        d(i) = sqrt(d(i));
    end
    
end

