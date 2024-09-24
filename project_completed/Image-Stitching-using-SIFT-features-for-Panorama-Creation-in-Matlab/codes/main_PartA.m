function mosaic_partA= main_PartA()

%% Part A
disp('Part A - Running Image Stitching Using Affine');
img1=imread('parliament/parliament-left.jpg');
img2=imread('parliament/parliament-right.jpg');

mosaic_partA = fun_stitching_affine(img1, img2);

end