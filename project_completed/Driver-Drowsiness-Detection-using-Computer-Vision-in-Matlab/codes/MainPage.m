function varargout = MainPage(varargin)
% MAINPAGE MATLAB code for MainPage.fig
%      MAINPAGE, by itself, creates a new MAINPAGE or raises the existing
%      singleton*.
%
%      H = MAINPAGE returns the handle to a new MAINPAGE or the handle to
%      the existing singleton*.
%
%      MAINPAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINPAGE.M with the given input arguments.
%
%      MAINPAGE('Property','Value',...) creates a new MAINPAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainPage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainPage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainPage

% Last Modified by GUIDE v2.5 20-Apr-2021 23:19:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainPage_OpeningFcn, ...
                   'gui_OutputFcn',  @MainPage_OutputFcn, ...
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


% --- Executes just before MainPage is made visible.
function MainPage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainPage (see VARARGIN)

% Choose default command line output for MainPage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
delete(imaqfind)
set(handles. uipanel5,'Visible','off');
clear all;
clc
global cap isstop numFrame
cap = webcam(1);
isstop = false;
numFrame = 1;
global y, global Fs
[y, Fs] = audioread('alarm.wav');

% UIWAIT makes MainPage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainPage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Start Button Functions
global exit_status
exit_status=0;
set(handles. uipanel5,'Visible','on');
set(handles.text28, 'String', "1");

load DB
cl = {'open','close'};

dim = [30 60;
       30 60
       40 65];
delete(imaqfind)


global exit_status
global vid

% Create a detector object
faceDetector = vision.CascadeObjectDetector;   
faceDetectorLeye = vision.CascadeObjectDetector('EyePairBig'); 
faceDetectorM = vision.CascadeObjectDetector('Mouth'); 

% global vid
global alert_count;
global exit_status;
global cap isstop numFrame

if isstop
    isstop = false;
    handles.pushbutton1.String = 'Start Camera';
    set(handles. pushbutton2,'Enable','on');
    set(handles. pushbutton3,'Enable','on');
    set(handles. pushbutton5,'Enable','on');
else
    isstop = true;
    handles.pushbutton1.String = 'Stop Camera';
    set(handles. pushbutton2,'Enable','off');
    set(handles. pushbutton3,'Enable','off');
    set(handles. pushbutton5,'Enable','off');
    handles.text19.String = cap.Exposure;
    handles.text21.String = cap.Sharpness;
    handles.text23.String = cap.Exposure;
    handles.text25.String = cap.Saturation;
    handles.text27.String = cap.Gamma;
end
axes(handles.axes1);
ts1 = 0;
alert_count=1;
while exist('isstop','var')&&isstop
    numFrame = numFrame+1;
    [frame,ts] = snapshot(cap);
     im=fliplr(frame);
    frameRate = 1./(ts-ts1);
    ts1 = ts;
    
    showText = sprintf('frameRate:%d\n  Frame:%d\n',round(frameRate),numFrame);
    draw = insertText(im,[10,20],showText,'FontSize',20);
    
    set(handles.text17, 'String', showText);

    axes(handles.axes1)
    imshow(im);
    drawnow;
% end


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% for ii = 1:500
%     trigger(vid);
%        
%     im=getdata(vid,1); % Get the frame in im
%     im=fliplr(im);
%    im=rgb2gray(im);
%     subplot(3,4,[1 2 5 6 9 10]);
    
%    axes(handles.axes1)
%     imshow(im)
%      preview(vid,hImage);   
    % Detect faces
    bbox = step(faceDetector, im); 
    
    if ~isempty(bbox);
        bbox = bbox(1,:);

        % Plot box
        rectangle('Position',bbox,'edgecolor','r');

         S = fun_skin_seg2(im);
    
        % Segment skin region
        bw3 = cat(3,S,S,S);

        % Multiply with original image and show the output
        Iss = double(im).*bw3;

        Ic = imcrop(im,bbox);
        Ic1 = imcrop(Iss,bbox);
        
