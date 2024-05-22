function createVideoWithFFmpeg(frames, outputFileName, frameRate)
  tempDir = 'temp_frames';

  saveFramesAsImages(frames, tempDir);

  ffmpegCmd = sprintf('ffmpeg -y -loglevel error -r %d -i %s/frame_%%04d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p %s', ...
                      frameRate, tempDir, outputFileName);

  system(ffmpegCmd);

  delete([tempDir, '/*']);
  rmdir(tempDir);

  fprintf('Video creado usando FFmpeg: %s\n', outputFileName);
end

