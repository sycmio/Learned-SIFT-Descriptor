function newImg = getNewImg(myim1, myim2, matches, locs1, locs2)
% INPUT
% im1, im2 - grayscale images, scaled into [0 1]
% matches -  the list of matches returned by briefMatch()
% locs1, locs 2 - the locations of keypoints returne by briefLite() . 
%                 m1 x 3 and m2 x3 respectively. each row corresponds to the 
%                 space-scale position: [x_coordinate,y_coordiante,scale]


    im1= im2double(myim1);
    im2= im2double(myim2);
    
    width = size(im1,2) + size(im2,2);
    height = max(size(im1,1), size(im2,1));
    nchannel = size(im1,3); 
    img = zeros(height, width,nchannel);
%     size(img)
    img(1:size(im1,1),1:size(im1,2),:) = im1;
    img(1:size(im2,1),size(im1,2)+1:size(im1,2) + size(im2,2),:) = im2; 

    position = zeros(size(matches,1),4);
    
    for i = 1:size(matches,1)
        p1 = locs1(matches(i,1),:);
        p2 = locs2(matches(i,2),:); 
        position(i,:) = [p1(1) p1(2) size(im1,2)+p2(1) p2(2)];
    end
    newImg = insertShape(img,'Line',position,'Color','r','LineWidth',1);
end