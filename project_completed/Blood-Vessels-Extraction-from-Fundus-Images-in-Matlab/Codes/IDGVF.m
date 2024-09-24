%% GVF 
   function [O1,rg2,O2,P] = IDGVF(x2,y2,x3,y3,Dr)
   P=[y2(:) x2(:)];
   P2=[y3(:) x3(:)];
   [O,J2]=Snake2D_2(Dr,P);
   [O2,J3]=Snake2D_2(Dr,P2);
  
    rg2 = zeros(size(J2,1),size(J2,2));
  for i =1:size(J2,1)
      for j=1:size(J2,2)
           
        if J2(i,j) ==1
            rg2(i,j) = Dr(i,j);
        end
        if J3(i,j)==1 
            rg2(i,j) = nan;

        end

      end
  end
   k = 5;
   Ob = O2;
   for i =3:k
       j = i+1;
       str = 'O';
       str2 = 'J';
       out{i} = sprintf('%s%d',str,i);
       out2{i} = sprintf('%s%d',str2,i);
       ou{i} = sprintf('%s%d',str,i);
       ou2{i} = sprintf('%s%d',str2,i);
      
       if i ==4
       [O1,J1] = Snake2D_2(rg2,Ob);
       ou{i} = O1;
       A = polyarea(ou{i}(:,2),ou{i}(:,1));
       B= polyarea(Ob(:,2),Ob(:,1));
       sub = A-B;
       Ob = O1;  
       else
        [O1,J1] = Snake2D_3(rg2,Ob);
        ou{i} = O1;
        A = polyarea(ou{i}(:,2),ou{i}(:,1));
        B= polyarea(Ob(:,2),Ob(:,1));
         sub = abs(A-B);
%           sub = A-B;
         t = 0.25*B;
% t = 10000;
         if (sub < t && i>3) 
             disp("k: "+i);
            break;  
         else 
             k = k+1;
         end
        Ob = O1;
        
       end
   end 
  

  x4 = ou{4}(:,2);
  y4 = ou{4}(:,1);
  k4 = boundary(x4,y4);
  X4 = x4(k4);
  Y4 = y4(k4);
  P=[Y4 X4];
   end