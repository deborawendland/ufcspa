#Equalização

pkg load image;
pkg load signal;
imagem = imread('prova.tif');

img = double(imagem);

figure;
imshow(imagem);

rmax = max(max(img));
rmin = min(min(img));
l = rmax - rmin + 1;
[a,b] = size(img);
equalizada = zeros(a, b);
frequencia = zeros(256);

for i = 1:rows(img)
  for j = 1:columns(img)
    pixel = img(i,j);
    frequencia(pixel+1) = frequencia(pixel+1) + 1;
  endfor;
endfor;

for i = 1:rows(img)
  for j = 1:columns(img)
    pixel = img(i,j);
    equalizada(i,j) = round(((l-1)/(a*b))*sum([frequencia(1:(pixel+1))]));
  endfor;
endfor;

equalizada = uint8(equalizada);

figure;
imshow(equalizada);

figure;
subplot(1,2,1);imshow(imagem); title("Imagem original");
subplot(1,2,2);imshow(equalizada); title("Equalizada");

figure;
