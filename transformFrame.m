function tFrame = transformFrame(frame, sigma, ROI)
  pkg load image
  tFrame = rgb2gray(frame);
  [rows, cols] = size(tFrame);
  ones = ones(rows, cols);
   if nargin > 3 && isa(ROI, 'function_handle')
    mask = ROI(ones);
    tFrame = tFrame.* mask;
   end
  tFrame = imsmooth(tFrame,'Gaussian', sigma);
endfunction
