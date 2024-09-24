 if (j >= 0) && (j <= 17)
        disp('Jaw')
        plot(s(i, j, 1), s(i, j, 2), 'y+');
        box_jaws(j,1)=s(i, j, 1);
        box_jaws(j,2)=s(i, j, 2);
        
        elseif (j >= 17) && (j <= 27)
        disp('Eye Brows.')
        plot(s(i, j, 1), s(i, j, 2), 'b*');
        box_eyebrows(j,1)=s(i, j, 1);
        box_eyebrows(j,2)=s(i, j, 2);

        elseif (j >= 28) && (j <= 36)
        disp('Nose')
        plot(s(i, j, 1), s(i, j, 2), 'gd');
        box_nose(j,1)=s(i, j, 1);
        box_nose(j,2)=s(i, j, 2);

        elseif (j >= 37) && (j <= 48)
        disp('Eyes')
        plot(s(i, j, 1), s(i, j, 2), 'w+');
        box_eyes(j,1)=s(i, j, 1);
        box_eyes(j,2)=s(i, j, 2);
        
         
        elseif (j >= 49) && (j <= 68)
        disp('Mouth')
        plot(s(i, j, 1), s(i, j, 2), 'co');
        box_mouth(j,1)=s(i, j, 1)
        box_mouth(j,2)=s(i, j, 2);
        else
        disp('Value is below minimum value.')
        end