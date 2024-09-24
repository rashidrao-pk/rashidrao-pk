function final=New_PSNR(noisyImage)
grayImage = noisyImage;
% grayImage=rgb2gray(grayImage);
[rows columns] = size(grayImage);
% Display the first image.
% figure,
% subplot(2, 2, 1),imshow(grayImage, []),title('Inpainted Image');
% Filtered image
% noisyImage = imnoise(grayImage, 'gaussian', 0, 0.003);
% Display the second image.
% subplot(2, 2, 2),imshow(noisyImage, []),title('Noisy Image');
%------ PSNR CALCULATION ----------------------------------------------------------
% Now we have our two images and we can calculate the PSNR.
% First, calculate the "square error" image.
% Make sure they're cast to floating point so that we can get negative differences.
% Otherwise two uint8's that should subtract to give a negative number
% would get clipped to zero and not be negative.

% Sum the Squared Image and divide by the number of elements
% to get the Mean Squared Error.  It will be a scalar (a single number).
%% For Noisy Image
mse_original = sum(sum(noisyImage)) / (rows * columns);
mse_original_avg=mean2(mse_original);
% Calculate PSNR (Peak Signal to Noise Ratio) from the MSE according to the formula.
PSNR_original = 10 * log10( 256^2 ./ mse_original);
PSNR_original_avg=mean2(PSNR_original);
snr_original=10*log10(mean(noisyImage(:).^2)/mse_original);
snr_original_avg=mean2(snr_original);



% final_cell=table();
% final_cell.PSNR=PSNR_original_avg;
% final_cell.MSE=mse_original_avg;
% final_cell.SNR=snr_original_avg;

final=[PSNR_original_avg,mse_original_avg,snr_original_avg];

end