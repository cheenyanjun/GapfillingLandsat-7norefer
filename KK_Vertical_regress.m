function [K_Vertical regress_n]=KK_Vertical_regress( SLC_off_graph, UP_boundary, DOWN_boundary )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Compute vertical ratio or say, slope--K_Vertical.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%以（i=0，j=0）为原点，上下边界以外各取三个点,y1=SLC_off_graph(UP_boundary-1,j),
%%%y2=SLC_off_graph(UP_boundary-2,j),y3=SLC_off_graph(UP_boundary-3,j),y4=SLC_off_graph(DOWN_boundary+1,j),
%y5=SLC_off_graph(DOWN_boundary+2,j),y6=SLC_off_graph(DOWN_boundary+3,j),
%x=[UP_boundary-3,UP_boundary-2,UP_boundary-1,DOWN_boundary+1,DOWN_boundary+2,DOWN_boundary+3]
%y=[y1,y2,y3,y4,y5,y6],aa=polyfit(x,y,1),求出K_Vertical(i,j)=aa(1)

regress_n=0;
SIZEOFIMAGE=size(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
flag=zeros(M,N);
K_Vertical=zeros(M,N);
for i=1:M
    for j=1:N
        if flag(i,j)==0&&SLC_off_graph(i,j)==0
            UI=UP_boundary(i,j);
            DI=DOWN_boundary(i,j);
            if UI-3>0&&DI+3<=M
                y1=SLC_off_graph(UI-3,j);
                y2=SLC_off_graph(UI-2,j);
                y3=SLC_off_graph(UI-1,j);
                y4=SLC_off_graph(DI+1,j);
                y5=SLC_off_graph(DI+2,j);
                y6=SLC_off_graph(DI+3,j);
        
                x=[UI-3,UI-2,UI-1,DI+1,DI+2,DI+3]';
                y=[y1,y2,y3,y4,y5,y6]';
                s=size(x);
                X=[ones(s(1,1),1) x];
                [b,bint,r,rint,stats]=regress(y,X);
                %rcoplot(r,rint);
                if stats(1,3)<0.05%p小于0.05，说明模型可用
                    for ii=1:s(1,1)
                        if (ii<=s(1,1))
                            if (rint(ii,1)*rint(ii,2)>0&&stats(1,3)<0.05)
                                if ii>1&&ii<s(1,1)
                                    x=[x(1:ii-1); x(ii+1:s(1,1))];
                                    y=[y(1:ii-1); y(ii+1:s(1,1))];
                                    X=[ones(s(1,1)-1,1) x];
                                    s=size(x);
                                elseif ii==1
                                    x=x(2:s(1,1));
                                    y=y(2:s(1,1));
                                    X=[ones(s(1,1)-1,1) x];
                                    s=size(x);
                                else
                                    x=x(1:s(1,1)-1);
                                    y=y(1:s(1,1)-1);
                                    X=[ones(s(1,1)-1,1) x];
                                    s=size(x);
                                end
                                [b,bint,r,rint,stats]=regress(y,X);
                                %figure;rcoplot(r,rint);
                            end
                        end
                    end
                    a1=b(1);
                    regress_n=regress_n+1;                    
                else
                    aa=polyfit(x,y,1);
                    a1=aa(1);
                end
                for m=0:DI-i
                    K_Vertical(i+m,j)=a1;
                    flag(i+m,j)=1;    
                end
            end
        end
    end
end
end