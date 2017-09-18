function [signal_predict] = computePrediction(image_base,complicationID)
    assert(~isempty(image_base) && ~isempty(complicationID));
    if(strcmp(complicationID,'default'))
        % default handling --- prediction is a copy of the base image signal
        signal_predict = image2signal(image_base,complicationID);
        assert(numel(signal_predict)==numel(image_base));
    else
        % note: the produced prediction signal should correspond to the output of image2signal(...)
        if(strcmp(complicationID,'blur'))
            % TODO: IMPROVE ME! @@@@@
            %https://www.mathworks.com/help/images/ref/imgaussfilt.html
            if ndims(image_base) == 2
                image_base = imgaussfilt(image_base, 2);
            elseif ndims(image_base) == 3
                %https://www.mathworks.com/help/images/ref/imgaussfilt3.html
                image_base = imgaussfilt(image_base, 3);
            else disp('This case is not covered (computePrediction)');
            end
            signal_predict = image2signal(image_base,2);
            assert(numel(signal_predict)==numel(image_base));
        elseif(strcmp(complicationID,'dark'))
            % TODO: IMPROVE ME! @@@@@
            %https://www.mathworks.com/help/images/ref/imadjust.html
            image_base = imajust(image_base)
            signal_predict = image2signal(image_base,complicationID);
            assert(numel(signal_predict)==numel(image_base));
        elseif(strcmp(complicationID,'noisy'))
            % TODO: IMPROVE ME! @@@@@
            %https://www.mathworks.com/help/images/ref/medfilt2.html
            if ndims(image_base) == 2
                image_base = medlift2(image_base);
            elseif ndims(image_base) == 3
                %https://www.mathworks.com/help/images/ref/medfilt3.html
                image_base = medfilt3(image_base);
            else disp('This case is not covered (computePrediction)');
            signal_predict = image2signal(image_base,complicationID);
            assert(numel(signal_predict)==numel(image_base));
            end
        elseif(strcmp(complicationID,'colorShift'))
            assert(size(image_base,3)==3); % assume we are processing a 3-channel image
            % TODO: IMPROVE ME! @@@@@
            % https://www.mathworks.com/matlabcentral/answers/111104-how-to-separate-an-image-to-rgb
            % Extract the individual red, green, and blue color channels.
            redChannel = image_base(:, :, 1);
            greenChannel = image_base(:, :, 2);
            blueChannel = image_base(:, :, 3);
            
            % Recombine separate color channels into a single, true color RGB image.
            image_base = cat(3, greenChannel,redChannel, blueChannel);
            
            signal_predict = image2signal(image_base,complicationID);
            assert(numel(signal_predict)==numel(image_base));
        else
            assert(false); % unexpected complication ID; should never get here
        end
    end
end