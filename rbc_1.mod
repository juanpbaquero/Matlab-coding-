// RBC model 

var h w c r k y z g ;
varexo e_g e_z; 


parameters psi beta s_k r_ss s_h e_h_k k_y c_y delta g_y rho_g rho_z  ;

beta=0.99    ;
delta=0.025  ;
r_ss= 1/beta - (1-delta);
psi=0.25                ;
s_h= 0.67               ;
s_k= 1- s_h             ;
e_h_k= 1                ;
c_y= 0.65               ;
g_y= 0.20                  ;
k_y=(1/delta- (c_y/delta)) ;
rho_z=0.99              ;
rho_g=0.90              ;


model(linear) ;
               
psi*h= w-c    ; 

c(+1) = r_ss*beta*r(+1) + c ;

s_k/e_h_k*(k(-1) -h -z )=w     ;

s_h/e_h_k*(h+z-k(-1))=r                          ;

y= k_y*k - k_y*(1-delta)*k(-1)+c_y*c+g_y*g       ;

y= s_k*k(-1) + s_h*(h+z)                         ;

z=rho_z*z(-1)  + e_z   ;

g=rho_g*g(-1)  + e_g   ;


end;

initval;

h=0; 
w=0; 
c=0; 
r=0; 
k=0; 
y=0; 
z=0; 
g=0;

end;
steady;
check;
solve_algo = 0;
resid;

shocks;

var e_g;
stderr 0.05;
end;

stoch_simul(periods=2000,irf=80);





