function [T_beam,L]=beam_transformation_matrix(xd,yd,zd)
    if xd~=0
        if xd>0
            t=[1 0 0;0 1 0;0 0 1];
            L=xd;
        else
            t=[-1 0 0;0 1 0;0 0 -1];
            L=-xd;
        end
    elseif yd~=0
        if yd>0
            t=[0 1 0;-1 0 0;0 0 1];
            L=yd;
        else
            t=[0 -1 0;1 0 0;0 0 1];
            L=-yd;
        end
    else
        if zd>0
            t=[0 0 1;0 1 0;-1 0 0];
            L=zd;
        else
            t=[0 0 -1;0 1 0;1 0 0];
            L=-zd;
        end
    end
    T_beam=zeros(12);
    for j=1:4
        T_beam(3*j-2:3*j,3*j-2:3*j)=T_beam(3*j-2:3*j,3*j-2:3*j)+t;
    end
end