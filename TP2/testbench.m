close all;
clear;
clc;

fprintf('\nRunning test bench for all functions...\n');

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n convRGB2YCbCr\n');
test_in = [];
test_in(:,:,1) = uint8([0,128;255,255;]);
test_in(:,:,2) = uint8([128,0;128,255;]);
test_in(:,:,3) = uint8([128,255;128,255;]);
test_gt_Y = uint8([90,67;166,255;]);
test_gt_Cb = uint8([150,234;107,128;]);
test_gt_Cr = uint8([64,171;191,128;]);
[Y,Cb,Cr] = convRGB2YCbCr(test_in,false);
if(print(isequal(size(Y),[2 2]),'Y mat size (without subsampl) mismatch'))
    print(isCustomEqual(Y,test_gt_Y,1.0),'Y mat values (without subsampl) mismatch');
end
if(print(isequal(size(Cb),[2 2]),'Cb mat size (without subsampl) mismatch'))
    print(isCustomEqual(Cb,test_gt_Cb,1.0),'Cb mat values (without subsampl) mismatch');
end
if(print(isequal(size(Cr),[2 2]),'Cr mat size (without subsampl) mismatch'))
    print(isCustomEqual(Cr,test_gt_Cr,1.0),'Cr mat values (without subsampl) mismatch');
end
[Y,Cb,Cr] = convRGB2YCbCr(test_in,true);
if(print(isequal(size(Y),[2 2]),'Y mat size (with subsampl) mismatch'))
    print(isCustomEqual(Y,test_gt_Y,1.0),'Y mat values (with subsampl) mismatch');
end
if(print(isequal(size(Cb),[1 1]),'Cb mat size (with subsampl) mismatch'))
    print(isCustomEqual(Cb,test_gt_Cb(1,1),1.0),'Cb mat values (with subsampl) mismatch');
end
if(print(isequal(size(Cr),[1 1]),'Cr mat size (with subsampl) mismatch'))
    print(isCustomEqual(Cr,test_gt_Cr(1,1),1.0),'Cr mat values (with subsampl) mismatch');
end
    
% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n convYCbCr2RGB\n');
test_in_Y = uint8([90,67;166,255;]);
test_in_Cb = uint8([150,234;107,128;]);
test_in_Cr = uint8([64,171;191,128;]);
test_gt = [];
test_gt(:,:,1) = uint8([0,128;255,255;]);
test_gt(:,:,2) = uint8([128,0;128,255;]);
test_gt(:,:,3) = uint8([128,255;128,255;]);
RGB = convYCbCr2RGB(test_in_Y,test_in_Cb,test_in_Cr,false);
if(print(isequal(size(RGB),[2 2 3]),'RGB mat size (without subsampl) mismatch'))
    print(isCustomEqual(RGB,test_gt,1.0),'RGB mat values (without subsampl) mismatch');
end
test_gt_subsampl = [];
test_gt_subsampl(:,:,1) = uint8([0,0;76,165;]);
test_gt_subsampl(:,:,2) = uint8([128,105;204,255;]);
test_gt_subsampl(:,:,3) = uint8([128,106;205,255;]);
RGB = convYCbCr2RGB(test_in_Y,test_in_Cb(1,1),test_in_Cr(1,1),true);
if(print(isequal(size(RGB),[2 2 3]),'RGB mat size (with subsampl) mismatch'))
    print(isCustomEqual(RGB,test_gt_subsampl,1.0),'RGB mat values (with subsampl) mismatch');
end

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n formatBlocks\n');
test_in = zeros(64,128,'uint8');
for i=1:numel(test_in)
    test_in(i) = mod(int32(i-1),256);
