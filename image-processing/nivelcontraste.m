imagem = imread('prova.tif');
img = double(imagem);
rmaximo = max(max(img));
rminimo = min(min(img));
nivel = rmaximo - rminimo;
disp(rmaximo);
disp(rminimo);
disp(nivel);

pkg load image; 
figure;
imhist(imagem);

imagem = imread('prova.tif');
img = double(imagem);
frequencia = zeros(256);

for i = 1:rows(img)
  for j = 1:columns(img)
    pixel = img(i,j);
    frequencia(pixel+1) = frequencia(pixel+1) + 1;
  endfor;
endfor;

plot(frequencia);