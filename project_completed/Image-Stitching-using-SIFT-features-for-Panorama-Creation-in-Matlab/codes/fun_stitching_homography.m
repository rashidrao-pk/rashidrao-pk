function Stitched_Final=fun_stitching_homography(partb_img1,partb_img2,partb_img3)
%  Taking Mosaic of first two images (Left and Middle One)
disp('Part B.1 - Running Image Stitching Using Homography');
Stitched_1 = fun_stitching_homography_1(partb_img1, partb_img2);


%  Taking Mosaic of First Mosaic and Right One
disp('Part B.2 - Running Image Stitching Using Homography');
Stitched_Final = fun_stitching_homography_1(Stitched_1,partb_img3 );
end