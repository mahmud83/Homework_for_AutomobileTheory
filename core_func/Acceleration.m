function acc=Acceleration(trans,m,F_drive,F_res)
acc=(F_drive-F_res)/(trans*m);
end