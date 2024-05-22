function saveFramesAsImages(frames, tempDir)

  if ~exist(tempDir, 'dir')
      mkdir(tempDir);
  end

  for k = 1:length(frames)
      img = frames{k};
      if ~isa(img, 'uint8')
          img = im2uint8(img);
      end
      imwrite(img, fullfile(tempDir, sprintf('frame_%04d.png', k)));
  end
end

