% Replication of :
%  The risk-free rate in heterogeneous-agent incomplete-insurance economies
%  Hugget(1993)
% Juan Pablo Baquero 
% Juan Guillermo Salazar
% Amalia Rodriguez 




%  opt = optimset ( 'TolX',1e-20,'TolFun',1e-4,'Display','iter')
 opt = optimset ( 'TolX',1e-20,'TolFun',1e-4);
disp('evaluating limit 2')
[X_12,FVAL,EXITFLAG,OUTPUT]= fminbnd(@(q) hugget(q,2,1.5),-0.02,0,opt);
[X_22,FVAL,EXITFLAG,OUTPUT]= fminbnd(@(q) hugget(q,2,3),-0.05,-0.03,opt);
disp('evaluating limit 4')
[X_14,FVAL,EXITFLAG,OUTPUT]= fminbnd(@(q) hugget(q,4,1.5),0,0.03,opt);
[X_24,FVAL,EXITFLAG,OUTPUT]= fminbnd(@(q) hugget(q,4,3),-0.01,0,opt);
disp('evaluating limit 6')
[X_16,FVAL,EXITFLAG,OUTPUT]= fminbnd(@(q) hugget(q,6,1.5),0,0.02,opt);
[X_26,FVAL,EXITFLAG,OUTPUT]= fminbnd(@(q) hugget(q,6,3),0,0.01,opt);
disp('evaluating limit 8')
[X_18,FVAL,EXITFLAG,OUTPUT]= fminbnd(@(q) hugget(q,8,1.5),0,0.02,opt);
[X_28,FVAL,EXITFLAG,OUTPUT]= fminbnd(@(q) hugget(q,8,3),0,0.02,opt);



 fprintf([' \n                           Table 1  \n'])     ;
  fprintf('\n       Coefficient of relative risk aversion %s=1.5 \n' ,texlabel('sigma') );
  fprintf('\n         Credit limit      Interest rate         Price      \n');
    fprintf('\n         (a)                   (r)                  (q)      \n');
  fprintf('         -2                  %.2f                %.4f                \n',   X_12*6*100, 1/(1+X_12));
    fprintf('         -4                   %.2f                %.4f                \n',   X_14*6*100, 1/(1+X_14));
        fprintf('         -6                   %.2f                %.4f                \n',   X_16*6*100, 1/(1+X_16));
            fprintf('         -8                   %.2f                %.4f                \n',   X_18*6*100, 1/(1+X_18));
            
             fprintf([' \n                           Table 2  \n'])     ;
  fprintf('\n       Coefficient of relative risk aversion %s=3 \n' ,texlabel('sigma') );
  fprintf('\n         Credit limit      Interest rate         Price      \n');
    fprintf('\n         (a)                   (r)                  (q)      \n');
  fprintf('         -2                 %.2f                %.4f                \n',   X_22*6*100, 1/(1+X_22));
    fprintf('         -4                  %.2f                %.4f                \n',   X_24*6*100, 1/(1+X_24));
        fprintf('         -6                   %.2f                %.4f                \n',   X_26*6*100, 1/(1+X_26));
            fprintf('         -8                   %.2f                %.4f                \n',   X_28*6*100, 1/(1+X_28));


  
            
  huggetplot(X_12,2,1.5);   % Function that plots the stationary distribution and the policy function. 


