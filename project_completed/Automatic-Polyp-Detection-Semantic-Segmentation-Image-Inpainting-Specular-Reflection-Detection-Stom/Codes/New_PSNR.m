function final=New_PSNR(noisyImage,inpaintedImg)
grayImage = inpaintedImg;
% grayImage=rgb2gray(grayImage);
[rows columns] = size(grayImage);
% Display the first image.
figure,
subplot(2, 2, 1);
imshow(grayImage, []);
title('Inpainted Image');
% Filtered image
% noisyImage = imnoise(grayImage, 'gaussian', 0, 0.003);
% Display the second image.
subplot(2, 2, 2);
imshow(noisyImage, []);
title('Noisy Image');
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

%% For Inpainted image
mse_improved = sum(sum(grayImage)) / (rows * columns);
mse_improved_avg=mean2(mse_improved);
% Calculate PSNR (Peak Signal to Noise Ratio) from the MSE according to the formula.
PSNR_improved = 10 * log10( 256^2 / mse_improved);
PSNR_improved_avg=mean2(PSNR_improved);
snrr_improved=10*log10(mean(grayImage(:).^2)/mse_improved);
snrr_improved_avg=mean2(snrr_improved);

final=cell(3,4);
final(1,2)={'MSE_AVG'};
final(1,3)={'PSNR_AVG'};
final(1,4)={'SNR_AVG'};

final(2,1)={'Noisy'};
final(3,1)={'Inpainted Image'};


final(2,2)={mse_original_avg};
final(2,3)={PSNR_original_avg};
final(2,4)={snr_original_avg};

final(3,2)={mse_improved_avg};
final(3,3)={PSNR_improved_avg};
final(3,4)={snrr_improved_avg};

end