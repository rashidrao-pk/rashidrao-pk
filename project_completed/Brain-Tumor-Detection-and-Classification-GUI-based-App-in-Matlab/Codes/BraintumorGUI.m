function varargout = BraintumorGUI(varargin)
% BRAINTUMORGUI MATLAB code for BraintumorGUI.fig
%      BRAINTUMORGUI, by itself, creates a new BRAINTUMORGUI or raises the existing
%      singleton*.
%
%      H = BRAINTUMORGUI returns the handle to a new BRAINTUMORGUI or the handle to
%      the existing singleton*.

% Edit the above text to modify the response to help BraintumorGUI

% Last Modified by GUIDE v2.5 07-Feb-2022 20:41:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BraintumorGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @BraintumorGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before BraintumorGUI is made visible.
function BraintumorGUI_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.axes1,'visible', 'off');
set(handles.axes2,'visible', 'off');
set(handles.axes3,'visible', 'off');
set(handles.axes4,'visible', 'off');
set(handles.axes5,'visible', 'off');
set(handles.axes6,'visible', 'off');
set(handles.axes7,'visible', 'off');
set(handles.axes8,'visible', 'off');

% --- Outputs from this function are returned to the command line.
function varargout = BraintumorGUI_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function fun_load_image_Callback(hObject, eventdata, handles)
% hObject    handle to fun_load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Function Load Image
global Brain_RGB_Img inp
[filename, pathname] = uigetfile({'*.jpg'; '*.bmp'; '*.tif'; '*.gif'; '*.png'; '*.jpeg'}, 'Load Image File');
if isequal(filename,0)||isequal(pathname,0)
    warndlg('Failed to Load Image', 'Warning');
else
%      Read Image if variable are successfully loaded
Brain_RGB_Img = imread([pathname filename]);
Brain_RGB_Img = imresize (Brain_RGB_Img,[256,256]);
% Show Input Loaded Image on Axes 1 Location
axes(handles.axes1);
imshow(Brain_RGB_Img);

num_iter = 10;
delta_t = 1/7;
kappa = 15;
option = 2;
%% Calling to Anisotropic Diffusion Function
inp = fun_Anisotropic_Diffusion(Brain_RGB_Img,num_iter,delta_t,kappa,option);
% Converting the matrix to Image Format
inp = uint8(inp);
%  Resizing to 256 x 256 
inp=imresize(inp,[256,256]);
%  checking if the image is in rgb, then convert to gray image
if size(inp,3)>1
    inp=rgb2gray(inp);
end
% axes(handles.axes2);
% imshow(inp);
end


% --- Executes on button press in fun_High_Pass_Filter.
function fun_High_Pass_Filter_Callback(hObject, eventdata, handles)
%% Function High Pass Filter

global Brain_RGB_Img inp filter_High_Pass_Img
%% Possibility 1 
kernel = [-1 -1 -1;-1 8 -1;-1 -1 -1];
filter_High_Pass_Img = imfilter(Brain_RGB_Img, kernel, 'same');

%% Possibility 2
% H = fspecial('unsharp');
% filter_High_Pass_Img = imfilter(Brain_RGB_Img, H);

% Showing on Axes
axes(handles.axes7);
imshow(filter_High_Pass_Img);


% --- Executes on button press in fun_grayscale.
function fun_grayscale_Callback(hObject, eventdata, handles)
%% Function Grayscale Conversion
global Brain_RGB_Img gray_input_image

if(size(Brain_RGB_Img,3)>1)
gray_input_image = rgb2gray(Brain_RGB_Img);
else
    gray_input_image=Brain_RGB_Img;
end

% Showing on Axes
axes(handles.axes8);
imshow(gray_input_image);

% --- Executes on button press in fun_Median_Filter.
function fun_Median_Filter_Callback(hObject, eventdata, handles)
% hObject    handle to fun_Median_Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Function Mediun Filter
global Brain_RGB_Img img_med_filter binary_input_image

