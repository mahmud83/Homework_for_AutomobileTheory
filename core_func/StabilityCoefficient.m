function K=StabilityCoefficient(m,L,a,k2,b,k1)
K=(a/k2-b/k1)*m/L.^2;
end