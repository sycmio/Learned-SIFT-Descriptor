myim1 = imread('../data/book.jpg');
myim1 = imrotate(myim1,-90);
myim1 = imresize(myim1,0.1);
im1 = im2double(myim1);
if size(im1,3)==3
    im1= rgb2gray(im1);
end
[locs1, desc1] = learned_siftLite(im1);
% 
% im2 = imrotate(im1,45);
% [locs2, desc2] = briefLite(im2);
% [matches] = briefMatch(desc1, desc2);
% plotMatches(im1, im2, matches, locs1, locs2);

video_file='../data/IMG_0918.mp4';
video=VideoReader(video_file);
frame_number=floor(video.Duration * video.FrameRate)-1;

myvideo = zeros(384,461,3,frame_number);
for i=1:frame_number
    myim2 = read(video,i);
    myim2 = imresize(myim2,0.2);
    im2 = im2double(myim2);
    if size(im2,3)==3
        im2= rgb2gray(im2);
    end
    [locs2, desc2] = learned_siftLite(im2);

    [matches] = siftMatch(desc1, desc2);
    newImg = getNewImg(myim1, myim2, matches, locs1, locs2);
    myvideo(:,:,:,i) = newImg;
    disp(i);
end
% save('../data/myvideo_brief.mat','myvideo');
% load('../data/myvideo_brief.mat');
% implay(myvideo);
writer = VideoWriter('..\data\myvideo_SIFT.avi', ...
                        'Uncompressed AVI');
writer.FrameRate = video.FrameRate;
open(writer);
for i=1:size(myvideo,4)
   writeVideo(writer,myvideo(:,:,:,i));
end
close(writer);