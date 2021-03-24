#mediana

pkg load image;
imagem = imread('lena.jpg');

img = double(imagem);
tammasc = 3;
w = ones(tammasc,tammasc);

p = padarray(img, [2 2]);
[a,b] = size(p);
a = a - 2;
b = b - 2; 
g = zeros(a,b);

for i = 1:a
  for j = 1:b
    for x = 1:tammasc
      for y = 1:tammasc
        g(i,j) = g(i,j) + (w(x,y) * p(i+(x-1),j+(y-1)));
      endfor;  
    endfor;
    g(i,j) = g(i,j)/9;
   endfor;
endfor;

g = uint8(g);
subplot(1,2,1);imshow(imagem); title("Imagem original");
subplot(1,2,2);imshow(g); title("Convolução");