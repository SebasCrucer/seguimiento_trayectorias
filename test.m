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
mvFrames = arrayfun(@(x) x.*ROI, cat(3, mvFrames{:}), 'UniformOutput', false);

createVideoWithFFmpeg(mvFrames, 'outputs/output.mp4', 30);

binaryMvAccFrames = mvAccFrames >= 1;
imwrite(mat2gray(binaryMvAccFrames), 'outputs/accumulated_image.png');

figure;
imagesc(mvAccFrames)
colormap(jet)
colorbar
figure;
surf(mvAccFrames)
