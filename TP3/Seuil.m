function [image] = Seuil(img,T)
    for i=1:size(img,1)
        for j=1:size(img,2)
            if img(i,j,1)>T || img(i,j,2)>T || img(i,j,3)>T
                img(i,j,:)=255;
            else
                img(i,j,:)=0;
            end
        end
    end
    
    image = (img(:,:,1)+img(:,:,2)+img(:,:,3))/3;
end