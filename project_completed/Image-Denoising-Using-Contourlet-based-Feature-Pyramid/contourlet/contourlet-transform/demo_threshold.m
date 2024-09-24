clear all
clc
close all
M0=imread('E:\MS(CS)\Others\Rida_Khalid_FAU\contourlet\dataset\mandrill.jpg');

M0=double(M0(:,:,1));
% Then we add some gaussian noise to it.
sig = std(M0(:));
sigma = sig / 4;

M = M0 + sigma*randn(size(M0));

% Display.

% plot(M0);
% imageplot(clamp(M), 'Noisy', 1,2,2);

% threshold value
T = 1;
v = -linspace(-3,3,2000);

% hard thresholding of the t values
v_hard = v.*(abs(v)>T);
% soft thresholding of the t values
v_soft = max(1-T./abs(v), 0).*v;



clf;
hold('on');
h = plot(v, v_hard);
    set(h, 'LineWidth', 2);
h = plot(v, v_soft, 'r--');
    set(h, 'LineWidth', 2);

    axis('equal'); axis('tight');
legend('Hard thresholding', 'Soft thresholding');
hold('off');