close all; clearvars; clc;

videoFile = 'assets/DM_avenidas.mp4'
evalRange = 5;
filterSigma = 1;

frameHeight = 480;
frameWidth = 704;
ROI = ones(frameHeight, frameWidth);
ROI(1:30, 1:end) = 0;

[mvAccFrames, mvFrames] = getMovement(videoFile, evalRange, filterSigma);

mvAccFrames = mvAccFrames.*ROI;
matMvFrames = cat(3, mvFrames{:});

for i = 1:size(matMvFrames, 3)
    matMvFrames(:, :, i) = matMvFrames(:, :, i) .* ROI;
end

createVideoWithFFmpeg(matMvFrames, 'outputs/output.mp4', 30);

binaryMvAccFrames = mvAccFrames >= 1;
imwrite(mat2gray(binaryMvAccFrames), 'outputs/accumulated_image.png');

i1 = figure('visible', 'off');
imagesc(mvAccFrames);
colormap(jet);
colorbar;
print(i1, 'outputs/imagesc_jet_colorbar.png', '-dpng');
close(i1);

i2 = figure('visible', 'off');
surf(mvAccFrames);
print(i2, 'outputs/surf_plot.png', '-dpng');
close(i2);
