im1 = imread('../data/model_chickenbroth.jpg');
% im1 = imread('../data/incline_L.png');
% im1 = imread('../data/pf_scan_scaled.jpg');
im1 = im2double(im1);
if size(im1,3)==3
    im1= rgb2gray(im1);
end
[locs1, desc1] = siftLite(im1);

im2 = imread('../data/chickenbroth_01.jpg');
% im2 = imrotate(im2,180);
% im2 = imread('../data/incline_R.png');
% im2 = imread('../data/pf_stand.jpg');
im2 = im2double(im2);
if size(im2,3)==3
    im2= rgb2gray(im2);
end
[locs2, desc2] = siftLite(im2);

[matches] = siftMatch(desc1, desc2);
plotMatches(im1, im2, matches, locs1, locs2)