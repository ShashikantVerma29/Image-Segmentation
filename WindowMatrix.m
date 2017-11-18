function [window_mat, patch_size]= WindowMatrix(m,n,row,col)
    
    %REMOVING VALID ROWS i.e. REJECTING NEGATIVE AND OUT OF BOUND ROWS
    v_indm=( m>=1 & m<=row);
    m=m(v_indm);
    
    %REMOVING VALID COLUMNS i.e. REJECTING NEGATIVE AND OUT OF BOUNDS COLUMNS
    v_indn=( n>=1 & n<=col);
    n=n(v_indn);
    
     for i=1:length(n)
        for j=1:length(m)
            
            %% EVERY PIXEL IN PATCH CAN BE DEFINED BY EQUATION (m+(n-1)*rows)
            % m= incrementing row
            % (n-1)*rows= this maps to pixel_def values for each increementing columns within patch  
            window_mat(j,i)= m(j)+(n(i)-1)*row;
            
            %% RETURN THE window_mat WHICH CONTAINS ALL PIXEL SPATIAL INFORMATION WITHIN PATCH
            % which is used to extract feature values at that spatial
            % location using feature_def vector.
        end
    end
end






