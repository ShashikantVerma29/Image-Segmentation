function [pixel_def]= DefinePixel(row,col)
    
    % FORMING REPEATED MATRIX FROM INDICES 1:row
    X1=(1:row)';
    X1= repmat(X1,[col,1]);
    
    % FORMING EACH ONE OF 1:row VALUES FOR EVERY SET OF X1
    k=1;
    for i=1:col
        for j=1:row
            Y1(k,1)=i;
            k=k+1;
        end
    end
    
    % RETURNING MAPPED PIXEL IN MATRIX OF DIMENSION (N,2)
    pixel_def= [X1, Y1];
end