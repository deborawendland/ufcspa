
pkg load image;
imagem = imread('Fig0911(a)(noisy_fingerprint).tif');

img = double(imagem);
tammasc = 2;
masc1 = ones(tammasc, tammasc);
p = padarray(img, [tammasc-1 tammasc-1]);
[a,b] = size(p);
a = a - tammasc-1;
b = b - tammasc-1; 
g = zeros(a,b);

for i = 1:a
  for j = 1:b
    flag = 0;
    for x = 1:tammasc
      for y = 1:tammasc
        if (p(i+(x-1),j+(y-1)) != masc1(x,y))
          flag = 1;
        endif; 
      endfor;  
    endfor;
    if (flag == 0)
      g(i,j) = 1;
    endif;;  
   endfor;
endfor;

g = g(3:a-2, 3:b-2);
g = logical(g);


subplot(1,2,1);imshow(imagem); title("Imagem original");
subplot(1,2,2);imshow(g); title("Erosão");
