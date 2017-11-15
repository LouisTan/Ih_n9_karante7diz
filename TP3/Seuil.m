function [image] = Seuil(img)
    for i=1:size(img,1)
        for j=1:size(img,2)
            % Seuil déterminé à main pour fin d'illustration.
            if img(i,j,1)>0.30 || img(i,j,2)>0.30 || img(i,j,3)>0.30
                img(i,j,:)=255;
            else img(i,j,:)=0;
            end
        end
    end
    
    image = (img(:,:,1)+img(:,:,2)+img(:,:,3))/3;
end