function Q_s=FuelConsume(P_e,b,u_a,pg)
Q_s=P_e.*b./(1.02*u_a*pg);
end