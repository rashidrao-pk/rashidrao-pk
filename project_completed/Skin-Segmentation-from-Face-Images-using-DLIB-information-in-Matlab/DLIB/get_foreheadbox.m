function box_chin=get_foreheadbox(box_x,box_y,x,y)

box_chin(1,1)=x(1,1);
box_chin(2,1)=y(1,1);

box_chin(1,2)=box_x(1,20);
box_chin(2,2)=box_y(1,20);

box_chin(1,3)=box_x(1,25);
box_chin(2,3)=box_y(1,25);

box_chin(1,4)=x(1,2);
box_chin(2,4)=y(1,1);
% % % % % % % % % % % % % 

end