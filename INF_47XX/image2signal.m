function [signal] = image2signal(image,complicationID)
    assert(~isempty(image) && (ndims(image)==2 || (ndims(image)==3 && size(image,3)==3)) && isa(image(1),'uint8'));
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
            assert(false); % missing impl here!
            % signal = ... ;
    end
    signal = uint8(signal); % makes sure output is still the same type!
end
