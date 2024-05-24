close all; clearvars; clc;

% videoFile = 'assets/DM_avenidas.mp4'
videoFile = 'assets/video.mp4'

evalRange = 10;
filterSigma = 1;

%function mask = ROI(mask)
%  mask(1:30, 1:end) = 0;
%endfunction

[mvAccFrames, mvFrames] = getMovement(videoFile, evalRange, filterSigma);

mvAccFrames = mvAccFrames;
mvFrames = cat(3, mvFrames{:});

for i = 1:size(mvFrames, 3)
    mvFrames(:, :, i) = mvFrames(:, :, i);
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
