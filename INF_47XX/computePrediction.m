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
            signal_predict = image2signal(image_base,complicationID);
            assert(numel(signal_predict)==numel(image_base));
        elseif(strcmp(complicationID,'dark'))
            % TODO: IMPROVE ME! @@@@@
            signal_predict = image2signal(image_base,complicationID);
            assert(numel(signal_predict)==numel(image_base));
        elseif(strcmp(complicationID,'noisy'))
            % TODO: IMPROVE ME! @@@@@
            signal_predict = image2signal(image_base,complicationID);
            assert(numel(signal_predict)==numel(image_base));
        elseif(strcmp(complicationID,'colorShift'))
            assert(size(image_base,3)==3); % assume we are processing a 3-channel image
            % TODO: IMPROVE ME! @@@@@
            signal_predict = image2signal(image_base,complicationID);
            assert(numel(signal_predict)==numel(image_base));
        else
            assert(false); % unexpected complication ID; should never get here
        end
    end
end