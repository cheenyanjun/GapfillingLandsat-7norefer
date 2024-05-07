function [ K_Leftline regress_n]=KK_Leftline_regress( SLC_off_graph, RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Compute Leftline ratio or say, slope--K_Leftline.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%以（i=0，j=0）为原点，左上和右下边界以外各取三个点,y1=SLC_off_graph(RIGHTUP_boundary_I-3,RIGHTUP_boundary_J-3),
%%%y2=SLC_off_graph(RIGHTUP_boundary_I-2,RIGHTUP_boundary_J-2),y3=SLC_off_graph(RIGHTUP_boundary_I-1,RIGHTUP_boundary_J-1),
%y4=SLC_off_graph(LEFTDOWN_boundary_I+1,LEFTDOWN_boundary_J+1),
%y5=SLC_off_graph(LEFTDOWN_boundary_I+2,LEFTDOWN_boundary_J+2),y6=SLC_off_graph(LEFTDOWN_boundary_I+3,LEFTDOWN_boundary_J+3),
%x=sqrt(2)*[RIGHTUP_boundary_I-3,RIGHTUP_boundary_I-2,RIGHTUP_boundary_I-1,LEFTDOWN_boundary_I+1,LEFTDOWN_boundary_I+2,LEFTDOWN_boundary_I+3]
%y=[y1,y2,y3,y4,y5,y6],aa=polyfit(x,y,1),求出K_Leftline(i,j)=aa(1)

regress_n=0;
SIZEOFIMAGE=size(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
flag=zeros(M,N);
K_Leftline=double(flag);
for i=1:M
    for j=1:N
        if flag(i,j)==0&&SLC_off_graph(i,j)==0
            UI=RIGHTUP_boundary_I(i,j);
            UJ=RIGHTUP_boundary_J(i,j);        
            DI=LEFTDOWN_boundary_I(i,j);
            DJ=LEFTDOWN_boundary_J(i,j);        
            if UI-3>0&&DI+3<=M&&DJ-3>0&&UJ+3<=N
                x1=UI-3;
                x2=UI-2;
                x3=UI-1;
                x4=DI+1;
                x5=DI+3;
                x6=DI+4;
                y1=SLC_off_graph(UI-3,UJ+3);
                y2=SLC_off_graph(UI-2,UJ+2);
                y3=SLC_off_graph(UI-1,UJ+1);
                y4=SLC_off_graph(DI+1,DJ-1);
                y5=SLC_off_graph(DI+2,DJ-2);
                y6=SLC_off_graph(DI+3,DJ-3);
                x=sqrt(2)*[x1,x2,x3,x4,x5,x6]';
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
                    K_Leftline(i+m,j+m)=a1;
                    flag(i+m,j+m)=1;                    
                end
            end
        end
    end
end
end