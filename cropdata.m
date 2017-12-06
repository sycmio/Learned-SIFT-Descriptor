img=imread('../data/book.jpg');

img=imrotate(img,-90);

img=imresize(img,0.1);

img=rgb2gray(img);

[h,w]=size(img);

patch=zeros(64,64);
counter=0;
for x=1:10:w-63
    for y=1:10:h-63
        patch=img(y:y+64-1,x:x+64-1);
        imwrite(patch,sprintf('book/%d.jpg',counter));
        counter=counter+1;
    end
end

