function [box_cheek_right,box_cheek_left]=get_cheeckbox(box_x,box_y)
%% Right Cheek
box_cheek_right(1,1)=box_x(1,3);
box_cheek_right(2,1)=box_y(1,3);
box_cheek_right(1,2)=box_x(1,4);
box_cheek_right(2,2)=box_y(1,4);
box_cheek_right(1,3)=box_x(1,5);
box_cheek_right(2,3)=box_y(1,5);
box_cheek_right(1,4)=box_x(1,6);
box_cheek_right(2,4)=box_y(1,6);
box_cheek_right(1,5)=box_x(1,32);
box_cheek_right(2,5)=box_y(1,32);


%% Left Cheek
box_cheek_left(1,1)=box_x(1,13);
box_cheek_left(2,1)=box_y(1,13);
box_cheek_left(1,2)=box_x(1,14);
box_cheek_left(2,2)=box_y(1,14);
box_cheek_left(1,3)=box_x(1,15);
box_cheek_left(2,3)=box_y(1,15);
box_cheek_left(1,4)=box_x(1,16);
box_cheek_left(2,4)=box_y(1,16);
box_cheek_left(1,5)=box_x(1,36);
box_cheek_left(2,5)=box_y(1,36);


end