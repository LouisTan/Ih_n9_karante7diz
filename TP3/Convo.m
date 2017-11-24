function [G] = Convo(img)
    img = double(img);
    for n=1:3
        for i=1:size(img,1)-2
            for j=1:size(img,2)-2
                Gx=((2*img(i+2,j+1,n)+img(i+2,j,n)+img(i+2,j+2,n))-(2*img(i,j+1,n)+img(i,j,n)+img(i,j+2,n)));
                Gy=((2*img(i+1,j+2,n)+img(i,j+2,n)+img(i+2,j+2,n))-(2*img(i+1,j,n)+img(i,j,n)+img(i+2,j,n)));
                %Calcul du gradient
                G(i,j,n)=abs(Gx)+abs(Gy);
                G(i,j,n)=sqrt(Gx.^2+Gy.^2);
            end
        end
    end
    %Mise à l'échelle
    A = G(:,:,1);
    B = G(:,:,2);
    C = G(:,:,3);

    A = (A-min(A(:))) ./ (max(A(:)-min(A(:))));
    B = (B-min(B(:))) ./ (max(B(:)-min(B(:))));
    C = (C-min(C(:))) ./ (max(C(:)-min(C(:))));

    G = cat(3,A,B,C);           
end