% INF4710 A2017 TP1

close all;
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% first, let's test to see if the default cases in image2signal/signal2image are properly implemented
test_data = uint8(1:60); % mat will be 5x4 with 3 channels, or 6x10 with 1 channel (so 60 elements total)
test_mat_3ch = reshape(test_data,5,4,3);
test_signal_3ch_real = uint8([1,21,41,6,26,46,11,31,51,16,36,56,2,22,42,7,27,47,12,32,52,17,37,57,3,23,43,8,28,48,13,33,53,18,38,58,4,24,44,9,29,49,14,34,54,19,39,59,5,25,45,10,30,50,15,35,55,20,40,60]);
test_signal_3ch = image2signal(test_mat_3ch,'default');
assert(isequal(test_signal_3ch(:),test_signal_3ch_real(:)));
assert(isequal(test_mat_3ch,signal2image(test_signal_3ch,'default',size(test_mat_3ch))));
test_mat_1ch = reshape(test_data,6,10);
test_signal_1ch_real = uint8([1:6:60,2:6:60,3:6:60,4:6:60,5:6:60,6:6:60]);
test_signal_1ch = image2signal(test_mat_1ch,'default');
assert(isequal(test_signal_1ch(:),test_signal_1ch_real(:)));
assert(isequal(test_mat_1ch,signal2image(test_signal_1ch,'default',size(test_mat_1ch))));
% if you get past this test, the first part is complete! the real image compression app is below...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_pairs_info = { ...
    {'data/tp1/test1a.jpg','data/tp1/test1b.jpg','default'}, ...
    {'data/tp1/test2a.jpg','data/tp1/test2b.jpg','blur'}, ...
    {'data/tp1/test3a.jpg','data/tp1/test3b.jpg','dark'}, ...
    {'data/tp1/test4a.jpg','data/tp1/test4b.jpg','noisy'}, ...
    {'data/tp1/test5a.jpg','data/tp1/test5b.jpg','colorShift'}, ...
    {'data/tp1/test6a.png','data/tp1/test6b.png','default'}, ...
    {'data/tp1/test7a.png','data/tp1/test7b.png','blur'}, ...
    {'data/tp1/test8a.jpg','data/tp1/test8b.png','noisy'}, ...
    {'data/tp1/test9a.png','data/tp1/test9b.png','dark'}, ...
    {'data/tp1/test10a.png','data/tp1/test10b.png','colorShift'}, ...
};

test_pair_idx = 1;
for t=1:numel(test_pairs_info)
    input_base = imread(test_pairs_info{t}{1});
    input_next = imread(test_pairs_info{t}{2});
    complicationID = test_pairs_info{t}{3};
    assert(isequal(size(input_base),size(input_next)));
    fprintf('Processing image pair #%d...\n',test_pair_idx);
    test_pair_idx = test_pair_idx+1;
    subplot(1,2,1); imshow(input_base); title('base');
    subplot(1,2,2); imshow(input_next); title('next');
    
    % our goal is to use the 'input_base' matrix to predict 'input_next'; only the error on the
    % prediction is encoded, which means that if the prediction is good, the compression will also be good

    signal_predict = computePrediction(input_base,complicationID);
    assert(numel(signal_predict)==numel(input_base));
    % the 'next' image is the real one we are trying to predict; we must transform it the same way it is transformed in 'computePrediction'
    signal_next = image2signal(input_next,complicationID);
    assert(numel(signal_predict)==numel(signal_next));
    signal_error = calcPredictError(signal_predict,signal_next);
    assert(numel(signal_error)==numel(signal_predict));
    signal_compr = encodeHuffman(signal_error);
    assert(~isempty(signal_compr.map));
    tot_input_size = numel(input_next);
    tot_code_size = numel(signal_compr.string)/8 + numel(signal_compr.map)*2*2; % rough map size approximation, but close enough!

    compr_rate = 1.0; % ... @@@@ TODO (check compression rate here!)
    fprintf('\t... compression rate = %f\n',compr_rate);

    signal_error_decompr = decodeHuffman(signal_compr,0); % yes, this call is slow, matlab can't optimize it properly -- we have to live with it!
    assert(numel(signal_error_decompr)==numel(signal_predict));
    signal_next_decompr = rebuildSignal(signal_predict,signal_error_decompr);
    assert(numel(signal_next_decompr)==numel(signal_predict));
    input_next_decompr = signal2image(signal_next_decompr,complicationID,size(input_base));
    assert(isequal(size(input_next_decompr),size(input_next)));

    % the whole process should be LOSSLESS --- if the asserts below fail, there's a problem somewhere in the lib code!
    assert(isequal(input_next,input_next_decompr));

    fprintf('\t... done.\n');
end
fprintf('all done\n');
