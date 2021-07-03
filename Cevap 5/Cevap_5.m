clc;
clear all;
close all;

imgRGB=imread('odevrenkli.bmp');

img = im2double(imgRGB);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

img_size = size(img);
row = img_size(1);
column = img_size(2);

%% Hesaplama V
for i=1:1:row
    for j=1:1:column
        maxMatrix(i,j) = max(max(R(i,j),G(i,j)),B(i,j));
        minMatrix(i,j) = min(min(R(i,j),G(i,j)),B(i,j));
    end
end
V = maxMatrix;
%% Hesaplama S
for i=1:1:row
    for j=1:1:column
        if V(i,j) == 0
            S(i,j) = 0;
        else
            S(i,j) = (maxMatrix(i,j)- minMatrix(i,j)) / maxMatrix(i,j);
        end
    end
end
%% Hesaplama H
for i=1:1:row
    for j=1:1:column
        if     maxMatrix(i,j) == R(i,j)
            H(i,j) = (1/6)*(0 + ((G(i,j) - B(i,j))  / (maxMatrix(i,j)- minMatrix(i,j))));
        elseif maxMatrix(i,j) == G(i,j)
            H(i,j) = (1/6)*(2 + ((B(i,j) - R(i,j))  / (maxMatrix(i,j)- minMatrix(i,j))));
        elseif maxMatrix(i,j) == B(i,j)
            H(i,j) = (1/6)*(4 + ((R(i,j) - G(i,j))  / (maxMatrix(i,j)- minMatrix(i,j))));
        end
        if H(i,j) < 0
            H(i,j) = H(i,j) + 360; 
        end   
    end
end

HSV = cat(3,H,S,V);

hsvImage=HSV;
hsvImage(:, :, 1) = hsvImage(:, :, 1) + 0.1;

subplot(1,3,1);imshow(imgRGB);title('Resim');
subplot(1,3,2);imshow(HSV);title('HSV Resim');
subplot(1,3,3);imshow(hsv2rgb(hsvImage));title('RGB Yeni Resim');