%         subplot(3,4,[3 4]);
         axes(handles.axes2)
        imshow(uint8(Ic1))
        
        
    
        bboxeye = step(faceDetectorLeye, Ic); 
        
        if ~isempty(bboxeye);
            bboxeye = bboxeye(1,:);

            Eeye = imcrop(Ic,bboxeye);
            % Plot box
            rectangle('Position',bboxeye,'edgecolor','y');
            set(handles.text13, 'String', '');
        else
%             disp('Eyes not detected')
            set(handles.text13, 'String', 'Eyes not detected');
            cla(handles.axes6)
            cla(handles.axes7)
        end
        
        if isempty(bboxeye)
            continue;
        end
       Ic(1:bboxeye(2)+2*bboxeye(4),:,:) = 0; 

        % Detect Mouth
        bboxM = step(faceDetectorM, Ic); 
        

        if ~isempty(bboxM);
            bboxMtemp = bboxM;
            
            if ~isempty(bboxMtemp)
            
                bboxM = bboxMtemp(1,:);
                Emouth =  imcrop(Ic,bboxM);

                % Plot box
                rectangle('Position',bboxM,'edgecolor','y');
                set(handles.text7, 'String', ' ');
            else
%                 disp('Mouth  not detected')
                set(handles.text7, 'String', 'Mouth  not detected');
                drawnow; % Needed only if this is in a fast loop.
                cla(handles.axes8)
            end
        else
%             disp('Mouth not detected')
              set(handles.text7, 'String', 'Mouth  not detected');
              cla(handles.axes8)
        end
        axes(handles.axes9)
        histogram(im)
        [nre nce k ] = size(Eeye);
        
        % Divide into two parts
        Leye = Eeye(:,1:round(nce/2),:);
        Reye = Eeye(:,round(nce/2+1):end,:);
              
%         subplot(3,4,7)
        axes(handles.axes6)
        imshow(histeq(Leye));
%         subplot(3,4,8)
        axes(handles.axes7)
        imshow(histeq(Reye));
%         subplot(3,4,[11,12]);
        axes(handles.axes10)
        histogram(Reye)
     if exist('Emouth','var') == 1
     axes(handles.axes8)
        imshow(histeq(Emouth));
        
        axes(handles.axes11)
        histogram(Emouth)
        if isequal(size(Emouth,3),3)
        Emouth = rgb2gray(Emouth);
        else
        end
     end

        Leye = rgb2gray(Leye);
        Reye = rgb2gray(Reye);
        
%% Template matching using correlation coefficient
% Left eye
% Resize to standard size
Leye =  imresize(Leye,[dim(1,1) dim(1,2)]);

c1 =fun_match_DB(Leye,DBL);
set(handles.text3, 'String', cl{c1});
drawnow; % Needed only if this is in a fast loop.
        
%       Right eye
% Resize to standard size
Reye =  imresize(Reye,[dim(2,1) dim(2,2)]);
c2 = fun_match_DB(Reye,DBR);
set(handles.text4, 'String', cl{c2});
drawnow; % Needed only if this is in a fast loop.
%   Mouth
% % % % % % % % % % % % % % % % % % % % % % % %    
if exist('Emouth','var')
    % Resize to standard size
    Emouth =  imresize(Emouth,[dim(3,1) dim(3,2)]);
    c3 = fun_match_DB(Emouth,DBM);
    set(handles.text5, 'String', cl{c3}); 
else
end
global Fs, global y
if exist('c1','var')
    if exist('c2','var')
        if exist('c3','var')
            
   if cl{c1} =="close" && cl{c2} =="close" 
        if cl{c3} == "open"
%             disp("Drowsiness Alert")
            player = audioplayer(y, Fs);
            alert_count=alert_count+1;
%%              Setting Status Bar Color
            if alert_count>5
            set(handles. pushbutton6,'BackgroundColor','#DC143C');
            set(handles.text28, 'String', "5");
             %  Sending Email and Checking Email Status
            success=fun_send_email;
             % Creating Alert Sound
            play(player);
            alert_count=0;
                if success==1
                    set(handles.text15, 'String', "ALERT SENT");
                elseif success~=1
                    set(handles.text15, 'String', "Couldn't Send Mail");
                end
            elseif alert_count>4
             set(handles.text28, 'String', "4");
             set(handles. pushbutton6,'BackgroundColor','#FF0000');
            elseif alert_count>3
             set(handles.text28, 'String', "3");
             set(handles. pushbutton6,'BackgroundColor','#FF6347');
            elseif alert_count>2
             set(handles.text28, 'String', "2");
             set(handles. pushbutton6,'BackgroundColor','#FF7F50');
            else
             stop(player);
            end
            else
  
        end
   else
        set(handles. pushbutton6,'BackgroundColor','green')
        set(handles.text15, 'String', "");
   end
        end
    end
