function [X,Y,Z]=X_Y_Z(elements,indices,nodes)
    X=zeros(2,elements);
    Y=zeros(2,elements);
    Z=zeros(2,elements);
    for i=1:elements
        for j=1:2
            X(j,i)=nodes(indices(i,j+1),2);
            Y(j,i)=nodes(indices(i,j+1),3);
            Z(j,i)=nodes(indices(i,j+1),4);
        end
end