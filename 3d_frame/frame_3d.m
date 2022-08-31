clc
clear
%%%%%%%%%%%%%%getting_data_from_std_file%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

text_read

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%degrees_of_freedom%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[GDOF,PDOF,ADOF,elements]=DOFS(nodes,supports,indices);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%global_stiffness_matrix_of_system%%%%%%%%%%%%%%%%%%%%%%%

Kg=zeros(GDOF);
Kg_ele=zeros(12,12,elements);
T_ele=zeros(12,12,elements);
for i=1:elements
    [xd,yd,zd,m]=coordinate_diff(indices,nodes,i);
    [T_beam,L]=beam_transformation_matrix(xd,yd,zd);
    beam_stiffness_matrix
    T_ele(:,:,i)=T_beam;
    Kg_ele(:,:,i)=T_beam'*K_beam*T_beam;
    Kg(m,m)=Kg(m,m)+Kg_ele(:,:,i);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%giving_load_vector%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[member_forces,forces_input]=forces_acting(FX,GY,elements,indices,nodes, ...
    T_ele,member_load,joint_load,GDOF);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%finding_displacement_vector%%%%%%%%%%%%%%%%%%%%%%%

u_int=initial_dis(forces_input,Kg,GDOF,ADOF);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%final_reactions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[member_reaction_local,joint_reaction,member_reaction_global]=final_reaction(nodes, ...
    indices,u_int,GDOF,Kg_ele,member_forces,T_ele);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%plots%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%scale%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dis_scale=1;

F_scale=[0.001,0.01,0.1,1,0.005,0.001];
dis=0.5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X,Y,Z]=X_Y_Z(elements,indices,nodes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%plot_displacement%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
title('deflections')
hold on
plot_displacement(nodes,u_int,indices,X,Y,Z,dis_scale);
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%reaction_plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
reaction_plot(nodes,indices,dis,F_scale,member_reaction_local,X,Y,Z,GY);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(member_reaction_local)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%