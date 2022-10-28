% Reviewed

function Ssh = gaussian_generate_entropy_map(stack, q)
    stack_size = size(stack);

    if nargin < 2
        q = 11; % size of the window
    end
    t = (q-1)/2 + 1; % border handling
    
    m = stack_size(1);
    n = stack_size(2);
    o = stack_size(3);

    m = 32; % debug
    n = 32; % debug 
    
    Sigma2 = zeros(m,n,o);

    Ssh = zeros(m,n);
    
    for k=1:o
        for i=t:m-t-1
            for j=t:n-t-1
                W = stack(i-t+1:i+t-1,j-t+1:j+t-1, k);
                Sigma2(i, j, k) = var(W(:));
            end
        end
    end
    % Gaussian entropy for each image
    H = 0.5*log(2*pi*Sigma2) + 0.5;
    Hb = mean(H, 3);

    % Equation (9) of the paper or line 8 of Algorithm 1
    % multiplication by 2, as in 2*N, is incorrect. The factor 2 does
    % not exists. It should only be N*(H(:,:,k)-Hb).^2./0.5;
    for k=1:o
        Ssh = Ssh + n*(H(:,:,k)-Hb).^2./0.5;
    end

end