end

%   handles.text5=cl{c3};
        drawnow; % Needed only if this is in a fast loop.
        pause(0.005)
    end
    
end
if evalin( 'base', 'exist(''vid'',''var'') == 1' )
stop(vid);
disp('VID was existing');
else
end

% end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% HomePage Button
close(MainPage)
first_page
clc

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Exit Button
global exit_status
delete(imaqfind)
close(MainPage)
exit_status=1;


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Select Video Function
set(handles. pushbutton1,'Enable','off');
set(handles. pushbutton2,'Enable','off');
set(handles. pushbutton3,'Enable','off');
set(handles. uipanel5,'Visible','off');

    
code_path=cd;
cd DS
[file,path]=uigetfile('*.*');
cd(code_path)
if isequal(file,0) | isequal(path,0)
   warndlg('File is not selected');
   
else 
    
videoObject = VideoReader([path,file]);

load DB
cl = {'open','close'};
dim = [30 60;
        30 60
        40 65];
% Determine how many frames there are.
numberOfFrames = videoObject.NumFrames;
vidHeight = videoObject.Height;
vidWidth = videoObject.Width;
numberOfFramesWritten = 0;
%  Create a detector object
faceDetector = vision.CascadeObjectDetector;   
faceDetectorLeye = vision.CascadeObjectDetector('EyePairBig'); 
faceDetectorM = vision.CascadeObjectDetector('Mouth'); 
global alert_count
alert_count=0;
    
for frame=1:numberOfFrames
    im = read(videoObject, frame);
    
    axes(handles.axes1)
    imshow(im) 
    
   axes(handles.axes1)
    imshow(im)

    % Detect faces
    bbox = step(faceDetector, im); 
    
    if ~isempty(bbox);
        bbox = bbox(1,:);

        % Plot box
        rectangle('Position',bbox,'edgecolor','r');

         S = fun_skin_seg2(im);
    
        % Segment skin region
        bw3 = cat(3,S,S,S);

        % Multiply with original image and show the output
        Iss = double(im).*bw3;
        Ic = imcrop(im,bbox);
        Ic1 = imcrop(Iss,bbox);
        axes(handles.axes2)
        imshow(uint8(Ic1))
        bboxeye = step(faceDetectorLeye, Ic); 
        
        if ~isempty(bboxeye);
            bboxeye = bboxeye(1,:);
            Eeye = imcrop(Ic,bboxeye);
            % Plot box
            rectangle('Position',bboxeye,'edgecolor','y');
            set(handles.text13, 'String', '');
        else
            set(handles.text13, 'String', 'Eyes not detected');
            cla(handles.axes6)
            cla(handles.axes7)
        end
        
        if isempty(bboxeye)
            continue;
        end
       Ic(1:bboxeye(2)+2*bboxeye(4),:,:) = 0; 

        % Detect Mouth
        bboxM = step(faceDetectorM, Ic); 
        
        if ~isempty(bboxM);
            bboxMtemp = bboxM;            
            if ~isempty(bboxMtemp)
                bboxM = bboxMtemp(1,:);
                Emouth =  imcrop(Ic,bboxM);
                % Plot box
                rectangle('Position',bboxM,'edgecolor','y');
                set(handles.text7, 'String', ' ');
            else

                set(handles.text7, 'String', 'Mouth  not detected');
                cla(handles.axes8)
                drawnow; % Needed only if this is in a fast loop.                
            end
        else
