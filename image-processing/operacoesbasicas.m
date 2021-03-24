#Operações básicas:

pkg load image;
pkg load signal;
imagem = imread('lena.jpg');

figure;
imshow(imagem);

#Contraste
limiar = 180;
a = double(imagem)/limiar;
b = a.^2;
y = uint8(b*limiar);

figure;
imshow(y);

#Negativo
x = uint8(-1*(double(imagem)-255));

figure;
imshow(x);

#Aumentar/Reduzir brilho
w = imagem + 50;

figure;
imshow(w);

v = imagem - 100;

figure;
imshow(v);

#Binarização
limiar = 120;
u = double(imagem);
t = u >= limiar;
s = double(t);

figure;
imshow(s);