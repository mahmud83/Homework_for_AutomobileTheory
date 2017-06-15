function ss=SteeringSensitivity(u,L,K)
ss=(u/L)./(1+K*u.^2);
end