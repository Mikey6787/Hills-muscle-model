
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
%% Creat the whole muscle model corresponded to Hill's model 

function [m_s,m_t] = hill_model (Kse_val, Kpe_val, Tce_val, B_val, T_val , e_val, t_val)

syms Kse Kpe Tce B e t s
T = (Kse.*Tce) / (( (B.*s)+Kpe+Kse).* s) + ((Kse.*(B.*s+Kpe)) / (B.*s+Kpe+Kse)) .* (e/s);
m_t = ilaplace (T,t);

vars = [Kse Kpe Tce B e];

values = [Kse_val Kpe_val Tce_val B_val e_val];
m_t = subs (m_t,vars,values);

%% time subsitute 
vars = t ;
values = t_val;
m_t = subs (m_t,vars,values);
%plot (m)

%% model in order of strain

syms Kse Kpe Tce B T t s


e = ( (((B.*s) + Kpe + Kse ) .* T ) /  (((B.*s)+Kpe).*Kse.*s) ) - ...
      (Tce / ((B.*s)+Kpe)).* (1/s) ;

m_s = ilaplace (e,t);

vars = [Kse Kpe Tce B T];

values = [Kse_val Kpe_val Tce_val B_val T_val];
m_s = subs (m_s,vars,values);

%% time subsitute 
vars = t ;
values = t_val;
m_s = subs (m_s,vars,values);





