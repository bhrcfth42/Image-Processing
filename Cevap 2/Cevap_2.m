clc;
clear all;
close all;
x=imread('odev2.bmp');

avg =[1 1 1;1 1 1;1 1 1]/9;
B = padarray(x,[1 1]);
B=double(B);
ortalama_img = zeros(size(x));

for i = 1:size(B,1)-2
    for j = 1:size(B,2)-2
        Temp = B(i:i+2,j:j+2).*avg;
        ortalama_img(i,j) = sum(Temp(:));
    end
end
 
[m n]=size(ortalama_img);
keskinlestirme_img =zeros(m,n);
for i=2:m-1
    for j=2:n-1
        keskinlestirme_img(i,j) = (5*ortalama_img(i,j))-(ortalama_img(i-1,j)+ortalama_img(i+1,j)+ortalama_img(i,j-1)+ortalama_img(i,j+1));
    end
end

subplot(1,3,1);imshow(x);title('Orjinal Resim')
subplot(1,3,2);imshow(uint8((ortalama_img)));title('Ortalama Filtre Resim')
subplot(1,3,3);imshow(uint8((keskinlestirme_img)));title('Keskinleştirme Resim')