binary_input_image=im2bw(Brain_RGB_Img);
img_med_filter = medfilt2(binary_input_image);
axes(handles.axes2);
imshow(img_med_filter);

% --- Executes on button press in fun_Watershed_Segmentation.
function fun_Watershed_Segmentation_Callback(hObject, eventdata, handles)
global  inp  Segmented_RGB
%% Watershed Segmentation
resized=imresize(inp,[256,256]);
t0=60;
th=t0+((max(inp(:))+min(inp(:)))./2);
for i=1:1:size(inp,1)
    for j=1:1:size(inp,2)
        if inp(i,j)>th
            resized(i,j)=1;
        else
            resized(i,j)=0;
        end
    end
end
%  Applying Sobel Filter
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(resized), hy, 'replicate');
Ix = imfilter(double(resized), hx, 'replicate');
%  Taking Squareroot
magnitude = sqrt(Ix.^2 + Iy.^2);
L = watershed(magnitude);
Segmented_RGB = label2rgb(L);
% Showing Segmented Image
axes(handles.axes3);
imshow(Segmented_RGB);

% --- Executes on button press in fun_morphological_refinments.
function fun_morphological_refinments_Callback(hObject, eventdata, handles)
%% Function Morphological Refinments
global  inp tumor_label label stats density detected_tumor_area sout h tumor

sout=imresize(inp,[256,256]);
t0=60;
th=t0+((max(inp(:))+min(inp(:)))./2);
for i=1:1:size(inp,1)
    for j=1:1:size(inp,2)
        if inp(i,j)>th
            sout(i,j)=1;
        else
            sout(i,j)=0;
        end
    end
end

%% Morphological Operation
label=bwlabel(sout);
%% detected_tumor_area Calculation using RegionProps Function
stats=regionprops(logical(sout),'Solidity','Area','BoundingBox');
density=[stats.Solidity];
detected_tumor_area=[stats.Area];
high_dense_detected_tumor_area=density>0.6;
max_detected_tumor_area=max(detected_tumor_area(high_dense_detected_tumor_area));
tumor_label=find(detected_tumor_area==max_detected_tumor_area);
tumor=ismember(label,tumor_label);

if max_detected_tumor_area>100
   axes(handles.axes4);
   imshow(tumor);
else
    h = msgbox('No Tumor!!','status');
   
    return;
end


% --- Executes on button press in fun_Tumor_detected_tumor_area_Location.

function fun_Tumor_Area_Location_Callback(hObject, eventdata, handles)
%% Tumor detected_tumor_area 
global inp tumor_label sout h tumor
label=bwlabel(sout);
stats=regionprops(logical(sout),'Solidity','Area','BoundingBox');
density=[stats.Solidity];
detected_tumor_area=[stats.Area];

high_dense_detected_tumor_area=density>0.6;

max_detected_tumor_area=max(detected_tumor_area(high_dense_detected_tumor_area));
tumor_label=find(detected_tumor_area==max_detected_tumor_area);
tumor=ismember(label,tumor_label);

if max_detected_tumor_area>100

imshow(tumor);
 set(handles.edit2,'String','Tumor present');
  
else
    h = msgbox('No Tumor!!','status');
     set(handles.edit2,'String','No tumor');
    %disp('No tumor');
    return;
end
%% Bounding box
box = stats(tumor_label);

wantedBox = box.BoundingBox;
axes(handles.axes5);
imshow(inp);

%  Drawing Rectangle Box Around the Detected Tumor
hold on;
rectangle('Position',wantedBox,'EdgeColor','y');
hold off;  

dilationAmount = 5;
rad = floor(dilationAmount);
[r,c] = size(tumor);
filledImage = imfill(tumor, 'holes');

for i=1:r
   for j=1:c
       x1=i-rad;
       x2=i+rad;
       y1=j-rad;
       y2=j+rad;
       if x1<1
           x1=1;
       end
       if x2>r
           x2=r;
       end
       if y1<1
           y1=1;
       end
       if y2>c
           y2=c;
       end
       erodedImage(i,j) = min(min(filledImage(x1:x2,y1:y2)));
   end
