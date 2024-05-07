function [ AVERAGE_gray_Vertical ] = AAVERAGE_gray_Vertical( SLC_off_graph, UP_boundary,DOWN_boundary )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

SIZEOFIMAGE=size(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
flag=zeros(M,N);
AVERAGE_gray_Vertical=zeros(M,N);
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
                AA=(y1+y2+y3+y4+y5+y6)/6;                
                for m=0:DI-i
                    AVERAGE_gray_Vertical(i+m,j)=AA;
                    flag(i+m,j)=1;    
                end
            end
       end
    end
end
end

