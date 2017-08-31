function [image] = signal2image(signal,complicationID,img_size)
    assert((size(signal,1)==numel(signal) || size(signal,2)==numel(signal)) && numel(signal)>1 && isa(signal(1),'uint8'));
    assert((numel(img_size)==2 && (img_size(1)*img_size(2))==numel(signal)) || (numel(img_size)==3 && (img_size(1)*img_size(2)*img_size(3))==numel(signal)));
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
            % TODO: THIS IS THE BASE CASE, FIX ME FIRST! @@@@@
            assert(false); % missing impl here!
            % image = ... ;
    end
    image = uint8(image); % makes sure output is still the same type!
end
