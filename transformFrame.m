function tFrame = transformFrame(frame, sigma, ROI)
  pkg load image
  tFrame = rgb2gray(frame);
  [rows, cols] = size(tFrame);
  ones = ones(rows, cols);
  mask = ROI(ones);
  tFrame = tFrame.* mask;
  tFrame = imsmooth(tFrame,'Gaussian', sigma);
endfunction
