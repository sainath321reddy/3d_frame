function [xd,yd,zd,Kg_idx]=coordinate_diff(indices,nodes,i)
    d1=indices(i,2);
    d2=indices(i,3);
    Kg_idx=[6*(d1-1)+1:6*d1,6*(d2-1)+1:6*d2];
    xd=nodes(d2,2)-nodes(d1,2);
    yd=nodes(d2,3)-nodes(d1,3);
    zd=nodes(d2,4)-nodes(d1,4);
end