function tFrame = transformFrame(frame, sigma)
  pkg load image
  tFrame = rgb2gray(frame);
  tFrame = imsmooth(tFrame,'Gaussian', sigma);
endfunction
