function [ AVERAGE_gray_Rightline ] = AAVERAGE_gray_Rightline( SLC_off_graph, LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

SIZEOFIMAGE=size(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
flag=zeros(M,N);
AVERAGE_gray_Rightline=zeros(M,N);
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
                else
                    y1=SLC_off_graph(UI-3,UJ-3);
                    y2=SLC_off_graph(UI-2,UJ-2);
                    y3=SLC_off_graph(UI-1,UJ-1);
                end
                if  SLC_off_graph(DI+2,DJ+2)==0
                    y4=SLC_off_graph(DI+1,DJ+1);
                    y5=SLC_off_graph(DI+3,DJ+3);
                    y6=SLC_off_graph(DI+4,DJ+4);
                else
                    y4=SLC_off_graph(DI+1,DJ+1);
                    y5=SLC_off_graph(DI+2,DJ+2);
                    y6=SLC_off_graph(DI+3,DJ+3);
                end     
                y=(y1+y2+y3+y4+y5+y6)/6;
                for m=0:DI-i
                    AVERAGE_gray_Rightline(i+m,j)=y;
                    flag(i+m,j)=1;    
                end
            end
        end
    end
end
end

