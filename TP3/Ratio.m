function [p_in,p_out] = Ratio(bin_img,dilate_img,bin_img_t_1,dilate_img_t_1)
    p_in_num = 0;
    p_in_den = 0;
    
    for i=1:size(bin_img,1)
        for j=1:size(bin_img,2)
            p_in_num = p_in_num + dilate_img(i,j)*bin_img_t_1(i,j);
            p_in_den = p_in_den + bin_img_t_1(i,j);
        end
    end

    p_in = 1 - (p_in_num)/(p_in_den);
    
    p_out_num = 0;
    p_out_den = 0;
    
    for i=1:size(bin_img,1)
        for j=1:size(bin_img,2)
            p_out_num = p_out_num + bin_img(i,j)*dilate_img_t_1(i,j);
            p_out_den = p_out_den + bin_img(i,j);
        end
    end
    
    p_out = 1 - (p_out_num)/(p_out_den);

end