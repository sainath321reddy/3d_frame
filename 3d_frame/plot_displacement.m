function plot_displacement(nodes,u_int,indices,X,Y,Z,scale)
    mx=zeros(size(nodes,1),1);
    my=zeros(size(nodes,1),1);
    mz=zeros(size(nodes,1),1);
    for i=1:size(nodes,1)
        d=6*(i-1);
        mx(i)=scale*u_int(d+1)+nodes(i,2);
        mz(i)=scale*u_int(d+3)+nodes(i,4);
        my(i)=scale*u_int(d+2)+nodes(i,3);
    end
    Xu=[];
    Yu=[];
    Zu=[];
    for i=1:size(indices,1)
        d1=indices(i,2);
        d2=indices(i,3);
        u1=[mx(d1);mx(d2)];
        u2=[my(d1);my(d2)];
        u3=[mz(d1);mz(d2)];
        Xu=[Xu,u1];
        Yu=[Yu,u2];
        Zu=[Zu,u3];
    end
    plot3(X,Z,Y,'Color','r')
    plot3(X,Z,Y,'o')
    grid on
    plot3(Xu,Zu,Yu,'Color','black')
end