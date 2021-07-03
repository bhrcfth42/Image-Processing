clc;
clear all;
close all;

image = imread('odev2.bmp');
[M, N] = size(image);
FourierDonusumlu_image = fft2(double(image));

%Butterworth Alçak Geçirgen Filtre
butterworth_n = 2;
butterworth_D0 = 20;
butterworth_u = 0:(M-1);
butterworth_v = 0:(N-1);
butterworth_x = find(butterworth_u > M/2);
butterworth_u(butterworth_x) = butterworth_u(butterworth_x) - M;
butterworth_y = find(butterworth_v > N/2);
butterworth_v(butterworth_y) = butterworth_v(butterworth_y) - N;
[butterworth_V, butterworth_U] = meshgrid(butterworth_v, butterworth_u);
butterworth_D = sqrt(butterworth_U.^2 + butterworth_V.^2);
butterworth_H = 1./(1 + (butterworth_D./butterworth_D0).^(2*butterworth_n));
butterworth_FourierDonusumlu_image = butterworth_H.*FourierDonusumlu_image;  
butterworth_image = real(ifft2(double(butterworth_FourierDonusumlu_image)));

%İdeal Alçak Geçirgen Filtre%
ideal_D0 = 20;
ideal_u = 0:(M-1);
ideal_x = find(ideal_u>M/2);
ideal_u(ideal_x) = ideal_u(ideal_x)-M;
ideal_v = 0:(N-1);
ideal_y = find(ideal_v>N/2);
ideal_v(ideal_y) = ideal_v(ideal_y)-N;
[ideal_V, ideal_U] = meshgrid(ideal_v, ideal_u);
ideal_D = sqrt(ideal_U.^2+ideal_V.^2);
ideal_H = double(ideal_D <= ideal_D0);
ideal_FourierDonusumlu_image = ideal_H.*FourierDonusumlu_image;
ideal_image = real(ifft2(double(ideal_FourierDonusumlu_image)));

subplot(1, 3, 1); imshow(image); title('Orjinal Resim'); 
subplot(1, 3, 2), imshow(uint8(butterworth_image)); title('Butterworth Filtre Resim');
subplot(1, 3, 3), imshow(uint8(ideal_image)); title('İdeal Filtre Resim');