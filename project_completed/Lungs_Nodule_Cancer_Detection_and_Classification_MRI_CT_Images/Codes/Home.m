function varargout = Home(varargin)
% HOME MATLAB code for Home.fig
%      HOME, by itself, creates a new HOME or raises the existing
%      singleton*.
%
%      H = HOME returns the handle to a new HOME or the handle to
%      the existing singleton*.
%
%      HOME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOME.M with the given input arguments.
%
%      HOME('Property','Value',...) creates a new HOME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Home_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Home_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Home

% Last Modified by GUIDE v2.5 20-Jun-2022 19:35:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Home_OpeningFcn, ...
                   'gui_OutputFcn',  @Home_OutputFcn, ...
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


% --- Executes just before Home is made visible.
function Home_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Home (see VARARGIN)

% Choose default command line output for Home
handles.output = hObject;
% Show Logo
logo = imread('Logo.png');
axes(handles.axes17)
imshow(logo);

header= imread('Header.jpg');
axes(handles.axes18)
imshow(header);


% Update handles structure
guidata(hObject, handles);
global imds1 imds2
clc
DS_Detection_Folder='F:\Datasets\Lungs\Data\detection';
DS_Detection_Folder = fullfile(DS_Detection_Folder);
imds1 = imageDatastore(fullfile(DS_Detection_Folder));


DS_Classification_Folder='F:\Datasets\Lungs\Data\train';
allfoldernames= struct2table(dir(DS_Classification_Folder));
for (i=3:height(allfoldernames))
    new(i-2)=allfoldernames.name(i);
end
clear i
categories=new;

imds2 = imageDatastore(fullfile(DS_Classification_Folder,...
                    categories), 'LabelSource','foldernames');

%% Detection Sample           
idx1 = randperm(numel(imds1.Files),6);
for i = 1:size(idx1,2)
    img= readimage(imds1,idx1(i));
    img = imresize(img,[512,512]);
    if i==1
        axes(handles.axes2);
    elseif i==2
        axes(handles.axes3);
    elseif i==3
        axes(handles.axes4);
    elseif i==4
        axes(handles.axes5);
    elseif i==5
        axes(handles.axes6);
    elseif i==6
        axes(handles.axes7);
    else
    end
    imshow(img)
end

%% Classification Samples

idx2 = randperm(numel(imds2.Files),9);
for i = 1:size(idx2,2)
    img= readimage(imds2,idx2(i));
    img = imresize(img,[512,512]);
    if i==1
        axes(handles.axes8);
    elseif i==2
        axes(handles.axes9);
    elseif i==3
        axes(handles.axes10);
    elseif i==4
        axes(handles.axes11);
    elseif i==5
        axes(handles.axes12);
    elseif i==6
        axes(handles.axes13);
    elseif i==7
        axes(handles.axes14);
    elseif i==8
        axes(handles.axes15);
    elseif i==9
        axes(handles.axes16);
    else
    end
    imshow(img)
end

% UIWAIT makes Home wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Home_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in btn_detection.
function btn_detection_Callback(hObject, eventdata, handles)
% hObject    handle to btn_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Detection Page 
close(Home)
detection();

% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Button Exit
close all

% --- Executes on button press in btn_classification.
function btn_classification_Callback(hObject, eventdata, handles)
% hObject    handle to btn_classification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Home)
classification();
