function [feature_def]= Define_Feature(I,row,col,dim)

    % RESHAPING FEATURES OF EVERY PIXEL IN ONE ROW EACH. GRAY- Nx1 DIMENSION, RGB Nx3 DIMENSION
    for i=1:dim
        feature_def(:,i)=reshape(I(:,:,i), [row*col,1]);
    end
end