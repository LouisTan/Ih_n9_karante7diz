function [signal] = image2signal(image,complicationID)
    assert(~isempty(image) && (ismatrix(image) || (ndims(image)==3 && size(image,3)==3)) && isa(image(1),'uint8'));
    
    img_s = size(image);
    %disp('La matrice de l-image est de taille:');
    %disp(img_s);
    
    %disp('L-image contient les donnees suivantes:');
    %disp(image);
    
    signal = [];
    
    switch complicationID
        %case 'blur'
            % TODO: IMPROVE ME (if needed!) signal = ...; @@@@@ break;
        %case 'dark'
            % TODO: IMPROVE ME (if needed!) signal = ...; @@@@@ break;
        %case 'noisy'
            % TODO: IMPROVE ME (if needed!) signal = ...; @@@@@ break;
        %case 'colorShift'
            % TODO: IMPROVE ME (if needed!) signal = ...; @@@@@ break;
        otherwise
            if ndims(image) == 2
                for n = 1:img_s(1)
                    for m = 0:img_s(2)-1
                        signal(end+1) = image(n+m*img_s(1));
                    end
                end
            elseif ndims(image) == 3
                offset = img_s(1)*img_s(2);
                for n = 1:img_s(1)
                    for m = 0:img_s(2)-1
                        currentPixel = n + m*img_s(1);
                        %La variable est allouee dynamiquement
                        signal(end+1) = image(currentPixel);
                        currentPixel = currentPixel + offset;
                        while currentPixel <= numel(image)
                            signal(end+1) = image(currentPixel);
                            currentPixel = currentPixel + offset;
                        end     
                    end
                end
            else disp('This case is not covered (image2signal)');
            end
   end
   %disp('Voici le signal encode:');
   %disp(signal); 
   signal = uint8(signal);
end
