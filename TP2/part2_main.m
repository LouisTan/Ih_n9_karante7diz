% INF4710 A2017 TP2

close all;
clear;
clc;

sequence_path_prefix = 'data/tp2/heart/heart.';
sequence_frame_count = 38;
sequence_path_suffix = '.png';

figure;

sequence_frame_path = [sequence_path_prefix sprintf('%03d',1) sequence_path_suffix];
frame_base = imread(sequence_frame_path);
assert(isequal(size(frame_base),[256,256]));

% extract block at hard-coded location to run some tracking tests... (you should try more than one location!)
% note: don't expect good results after 5-6 frames, tracking will be lost quickly if local intensities change too much!
block_size = 16; % let's use big blocks, it will be easier to track large patterns!
default_block_pos = [126,172]; % always use top-left location for regions, and in [row,col] format
default_block = frame_base(default_block_pos(1):default_block_pos(1)+block_size-1,default_block_pos(2):default_block_pos(2)+block_size-1);
frame_base_display = frame_base; % clone
frame_base_display(default_block_pos(1):default_block_pos(1)+block_size-1,default_block_pos(2):default_block_pos(2)+block_size-1) = 255; % draw a white rectangle over the current block location, and refill interior with original intensnty values
frame_base_display(default_block_pos(1)+2:default_block_pos(1)+block_size-3,default_block_pos(2)+2:default_block_pos(2)+block_size-3) = frame_base(default_block_pos(1)+2:default_block_pos(1)+block_size-3,default_block_pos(2)+2:default_block_pos(2)+block_size-3);

imshow(frame_base_display)

for frame_idx=1:sequence_frame_count
    
    sequence_frame_path = [sequence_path_prefix sprintf('%03d',frame_idx) sequence_path_suffix];
    frame = imread(sequence_frame_path);
    assert(isequal(size(frame),[256,256]));
    
    % some hard-coded search region... (you should try more than one region! borders too!)
    default_search_region_pos = [100,150];
    default_search_region_size = [60,60]; 
    default_search_region = frame(default_search_region_pos(1):default_search_region_pos(1)+default_search_region_size(2)-1,default_search_region_pos(2):default_search_region_pos(2)+default_search_region_size(2)-1);
    
    [offset_vec,eqm] = match_block(default_block,default_block_pos,default_search_region,default_search_region_pos);

    if (frame_idx==1)
        % if we are still on the first frame, the search should find the same block at the same location, since the search region overlaps with the original block location
        assert(offset_vec(1)==0 && offset_vec(2)==0); % this is only valid for the hard-coded values above; remove this if you intend on running more complicated tests later
        fprintf('press any key to step through the video...\n');
    else
        fprintf('offset = [%d,%d];  eqm = %f\n',offset_vec(1),offset_vec(2),eqm);
    end
    next_block_pos = default_block_pos + offset_vec;
    frame_display = frame; % clone
    frame_display(next_block_pos(1):next_block_pos(1)+block_size-1,next_block_pos(2):next_block_pos(2)+block_size-1) = 255; % draw a white rectangle over the current block location, and refill interior with original intensnty values
    frame_display(next_block_pos(1)+2:next_block_pos(1)+block_size-3,next_block_pos(2)+2:next_block_pos(2)+block_size-3) = frame(next_block_pos(1)+2:next_block_pos(1)+block_size-3,next_block_pos(2)+2:next_block_pos(2)+block_size-3);
    % left side of the display is the base frame (static), and right side is the current best match location
    imshow(cat(2,frame_base_display,frame_display));
    waitforbuttonpress;
end
fprintf('all done\n');

