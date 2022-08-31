function u_int=initial_dis(F,Kg,GDOF,ADOF)
    u_int=zeros(GDOF,1);
    u_int(ADOF)=Kg(ADOF,ADOF)\F(ADOF);
end