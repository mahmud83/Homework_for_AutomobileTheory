function F_res=Resistance(G,f,CdA,u_a)
F_res=G*f+CdA*u_a.^2/21.25;
end