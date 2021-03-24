
pkg load image;
imagem = imread('Fig0911(a)(noisy_fingerprint).tif');

img = double(imagem);
tammasc = 3;
masc1 = ones(tammasc, tammasc);
w = imrotate(masc1, 180);
p = padarray(img, [2 2]);
[a,b] = size(p);
a = a - 2;
b = b - 2; 
g = zeros(a,b);
med = [1 1 1 1 1 1 1 1 1];

for i = 1:a
  for j = 1:b
    z = 1;
    med = [1 1 1 1 1 1 1 1 1];
    for x = 1:tammasc
      for y = 1:tammasc
        med(z) = (w(x,y) * p(i+(x-1),j+(y-1)))
        #g(i,j) = g(i,j) + (w(x,y) * p(i+(x-1),j+(y-1)));
        z = z + 1;
      endfor;  
    endfor;
    for c = 1:9
      for d = 1:9-c
        if med(d) > med(d+1)
          temp = med(d);
          med(d) = med(d+1);
          med(d+1) = temp;
        endif;
      endfor;  
    endfor;
    g(i,j) = med(5);  
   endfor;
endfor;

g = g(3:a-2, 3:b-2);
g = uint8(g);


subplot(1,2,1);imshow(imagem); title("Imagem original");
subplot(1,2,2);imshow(g); title("Mediana");
