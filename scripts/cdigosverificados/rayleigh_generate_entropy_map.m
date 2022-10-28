function Ssh = rayleigh_generate_entropy_map(stack)
% stack is the matrix of shape (height, width, num_images)
    stack_size = size(stack);

    if nargin <2
        % window size is an input variable
        q = 11; % size of the window
    end
    
    % same consideration as of the Gaussian analysis -> window size
    % is a hyperparameter yet to be fully defined; hence, it should be
    % a variable
    t = (q-1)/2 + 1; % border handling
    
    % M and N are not constants, so I wouldn't capitalize them
    m = stack_size(1);
    n = stack_size(2);
    % same as before, O as a variable name looks strange. I suggest p
    o = stack_size(3);

    m = 32; % debug
    n = 32; % debug 

    % Rayleigh has only one parameter, namely Sigma
    % Rayleigh does not have the Shape parameter

    % The gamma in the entropy equation for the Rayleigh is
    % Euler-Mascheroni constant, which is about 0.577. The 
    % precise value of this constant is given by the following
    % integral: -int(exp(-x).*log(x), 0, inf), where x is a 
    % dummy variable

    gamma = -int(exp(-x).*log(x), 0, inf);
    
    Sigma = zeros(m, n, o);

    Ssh = zeros(m,n);
    
    for k=1:o
        for i=t:m-t-1
            for j=t:n-t-1
                W = stack(i-t+1:i+t-1,j-t+1:j+t-1, k);

                W = W(:);
                Sigma(i, j, k) = sqrt(sum(W.^2)/(2*length(W)));

            end
        end
    end

    H = 1 + log(sigma/sqrt(2)) + gamma/2;


    Hb = mean(H, 3);
    Sigmaent = 0.25;

    for k=1:o
        Ssh = Ssh + n*(H(:,:,k)-Hb).^2./Sigmaent;
    end

end
