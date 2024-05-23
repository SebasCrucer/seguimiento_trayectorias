close all; clearvars; clc;

videoFile = 'assets/DM_avenidas.mp4'
evalRange = 20;
filterSigma = 1;

frameHeight = 480;
frameWidth = 704;
ROI = ones(frameHeight, frameWidth);
ROI(1:30, 1:end) = 0;

[mvAccFrames, mvFrames] = getMovement(videoFile, evalRange, filterSigma);

mvAccFrames = mvAccFrames.*ROI;
mvFrames = cat(3, mvFrames{:});

for i = 1:size(mvFrames, 3)
    mvFrames(:, :, i) = mvFrames(:, :, i) .* ROI;
end

mvFrames = mat2cell(mvFrames, size(mvFrames, 1), size(mvFrames, 2), ones(1, size(mvFrames, 3)));

createVideoWithFFmpeg(mvFrames, 'outputs/output.mp4', 30);

binaryMvAccFrames = mvAccFrames >= 1;
imwrite(mat2gray(binaryMvAccFrames), 'outputs/accumulated_image.png');

i1 = figure('visible', 'off');
imagesc(mvAccFrames);
colormap(jet);
colorbar;
print(i1, 'outputs/imagesc_jet_colorbar.png', '-dpng');
close(i1);

figure;
surf(mvAccFrames);
