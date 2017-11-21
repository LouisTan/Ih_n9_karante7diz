% INF4710 A2017 TP3
vrobj = VideoReader('samples\test.avi');

p_in_data = []; 
p_out_data = [];
d_data = [];

fprintf('Program starts...\n');

for t=1:vrobj.NumberOfFrames
    fprintf('Frame %d\n',t);
    img = read(vrobj,t);
    imshow(img);
    
    h = Histo(img);
    
    G = Convo(img);
%     figure, imshow(G); 
%     title('Sobel gradient');

    bin_img = Seuil(G);
%     imshow(bin_img); 
%     title('Threshold');

    dilate_img = Dilate(bin_img);
%     imshow(dilate_img);
%     title('Dilatation');

    img_t_1 = [];

    if t > 1
        img_t_1 = read(vrobj,t-1);
        h1 = Histo(img_t_1);
        
        G_t_1= Convo(img_t_1);
        bin_img_t_1 = Seuil(G_t_1);
        dilate_img_t_1 = Dilate(bin_img_t_1);
        
        [p_in,p_out] = Ratio(bin_img,dilate_img,bin_img_t_1,dilate_img_t_1);  
        p_in_data(t) = p_in;
        p_out_data(t) = p_out;
        
        d = Histo_dist(h,h1);
        
        if d(1) > 0.4 || d(2) > 0.4 || d(3) > 0.4
            fprintf('detected with histogram [frame = %d]\n',t);
        elseif d(1) > 0.01 || d(2) > 0.01 || d(3) > 0.01
            fprintf('detected with histogram [frame = %d]\n',t);
        end
        
        d_data = [d;d_data];
    end
end

y = 1:vrobj.NumberOfFrames;
scatter(y,p_in_data,25,'red');
hold on
scatter(y,p_out_data,25,'green');
hold off

pause();

y = 1:vrobj.NumberOfFrames-1;
plot(y,d_data,'red');
hold on

save('results.mat')

fprintf('\n...all done.');