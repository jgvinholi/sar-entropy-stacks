function Ssh = log_normal_generate_entropy_map(stack, q)
% stack is the matrix of shape (height, width, num_images)
    stack_size = size(stack);
    
    if nargin <2
        % window size is an input variable
        q = 11; % size of the window
    end

    t = (q-1)/2 + 1; % border handling
    
    % M and N not capitalized
    m = stack_size(1);
    n = stack_size(2);
    o = stack_size(3);

    m = 32; % debug
    n = 32; % debug 
    
    Mean = zeros(m, n, o);
    Sigma2 = zeros(m,n,o);

    Ssh = zeros(m,n);
    
    for k=1:o
        for i=t:m-t-1
            for j=t:n-t-1
                W = stack(i-t+1:i+t-1,j-t+1:j+t-1, k);

                % I don't agree with the computation of the mean and
                % Sigma^2. I believe it should be like this:
                W = W(:);
                Mean(i, j, k) = sum(log(W))/length(W);
                Sigma2(i, j, k) = sum((log(W) - Mean(i, j, k)).^2)/...
                                  (length(W) - 1);

                % minus 1 on the denominator is necessary to make the 
                % maximum likelihood estimator unbiased
            end
        end
    end
    H = 0.5*log(2*pi*Sigma2) + 0.5 + Mean;
    Hb = mean(H, 3);
    Sigmaent = Sigma2 + 0.5;

    % O is not a good variable name
    for k=1:o
        % Factor 2 is not present
        % Wrong!
        Ssh = Ssh + n*(H(:,:,k)-Hb).^2./Sigmaent;

        % Ssh = Ssh + N*(H(:,:,k)-Hb).^2./Sigmaent;
    end

end