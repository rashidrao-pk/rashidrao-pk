%% Reading Coordinators.xlsx
% Clears all variable from workspace ( matlab's memory)
clear all; 
% Clears all values from command window.
clc; 
% Close all figures opened previously
close all; 
% Setting Workspace to show if hidden.
workspace; 
%  Best of fixed or floating point format with 15 
%  digits for double and 7 digits for single.
format long g;
% Reading Excel File 'Coordinators.xlsx' into matlab using readtable function and saving all
% values into 'GT_Desc'
% [file,path]=uigetfile('*.*');

GT_Desc = readtable('orignal_Coordinators of Image 01.xlsx', 'ReadVariableNames', true);
% GT_Desc = readtable([path,file], 'ReadVariableNames', true);
% GT_Desc_Sorted = sortrows(GT_Desc,{'Height','Weight'},{'ascend','descend'});
% GT_Desc_Sorted_1 = sortrows(GT_Desc,{'yAxis','xAxis'},{'ascend','ascend'});
% GT_Desc_Sorted = sortrows(GT_Desc,["xAxis","yAxis"]);
GT_Desc_Sorted = sortrows(GT_Desc,["yAxis","xAxis"]);
%%  Open File for DOM Saving
fid = fopen( 'results.txt', 'w+' );
%%
D = 'Classified_Components';
S = dir(fullfile(D,'*.jpg'));
%% Sort image in actual order according to their names
% >> A = {'a2.txt', 'a10.txt', 'a1.txt'}
% >> sort(A)
% ans = 'a1.txt'  'a10.txt'  'a2.txt'
% >> natsortfiles(A)
% ans = 'a1.txt'  'a2.txt'  'a10.txt'

N = natsortfiles({S.name});
F = cellfun(@(images_names)fullfile(D,images_names),N,'uni',0);

% Defines a collection of images by specifying imageLocation
imset=imageSet(F);
%   Popolating Maximum x, y, width and height value for each component among
%   all the components.
[max_x,index_x]=max(GT_Desc.xAxis);
[max_y,index_y]=max(GT_Desc.yAxis);
[max_w,index_w]=max(GT_Desc.width);
[max_h,index_h]=max(GT_Desc.height);

% Applying ceil function to get inetger values instead of decimal values.
max_x=ceil(max_x);
max_y=ceil(max_y);
max_w=ceil(max_w);
max_h=ceil(max_h);

% Creating a Black Image using Max_x and Max_y to make Bigger Picture
img=ones(max_y+600,max_x+600);
% Showing Created Picture
figure(1),
imshow(img);
% Setting up the total no of inner components
total_inner_Components=34;

for i=1:total_inner_Components
%     Getting Image Location for image at i index
    filename=imset.ImageLocation{1,i};
%     Splitting up the complete filename to path, name and extension using
%     filegetparts (matlab's function)
    [bpath,bname,bext]=fileparts(filename);
%     Spliitting the name according to '_'
    bname = split(bname,"_")';
%     Most of names of images are having one '_' and some of them have two
%     '_' in the name. hence splitting will make them either into two values or
%     three values
% Checking for splitted up Values
    if (size(bname,2)==2)
%         if the values are two then ignoring the first one which is 1,2,3
%         or the serial no concatenated with the images name.
        finalName{i,1}=string(bname(1,2));
    elseif (size(bname,2)==3)
%         If the values are three then ignoring the first one and getting
%         the second and thrid one and joining them 
        tempName=string(join([bname(1,2),'_',bname(1,3)]));
%         Removing Unnecessary space after join function of matlab
        tempName= strrep(tempName,' ','') ;
%         Saving new image name into cell type 
        finalName{i,1}=tempName; 
    end
%     Clering bname and tempName variable only
    clear bname tempName
% checking if the Image name and the Coordinates file have the same name or
% not ??
    if (GT_Desc.Component(i,1) == finalName{i,1})
%   Displaying the Image name and the Coordinates file have the same name or not
%         disp([GT_Desc.Component(i,1) ' == ' finalName{i,1}]);
%       Saving Coordinates values into varibale
        pos_x=GT_Desc.xAxis(i,1);
        pos_y=GT_Desc.yAxis(i,1);
        pos_w=GT_Desc.width(i,1);
        pos_h=GT_Desc.height(i,1);
        
        % as _ is not supported in the Figure Captioning or title so Converting the
% _ to - and then making text ready to be shown in the each component.
% i.e. for div, hyperlink, button all is ok
% but for hyperlink_text, button_text, this '_' makes confusion in text
% function, so they are converted to '-'.
         name = split(finalName{i,1},"_")';
        if (size(name,2)==2)
            if (name(1,1)=="Hyperlink")
                tmp=join(["Hyperlink-",name(1,2)]);
                tmp= strrep(tmp,' ','') ;
                finalName{i,1}=tmp;
            else
                tmp=join(["Button-",name(1,2)]);
                tmp= strrep(tmp,' ','') ;
                finalName{i,1}=tmp;
            end
        end
%         Adding Text accroding to the position and getting name of the
%         component from above acheived fileName.
% Chekcing if the Text is existing in the component Name 
    a=contains(name,"Text");
    
%         Making Figure Named as '1' and plotting recatngle onto the
%         position as for each component accroding to its corresponding
%         coordinates.
        figure(1),
    if (finalName{i,1}=="div")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', '#77AC30','LineWidth',2);
        text('Position',[pos_x+10 pos_y-15],'string',finalName{i,1},'Color','#77AC30','fontsize',8,'FontWeight', 'bold');
    elseif (finalName{i,1}=="Hyperlink")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', 'black','LineWidth',2);
        text('Position',[pos_x+pos_w/4 pos_y-15],'string',finalName{i,1},'Color','black','fontsize',8,'FontWeight', 'bold');
    elseif (finalName{i,1}=="Buttons")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', '#A2142F','LineWidth',2);
        text('Position',[pos_x+5 pos_y+10],'string',finalName{i,1},'Color','#A2142F','fontsize',8,'FontWeight', 'bold');
    elseif (finalName{i,1}=="Paragraph")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', '#7E2F8E','LineWidth',2);
        text('Position',[pos_x+5 pos_y+10],'string',finalName{i,1},'Color','#7E2F8E','fontsize',8,'FontWeight', 'bold');
    elseif (finalName{i,1}=="Heading")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', 'blue','LineWidth',2);
        text('Position',[pos_x+5 pos_y+10],'string',finalName{i,1},'Color','blue','fontsize',8,'FontWeight', 'bold');
    elseif (finalName{i,1}=="Hyperlink-Text")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', 'red','LineWidth',2);
        text('Position',[pos_x+5 pos_y+pos_h/2 ],'string',finalName{i,1},'Color','red','fontsize',8,'FontWeight', 'bold');
    elseif (finalName{i,1}=="Button-Text")
        rectangle('Position', [pos_x, pos_y, pos_w, pos_h], 'EdgeColor', '#4DBEEE','LineWidth',2);
        text('Position',[pos_x+5 pos_y+pos_h/2 ],'string',finalName{i,1},'Color','#4DBEEE','fontsize',8,'FontWeight', 'bold') ;
    else
    end   
    pause(0.3)
%       disp('Align Text in the center');
% If the component is having 'Text' in the name then placing it in the
% center of the component.
       
    
%         If the text is not existing then placing label in the start of the
%         component.
%         Showing total component at the Figure Title.
        title(['DOM Creation using ' num2str(total_inner_Components) 'Components :']);
%       Read each component from the images folder
        img_subimage=imread(filename);
%       Getting size for each sub image        
        [imr,imc]=size(img_subimage);
%         Resizing each sub image according to size it should be, using
%         width and height from coordinates file.
        img_subimage=imresize(img_subimage,[pos_h,pos_w]);
%         figure(2),
%         imshow(img_subimage);
        %% Overlay Image
%         To place each component onto the bigger image.
%         image(img)
%         hold on
%         image([pos_x pos_y], [pos_x pos_y],img_subimage);   % specify your locations here        
    else
    end
end
clear i
%% Loop for creating DOM File
% GT_Desc_Sorted
% first loop is to find whether it is child or parent

% for
%     for
%     end
% end
%%  OUTER LOOP
for i=1:total_inner_Components
%     Getting Image Location for image at i index
    clear component_name
    component_name=GT_Desc_Sorted.Component(i,1);
    x1=GT_Desc_Sorted.xAxis(i,1);
    y1=GT_Desc_Sorted.yAxis(i,1);
    h=GT_Desc_Sorted.height(i,1);
    w=GT_Desc_Sorted.width(i,1);
    
    if(i==total_inner_Components)
    x1=GT_Desc_Sorted.xAxis(i,1);
    y1=GT_Desc_Sorted.yAxis(i,1);
    w=GT_Desc_Sorted.width(i,1);
    h=GT_Desc_Sorted.height(i,1);
    else
    x2=x1+w;
    y2=y1+h;
    end
% %  Finding if parent or child
%   x1,y1,x2,y2 are parent and x,y are of child
%% Loop to compare current value with all other values
GT_Desc_Sorted_New{i,1}=component_name;
GT_Desc_Sorted_New{i,2}=x1;
GT_Desc_Sorted_New{i,3}=y1;
GT_Desc_Sorted_New{i,4}=x2;
GT_Desc_Sorted_New{i,5}=y2;
%%  INNER LOOP
    for j=1:total_inner_Components
    x=GT_Desc_Sorted.xAxis(j,1);
    y=GT_Desc_Sorted.yAxis(j,1);

    diff1=abs((x1-x) + (y1-y));
    diff2=abs((x-y) + (x1-y1));


    GT_Desc_Sorted_New{i,6}=x;
    GT_Desc_Sorted_New{i,7}=y;

        if (x > x1 && x < x2 && y > y1 && y < y2)
        GT_Desc_Sorted_New{i,8}='Child';
        GT_Desc_Sorted_New{i,9}=i;
        %     inner_of_which = i;
        else   
            GT_Desc_Sorted_New{i,8}='Parent';      
        end
        GT_New{i,j}=diff1;
    end
GT_Desc_Sorted_New{i,10}=diff1;
GT_Desc_Sorted_New{i,11}=diff2;



%     disp([ num2str(x_Axis + width) ' > ' num2str(x1 + w1)]);
%     disp([ num2str(y_Axis + height+ x_Axis) ' > ' num2str(y1+ h1)]);
%     
%     if  y_Axis == GT_Desc_Sorted.yAxis(i+1,1)
%         if (x_Axis + width > x1 + w1 && y_Axis + height >  y1+ h1)
%             disp('---> Inner');
%         end
%          disp('---> Outer');
%     end
    
%     GT_Desc_Sorted_New{i,1}=component_name;
% % % %     X+Width
%     GT_Desc_Sorted_New{i,2}= GT_Desc_Sorted.xAxis(i,1)+ GT_Desc_Sorted.width(i,1);    
% % % %     Y+ Height
%     GT_Desc_Sorted_New{i,3}= GT_Desc_Sorted.yAxis(i,1)+ GT_Desc_Sorted.height(i,1);
% % % %      X + Y + Height
%     GT_Desc_Sorted_New{i,2}= x1 + y2+ h;  
% % % %       (X+X1) - (Y + Y1)
%     GT_Desc_Sorted_New{i,3}= (x1 + x1) - (y2 + y2) ;
% % % %     Y-Y1
%     GT_Desc_Sorted_New{i,4}= y2 -y2 ;
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

GT_Desc_Sorted_New = sortrows(GT_Desc_Sorted_New,[3 10],{'ascend' 'ascend'});

% GT_Desc_Sorted_New = sortrows(GT_Desc_Sorted_New,3,'ascend');