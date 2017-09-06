function signal = decodeHuffman(code,chunk_size)
    assert(numel(code.string)>0 && numel(code.map)>0 && numel(size(code.map))==2 && chunk_size>=0);
    string = logical(code.string);
    symbols_list = code.map(:,1);
    symbols_strings = code.map(:,2);
    signal = int16([]);
    max_string_len = max(cellfun(@(x)numel(x),symbols_strings));
    symbols_strings_by_len = cell(max_string_len,1);
    symbols_lists_by_len = cell(max_string_len,1);
    for s=1:numel(symbols_strings)
        symbols_strings_by_len{numel(symbols_strings{s})} = [symbols_strings_by_len{numel(symbols_strings{s})};logical(symbols_strings{s})'];
        symbols_lists_by_len{numel(symbols_strings{s})} = [symbols_lists_by_len{numel(symbols_strings{s})} symbols_list{s}];
    end
    string_start_idx = 1;
    string_end_idx = 1;
    signal_idx = 0;
    signal = zeros(numel(string),1,'int16');
    good = true;
    while good
        curr_string_len = string_end_idx-string_start_idx+1;
        if curr_string_len>0
            curr_potential_strings = symbols_strings_by_len{curr_string_len};
            for s=0:(numel(curr_potential_strings)/curr_string_len)-1
                curr_test_string = curr_potential_strings((1:curr_string_len)+s*curr_string_len);
                if isequal(curr_test_string,string(string_start_idx:string_end_idx))
                    signal(signal_idx+1) = symbols_lists_by_len{curr_string_len}(s+1);
                    signal_idx = signal_idx + 1;
                    string_start_idx = string_end_idx + 1;
                    good = string_start_idx<=numel(string);
                    break;
                end
            end
        end
        string_end_idx = string_end_idx + 1;
        if mod(int32(string_end_idx),int32(numel(string)/20))==0
            fprintf('decode huff @ %d percent\n',int32(100*double(string_end_idx)/numel(string)));
        end
    end
    if(chunk_size>0)
        assert(mod(signal_idx,chunk_size)==0);
        signal = reshape(signal(1:signal_idx),chunk_size,[]);
    else
        signal = signal(1:signal_idx);
    end
end
