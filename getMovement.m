function [mvAccFrames, mvFrames, frames] = getMovement(videoFile, gap, showAcc = false)
    frames = processVideoFrames(videoFile, @rgb2gray);

    [rows, cols] = size(frames{1});
    mvAccFrames = zeros(rows, cols);
    mvFrames = {};
    for f = 1 + gap:length(frames)
      mvFrames = abs(frames{f} - frames{f - gap});
      newFrames{f - gap} = mvFrames;
      mvAccFrames+=mvFrames;
    endfor

    createVideoWithFFmpeg(newFrames, 'outputs/output.mp4', 30)
    imwrite(mat2gray(mvAccFrames), 'outputs/accumulated_image.png');
    if(showAcc)
      imshow(mvAccFrames)
    endif

endfunction

