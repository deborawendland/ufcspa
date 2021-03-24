

pkg load image;
m = [0 0 0 0; 0, 255, 255, 0;  0, 255, 255, 0; 0 0 0 0];
n = [255 255; 255 255];
p = padarray(m, [1 1]);
[a,b] = size(p);
#a = a - 1;
#b = b - 1; 
g = zeros(a,b);
tammasc = 2;

for i = 2:a-1
  for j = 2:b-1
    flag = 0;
    for x = 1:tammasc
      for y = 1:tammasc
        if (p(i+(x-1),j+(y-1)) != n(x,y))
          flag = 1;
        endif; 
      endfor;  
    endfor;
    if (flag == 0)
      g(i,j) = 255;
    endif;
   endfor;
endfor;

g = g(2:a-1, 2:b-1);

g