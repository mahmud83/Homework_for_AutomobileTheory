function ef=BrakingEffFront(b,L,beta,uf,hg)
ef=(b/L)./(beta-uf*hg./L);
end