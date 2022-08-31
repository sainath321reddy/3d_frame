fid=fopen("multi_task_1.STD");
tline = fgetl(fid);
%%%%%%%%%DEFINING_THE_VARIABLES_WE_NEED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%AS_PER_REQUIRED_DATA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nodes=[];
indices=[];
member=[];
supports=[];
member_load=[];
joint_load=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while ischar(tline)
    tline = fgetl(fid);
%%%%%%%%%%FINDING_JOINT_COORDINATES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(tline,'JOINT COORDINATES')
        while ischar(tline)
            tline = fgetl(fid);
            if strcmp(tline,'MEMBER INCIDENCES')
                break
            end
            newStr=split(tline,[" ",";"]);
            for i=1:size(newStr)
                if(rem(i,5)>0)
                    nodes=[nodes,str2double(newStr{i})];
                end
            end
        end    
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%FINDING_MEMBER_INDICES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if strcmp(tline,'MEMBER INCIDENCES')
         while ischar(tline)
            tline = fgetl(fid);
            if strcmp(tline,'DEFINE MATERIAL START')
                break
            end
            newStr=split(tline,[" ",";"]);
            for i=1:size(newStr)
                if(rem(i,4)>0)
                    indices=[indices,str2double(newStr{i})];
                end
            end
         end
     end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%ISOTROPIC_MATERIAL_PROPERTIES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if strcmp(tline,'ISOTROPIC MATERIAL')
         while ischar(tline)
            tline = fgetl(fid);
            if strcmp(tline,'TYPE STEEL')
                break
            end
            newStr=split(tline);
            if newStr{1}=='E'%%%%%%%%%%%%%%%%%_E_%%%%%%%%%%%%%%%%%%%%%%%%%%
                E=str2double(newStr{2});
            end
            if newStr{1}=='G'%%%%%%%%%%%%%%%%%_G_%%%%%%%%%%%%%%%%%%%%%%%%%%
                G=str2double(newStr{2});
            end
         end
     end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%MEMBER_PROPERTIES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if strcmp(tline,'MEMBER PROPERTY')
         while ischar(tline)
            tline = fgetl(fid);
            if strcmp(tline,'CONSTANTS')
                break;
            end
            newStr=split(tline);
            for i=1:size(newStr)
                if strcmp(newStr{i},'TO')
                    for j=str2double(newStr(i-1)):str2double(newStr(i+1))
                        member=[member,j];
                    end
                end
                if strcmp(newStr{i},'YD')%%%%%%%%%%_YD_%%%%%%%%%%%%%%%%%%%%
                    YD=str2double(newStr{i+1});
                end
                if strcmp(newStr{i},'ZD')%%%%%%%%%%_ZD_%%%%%%%%%%%%%%%%%%%%
                    ZD=str2double(newStr{i+1});
                end
            end
         end
     end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%SUPPORTS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if strcmp(tline,'SUPPORTS')
         tline = fgetl(fid);
         newStr=split(tline);        
         for i=1:size(newStr)
            if strcmp(newStr{i},'TO')
                for j=str2double(newStr(i-1)):str2double(newStr(i+1))
                    supports=[supports,j];
                end
            end
         end
     end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%MEMBER_LOAD%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if strcmp(tline,'MEMBER LOAD')
         while ischar(tline)
            tline = fgetl(fid);
            if strcmp(tline,'JOINT LOAD')
                break
            end
            newStr=split(tline);  
            for i=1:size(newStr)
                if strcmp(newStr{i},'TO')  
                    for j=str2double(newStr{i-1}):str2double(newStr{i+1})       
                        member_load=[member_load,j];
                    end                                              
                end
                if strcmp(newStr{i},'GY')
                    GY=-str2double(newStr{i+1});
                end
            end
         end
     end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%JOINT_LOAD%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if strcmp(tline,'JOINT LOAD')
         while ischar(tline)
            tline = fgetl(fid);
            if strcmp(tline,'PERFORM ANALYSIS PRINT ALL')
                break
            end
            newStr=split(tline);  
            for i=1:size(newStr)
                if strcmp(newStr{i},'FX')
                    FX=str2double(newStr{i+1});
                    break;
                end
                joint_load=[joint_load,str2double(newStr{i})];
            end
         end
     end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%OBTAINED_ALL_REQUIRED_DATA%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%SIMPLIFIED_DATA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=size(nodes,2);
A=zeros(a/4,4);
for i=1:a/4
    for j=1:4
        A(i,j)=nodes(4*(i-1)+j);
    end
end
nodes=A;%%%%%%%%%%%%%%%%%%%JOINT_NODE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=size(indices,2);
A=zeros(a/3,3);
for i=1:a/3
    for j=1:3
        A(i,j)=indices(3*(i-1)+j);
    end
end
indices=A;%%%%%%%%%%%%%%%%MEMBER_INDICES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%TRANSPOSED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
member=member';
supports=supports';
member_load=member_load';
joint_load=joint_load';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%MATERIAL_PROPERTIES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Iy=ZD*YD^3/12;
Iz=YD*ZD^3/12;
J=Iy+Iz;
A=YD*ZD;
AE=A*E;
GIx=G*J;
EIy=E*Iy;
EIz=E*Iz;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
