function u_ch_cr=ChCrSpeed(K)
if(K<0)
    u_ch_cr=sqrt(-1/K);
else
    u_ch_cr=sqrt(1/K);
end