%% POST Processing
function [binaryImage3,binaryImage2,biggestBlob] = post_processing(binaryImage)
% figure(2),
% subplot(221),imshow(binaryImage),title('Input');
% Extract the largest area using our custom function ExtractNLargestBlobs().
% This is the meat of the demo!
[biggestBlob,status ]= ExtractNLargestBlobs(binaryImage, 1);
% figure(2),
% subplot(222),imshow(biggestBlob),title('Biggest Blob');
    if status==1
        binaryImage2=binaryImage;
    else
        binaryImage2=binaryImage-biggestBlob;
    end
% figure(2),
% subplot(223),imshow(binaryImage2),title('After Removing Largest Area');

%% Pre_Processing of Mask (Performing Dialtion to enhance the size of mask )
B1=imclearborder(binaryImage2,8);
se = strel('disk',8);
BW2 = imdilate(B1,se);
% BW3=imclose(BW2,se);
binaryImage3=imclearborder(BW2,8);
% figure(2),
% subplot(224),imshow(binaryImage3),title('Post Processed');
%%
end
function [binaryImage,status] = ExtractNLargestBlobs(binaryImage, numberToExtract)
try
	% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
	[labeledImage, numberOfBlobs] = bwlabel(binaryImage);
	blobMeasurements = regionprops(labeledImage, 'area');
	% Get all the areas
	allAreas = [blobMeasurements.Area];
	if numberToExtract > length(allAreas);
		% Limit the number they can get to the number that are there/available.
		numberToExtract = length(allAreas);
	end
	if numberToExtract > 0
		% For positive numbers, sort in order of largest to smallest.
		% Sort them.
		[sortedAreas, sortIndexes] = sort(allAreas, 'descend');
        
        if sortedAreas(1:1)<=2000
         sortedAreas(1:1)=1;
         status=1;
%         disp('Area Less than 2000')
        sortIndexes(1:1)=0;
        else
%             disp('Area Greater than 2000')
            status=0;
        end
	elseif numberToExtract < 0
		% For negative numbers, sort in order of smallest to largest.
		% Sort them.
		[sortedAreas, sortIndexes] = sort(allAreas, 'ascend');
		% Need to negate numberToExtract so we can use it in sortIndexes later.
		numberToExtract = -numberToExtract;
	else
		% numberToExtract = 0.  Shouldn't happen.  Return no blobs.
        return;
	end
	% Extract the "numberToExtract" largest blob(s) using ismember().
	biggestBlob = ismember(labeledImage, sortIndexes(1:numberToExtract));
        if status==1
        % Convert from integer labeled image into binary (logical) image.
        binaryImage = 0;
%         binaryImage=1-binaryImage ;
        else
        % Convert from integer labeled image into binary (logical) image.
        binaryImage = biggestBlob > 0;

        end
catch ME
	errorMessage = sprintf('Error in function ExtractNLargestBlobs().\n\nError Message:\n%s', ME.message);
	fprintf(1, '%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
end