%             disp('Mouth not detected')
          set(handles.text7, 'String', 'Mouth  not detected');
          cla(handles.axes8)
        end
        
        axes(handles.axes9)
        histogram(im)

        [nre nce k ] = size(Eeye);
        
        % Divide into two parts
        Leye = Eeye(:,1:round(nce/2),:);
        Reye = Eeye(:,round(nce/2+1):end,:);

        axes(handles.axes6)
        imshow(histeq(Leye));

        axes(handles.axes7)
        imshow(histeq(Reye));

        axes(handles.axes10)
        histogram(Reye)
    
        axes(handles.axes8)
        imshow(histeq(Emouth));
        
        axes(handles.axes11)
        histogram(Emouth)
        
        Leye = rgb2gray(Leye);
        Reye = rgb2gray(Reye);
        
    if isequal(size(Emouth,3),3)
        Emouth = rgb2gray(Emouth);
    else
    end

        
    %% Template matching using correlation coefficient
    %% Left eye
    % Resize to standard size
    Leye =  imresize(Leye,[dim(1,1) dim(1,2)]);
    c1 =fun_match_DB(Leye,DBL);
    set(handles.text3, 'String', cl{c1});
    drawnow; % Needed only if this is in a fast loop.

    %% Right eye
    % Resize to standard size
    Reye =  imresize(Reye,[dim(2,1) dim(2,2)]);
    c2 = fun_match_DB(Reye,DBR);
    set(handles.text4, 'String', cl{c2});
    drawnow; % Needed only if this is in a fast loop.
    %% Mouth
    % Resize to standard size
    Emouth =  imresize(Emouth,[dim(3,1) dim(3,2)]);
    c3 = fun_match_DB(Emouth,DBM);
    set(handles.text5, 'String', cl{c3});
    global Fs, global y
%%   Decision Making on Full Status of Mouth and Face
    if cl{c1} =="close" && cl{c2} =="close" 
        if cl{c3} == "open"
         player = audioplayer(y, Fs);
%             disp("Drowsiness Alert")
            alert_count=alert_count+1;
%%              Setting Status Bar Color
            if alert_count>5
             set(handles. pushbutton6,'BackgroundColor','#DC143C');
             set(handles.text28, 'String', "5");
            % Creating Alert Sound
             play(player);
             
             %% Sending Email and Checking Email Status
             success=fun_send_email;
                if success==1
                    set(handles.text15, 'String', "ALERT Email SENT");
                else
                    set(handles.text15, 'String', "Internet Unavailable");
                end
            alert_count=0;
            elseif alert_count>4
             set(handles. pushbutton6,'BackgroundColor','#FF0000');
             set(handles.text28, 'String', "4");
            elseif alert_count>3
             set(handles. pushbutton6,'BackgroundColor','#FF6347');
             set(handles.text28, 'String', "3");
            elseif alert_count>2
             set(handles. pushbutton6,'BackgroundColor','#FF7F50');
             set(handles.text28, 'String', "2");
            else
                set(handles.text28, 'String', "1");
                stop(player);
                set(handles.text15, 'String', "");
            end
  
        end
    else
       set(handles.text28, 'String', "0"); 
        set(handles. pushbutton6,'BackgroundColor','green')
    end
%   handles.text5=cl{c3};
        drawnow; % Needed only if this is in a fast loop.
        pause(0.001)
    end
        set(handles.text17, 'String', frame);
        set(handles. pushbutton1,'Enable','off');
        set(handles. pushbutton2,'Enable','off');
        set(handles. pushbutton3,'Enable','off');
        set(handles. pushbutton5,'Enable','off');
    end
        f = msgbox('Operation Completed','Success');
        set(handles. pushbutton1,'Enable','on');
        set(handles. pushbutton2,'Enable','on');
        set(handles. pushbutton3,'Enable','on');
        set(handles. pushbutton5,'Enable','on');
end
set(handles. pushbutton1,'Enable','on');
set(handles. pushbutton2,'Enable','on');
set(handles. pushbutton3,'Enable','on');


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global exit_status
exit_status=1;
global vid
if evalin( 'base', 'exist(''vid'',''var'') == 1' )
%     delete(vid);
disp('VID was existing');
else
end
pause(2)
delete(MainPage)
delete(imaqfind)
clear all;

function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ¹Ø±Õ´°¿ÚµÄ»Øµ÷º¯Êý
clear all;