end
out = formatBlocks(test_in',1);
if(print(numel(out)==128*64 && size(out,1)==1 && size(out,2)==1,'N=1, vec size error'))
    for n=1:numel(out)
        if(~print(out(1,1,n)==test_in(n),'N=1, row-by-row formatting error'))
            break;
        end
    end
end
out = formatBlocks(test_in',2);
if(print(numel(out)==128*64 && size(out,3)==128*64/4,'N=2, vec size error'))
    for n=1:4
        if(~print(out(1,1,n)==test_in(n*2-1),'N=2, row-by-row formatting error'))
            break;
        end
        if(~print(out(1,2,n)==test_in(n*2),'N=2, row-by-row formatting error'))
            break;
        end
    end
end
out = formatBlocks(test_in',64);
print(isequal(size(out),[64 64 2]),'N=64, vec size error');

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n formatImage\n');
in = zeros([2,2,6],'uint8');
in(:,:,1) = uint8([0,1;2,3]);
in(:,:,2) = uint8([4,5;6,7]);
in(:,:,3) = uint8([8,9;10,11]);
in(:,:,4) = uint8([12,13;14,15]);
in(:,:,5) = uint8([16,17;18,19]);
in(:,:,6) = uint8([20,21;22,23]);
out = formatImage(in,[4,6]);
if(print(isequal(size(out),[4 6]),'image size error'))
    print(isequal(out(1,:),[0,1,4,5,8,9]),'image formatting error (row 1)');
    print(isequal(out(2,:),[2,3,6,7,10,11]),'image formatting error (row 2)');
    print(isequal(out(3,:),[12,13,16,17,20,21]),'image formatting error (row 3)');
    print(isequal(out(4,:),[14,15,18,19,22,23]),'image formatting error (row 4)');
end

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n dwt\n');
test_in = uint8([ ...
    0,   0,   0,   0; ...
    0,   0, 100,   0; ...
    0, 200, 200, 100; ...
    0,   0,   0, 100; ...
]);
% low = 0, 0; 0, 50; 100, 150; 0, 50;
% high = 0, 0; 0, 50; -100, 50; 0, -50;
pyramid = [];
[out,pyramid] = dwt(pyramid,test_in,1);
if(print(isequal(size(out),[2,2]),'pyramid output low-low image size error'))
    print(isequal(out,uint8([0,25;50,100])),'pyramid output low-low image content error');
end
if(print(isequal(size(pyramid.lowhigh),[2,2]),'pyramid output low-high image size error'))
    print(isequal(pyramid.lowhigh,int8([0,-25;50,50])),'pyramid output low-high image content error');
end
if(print(isequal(size(pyramid.highlow),[2,2]),'pyramid output high-low image size error'))
    print(isequal(pyramid.highlow,int8([0,25;-50,0])),'pyramid output high-low image content error');
end
if(print(isequal(size(pyramid.highhigh),[2,2]),'pyramid output high-high image size error'))
    print(isequal(pyramid.highhigh,int8([0,-25;-50,50])),'pyramid output high-high image content error');
end

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n idwt\n');
lowlow = uint8([0,25;50,100]);
lowhigh = int8([0,-25;50,50]);
highlow = int8([0,25;-50,0]);
highhigh = int8([0,-25;-50,50]);
pyramid = struct('lowhigh',lowhigh,'highlow',highlow,'highhigh',highhigh,'nextlevel',cell(1,1));
out = idwt(pyramid,lowlow);
test_gt = uint8([ ...
    0,   0,   0,   0; ...
    0,   0, 100,   0; ...
    0, 200, 200, 100; ...
    0,   0,   0, 100; ...
]);
if(print(isequal(size(out),[4,4]),'reconstr output image size error'))
    print(isequal(out,test_gt),'reconstr output image content error');
end

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n quantif\n');
for i=1:10
    out = quantif(int8(i),1,0);
    if(print(numel(out)==1,'quantif v=1,k=1,t=0 output vec size error'))
        if(~print(out==int16(i),'quantif v=1,k=1,t=0 output vec content error'))
            break;
        end
    else
        break;
    end
end
out = quantif(int8([2,4;8,12]),2,3);
if(print(isequal(size(out),[4 1]),'quantif v=4,k=2,t=3 output vec size error'))
    print(isequal(out,int16([0,2,4,6]')),'quantif v=4,k=2,t=3 output vec content error');
end

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n iquantif\n');
for i=1:10
    out = iquantif(int16(i),1,0);
    if(print(numel(out)==1,'quantif v=1,k=1,t=0 output vec size error'))
        if(~print(out==int16(i),'quantif v=1,k=1,t=0 output vec content error'))
            break;
        end
    else
        break;
    end
end
out = iquantif(int16([0,2,4,5]),2,3);
if(print(isequal(size(out),[2,2]),'iquantif v=4,k=2,t=3 output vec size error'))
    print(isequal(out,int16([0,4;8,10])),'iquantif v=4,k=2,t=3 output vec content error');
end

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n encodeHuff\n');
test = int16([...
    [0,0,1,0, 0,2,1,3, 0,4,0,3, 1,5,0,2,]', ...
    [0,1,1,1, 2,0,1,2, 0,0,1,4, 0,2,3,1,]', ...
]);
code = encodeHuff(test);
gtstring = logical([0,0,1,0,0,0,1,1,0,1,0,1,1,1,1,0,1,1,1,0,1,0,1,1,1,1,1,0,1,1,1,0,0,0,1,1,0,0,1,0,1,0,1,0,1,1,0,0,1,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,1,1,1,0]);
if(print(numel(code.map)>0 && numel(code.string)>0,'missing encoded struct data'))
    print(isequal(code.string,gtstring) || isequal(code.string,gtstring'),'bad code');
end

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n decodeHuff\n');
map = cell(6,2);
for i=0:5
    map{i+1,1} = int8(i);
end
map{1,2} = logical(0);
map{2,2} = logical([1,0]);
map{3,2} = logical([1,1,0]);
map{4,2} = logical([1,1,1,1]);
map{5,2} = logical([1,1,1,0,1]);
map{6,2} = logical([1,1,1,0,0]);
code = struct('map',{map},'string',{logical([0,0,1,0,0,0,1,1,0,1,0,1,1,1,1,0,1,1,1,0,1,0,1,1,1,1,1,0,1,1,1,0,0,0,1,1,0,0,1,0,1,0,1,0,1,1,0,0,1,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,1,1,1,0]')});
out = decodeHuff(code,16);
gt = int8([[0,0,1,0, 0,2,1,3, 0,4,0,3, 1,5,0,2,]',[0,1,1,1, 2,0,1,2, 0,0,1,4, 0,2,3,1,]',]);
if(print(isequal(size(out),size(gt)),'bad decoded data size'))
    print(out==gt,'bad decoded data');
end

% ////////////////////////////////////////////////////////////////////////

fprintf('\n--------\n\n All done.\n');