end

tumorOutline=tumor - erodedImage;

axes(handles.axes6);
imshow(tumorOutline);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
%% Boundry Plotting
global tumor Brain_RGB_Img
[new_rows,new_cols,channel]=size(Brain_RGB_Img);

resized_Brain_RGB_Img=imresize(tumor,[new_rows,new_cols]);

[B,L] = bwboundaries(resized_Brain_RGB_Img,'noholes');
axes(handles.axes6);
    imshow(Brain_RGB_Img);
    hold on
    for k = 1:length(B)
       boundary = B{k};
       plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 2)
    end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)

% --- Executes on button press in btn_classify_tumor.
function btn_classify_tumor_Callback(hObject, eventdata, handles)
%% Function to Classify the Detected Tumor
% Bounding box
global tumor

if(exist('tumor','var') == 1)
    if(size(tumor,1)==0 & size(tumor,2)==0)
        disp('Not OK');
    else
        disp('OK');
global detected_tumor_area white_pixel_count detected_tumor_perimeter1 tumor x y labeledImage 
global total_pixels_2 detected_tumor_perimeter total_pixels_1 detected_tumor_centroid

white_pixel_count = sum(tumor(:))
labeledImage = bwlabel(tumor);
region_measure = regionprops(tumor,  ...
    'Area', 'Centroid', 'Perimeter');

detected_tumor_area = region_measure.Area
detected_tumor_centroid = region_measure.Centroid
detected_tumor_perimeter = region_measure.Perimeter

% Calculate the detected_tumor_area, in pixels
total_pixels_1 = sum(tumor(:));

total_pixels_2 = bwarea(tumor);
detected_tumor_area=sqrt(total_pixels_2);

 %Conversion from pixels to mm
detected_tumor_area=detected_tumor_area*0.26458333;
detected_tumor_perimeter1=detected_tumor_perimeter*0.26458333;

% Get coordinates of the boundary in tumor
bw_boundry = bwboundaries(tumor);
xy=bw_boundry{1};
x = xy(:, 2);
y = xy(:, 1);

   set(handles.text8,'String',detected_tumor_area);
   set(handles.text9,'String',detected_tumor_perimeter1);
   set(handles.text16,'String',detected_tumor_centroid);
   
if total_pixels_2 <= 100
   set(handles.edit1,'String','NoTumor');
     elseif (total_pixels_2 >= 100) && (total_pixels_2 <=2000)
   set(handles.edit1,'String','Low');
elseif (total_pixels_2 >= 2000) && (total_pixels_2 <=4500)
     set(handles.edit1,'String','Medium');
else
% %      If Total Pixels of Tumor are more than 4500 
set(handles.edit1,'String','High');
end

 message = sprintf('Number of pixels = %d\ndetected_tumor_area in pixels = %.2f\ndetected_tumor_perimeter = %.2f\ndetected_tumor_centroid at (x,y) = (%.1f, %.1f)\n', ...
 total_pixels_1, total_pixels_2, detected_tumor_perimeter, ...
detected_tumor_centroid(1), detected_tumor_centroid(2));
msgbox(message);
%% Plotting Centroid
axes(handles.axes6);
plot(detected_tumor_centroid(1), detected_tumor_centroid(2),'r.', 'markers', 10);
 end
else
    disp('Not OK');
end
% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
%% 
axes(handles.axes1); cla(handles.axes1); title('');
axes(handles.axes2); cla(handles.axes2); title('');
axes(handles.axes3); cla(handles.axes3); title('');
axes(handles.axes4); cla(handles.axes4); title('');
axes(handles.axes5); cla(handles.axes5); title('');
axes(handles.axes6); cla(handles.axes6); title('');
axes(handles.axes7); cla(handles.axes7); title('');
axes(handles.axes8); cla(handles.axes8); title('');
set(handles.text8,'String','');
set(handles.text9,'String','');
set(handles.text16,'String','');
set(handles.edit1,'String','');
set(handles.edit2,'String','');

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(BraintumorGUI)
