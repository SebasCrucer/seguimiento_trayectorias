function frames = processVideoFrames(videoFile, transformFunction)
  pkg load video

  videoObj = VideoReader(videoFile);

  frames = {};

  while hasFrame(videoObj)
      frame = readFrame(videoObj);
      if nargin > 1 && isa(transformFunction, 'function_handle')
          frame = transformFunction(frame);
      end

      frames{end+1} = frame;
  end

  fprintf('Se procesaron %d frames del video.\n', length(frames));
end

