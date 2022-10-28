function Ssh = weibull_generate_entropy_map(stack)
% stack is the matrix of shape (height, width, num_images)
    GAMMA_EULER = 0.57721566490153286060651209008240243104215933593992;

    stack_size = size(stack);
    
    q = 11; % size of the window
    t = (q-1)/2 + 1; % border handling
    
    M = stack_size(1);
    N = stack_size(2);
    O = stack_size(3);

%     M = 32; % debug
%     N = 32; % debug
    
    Shape = zeros(M,N,O);

    Scale = zeros(M,N,O);
    
    a = zeros(M,N,O);
    
    b = zeros(M,N,O);
    
    c = zeros(M,N,O);

    Ssh = zeros(M,N);
    
    for k=1:O
        for i=t:M-t-1
            for j=t:N-t-1
                W = stack(i-t+1:i+t-1,j-t+1:j+t-1, k);
                phat = wblfit(W(:));
                Shape(i,j,k) = phat(1); 
                Scale(i,j,k) = phat(2);

                a(i,j,k) = (mean(W.^Scale(i,j,k).*log(W).^2, "all") ...
                - (2.*log(Shape(i,j,k)).*mean(W.^Scale(i,j,k).*log(W), "all")) )./...
                Shape(i,j,k).^Scale(i,j,k) + log(Shape(i,j,k)).^2 + 1./Shape(i,j,k).^2;

                b(i,j,k) = -Scale(i,j,k)*mean(W.^Scale(i,j,k)*log(W), "all")/Shape(i,j,k).^(Scale(i,j,k)+1);
                c(i,j,k) = (Scale(i,j,k)/Shape(i,j,k)).^2;
                if mod(i, 10) == 0
                    disp(i/(M-t))
                end
            end
        end
    end
    H = Shape + log(Scale) + log(gamma(Shape)) + (1-Shape).*psi(Shape);
    Hb = mean( H, 3);

    Sigmaent2 = ( (b.*GAMMA_EULER./Scale.^2 - b./Scale -c./Shape).*(GAMMA_EULER./Scale.^2-1./Scale) + ...
        (1./Shape).*(-c.*GAMMA_EULER./Scale.^2 + c./Scale + a./Shape) )./ ...
        (a.*b - c.^2);

    for k=1:O
        Ssh = Ssh + 2*N*(H(:,:,k)-Hb).^2./Sigmaent2(:,:,k);
    end

end



