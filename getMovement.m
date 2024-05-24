function [mvAccFrames, mvFrames, frames] = getMovement(videoFile, gap, sigma, ROI = @(mask) mask)
    frames = processVideoFrames(videoFile, @(f) transformFrame(f, sigma, ROI));
    matFrames = cat(3, frames{:});

    [rows, cols, numFrames] = size(matFrames);
    mvAccFrames = zeros(rows, cols);
    mvFrames = cell(1, numFrames - gap);

    for f = 1 + gap:numFrames
        actualFrame = matFrames(:, :, f);

        histFrames = matFrames(:, :, 1:f);

        background = median(histFrames, 3);

        difFrame = abs(background - actualFrame);

        otsuThresh = otsuthresh(difFrame(:));

        mvFrame = difFrame >= otsuThresh * max(difFrame(:));

        mvFrames{f - gap} = mvFrame;
        mvAccFrames += mvFrame;
    end
end
