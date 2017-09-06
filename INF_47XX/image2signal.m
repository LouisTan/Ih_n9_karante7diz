function [signal] = image2signal(image,complicationID)
    assert(~isempty(image) && (ismatrix(image) || (ndims(image)==3 && size(image,3)==3)) && isa(image(1),'uint8'));
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
            %Signal espere:[1,21,41,6,26,46,11,31,51,16,36,56,2,22,42,7,27,
            %47,12,32,52,17,37,57,3,23,43,8,28,48,13,33,53,18,38,58,4,24,44,
            %9,29,49,14,34,54,19,39,59,5,25,45,10,30,50,15,35,55,20,40,60]
            
            if ndims(image) == 1
                disp('This case is one dimension');
            elseif ndims(image) == 3
                
                %%%%%%%DEBUG%%%%%%
                %disp('L-image contient les donnees suivantes:');
                %disp(image);
                %
                img_s = size(image);
                %disp('La matrice est de taille:');
                %disp(img_s);
                % 
                offset = img_s(1)*img_s(2);
                
                for n = 1:img_s(1)
                    for m = 0:img_s(2)-1
                        currentPixel = n + m*img_s(1);
                        %La variable est allouee dynamiquement
                        signal(end+1) = currentPixel;
                        currentPixel = currentPixel + offset;
                        %for k = 1:img_s(3)
                        while currentPixel <= numel(image)
                            signal(end+1) = currentPixel;
                            currentPixel = currentPixel + offset;
                        end     
                    end
                end
            else
                disp('This case is not covered');
            end
    end
   %%%%%%DEBUG%%%%%%
   %
   %disp('Voici le signal encode:');
   %disp(signal); 
   signal = uint8(signal); % makes sure the output is still the same type!
end
