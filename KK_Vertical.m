function [K_Vertical]=KK_Vertical( SLC_off_graph, UP_boundary, DOWN_boundary )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Compute vertical ratio or say, slope--K_Vertical.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%以（i=0，j=0）为原点，上下边界以外各取三个点,y1=SLC_off_graph(UP_boundary-1,j),
%%%y2=SLC_off_graph(UP_boundary-2,j),y3=SLC_off_graph(UP_boundary-3,j),y4=SLC_off_graph(DOWN_boundary+1,j),
%y5=SLC_off_graph(DOWN_boundary+2,j),y6=SLC_off_graph(DOWN_boundary+3,j),
%x=[UP_boundary-3,UP_boundary-2,UP_boundary-1,DOWN_boundary+1,DOWN_boundary+2,DOWN_boundary+3]
%y=[y1,y2,y3,y4,y5,y6],aa=polyfit(x,y,1),求出K_Vertical(i,j)=aa(1)

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
        
            x=[UI-3,UI-2,UI-1,DI+1,DI+2,DI+3];
            y=[y1,y2,y3,y4,y5,y6];
            aa=polyfit(x,y,1);
            for m=0:DI-i
                K_Vertical(i+m,j)=aa(1);
                flag(i+m,j)=1;    
            end
        end
        
        end
    end
end
end