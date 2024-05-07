function [ K_Rightline]=KK_Rightline( SLC_off_graph, LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Compute Rightline ratio or say, slope--K_Rightline.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%以（i=0，j=0）为原点，左上和右下边界以外各取三个点,y1=SLC_off_graph(LEFTUP_boundary_I-3,LEFTUP_boundary_J-3),
%%%y2=SLC_off_graph(LEFTUP_boundary_I-2,LEFTUP_boundary_J-2),y3=SLC_off_graph(LEFTUP_boundary_I-1,LEFTUP_boundary_J-1),
%y4=SLC_off_graph(RIGHTDOWN__boundary_I+1,RIGHTDOWN__boundary_J+1),
%y5=SLC_off_graph(RIGHTDOWN__boundary_I+2,RIGHTDOWN__boundary_J+2),y6=SLC_off_graph(RIGHTDOWN__boundary_I+3,RIGHTDOWN__boundary_J+3),
%x=sqrt(2)*[LEFTUP_boundary_I-3,LEFTUP_boundary_I-2,LEFTUP_boundary_I-1,RIGHTDOWN__boundary_I+1,RIGHTDOWN__boundary_I+2,RIGHTDOWN__boundary_I+3]
%y=[y1,y2,y3,y4,y5,y6],aa=polyfit(x,y,1),求出K_Rightline(i,j)=aa(1)

SIZEOFIMAGE=size(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
flag=zeros(M,N);
K_Rightline=double(flag);
for i=1:M
    for j=1:N
        if flag(i,j)==0&&SLC_off_graph(i,j)==0
            UI=LEFTUP_boundary_I(i,j);
            UJ=LEFTUP_boundary_J(i,j);        
            DI=RIGHTDOWN_boundary_I(i,j);
            DJ=RIGHTDOWN_boundary_J(i,j);        
            if UI-4>0&&DI+4<=M&&UJ-4>0&&DJ+4<=N
                if SLC_off_graph(UI-2,UJ-2)==0
                    y1=SLC_off_graph(UI-4,UJ-4);
                    y2=SLC_off_graph(UI-3,UJ-3);
                    y3=SLC_off_graph(UI-1,UJ-1);
                    x1=UI-4;
                    x2=UI-3;
                    x3=UI-1;
                else
                    y1=SLC_off_graph(UI-3,UJ-3);
                    y2=SLC_off_graph(UI-2,UJ-2);
                    y3=SLC_off_graph(UI-1,UJ-1);
                    x1=UI-3;
                    x2=UI-2;
                    x3=UI-1;
                end
                if  SLC_off_graph(DI+2,DJ+2)==0
                    y4=SLC_off_graph(DI+1,DJ+1);
                    y5=SLC_off_graph(DI+3,DJ+3);
                    y6=SLC_off_graph(DI+4,DJ+4);
                    x4=DI+1;
                    x5=DI+3;
                    x6=DI+4;
                else
                    y4=SLC_off_graph(DI+1,DJ+1);
                    y5=SLC_off_graph(DI+2,DJ+2);
                    y6=SLC_off_graph(DI+3,DJ+3);
                    x4=DI+1;
                    x5=DI+2;
                    x6=DI+3;
                end     
                x=sqrt(2)*[x1,x2,x3,x4,x5,x6];
                y=[y1,y2,y3,y4,y5,y6];
                aa=polyfit(x,y,1);
                a1=aa(1);
                
                for m=0:DI-i
                    K_Rightline(i+m,j+m)=a1;
                    flag(i+m,j+m)=1;                    
                end
            end
        end
    end
end
end