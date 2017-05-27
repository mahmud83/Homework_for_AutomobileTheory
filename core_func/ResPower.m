function res_power=ResPower(G,f,u_a,CdA,K)
res_power=(G*f*u_a/3600+CdA*u_a.^3/76140)/K;
end