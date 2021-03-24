#correlacao por que a matriz não está rotacionada
pkg load image;
pkg load signal;
imagem = imread('lena.jpg');

img = double(imagem);
%f = zeros(5,5);
%f(3,3) = 1;
%w = [1,2,3;4,5,6;7,8,9]; 
w = ones(3,3); #media - passabaixa
%expansão = padarray
#passaalta = [1 1 1; 1 -8 1; 1 1 1];

p = padarray(img, [2 2]);
[a,b] = size(p);
a = a - 2;
b = b - 2; 
g = zeros(a,b);
%disp(f);
%disp (w);
%disp (p);

for i = 1:a
  for j = 1:b
    for x = 1:3
      for y = 1:3
        g(i,j) = g(i,j) + (w(x,y) * p(i+(x-1),j+(y-1)));
      endfor;  
    endfor;
    g(i,j) = g(i,j)/9;
   endfor;
endfor;



%for i = 1:7
%  for j = 1:7
%    g(i,j) = w(1,1)*p(i,j)+ w(1,2)*p(i,j+1)+ w(1,3)*p(i,j+2)+ w(2,1)*p(i+1,j)+ w(2,2)*p(i+1,j+1)+ w(2,3)*p(i+1,j+2)+ w(3,1)*p(i+2,j)+ w(3,2)*p(i+2,j+1)+ w(3,3)*p(i+2,j+2);
%   endfor;
%endfor; 
g = g(3:a-2, 3:b-2);

g = uint8(g);
subplot(1,2,1);imshow(imagem); title("Imagem original");
subplot(1,2,2);imshow(g); title("Convolução");
%imshow(g);
%a = xcorr2(f,w);
%disp(a);