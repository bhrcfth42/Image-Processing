clc;
clear all;
close all;
img=imread('odev3.bmp');
numofpixels=size(img,1)*size(img,2);

histogram_Image=uint8(zeros(size(img,1),size(img,2)));
freq=zeros(256,1);
probf=zeros(256,1);
probc=zeros(256,1);
cum=zeros(256,1);
output=zeros(256,1);

for i=1:size(img,1)
    for j=1:size(img,2)
        value=img(i,j);
        freq(value+1)=freq(value+1)+1;
        probf(value+1)=freq(value+1)/numofpixels;
    end
end

sum=0;
no_bins=255;

for i=1:size(probf)
   sum=sum+freq(i);
   cum(i)=sum;
   probc(i)=cum(i)/numofpixels;
   output(i)=round(probc(i)*no_bins);
end

for i=1:size(img,1)
    for j=1:size(img,2)
        histogram_Image(i,j)=output(img(i,j)+1);
    end
end

subplot(2,2,1);imshow(img);title('Orjinal Image');
subplot(2,2,2);imshow(histogram_Image);title('Konstrast Artırılmış Image');
subplot(2,2,3);imhist(img);title('Orjinal Histogram');
subplot(2,2,4);imhist(histogram_Image);title('Konstrast Artırılmış Histogram');