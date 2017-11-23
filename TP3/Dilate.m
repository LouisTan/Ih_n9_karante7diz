function [image] = Dilate(img,N)
image = zeros(size(img,1),size(img,2),size(img,3));

    for i=1:size(img,1)-2
        for j=1:size(img,2)-2
            if img(i+1,j+1) == 255
                for k=1:N
                    image(i,j)=255; image(i+k,j)=255; image(i+2*k,j)=255; image(i,j+k)=255; 
                    image(i,j+2*k)=255; image(i+k,j+k)=255; image(i+k,j+2*k)=255; image(i+2*k,j+k)=255;
                end
            end
        end
    end
end