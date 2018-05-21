
%% Creating a muscle model described by Hill 
% We have 4 different elements to take care of 
% 1) The generated force by the muscle (Tc)
% 2) The Viscoelastic component of the muscle 
% 3) The elstic component of the muscle
% 4) and finally the tendon (as a elastic element)

% transfered through out series elastic elements, we have 2 equations 
% 1) Ttotal = Tce+ Bs ei + Kpe ei %% which B is the damping coeficient and
% ei is the initial strain to the muscle
% 2 = Ttotla is equal to The tension occur in tendon so we have:
% Ttotal = Kse (e-ei) %% which the e is the secondery strain of the muscle
% by equllibrium of the equation 1 and 2 we have 
% T = (Kse .* Tce /(Bs+Kpe+Kse)) + ((Kse.*(Bs+Kpe) / (Bs+Kpe+Kse)).* e

function [Uper_lim_stress_relaxation,model,Lower_lim_stress_relaxation] = ...
    hill_stress_relax (Kse_val,Kpe_val,Tce_val,B_val,e_val,t_val) 


%% Stress Relaxation 
% In this situation The Tce is Zero and the first term can be eliminiated
% and the Laplace transform of the unit step is eo/s (initial strain / s) 
syms Kse Kpe Tce B e t s
T =  ((Kse.*(B.*s+Kpe)) / (B.*s+Kpe+Kse)) .* (e/s); 
m= ilaplace (T ,t);

vars = [Kse Kpe Tce B e];


values = [Kse_val Kpe_val Tce_val B_val e_val];
m = subs (m,vars,values);

vars = t ;
values = t_val;
model = subs (m,vars,values);
% Finding the uper and lower Limitations 
% Upper Limit (In this situation, the initial strain is all taken up in the
% series elastic element)in this regard the Kpe = 0, we have :
Uper_lim_stress_relaxation = Kse_val .* e_val ; 

% Finding the lower Limit (in this situation the time tends to infinity and
% exp^(-infinity) = 0 , in this regard we have 

Lower_lim_stress_relaxation = (Kpe_val.*Kse_val.*e_val) / (Kpe_val+Kse_val); 


end
