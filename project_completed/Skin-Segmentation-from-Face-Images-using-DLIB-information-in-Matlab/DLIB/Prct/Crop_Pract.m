DS_Path='D:\Study\Projects\Fiverr\DIP\Orders\janvimeho-IEEE\Extracted-Face-Skin';
cd(DS_Path)
[f,p]=uigetfile('*.*');
[in_file,in_path,in_ext]=fileparts([p,f]);
rgb=imread([p,f]);

BW=roipoly(rgb,box_cheek_left(1,:),box_cheek_left(2,:));
%replacing white area with the desired image
out=zeros(size(BW,1),size(BW,2));
out = rgb .* uint8(BW);

imshow(out)


