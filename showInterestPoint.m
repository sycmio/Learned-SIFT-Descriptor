im = imread('..\data\chickenbroth_01.jpg');
im = im2double(im);
if size(im,3)==3
    im= rgb2gray(im);
end
levels = [-1; 0; 1; 2; 3; 4];
sigma0 = 1;
k = sqrt(2);
th_contrast = 0.03;
th_r = 12;
[locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);
imshow(im);
hold on;
plot(locsDoG(:,1),locsDoG(:,2),'.','MarkerEdgeColor','g','MarkerSize',10);