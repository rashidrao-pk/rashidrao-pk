% Lets user drag out a box on an image, then define where they want to paste it.
% Then it pastes the drawn region onto the original image.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
fontSize = 20;
format compact;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end

% Read in a standard MATLAB gray scale demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'eight.tif';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off')

% Let's compute and display the histogram, just for fun.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(2, 2, 2);
bar(pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

% Ask user to draw a box.
subplot(2, 2, 1);
promptMessage = sprintf('Drag out a box that you want to copy,\nor click Cancel to quit.');
titleBarCaption = 'Continue?';
button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
if strcmpi(button, 'Cancel')
	return;
end

k = waitforbuttonpress;
point1 = get(gca,'CurrentPoint');    % button down detected
finalRect = rbbox;                   % return figure units
point2 = get(gca,'CurrentPoint');    % button up detected
point1 = point1(1,1:2);              % extract x and y
point2 = point2(1,1:2);
p1 = min(point1,point2);             % calculate locations
offset = abs(point1-point2);         % and dimensions
% Find the coordinates of the box.
xCoords = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
yCoords = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
x1 = round(xCoords(1));
x2 = round(xCoords(2));
y1 = round(yCoords(5));
y2 = round(yCoords(3));
hold on
axis manual
plot(xCoords, yCoords, 'b-'); % redraw in dataspace units

% Display the cropped image.
croppedImage = grayImage(y1:y2,x1:x2);
subplot(2, 2, 3);
imshow(croppedImage);
axis on;
title('Region that you defined', 'FontSize', fontSize);

% Paste it onto the original image
[rows2, columns2] = size(croppedImage)
promptMessage = sprintf('In the UPPER LEFT IMAGE,\nClick on the upper left point where you want to paste it,\nor click Cancel to quit.');
titleBarCaption = 'Continue?';
button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
if strcmpi(button, 'Cancel')
	return;
end
[x, y] = ginput(1)
% Determine the pasting boundaries.
r1 = int32(y);
c1 = int32(x);
r2 = r1 + rows2 - 1;
r2 = min([r2 rows]);
c2 = c1 + columns2 - 1;
c2 = min([c2, columns]);
plot([c1 c2 c2 c1 c1], [r1 r1 r2 r2 r1], 'r-');
% Paste as much of croppedImage as will fit into the original image.
grayImage(r1:r2, c1:c2) = croppedImage(1:(r2-r1+1), 1:(c2-c1+1));
subplot(2, 2, 4);
imshow(grayImage);
axis on;
title('Region that you defined pasted onto original', 'FontSize', fontSize);

