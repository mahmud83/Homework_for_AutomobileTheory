function er=BrakingEffRear(a,L,beta,ur,hg)
er=(a/L)./(1-beta+ur*hg./L);
end