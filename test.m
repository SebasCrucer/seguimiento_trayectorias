close all; clearvars; clc;

videoFile = 'assets/DM_avenidas.mp4'

evalRange = 10;
filterSigma = 1;

function mask = ROI(mask)
  mask(1:30, 1:end) = 0;
endfunction

[mvAccFrames, mvFrames, frames] = getMovement(videoFile, evalRange, filterSigma, @ROI);

% guardo el video del preprocesado
createVideoWithFFmpeg(frames, 'outputs/preprocessed.mp4', 30);

% guardo video del movimiento
createVideoWithFFmpeg(mvFrames, 'outputs/movement.mp4', 30);

% creo y guardo video de barrido del movimiento
mvSweepFrames = cell(size(mvFrames));
mvSweepFramesAcc = zeros(size(mvFrames{1}));
for f = 1:size(mvSweepFrames, 2)
  mvSweepFramesAcc+=mvFrames{f};
  mvSweepFrames{f} = mvSweepFramesAcc;
endfor
createVideoWithFFmpeg(mvSweepFrames, 'outputs/movement_sweep.mp4', 30);

% guardo imagen del movimento acumulado en escala de grises
scaledMvAccFrames = (255/max(mvAccFrames(:)))*mvAccFrames;
imwrite(mat2gray(scaledMvAccFrames), 'outputs/accumulated_image.png');

% guardo imagen del movimiento binarizado
binaryMvAccFrames = mvAccFrames >= 1;
imwrite(mat2gray(binaryMvAccFrames), 'outputs/binary_image.png');

% creo imagen de mapa de calor
i1 = figure('visible', 'off');
imagesc(mvAccFrames);
colormap(jet);
colorbar;
print(i1, 'outputs/imagesc_jet_colorbar.png', '-dpng');
close(i1);

% muestro mapa 3d
figure;
surf(mvAccFrames);
