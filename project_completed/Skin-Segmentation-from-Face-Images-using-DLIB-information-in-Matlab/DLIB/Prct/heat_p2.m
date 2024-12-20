size = 50;
z = zeros(size, size);
for r = 1:size
    for c = 1:size
        z(r,c) = r+c;
    end
end
fig = figure;

colormap('hot');
imagesc(z);
colorbar;

%--PLOTLY--%

% Strip MATLAB<sup>&reg;</sup> style by default!
response = fig2plotly(fig, 'filename', 'matlab-basic-heatmap');
plotly_url = response.url;