clc;
clear all;
close all;
GT_Desc = readtable('orignal_Coordinators of Image 01.xlsx', 'ReadVariableNames', true);

fid = fopen( 'results.txt', 'w+' );


[max_x,index_x]=max(GT_Desc.xAxis);
[max_y,index_y]=max(GT_Desc.yAxis);
[max_w,index_w]=max(GT_Desc.width);
[max_h,index_h]=max(GT_Desc.height);


[x,y] = size(GT_Desc);
%% 
GT_Desc_Sorted = sortrows(GT_Desc,'yAxis','ascend');
% t=table();

ch_count=0;
a1 = 1;

for i=1: x
   x1=GT_Desc_Sorted.xAxis(i,1);
    y1=GT_Desc_Sorted.yAxis(i,1);
    h=GT_Desc_Sorted.height(i,1);
    w=GT_Desc_Sorted.width(i,1);
    
    for j=1:x
        x2=GT_Desc_Sorted.xAxis(j,1);
    y2=GT_Desc_Sorted.yAxis(j,1);
        if((x2 > x1 && x2< (x1+w)) &&  (y2 > y1 && y2< (y1+h)))
        disp('Yes')
        ch_count=ch_count+1;
        s(ch_count)=j;
        else
            disp('No')
        end
    
    end

    ss(a1,:)= GT_Desc_Sorted(i,:);
    ss(a1+1,:)= GT_Desc_Sorted(s(ch_count),:);
    a1=a1+2;
end
%% Remove Duplicate Rows
ss=unique(ss,'stable');


ch_count=0;
a1 = 1;

for i=1: x
   x1=ss.xAxis(i,1);
    y1=ss.yAxis(i,1);
    h=ss.height(i,1);
    w=ss.width(i,1);
    
    for j=1:x
        x2=ss.xAxis(j,1);
    y2=ss.yAxis(j,1);
        if((x2 > x1 && x2< (x1+w)) &&  (y2 > y1 && y2< (y1+h)))
        disp('Yes')
        ch_count=ch_count+1;
        s(ch_count)=j;
        else
            disp('No')
        end
    
    end

    ss1(a1,:)= ss(i,:);
    ss1(a1+1,:)= ss(s(ch_count),:);
    a1=a1+2;
end

ss1=unique(ss1,'stable');


ch_count=0;
a1 = 1;

for i=1: x
   x1=ss1.xAxis(i,1);
    y1=ss1.yAxis(i,1);
    h=ss1.height(i,1);
    w=ss1.width(i,1);
    
    for j=1:x
        x2=ss1.xAxis(j,1);
    y2=ss1.yAxis(j,1);
        if((x2 > x1 && x2< (x1+w)) &&  (y2 > y1 && y2< (y1+h)))
        disp('Yes')
        ch_count=ch_count+1;
        s(ch_count)=j;
        else
            disp('No')
        end
    
    end

    ss2(a1,:)= ss1(i,:);
    ss2(a1+1,:)= ss1(s(ch_count),:);
    a1=a1+2;
end

ss2=unique(ss2,'stable');

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

ch_count=0;
a1 = 1;

for i=1: x
   x1=ss2.xAxis(i,1);
    y1=ss2.yAxis(i,1);
    h=ss2.height(i,1);
    w=ss2.width(i,1);
    
    for j=1:x
        x2=ss2.xAxis(j,1);
    y2=ss2.yAxis(j,1);
        if((x2 > x1 && x2< (x1+w)) &&  (y2 > y1 && y2< (y1+h)))
        disp('Yes')
        ch_count=ch_count+1;
        s(ch_count)=j;
        else
            disp('No')
        end
    
    end

    ss3(a1,:)= ss2(i,:);
    ss3(a1+1,:)= ss2(s(ch_count),:);
    a1=a1+2;
end

ss3=unique(ss3,'stable');
% % % % % % % % % % % % % % % % % % % % % % % % % % % 
ch_count=0;
a1 = 1;

for i=1: x
   x1=ss3.xAxis(i,1);
    y1=ss3.yAxis(i,1);
    h=ss3.height(i,1);
    w=ss3.width(i,1);
    
    for j=1:x
        x2=ss2.xAxis(j,1);
    y2=ss2.yAxis(j,1);
        if((x2 > x1 && x2< (x1+w)) &&  (y2 > y1 && y2< (y1+h)))
        disp('Yes')
        ch_count=ch_count+1;
        s(ch_count)=j;
        else
            disp('No')
        end
    
    end

    ss4(a1,:)= ss3(i,:);
    ss4(a1+1,:)= ss3(s(ch_count),:);
    a1=a1+2;
end

ss4=unique(ss4,'stable');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

img=ones(ceil(max_y)+600,ceil(max_x)+600);

figure(1),imshow(img),title('Showing All Components');
total_inner_Components=34;
curr_s= ss4;

