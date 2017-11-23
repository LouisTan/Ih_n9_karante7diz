function [image] = Dilate(img)
image = zeros(size(img,1),size(img,2),size(img,3));
    for i=1:size(img,1)-2
        for j=1:size(img,2)-2
            if img(i+1,j+1) == 255
                image(i,j)=255; image(i+1,j)=255; image(i+2,j)=255; image(i,j+1)=255; 
                image(i,j+2)=255; image(i+1,j+1)=255; image(i+1,j+2)=255; image(i+2,j+1)=255;
            end
        end
    end
end