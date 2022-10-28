% Reviewed

function Ssh = gamma_generate_entropy_map(stack)
% stack is the matrix of shape (height, width, num_images)
    stack_size = size(stack);
    
    if nargin <2
        % window size is an input variable
        q = 11; % size of the window
    end

    t = (q-1)/2 + 1; % border handling
    
    % m and n lowercase
    m = stack_size(1);
    n = stack_size(2);
    o = stack_size(3);

%     m = 32;
%     n = 32;

    
    Shape = zeros(m,n,o);
    Scale = zeros(m,n,o);
    beta = zeros(m,n,o);

    Ssh = zeros(m,n);
    
    for k=1:o
        disp(k)
        for i=t:m-t-1
            for j=t:n-t-1
                W = stack(i-t+1:i+t-1,j-t+1:j+t-1, k);
                phat = gamfit(W(:));
                Shape(i,j,k) = phat(1); 
                Scale(i,j,k) = phat(2);
                beta(i,j,k) = 1 + (1-Shape(i,j,k))*psi(1, Shape(i,j,k)); 
                % psi(1, x) is the Trigamma function, i.e., the second
                % derivative of the Gamma function (here x is dummy
                % variable)
            end
        end
    end
    H = Shape + log(Scale) + log(gamma(Shape)) + (1-Shape).*psi(0, Shape);
    % where psi(0, x) is the Digamma function
    Hb = mean(H, 3);
    Sigmaent = (Shape.*beta.^2 - 2*beta + psi(1,Shape))./ ...
        (Shape.*psi(1,Shape) - 1);

    for k=1:o
        % the multiplicative factor 2 in front of N does not exist
        % wrong!
        Ssh = Ssh + n*(H(:,:,k)-Hb).^2./Sigmaent(:,:,k);
    end

end
