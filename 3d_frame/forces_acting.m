function [member_forces,forces_input]=forces_acting(P,w,elements,indices,nodes,T_ele,member_load,joint_load,GDOF)
    forces_input=zeros(GDOF,1);
    member_forces=zeros(12,elements);
    for i=1:size(member_load,1)
        [xd,yd,zd,m]=coordinate_diff(indices,nodes,member_load(i));
        f1=zeros(12,1);
        L=sqrt(xd^2+yd^2+zd^2);
        if yd==0
            f1(2)=w*L/2 ;
            f1(6)=w*L^2/12;
            f1(8)=w*L/2;
            f1(12)=-w*L^2/12;
            member_forces(:,member_load(i))=T_ele(:,:,member_load(i))'*f1;
        end
        forces_input(m)=forces_input(m)-member_forces(:,member_load(i));
    end
    for j=1:size(joint_load,1)
        i=(joint_load(j));
        forces_input(6*(i-1)+1)=P;
    end
end