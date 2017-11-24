% INF4710 A2017 TP3
vrobj = VideoReader('samples\test6.avi');

p_in_data = []; 
p_out_data = [];
d_data = [];

fprintf('Program starts...\n');

for t=1:vrobj.NumberOfFrames
    fprintf('Frame %d\n',t);
    start_time = clock();

    img = read(vrobj,t);
%     imshow(img);
    
    h = Histo(img);
    
    G = Convo(img);
%     figure, imshow(G); 
%     title('Sobel gradient');

    T=0.25;
    bin_img = Seuil(G,T);
%     imshow(bin_img); 
%     title('Threshold');
    
    D=3;
    dilate_img = Dilate(bin_img,D);
    imshow(dilate_img);
    title('Dilatation');

    img_t_1 = [];

    if t > 1
        if mod(t,5) == 0
            elapsed_time = etime(clock(), start_time);
            fprintf('There is approx. %f sec left\n',elapsed_time*(vrobj.NumberOfFrames - t))
        end
        
        img_t_1 = read(vrobj,t-1);
        h1 = Histo(img_t_1);
        
        G_t_1= Convo(img_t_1);
        bin_img_t_1 = Seuil(G_t_1,T);
        dilate_img_t_1 = Dilate(bin_img_t_1,D);
        
        [p_in,p_out] = Ratio(bin_img,dilate_img,bin_img_t_1,dilate_img_t_1);  
        p_in_data(t) = p_in;
        p_out_data(t) = p_out;
        
        H = -100; L = -200;
        if p_in_data(t) > H || p_out_data(t) > H
            fprintf('Detection H @ %d (p)',t);
        elseif p_in_data(t) > L || p_out_data(t) > L
            fprintf('Detection L @ %d (p)',t);
        end
        
        d = Histo_dist(h,h1);
        
        H = 0.4; L = 0.2;
        if d(1) > H || d(2) > H || d(3) > H
            fprintf('Detection H @ %d (h)',t);
        elseif d(1) > L || d(2) > L || d(3) > L
            fprintf('Detection L @ %d (h)',t);
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

save('results6.mat')

fprintf('\n...all done.');