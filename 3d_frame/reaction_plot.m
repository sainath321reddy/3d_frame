function reaction_plot(nodes,El,dis,scl,Fl,X,Y,Z,w)
    xc=nodes(:,2);
    yc=nodes(:,3);
    zc=nodes(:,4);
    figure
    title('axial force "Fx"')
    hold on
    plot3(X,Z,Y,'Color','r')
    plot3(X,Z,Y,'o')
    grid on
    e=scl(1);
    for i=1:size(El,1)
        d1=El(i,2);
        d2=El(i,3);
        xd=xc(d2)-xc(d1);
        yd=yc(d2)-yc(d1);
        zd=zc(d2)-zc(d1);
        if xd~=0
            xFx1=xc(d1):dis:xc(d2);
            yF=yc(d1)*xFx1.^0;
            yFx=e*Fl(1,i)*xFx1.^0;
            yFx1=yF+yFx;
            zFx1=zc(d2)*xFx1.^0;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        elseif yd~=0
            yFx1=yc(d1):dis:yc(d2);
            zFx1=zc(d1)*yFx1.^0;
            xF=xc(d1)*yFx1.^0;
            xFx=e*Fl(1,i)*yFx1.^0;
            xFx1=xF+xFx;
            Fxv1=[xF(:),xFx1(:)]';
            Fyv1=[yFx1(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        else
            zFx1=zc(d1):dis:zc(d2);
            xFx1=xc(d1)*zFx1.^0;
            yF=yc(d1)*zFx1.^0;
            yFx=e*Fl(1,i)*zFx1.^0;
            yFx1=yF+yFx;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';        
        end 
            plot3(xFx1,zFx1,yFx1,'color','b')
            plot3(Fxv1,Fzv1,Fyv1,'color','b')
    end
    hold off
    figure
    title('shear force "Fy"')
    hold on
    plot3(X,Z,Y,'Color','r')
    plot3(X,Z,Y,'o')
    grid on
    e=scl(2);
    for i=1:size(El,1)
        d1=El(i,2);
        d2=El(i,3);
        xd=xc(d2)-xc(d1);
        yd=yc(d2)-yc(d1);
        zd=zc(d2)-zc(d1);
        if xd~=0
            xFx1=xc(d1):dis:xc(d2);
            yF=yc(d1)*xFx1.^0;
            yFx=e*(Fl(2,i)-w*xFx1);
            yFx1=yF+yFx;
            zFx1=zc(d2)*xFx1.^0;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        elseif yd~=0
            yFx1=yc(d1):dis:yc(d2);
            zFx1=zc(d1)*yFx1.^0;
            xF=xc(d1)*yFx1.^0;
            xFx=e*Fl(2,i)*yFx1.^0;
            xFx1=xF+xFx;
            Fxv1=[xF(:),xFx1(:)]';
            Fyv1=[yFx1(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        else
            zFx1=zc(d1):dis:zc(d2);
            xFx1=xc(d1)*zFx1.^0;
            yF=yc(d1)*zFx1.^0;
            yFx=e*(Fl(2,i)-w*zFx1);
            yFx1=yF+yFx;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';        
        end 
        plot3(xFx1,zFx1,yFx1,'color','b')
        plot3(Fxv1,Fzv1,Fyv1,'color','b')
    end
    hold off
    figure
    title('shear force "Fz"')
    hold on
    plot3(X,Z,Y,'Color','r')
    plot3(X,Z,Y,'o')
    grid on
    e=scl(3);
    for i=1:size(El,1)
        d1=El(i,2);
        d2=El(i,3);
        xd=xc(d2)-xc(d1);
        yd=yc(d2)-yc(d1);
        zd=zc(d2)-zc(d1);
        if xd~=0
            xFx1=xc(d1):dis:xc(d2);
            yF=yc(d1)*xFx1.^0;
            yFx=e*Fl(3,i)*xFx1.^0;
            yFx1=yF+yFx;
            zFx1=zc(d2)*xFx1.^0;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        elseif yd~=0
            yFx1=yc(d1):dis:yc(d2);
            zFx1=zc(d1)*yFx1.^0;
            xF=xc(d1)*yFx1.^0;
            xFx=e*Fl(3,i)*yFx1.^0;
            xFx1=xF+xFx;
            Fxv1=[xF(:),xFx1(:)]';
            Fyv1=[yFx1(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        else
            zFx1=zc(d1):dis:zc(d2);
            xFx1=xc(d1)*zFx1.^0;
            yF=yc(d1)*zFx1.^0;
            yFx=e*Fl(3,i)*zFx1.^0;
            yFx1=yF+yFx;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';        
        end 
            plot3(xFx1,zFx1,yFx1,'color','b')
            plot3(Fxv1,Fzv1,Fyv1,'color','b')
    end
    hold off
    figure
    title('torsion "Mx or T"')
    hold on
    plot3(X,Z,Y,'Color','r')
    plot3(X,Z,Y,'o')
    grid on
    e=scl(4);
    for i=1:size(El,1)
        d1=El(i,2);
        d2=El(i,3);
        xd=xc(d2)-xc(d1);
        yd=yc(d2)-yc(d1);
        zd=zc(d2)-zc(d1);
        if xd~=0
            xFx1=xc(d1):dis:xc(d2);
            yF=yc(d1)*xFx1.^0;
            yFx=e*Fl(4,i)*xFx1.^0;
            yFx1=yF+yFx;
            zFx1=zc(d2)*xFx1.^0;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        elseif yd~=0
            yFx1=yc(d1):dis:yc(d2);
            zFx1=zc(d1)*yFx1.^0;
            xF=xc(d1)*yFx1.^0;
            xFx=e*Fl(4,i)*yFx1.^0;
            xFx1=xF+xFx;
            Fxv1=[xF(:),xFx1(:)]';
            Fyv1=[yFx1(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        else
            zFx1=zc(d1):dis:zc(d2);
            xFx1=xc(d1)*zFx1.^0;
            yF=yc(d1)*zFx1.^0;
            yFx=e*Fl(4,i)*zFx1.^0;
            yFx1=yF+yFx;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';        
        end 
            plot3(xFx1,zFx1,yFx1,'color','b')
            plot3(Fxv1,Fzv1,Fyv1,'color','b')
    end
    hold off
    figure
    title('bending moment "My"')
    hold on
    plot3(X,Z,Y,'Color','r')
    plot3(X,Z,Y,'o')
    grid on
    e=scl(5);
    for i=1:size(El,1)
        d1=El(i,2);
        d2=El(i,3);
        xd=xc(d2)-xc(d1);
        yd=yc(d2)-yc(d1);
        zd=zc(d2)-zc(d1);
        if xd~=0
            xFx1=xc(d1):dis:xc(d2);
            yF=yc(d1)*xFx1.^0;
            yFx=e*(Fl(5,i)+Fl(3,i)*xFx1);
            yFx1=yF+yFx;
            zFx1=zc(d2)*xFx1.^0;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        elseif yd~=0
            yFx1=yc(d1):dis:yc(d2);
            zFx1=zc(d1)*yFx1.^0;
            xF=xc(d1)*yFx1.^0;
            xFx=e*(Fl(5,i)+Fl(3,i)*yFx1);
            xFx1=xF+xFx;
            Fxv1=[xF(:),xFx1(:)]';
            Fyv1=[yFx1(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        else
            zFx1=zc(d1):dis:zc(d2);
            xFx1=xc(d1)*zFx1.^0;
            yF=yc(d1)*zFx1.^0;
            yFx=e*(Fl(5,i)+Fl(3,i)*zFx1);
            yFx1=yF+yFx;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';        
        end 
            plot3(xFx1,zFx1,yFx1,'color','b')
            plot3(Fxv1,Fzv1,Fyv1,'color','b')
    end
    hold off
    figure
    title('bending moment "Mz"')
    hold on
    plot3(X,Z,Y,'Color','r')
    plot3(X,Z,Y,'o')
    grid on
    e=scl(6);
    for i=1:size(El,1)
        d1=El(i,2);
        d2=El(i,3);
        xd=xc(d2)-xc(d1);
        yd=yc(d2)-yc(d1);
        zd=zc(d2)-zc(d1);
        if xd~=0
            xFx1=xc(d1):dis:xc(d2);
            yF=yc(d1)*xFx1.^0;
            yFx=e*(Fl(6,i)-Fl(2,i)*xFx1+w*xFx1.^2);
            yFx1=yF+yFx;
            zFx1=zc(d2)*xFx1.^0;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        elseif yd~=0
            yFx1=yc(d1):dis:yc(d2);
            zFx1=zc(d1)*yFx1.^0;
            xF=xc(d1)*yFx1.^0;
            xFx=e*(Fl(6,i)-Fl(2,i)*yFx1);
            xFx1=xF+xFx;
            Fxv1=[xF(:),xFx1(:)]';
            Fyv1=[yFx1(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';
        else
            zFx1=zc(d1):dis:zc(d2);
            xFx1=xc(d1)*zFx1.^0;
            yF=yc(d1)*zFx1.^0;
            yFx=e*(Fl(6,i)-Fl(2,i)*zFx1+w*zFx1.^2);
            yFx1=yF+yFx;
            Fxv1=[xFx1(:),xFx1(:)]';
            Fyv1=[yF(:),yFx1(:)]';
            Fzv1=[zFx1(:),zFx1(:)]';        
        end 
            plot3(xFx1,zFx1,yFx1,'color','b')
            plot3(Fxv1,Fzv1,Fyv1,'color','b')
    end
    hold off
end
