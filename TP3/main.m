% INF4710 A2017 TP3
global p_in_data_array
global p_out_data_array
global index

%vrobj = VideoReader('samples\INF4710_TP3_A2017_video.avi');
vrobj = VideoReader('samples\test.avi');
img_t_1 = zeros(238,318);
p_in_data = []; p_out_data = [];

fprintf('Program starts...\n');
for t=1:vrobj.NumberOfFrames
    fprintf('Frame %d @ index %d\n',t,index);
    img = read(vrobj,t);
    
    G = Convo(img);
%     figure, imshow(G); 
%     title('Sobel gradient');

    bin_img = Seuil(G);
%     imshow(bin_img); 
%     title('Threshold');

    dilate_img = Dilate(bin_img);
%     imshow(dilate_img);
%     title('Dilatation');

    if t > 1
        img_t_1 = read(vrobj,t-1);
        
        G_t_1= Convo(img_t_1);
        bin_img_t_1 = Seuil(G_t_1);
        dilate_img_t_1 = Dilate(bin_img_t_1);
        
        [p_in,p_out] = Ratio(bin_img,dilate_img,bin_img_t_1,dilate_img_t_1);  
        p_in_data(t) = p_in;
        p_out_data(t) = p_out;
    end
    
end
% y = 1:vrobj.NumberOfFrames;
% scatter(y,p_in_data,25,'red');
% hold on
% scatter(y,p_out_data,25,'green');

p_in_data_array = [p_in_data_array;p_in_data];
p_out_data_array = [p_out_data_array;p_out_data];

%fprintf('\n...all done.');