function [ class_difference_situation ] = class_difference( Unsupervised_classes,UP_boundary,DOWN_boundary,LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J,RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J)
%class_difference give the result of class difference between up an down
%UP_boundary,DOWN_boundary,LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I
%,RIGHTDOWN_boundary_J,RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J
%123 means K_Vetical,K_Rightline,K_Leftline
SIZEOFIMAGE=size(Unsupervised_classes);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
class_difference_situation=zeros(M,N);
for i=2:M-1
    for j=2:N-1
        if UP_boundary(i,j)-1>0&&DOWN_boundary(i,j)+1<M&&LEFTUP_boundary_I(i,j)-1>0&&LEFTUP_boundary_J(i,j)-1>0&&RIGHTDOWN_boundary_I(i,j)+1<M&&RIGHTDOWN_boundary_J(i,j)+1<N&&...
            RIGHTUP_boundary_I(i,j)-1>0&&RIGHTUP_boundary_J(i,j)+1<N&&LEFTDOWN_boundary_I(i,j)+1<M&&LEFTDOWN_boundary_J(i,j)-1>0
            %判断上下边界是否是同一分类
            m1=Unsupervised_classes(UP_boundary(i,j)-1,j,1)== Unsupervised_classes(DOWN_boundary(i,j)+1,j,1)&&...
                    Unsupervised_classes(UP_boundary(i,j)-1,j,2)== Unsupervised_classes(DOWN_boundary(i,j)+1,j,2)&&...
                    Unsupervised_classes(UP_boundary(i,j)-1,j,3)== Unsupervised_classes(DOWN_boundary(i,j)+1,j,3);
            m2=Unsupervised_classes(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1,1)== Unsupervised_classes(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1,1)&&...
                Unsupervised_classes(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1,2)== Unsupervised_classes(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1,2)&&...
                Unsupervised_classes(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1,3)== Unsupervised_classes(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1,3);
            m3=Unsupervised_classes(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1,1)==Unsupervised_classes(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1,1)&&...
                    Unsupervised_classes(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1,2)==Unsupervised_classes(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1,2)&&...
                    Unsupervised_classes(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1,3)==Unsupervised_classes(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1,3);
            if m1==1&&m2==1&&m3==1||m1==0&&m2==0&&m3==0
                class_difference_situation(i,j)=123;
            elseif m1==1&&m2==1&&m3==0
                class_difference_situation(i,j)=12;
            elseif m1==1&&m2==0&&m3==1
                class_difference_situation(i,j)=13;
            elseif m1==0&&m2==1&&m3==1
                class_difference_situation(i,j)=23;
            elseif m1==1&&m2==0&&m3==0
                class_difference_situation(i,j)=1;
            elseif m1==0&&m2==0&&m3==1
                class_difference_situation(i,j)=3;
            elseif m1==0&&m2==1&&m3==0
                class_difference_situation(i,j)=2;
            end
        end
    end
end
end

