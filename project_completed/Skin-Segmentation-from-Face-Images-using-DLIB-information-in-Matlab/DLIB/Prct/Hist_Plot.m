%% https://www.mathworks.com/help/econ/moving-average-trend-estimation.html

%% Hist Plot
%%  ITA_Sum=Matrix
[pixelCountsR, grayLevelsR] = hist(ITA_Sum);
grid on
plot(grayLevelsR,pixelCountsR, 'r-', 'LineWidth', 2);
hold on; 
fontSize = 20;
ylabel('Frequency', 'FontSize', fontSize);
xlabel('Pixel Value', 'FontSize', fontSize);

[pixelCountsR, grayLevelsR] = imhist(rgb(:,:,1));
[pixelCountsG, grayLevelsG] = imhist(rgb(:,:,2));
[pixelCountsB, grayLevelsB] = imhist(rgb(:,:,3));
grid on

plot(grayLevelsR, pixelCountsR, 'r-', 'LineWidth', 2);
hold on;
grid on

plot(grayLevelsG, pixelCountsG, 'g-', 'LineWidth', 2);
hold on;
grid on

plot(grayLevelsB, pixelCountsB, 'b-', 'LineWidth', 2);
grid on;
fontSize = 20;
ylabel('Frequency', 'FontSize', fontSize);
xlabel('Pixel Value', 'FontSize', fontSize);