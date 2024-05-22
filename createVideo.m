function createVideo(frames, outputFileName, frameRate)
  vw = VideoWriter(outputFileName);
  vw.FrameRate = frameRate;
  open(vw);

  for k = 1:length(frames)
      img = frames{k};

      if ~isa(img, 'uint8')
          img = im2uint8(img);
      end

      writeVideo(vw, img);
  end

  close(vw);

  fprintf('Video creado: %s\n', outputFileName);
end

