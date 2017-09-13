function [image] = signal2image(signal,complicationID,img_size)
    assert((size(signal,1)==numel(signal) || size(signal,2)==numel(signal)) && numel(signal)>1 && isa(signal(1),'uint8'));
    assert((numel(img_size)==2 && (img_size(1)*img_size(2))==numel(signal)) || (numel(img_size)==3 && (img_size(1)*img_size(2)*img_size(3))==numel(signal)));
    
    %disp('Le signal contient les donnees suivantes:');
    %disp(signal);
    
    matrice1D = [];
    matrice2D = [];
    matrice3D = [];
    
    image1D = [];
    image2D = [];
    image3D = [];
    
    image = [];
    
    switch complicationID
        %case 'blur'
            % TODO: IMPROVE ME (if needed!) image = ...; @@@@@ break;
        %case 'dark'
            % TODO: IMPROVE ME (if needed!) image = ...; @@@@@ break;
        %case 'noisy'
            % TODO: IMPROVE ME (if needed!) image = ...; @@@@@ break;
        %case 'colorShift'
            % TODO: IMPROVE ME (if needed!) image = ...; @@@@@ break;
        otherwise
            
        if numel(img_size) == 2
            for n = 0:img_size(1)-1
                for m = 1:img_size(2)
                    image(n+1,m,1) = signal(m+n*img_size(2));
                end
            end
        elseif numel(img_size) == 3
            %Placer les elements de chaque dimension dans une liste
            for n = 1:numel(signal)
                if mod(n,img_size(3)) == 1
                    image1D(end+1) = signal(n);
                elseif mod(n,img_size(3)) == 2
                    image2D(end+1) = signal(n);
                elseif mod(n,img_size(3)) == 0
                    image3D(end+1) = signal(n);
                else disp('Something went wrong..');
                end
            end
            
            %disp('Premiere dimension:')
            %disp(image1D);
            %disp('Deuxieme dimension:')
            %disp(image2D);
            %disp('Troisieme dimension:')
            %disp(image3D);

            %Placer les elements de chaque tableau dans une matrice
            for n = 1:img_size(1)
                for m = 1:img_size(2)
                    matrice1D(n,m,1) = image1D(m+(n-1)*(img_size(2)));
                    matrice2D(n,m,1) = image2D(m+(n-1)*(img_size(2)));
                    matrice3D(n,m,1) = image3D(m+(n-1)*(img_size(2)));
                end
            end
            %disp('Premiere matrice:')
            %disp(matrice1D);
            %disp('Deuxieme matrice:')
            %disp(matrice2D);
            %disp('Troisieme matrice:')
            %disp(matrice3D);

            %Concatener les trois matrices
            image = cat(3,matrice1D,matrice2D,matrice3D);
        else disp('This case is not covered (signal2image)');
        end
    end
    disp('Voici l-image decodee:')
    disp(image)
    image = uint8(image);
end
