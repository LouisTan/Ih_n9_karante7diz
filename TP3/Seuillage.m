image=imread('RGB.jpg');

for i=1:size(image,1)
    for j=1:size(image,2)
        % Seuil déterminé à main pour fin d'illustration.
        if image(i,j,1)>20 || (image(i,j,2)<80 || image(i,j,2)>170) || (image(i,j,3)<130 || image(i,j,2)>190)
            image(i,j,:)=0;
        end
    end
end
imshow(image);
%On pourrait se baser sur les histogrammes
figure
image=imread('RGB.jpg');
imhist(image(:,:,1))
pause
imhist(image(:,:,2))
pause
imhist(image(:,:,3))