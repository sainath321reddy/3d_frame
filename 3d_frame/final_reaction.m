function [member_reaction_local,joint_reaction,member_reaction_global]=final_reaction(nodes,indices,u,GDOF,Kg_ele,member_forces,T_ele)
    un=zeros(size(nodes,1),6);
    for i=1:size(nodes,1)
        z=u(6*(i-1)+1:6*i)';
        un(i,:)=un(i,:)+z;
    end
    member_reaction_global=zeros(12,size(indices,1));
    member_reaction_local=zeros(12,size(indices,1));
    joint_reaction=zeros(GDOF,1);
    for i=1:size(indices,1)
        f2=zeros(12,1);
        d1=indices(i,2);
        d2=indices(i,3);
        m=[6*(d1-1)+1:6*d1,6*(d2-1)+1:6*d2]';    
        f2=Kg_ele(:,:,i)*u(m)+member_forces(:,i);
        member_reaction_global(:,i)=member_reaction_global(:,i)+f2;
        joint_reaction(m)=joint_reaction(m)+f2;
        %local member moments
        member_reaction_local(:,i)=member_reaction_local(:,i)+T_ele(:,:,i)*member_reaction_global(:,i);
    end
end