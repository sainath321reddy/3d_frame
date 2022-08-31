function[GDOF,PDOF,ADOF,elements]=DOFS(nodes,supports,indices)
    elements=size(indices,1);
    GDOF=6*size(nodes,1);
    PDOF=[];
    for i=1:size(supports,1)
        for j=1:6
            PDOF=[PDOF;6*(i-1)+j];
        end
    end
    ADOF=setdiff(1:GDOF,PDOF)';
end
