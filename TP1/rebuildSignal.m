function [signal_real] = rebuildSignal(signal_predict,signal_error)
    assert(numel(signal_predict)==numel(signal_error));
    signal_real = zeros(numel(signal_predict),1,'uint8');
    for n=1:numel(signal_predict)
        signal_real(n) = uint8(double(signal_predict(n))+double(signal_error(n)));
    end
end