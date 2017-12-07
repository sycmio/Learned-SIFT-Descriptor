im1 = imread('../data/book.jpg');
im1 = imrotate(im1, -90);
im1 = imresize(im1, 0.1);
%im2 = imread('../data/2.png');
% im1 = imread('../data/incline_L.png');
% im1 = imread('../data/pf_scan_scaled.jpg');
im1 = im2double(im1);
if size(im1,3)==3
    im1_gray= rgb2gray(im1);
end
[locs1, desc1] = learned_siftLite(im1_gray);

%im2 = imread('../data/chickenbroth_01.jpg');
im2 = imrotate(im1,20);
im2_gray=imrotate(im1_gray,20);
% im2 = imread('../data/incline_R.png');
% im2 = imread('../data/pf_stand.jpg');
im2 = im2double(im2);
[locs2, desc2] = learned_siftLite(im2_gray);

[matches] = siftMatch(desc1, desc2);
img=getNewImg(im1, im2, matches, locs1, locs2);