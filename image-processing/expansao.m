#Expansão

pkg load image;
pkg load signal;
imagem = imread('prova.tif');

img = double(imagem);

rmax = max(max(img));
rmin = min(min(img));
l = rmax - rmin + 1;
[a,b] = size(img);
expandida = zeros(a, b);
expandida = expandida + 255;

for i = 1:rows(img)
  for j = 1:columns(img)
    pixel = img(i,j);
    expandida(i,j) = round(((pixel-rmin)/(rmax-rmin))*(l-1));
  endfor;
endfor;

expandida = uint8(expandida);

figure;
imshow(expandida);

figure;
subplot(2,2,1);imshow(imagem); title("Imagem original");
subplot(2,2,2);imshow(expandida); title("Expandida");
subplot(2,2,3);hist(imagem); title("Histograma original");
subplot(2,2,4);hist(expandida); title("Expandida");