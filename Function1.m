[m n l]=size(image(:,:,1));
ref=imresize(ref,[m n]);
ref=im2double(ref);
image=im2double(image);
image=imadjust(image ,stretchlim(image ),[]);
ref=imadjust(ref ,stretchlim(ref ),[]);
usfac = 100;
[a, g] = dftregistration(fft2(ref),fft2(image(:,:,1)),usfac);
output=abs(ifft2(g));


