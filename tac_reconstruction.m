function w_estimate = tac_reconstruction(Output, Dic, lambda,MAXITER)
%%

% The algorithm solves the inverse problem 
%   $y = Aw + \xi$
%
% ============= Inputs ===============
% y                                    : output, in the paper $y(t) =
%                                           (x(t+\delta)-x(t))/\delta$;
% A                                    : dictionary matrix;
% lambda                         : the tradeoff parameter you should use, 
%                                          basically, it is proportional to
%                                          the invese of the variance, e.g. 1;
% MAXITER                    : maximum number of the iterations, e.g. 5


%%

delta = 1e-6;

[M,N]=size(Dic);
% initialisation of the variables
U=ones(N, MAXITER);
Gamma=zeros(N, MAXITER);
UU=zeros(N, MAXITER);
w_estimate=zeros(N, MAXITER);
WWW=ones(N, MAXITER);
% fprintf(1, 'Finding a sparse feasible point using l1-norm heuristic ...');

for iter=1:1:MAXITER
    
%     fprintf('This is round %d \n', iter);
    cvx_begin quiet
    cvx_solver sedumi   %sdpt3
    variable W(N)
    minimize    (lambda*norm( U(:,iter).*W, 1 )+ 0.5*sum((Dic* W-Output).^2) )
    %                 subject to
    %                           W.^2-ones(101,1)<=0;
    cvx_end
    
    
    w_estimate(:,iter)=W;
    WWW(:,iter)=W;
    Gamma(:,iter)=U(:,iter).^-1.*W;
    Dic0=lambda*eye(M)+Dic*diag(Gamma(:,iter))*Dic';
    UU(:, iter)=diag(Dic'*(Dic0\Dic));
    U(:,iter+1)=abs(sqrt(UU(:, iter)));
    
    for i=1:N
        if   w_estimate(i,iter).^2/norm(w_estimate(:,iter))^2<delta
            w_estimate(i,iter)=0;
        end
    end
     
end