for i =1:size(curr_s,1)
    disp(char(curr_s.Component(i)))
    if i==1
        current_name = char(curr_s.Component(i));
        next_name = char(curr_s.Component(i+1));
        previous_name=current_name;
    elseif i== size(curr_s,1)
        previous_name = char(curr_s.Component(i-1));
        current_name = char(curr_s.Component(i));
        next_name =current_name;
    else
        previous_name = char(curr_s.Component(i-1));
        current_name = char(curr_s.Component(i));
        next_name = char(curr_s.Component(i+1));
    end
    disp([previous_name,' ',current_name,' ',next_name]);
    
    if isequal(current_name,'div') ==1
        curr_s.order(i) = 1;
        curr_s.tab(i) = 0;
            if isequal(next_name,'Heading')  ==1
                curr_s.order(i) = 2;
                curr_s.tab(i) = 1;
            end
            if isequal(next_name,'Paragraph') ==1
                curr_s.order(i) = 3;
                curr_s.tab(i) = 1;
            end
            if isequal(next_name,'Button') ==1
                curr_s.order(i) = 4;
                curr_s.tab(i) = 1;
            end
            if isequal(next_name,'Button_Text') ==1
                curr_s.order(i) = 5;
                curr_s.tab(i) = 2;
            end
            if isequal(current_name,'Hyperlink_Text') ==1
                curr_s.order(i) = 5;
                curr_s.tab(i) = 2;
            end
    elseif isequal(current_name,'Buttons') ==1
        curr_s.order(i) = 1;
        curr_s.tab(i) = 0;
        if isequal(next_name,'Button_Text') ==1
            curr_s.order(i+1) = 2;
            curr_s.tab(i+1) = 1;
        end
    elseif isequal(current_name,'Hyperlink') ==1
        curr_s.order(i) = 1;
        curr_s.tab(i) = 0;
        if isequal(next_name,'Hyperlink_Text') ==1
            curr_s.order(i+1) = 2;
            curr_s.tab(i+1) = 1;
        end 
    end
    
end



for i=1:total_inner_Components
    
    pos_x=curr_s.xAxis(i,1);
    pos_y=curr_s.yAxis(i,1);
    pos_w=curr_s.width(i,1);
    pos_h=curr_s.height(i,1);
        
if (curr_s.Component(i,1)=="div")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', '#77AC30','LineWidth',2);
        text('Position',[pos_x+10 pos_y-15],'string',curr_s.Component(i,1),'Color','#77AC30','fontsize',8,'FontWeight', 'bold');
    elseif (curr_s.Component(i,1)=="Hyperlink")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', 'black','LineWidth',2);
        text('Position',[pos_x+pos_w/4 pos_y-15],'string',curr_s.Component(i,1),'Color','black','fontsize',8,'FontWeight', 'bold');
    elseif (curr_s.Component(i,1)=="Buttons")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', '#A2142F','LineWidth',2);
        text('Position',[pos_x+5 pos_y+10],'string',curr_s.Component(i,1),'Color','#A2142F','fontsize',8,'FontWeight', 'bold');
    elseif (curr_s.Component(i,1)=="Paragraph")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', '#7E2F8E','LineWidth',2);
        text('Position',[pos_x+5 pos_y+10],'string',curr_s.Component(i,1),'Color','#7E2F8E','fontsize',8,'FontWeight', 'bold');
    elseif (curr_s.Component(i,1)=="Heading")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', 'blue','LineWidth',2);
        text('Position',[pos_x+5 pos_y+10],'string',curr_s.Component(i,1),'Color','blue','fontsize',8,'FontWeight', 'bold');
    elseif (curr_s.Component(i,1)=="Hyperlink_Text")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', 'red','LineWidth',2);
        text('Position',[pos_x+5 pos_y+pos_h/2 ],'string',curr_s.Component(i,1),'Color','red','fontsize',8,'FontWeight', 'bold');
    elseif (curr_s.Component(i,1)=="Button_Text")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', '#4DBEEE','LineWidth',2);
        text('Position',[pos_x+5 pos_y+pos_h/2 ],'string',curr_s.Component(i,1),'Color','#4DBEEE','fontsize',8,'FontWeight', 'bold') ;
    else
end  
pause(0.5)
%% Names for Results.txt File
component_name=curr_s.Component(i,1);
disp(component_name);
    if (component_name=="div")
        fprintf( fid, '<Div> \n');
    elseif (component_name=="Hyperlink")
         fprintf( fid, '<Hyperlink> \n');
    elseif (component_name=="Buttons")
         fprintf( fid, '<Button> \n');
    elseif (component_name=="Paragraph")
         fprintf( fid, '<Paragraph> \n');
    elseif (component_name=="Heading")
        fprintf( fid, '<Heading> \n');
    elseif (component_name=="Hyperlink_Text")
        fprintf( fid, '\t<Hyperlink-Text> \n');
    elseif (component_name=="Button_Text")
        fprintf( fid, '\t<Button-Text> \n');
    else
    end
end

fclose(fid);
    