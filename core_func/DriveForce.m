function F_drive=DriveForce(T_tq,i_g,i_0,K,r)
F_drive=(T_tq*i_g*i_0*K)/r;
end