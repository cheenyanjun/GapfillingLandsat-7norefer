function [ Is_gap_in_the_middle ] = IIs_gap_in_the_middle( UP_boundary,DOWN_boundary,M,N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Is_gap=zeros(M,N);
Is_gap_in_the_middle=zeros(M,N);
for i=1:M
    for j=1:N
        if DOWN_boundary(i,j)>0&&UP_boundary(i,j)>0&&DOWN_boundary(i,j)<=M&&UP_boundary(i,j)<=M
            width=DOWN_boundary(i,j)-UP_boundary(i,j)+1;
            if width>=4&&Is_gap(i,j)==0
                if width==4
                    Is_gap_in_the_middle(i+1,j)=1;
                    Is_gap_in_the_middle(i+2,j)=1;
                    for m=0:3
                        Is_gap(i+m,j)=1;
                    end
                else
                    left=(width-4)/2;
                    right=floor((width-4)/2);
                    if left==right%even number
                        for m=UP_boundary(i,j):DOWN_boundary(i,j)
                            Is_gap(m,j)=1;
                        end
                        for m=0:right*2-1
                            Is_gap_in_the_middle(i+2+m,j)=1;
                        end
                    else%odd number
                        for m=UP_boundary(i,j):DOWN_boundary(i,j)
                            Is_gap(m,j)=1;
                        end
                        for m=0:right*2
                            Is_gap_in_the_middle(i+2+m,j)=1;
                        end
                    end
                end
            end
        end
    end
end
end

