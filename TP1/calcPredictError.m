function [signal_error] = calcPredictError(signal_predict,signal_real)
    assert(numel(signal_predict)==numel(signal_real));
    signal_error = zeros(numel(signal_predict),1,'int16');
    for n=1:numel(signal_predict)
        signal_error(n) = int16(double(signal_real(n))-double(signal_predict(n)));
    end
end