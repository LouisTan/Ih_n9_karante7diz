function code = encodeHuff(signal)
    assert(numel(signal)>0 && isequal(class(signal),'int16'));
    symbols = unique(signal(:));
    [~,signal_idx] = ismember(signal(:),symbols);
    symbols_p = accumarray(signal_idx,ones(numel(signal),1))./numel(signal);
    tree = build_tree(symbols,symbols_p);
    if numel(tree{1}{1})==1
        dict = [tree{1}{1} {0}];
    else
        [dict,dict_idx] = generate_codes(tree{1},[],cell(numel(tree{1}{1}),2),1);
        assert(dict_idx==numel(tree{1}{1})+1);
    end
    map = containers.Map(dict(:,1),dict(:,2));
    signal_compr = logical([]);
    symbols_list = cell2mat(dict(:,1));
    symbols_strings = dict(:,2);
    signal_compr = logical(zeros(max(cellfun(@(x)numel(x),symbols_strings))*numel(signal),1));
    signal_comp_idx = 1;
    for s=1:numel(signal)
        curr_symbol_string = symbols_strings{find(symbols_list==signal(s))}';
        signal_compr(signal_comp_idx+(0:numel(curr_symbol_string)-1)) = logical(curr_symbol_string);
        signal_comp_idx = signal_comp_idx + numel(curr_symbol_string);
    end
    signal_compr = signal_compr(1:(signal_comp_idx-1));
    code = struct('string',signal_compr,'map',{dict});
    assert(isa(signal_compr,'logical'));
end

function [tree] = build_tree(symbols,weights)
    assert(numel(symbols)>0 && numel(symbols)==numel(weights));
    tree = [];
    [weights_sorted,sort_idx] = sort(weights,'descend');
    symbols_sorted = symbols(sort_idx);
    for s=1:numel(weights_sorted)
        if weights_sorted(s)>0
            tree = [tree {{{symbols_sorted(s)} {} {} weights_sorted(s)}}];
        end
    end
    while numel(tree)>1
        new_node = {{[tree{end-1}{1} tree{end}{1}] [tree{end-1}] [tree{end}] tree{end-1}{4}+tree{end}{4}}};
        tree = tree(1:end-2);
        insert_idx = 0;
        while insert_idx<numel(tree)
            if tree{insert_idx+1}{4}<new_node{1}{4}
                break;
            end
            insert_idx = insert_idx + 1;
        end
        tree = [tree(1:insert_idx) new_node tree(insert_idx+1:end)];
    end
end

function [map,map_idx] = generate_codes(node,prefix,map,map_idx)
    assert(numel(node)>0);
    if numel(node{1})==1
        map(map_idx,:) = [node{1} {prefix}];
        map_idx = map_idx + 1;
    else
        [map,map_idx] = generate_codes(node{3},[prefix 0],map,map_idx);
        [map,map_idx] = generate_codes(node{2},[prefix 1],map,map_idx);
    end
end