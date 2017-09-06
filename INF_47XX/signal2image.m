function [image] = signal2image(signal,complicationID,img_size)
    assert((size(signal,1)==numel(signal) || size(signal,2)==numel(signal)) && numel(signal)>1 && isa(signal(1),'uint8'));
    assert((numel(img_size)==2 && (img_size(1)*img_size(2))==numel(signal)) || (numel(img_size)==3 && (img_size(1)*img_size(2)*img_size(3))==numel(signal)));
    image = zeros(0,0,3);
    image1D = zeros(0);
    image2D = zeros(0);
    image3D = zeros(0);
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
        if ndims(image) == 1
            disp('This case is one dimension');
        elseif ndims(image) == 3    
            %%%%%%DEBUG%%%%%%
            %
            %disp('Voici le signal encode:')
            %disp(signal)
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
        else disp('This case is not covered');
        end
        %%%%%%DEBUG%%%%%%
        %
        %disp('Premiere dimension:')
        %disp(image1D);
        %disp('Deuxieme dimension:')
        %disp(image2D);
        %disp('Troisieme dimension:')
        %disp(image3D);
        %
        image = cat(3,image1D,image2D,image3D);
        %
        disp('Voici l-image decodee:')
        disp(image)
    end
    image = uint8(image); % makes sure output is still the same type!
end
