function mosaic_partB= main_PartB()
%% Part B

partb_img1=imread('YU_Glendon-hall/Glendon-Hall-left.jpg');
partb_img2=imread('YU_Glendon-hall/Glendon-Hall-middle.jpg');
partb_img3=imread('YU_Glendon-hall/Glendon-Hall-right.jpg');

mosaic_partB=fun_stitching_homography(partb_img1,partb_img2,partb_img3);

end