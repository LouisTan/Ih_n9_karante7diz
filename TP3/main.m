% INF4710 A2017 TP3

close all;
clear;
clc;

vrobj = VideoReader('INF4710_TP3_A2017_video.avi');
figure

fprintf('Program starts...\n');
for t=1:vrobj.NumberOfFrames
    img = read(vrobj,t);
   
    G = Convo(img);
    imshow(G); 
    title('Sobel gradient');
    
    bin_img = Seuil(G);
    imshow(bin_img); 
    title('Threshold');
    
    dilate_img = Dilate(bin_img);
    imshow(dilate_img);
    title('Dilatation');

   
end
fprintf('\n...all done.');