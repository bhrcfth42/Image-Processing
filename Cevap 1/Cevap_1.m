clc;
clear all;
close all;
odev1=imread('odev1.bmp');
odev1hedef=imread('odev1hedef.bmp');
M=zeros(256,1,'uint8');
histogramodev1=imhist(odev1);
histogramodev1hedef=imhist(odev1hedef);
cdf1= cumsum(histogramodev1)/numel(odev1);
cdf2= cumsum(histogramodev1hedef)/numel(odev1hedef);

for i=1:256
    diff=abs(cdf1(i)-cdf2);
    [~,ind]=min(diff);
    M(i)=ind-1;
end

histogram_esleme=M(double(odev1)+1);

subplot(2,3,1),imshow(odev1);
title('odev1 image');
subplot(2,3,2),imshow(odev1hedef);
title('odev1hedef image');
subplot(2,3,3),imshow(histogram_esleme);
title('Histogram Eşleme');
subplot(2,3,4),imhist(odev1);
title('odev1 Histogram');
subplot(2,3,5),imhist(odev1hedef);
title('odev1hedef Histogram');
subplot(2,3,6),imhist(histogram_esleme);
title('Histogram Eşleme');