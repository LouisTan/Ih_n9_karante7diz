function [img] = Seuil(image)
    for i=1:size(image,1)
        for j=1:size(image,2)
            % Seuil déterminé à main pour fin d'illustration.
            if image(i,j,1)>0.30 || image(i,j,2)>0.30 || image(i,j,3)>0.30
                image(i,j,:)=255;
            else image(i,j,:)=0;
            end
        end
    end
    img = image;
end