%     
%     for i=t:limx-t-1
%         for j=t:limy-t-1
%             % vectorization
%             W1 = img1(i-t+1:i+t-1,j-t+1:j+t-1); v1 = W1(:);
%             W2 = img2(i-t+1:i+t-1,j-t+1:j+t-1); v2 = W2(:);
%             W3 = img3(i-t+1:i+t-1,j-t+1:j+t-1); v3 = W3(:);
%             W4 = img4(i-t+1:i+t-1,j-t+1:j+t-1); v4 = W4(:);
%     
% 	    % MLE (MLE for Gaussian Entropy just needs the sample variance)
%             phat = wblfit(W1(:));
%             Shape1(i,j) = phat(1); 
%             Scale1(i,j) = phat(2);
%             
%             a1(i,j) = (mean(W1.^Scale1(i,j).*log(W1).^2, "all") ...
%                 - (2.*log(Shape1(i,j)).*mean(W1.^Scale1(i,j).*log(W1), "all")) )./...
%                 Shape1(i,j).^Scale1(i,j) + log(Shape1(i,j)).^2 + 1./Shape1(i,j).^2;
%             b1(i,j) = -Scale1(i,j)*mean(W1.^Scale1(i,j)*log(W1), "all")/Shape1(i,j).^(Scale1(i,j)+1);
%             c1(i,j) = (Scale1(i,j)/Shape1(i,j)).^2;
%     
%             phat = wblfit(W2(:));
%             Shape2(i,j) = phat(1); Scale2(i,j) = phat(2);
%             
%             a2(i,j) = (mean(W2.^Scale2(i,j).*log(W2).^2, "all") ...
%                 - (2.*log(Shape2(i,j)).*mean(W2.^Scale2(i,j).*log(W2), "all")) )./...
%                 Shape2(i,j).^Scale2(i,j) + log(Shape2(i,j)).^2 + 1./Shape2(i,j).^2;
%             b2(i,j) = -Scale2(i,j)*mean(W2.^Scale2(i,j)*log(W2), "all")/Shape2(i,j).^(Scale2(i,j)+1);
%             c2(i,j) = (Scale2(i,j)/Shape2(i,j)).^2;
%             
%             
%             phat = wblfit(W3(:));
%             Shape3(i,j) = phat(1); Scale3(i,j) = phat(2);
%             
%             a3(i,j) = (mean(W3.^Scale3(i,j).*log(W3).^2, "all") ...
%                 - (2.*log(Shape3(i,j)).*mean(W3.^Scale3(i,j).*log(W3), "all")) )./...
%                 Shape3(i,j).^Scale3(i,j) + log(Shape3(i,j)).^2 + 1./Shape3(i,j).^2;
%             b3(i,j) = -Scale3(i,j)*mean(W3.^Scale3(i,j)*log(W3), "all")/Shape3(i,j).^(Scale3(i,j)+1);
%             c3(i,j) = (Scale3(i,j)/Shape3(i,j)).^2;
%             
%     
%             phat = wblfit(W4(:));
%             Shape4(i,j) = phat(1); Scale4(i,j) = phat(2);
%     
%             a4(i,j) = (mean(W4.^Scale4(i,j).*log(W4).^2, "all") ...
%                 - (2.*log(Shape4(i,j)).*mean(W4.^Scale4(i,j).*log(W4), "all")) )./...
%                 Shape4(i,j).^Scale4(i,j) + log(Shape4(i,j)).^2 + 1./Shape4(i,j).^2;
%             b4(i,j) = -Scale4(i,j)*mean(W4.^Scale4(i,j)*log(W4), "all")/Shape4(i,j).^(Scale4(i,j)+1);
%             c4(i,j) = (Scale4(i,j)/Shape4(i,j)).^2;
%         end
%     end
%     
%     % Shannon differential entropy: -int[f(x)*log(fx) dx]
%     % for the Gaussian reduces to 1/2*log(2*pig*sigma) + 1/2
%     H1 = Shape1 + log(Scale1) + log(gamma(Shape1)) + (1-Shape1).*psi(Shape1);
%     H2 = Shape2 + log(Scale2) + log(gamma(Shape2)) + (1-Shape2).*psi(Shape2);
%     H3 = Shape3 + log(Scale3) + log(gamma(Shape3)) + (1-Shape3).*psi(Shape3);
%     H4 = Shape4 + log(Scale4) + log(gamma(Shape4)) + (1-Shape4).*psi(Shape4);
%     
%     Nw = q^2; % number of samples in the window
%     
%     % Mean Entropy (b stands for entropy bar, i.e., mean entropy)
%     Hb = mean( cat(3, H1, H2, H3, H4), 3);
%     % Ssh and Srb should be Chi-square with 3 degrees of freedom (degrees
%     % of freedom = number of images - 1) granted the images are statistically
%     % equal
%     
%     % lambda=shape 
%     % k=scale
%     
%     GAMMA_EULER = 0.57721566490153286060651209008240243104215933593992;
%     
%     Sigmaent21 = ( (b1.*GAMMA_EULER./Scale1.^2 - b1./Scale1 -c1./Shape1).*(GAMMA_EULER./Scale1.^2-1./Scale1) + ...
%         (1./Shape1).*(-c1.*GAMMA_EULER./Scale1.^2 + c1./Scale1 + a1./Shape1) )./ ...
%         (a1.*b1 - c1.^2);
%     
%     Sigmaent22 = ( (b2*GAMMA_EULER./Scale2.^2 - b2./Scale2 -c2./Shape2).*(GAMMA_EULER./Scale2.^2-1./Scale2) + ...
%         (1./Shape2).*(-c2*GAMMA_EULER./Scale2.^2 + c2./Scale2 + a2./Shape2) )./ ...
%         (a2.*b2 - c2.^2);
%     
%     Sigmaent23 = ( (b3*GAMMA_EULER./Scale3.^2 - b3./Scale3 -c3./Shape3).*(GAMMA_EULER./Scale3.^2-1./Scale3) + ...
%         (1./Shape3).*(-c3*GAMMA_EULER./Scale3.^2 + c3./Scale3 + a3./Shape3) )./ ...
%         (a3.*b3 - c3.^2);
%     
%     Sigmaent24 = ( (b4*GAMMA_EULER./Scale4.^2 - b4./Scale4 -c4./Shape4).*(GAMMA_EULER./Scale4.^2-1./Scale4) + ...
%         (1./Shape4).*(-c4*GAMMA_EULER./Scale4.^2 + c4./Scale4 + a4./Shape4) )./ ...
%         (a4.*b4 - c4.^2);
%     
%     % Statistic = 2*N * sum(Hsi-Sbar)
%     Ssh = 2*N*((H1-Hb).^2./Sigmaent21+...
%                (H2-Hb).^2./Sigmaent22 +...
%                (H3-Hb).^2./Sigmaent23+...
%                (H4-Hb).^2./Sigmaent24);
%     
%     
%     save('GaussHyp_4Stack.mat',...
%          'Sigma21', 'Sigma22', 'Sigma23', 'Sigma24',...
%          'H1', 'H2', 'H3', 'H4','Hb','Ssh');
%     
% 
% 
