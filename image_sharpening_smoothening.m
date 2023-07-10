Imgg = imread("lenna_acc.bmp");
Img=rgb2gray(Imgg);
im1=double(Img);
for i=1:size(Img,1)    
    for j=1:size(Img,2)
           im1(i,j)= vadf(im1(i,j),8,4);
    end
end 
r2 = randi(size(Img,2),size(Img,1),20);

Img1=uint8(im1);

%Code for image sharpening: 
ims=imsharpen(Img1);
display("PSNR and SSIM values for image sharpening")
psnr_val_s=psnr(ims,Img)
ssim_val_s=ssim(ims,Img)
imwrite(Img1,"ImSharp_VADF_1.png");


%Code for image smoothening:
im=imgaussfilt(Img1,4);
display("PSNR and SSIM values for image smoothening")
psnr_val=psnr(im,Img)
ssim_val=ssim(im,Img)
imwrite(Img1,"imgauss_VADF_1.png");


