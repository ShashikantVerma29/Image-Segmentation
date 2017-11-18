%% SHASHIKANT VERMA

I= imread('cameraman.tif');
I= imresize(I,0.3);
[row, col, dim]= size(I);
N=row*col;

%% PARAMETER ASSIGNMENT
r = 2;
sigma_I =4;
sigma_X =6;

%% MAPPING ALL PIXEL'S SPATIAL INFORMATION IN (:,2)MATRIX FORM
[pixel_def]= DefinePixel(row,col);

%% MAPPING ALL PIXEL'S INTENSITY INFORMATION IN (:,dim) MATRIX FORM
[feature_def]= Define_Feature(I,row,col,dim);

%% WEIGHT MATRIX LOOP

window_size=5;
window_mat= zeros(window_size);
w= floor(window_size/2);
W = sparse(N,N);

for j1=1:col
    for i1=1:row
        % RANGE FOR PIXELS INSIDE THE PATCH/WINDOW 
        m = i1-w:i1+w;
        n= j1-w:j1+w;
        
        %PIXEL IN THE WINDOW MAPPED TO pixel_def VALUES
        [window_mat]= WindowMatrix(m,n,row,col);
        [r, c]= size(window_mat);
        
        %CONVERTING window_mat IN VECTOR FORM WHICH DENOTES VERTICES IN THE PATCH
        vertex= reshape(window_mat,r*c,1);
        
        % PRESENT PIXEL LOCATION AS PER LOOP ITERATION
        p_pix=i1 +(j1-1)*row;
        
 %-----------------------------SPATIAL DIFFERENCE----------------------------------------------------------       
        % LOOP FOR CALCULATING PIXEL INFORMATION FROM THE VERTICES OF THE PATCH
          Xj = zeros(length(vertex),1); 
           for i = 1:length(vertex)
              for j=1:2
                 Xj(i,j) = pixel_def(vertex(i),j);
              end
           end
           
          % FOR NO OF ELEMENTS IN Xj, SAME LENGTH VECTOR Xi IS CREATED WHICH REPRESENT CURRENT PIXEL VALUES ONLY 
          Xi=pixel_def(p_pix,:);
          Xi=repmat(Xi,length(vertex),1);  
          
          % DIFFERENCE OF PRESENT PIXEL LOCATION TO ALL LOCATION IN PATCH
          % SPATIAL DIFFERENCE
          diff_x= Xi-Xj;
          diff_x= sum(diff_x.*diff_x,2);
          valid_index= (sqrt(diff_x) <= window_size);
          
          % KEEPING ELEMENTS WITH MORE PROXIMITY AND REJECTING FARTHER LOCATION
          vertex=vertex(valid_index);
          diff_x=diff_x(valid_index);
          
%----------------------------------FEATURE DIFFERENCE--------------------------------------------------------------------
         
          % FOR LOCATION OF VERTICES Fj CONTAINS THEIR INTENSITY VALUES
          Fj=zeros(length(vertex),1);
          for i=1:length(vertex)
              for j=1:dim
                 Fj(i,j)= feature_def(vertex(i),j);
              end
          end
          Fj=uint8(Fj);
          
          % FOR CURRENT PIXEL LOCATION Fi CONTAINS PRESENT INTENSITY VALUE
          Fi= feature_def(p_pix,:);
          Fi=repmat(Fi,length(vertex),1);
          Fi=uint8(Fi);
          
          % FEATURE DIFFERENCE
          diff_f= Fi-Fj;
          diff_f=sum(diff_f.*diff_f,2);
          
          % WEIGHT MATRIX W
          W(p_pix,vertex)=exp(-diff_f / (sigma_I*sigma_I)) .* exp(-diff_x / (sigma_X*sigma_X));
    end
end
%% --------------------------------------PARTITION---------------------------------------------------------

k=input('no of partitions=\n');
%PARTITION AND DISPLAY SEGMENTS
k_part(W, k,dim,feature_def,row,col);

