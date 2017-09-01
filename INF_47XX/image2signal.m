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
            % TODO: THIS IS THE BASE CASE, FIX ME FIRST! @@@@@
            % assert(false); % missing impl here!
            if ndims(image) == 1
                disp('This case is one dimension');
            elseif ndims(image) == 3
                %col1 = image(:,:,1);
                %col2 = image(:,:,2);
                %col3 = image(:,:,3);
                %disp(img_s(2));
                %disp(numel(image));
                
                img_s = size(image);
                offset = 20;
                
                disp('La matrice est de taille:');
                disp(img_s);
                
                for n = 1:img_s(1)
                    for m = 0:img_s(2)-1
                        currentPixel = n + m*5;
                        %La procedure prend plus de temps puisque la
                        %variable est allouee dynamiquement..
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
   disp('Voici le signal encode:');
   disp(signal); 
   signal = uint8(signal); % makes sure output is still the same type!
end
