

function [marketclear]=hugget(int,debtlimit,sigma)  

% Howard Improvement algorithm 
 
%% Parameters and grid  
 

beta=0.9932; 
mina =   -debtlimit;                     % minimum value of the capital grid
maxa =  5;                     % maximum value of the capital grid   
ngrid=800;                   % size of capital grid increments
agrid = linspace(mina,maxa,ngrid)  ;
dimgrid=size(agrid,2);
% sigma=1.5; 
dist=0.03;
 
%% Markov Process
 
% [z, P] = rouwenhorst(5,1.2,0.9,0.1);
% nstates=size(z,1) ; 
% z=z' ; 
e=[0.1 1]  ;
P=[0.5 0.5 ; 0.0750 0.925] ;
nstates=size(e,2) ;
%  [z,P]=tauchen(10,1.2,0.9,0.1,0.2)
%   nstates=size(z,2) ; 
%  

% P=[1,0;0,1]
% z=[1,1] ;
% nstates=size(z,2) ;

 
%% Reward Function
[a_2,a_1]=meshgrid(agrid);





 dist=dist/2 ;
for i=1:nstates ;
    eval(sprintf('consum%d =a_1+e(i)-a_2/(1+int) ;', i))  
    str{i}=sprintf('consum%d',i) ;
end 
 
word=strjoin(str,';');
eval(strcat('consum=[',word,'];'));
 
limp=find(consum<0);
consum(limp)=nan;
R=[((consum).^(1-sigma))./(1-sigma)];
R(find(isnan(R))) = -inf;
 
% initialize some variables 
v=zeros(dimgrid,nstates);
policy=ones(dimgrid,1);
tol=5;
iter=0;
% v=zeros(dimgrid*2,1);
while abs(tol)>0.000007
 
[vt_o,ps1]=max(R+(beta*kron(P,ones(dimgrid,1)))*[v'],[],2);
 
% v_1=vt_o(1:dimgrid);
% v_2=vt_o(dimgrid+1:end);
 
%% step 1 
 
r=R(sub2ind(size(R),(1:nstates*dimgrid)',ps1));
 
% Creating the J matrix 
J=sparse(nstates*dimgrid,dimgrid);
 
for i=1:nstates*dimgrid 
     
J(i,ps1(i))=1;
 
end
 
ini=1;
fin=dimgrid;
 
for i=1:nstates 
 
H{i}=kron(P(i,:),J(ini:fin,:));
ini=fin+1 ;
fin=(i+1)*dimgrid ; 
end
 
vt=(speye(dimgrid*nstates)-beta*vertcat(H{:}))\r ;
 
vt=reshape(vt,dimgrid,nstates);
 
tol=max(max((vt-v)./vt))   ; 
v=vt;

 
end



%This calculates the invariant distributions

N=dimgrid;
m=nstates; 
s = 1:m*N;
s = reshape(s,N,m)';

 Tstar = zeros(N*m,N*m);
    for i = 1:m
        Tstar(s(i,:),:)= kron(P(i,:),sparse(1:N,ps1(s(i,:)),ones(1,N),N,N));
    end
    Tstar = Tstar^1000;
    mu = Tstar(1,:);
    
    marketclear = abs(dot(kron(ones(1,m),agrid),mu));
 















