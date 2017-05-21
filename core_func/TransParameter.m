function trans=TransParameter(I_w_sum,m,r,I_f,i_0,i_g,K)
trans=1+I_w_sum/(m*r.^2)+I_f*i_0.^2*i_g.^2*K/(m*r.^2);
end