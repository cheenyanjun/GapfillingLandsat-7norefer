function [ Average_gray_local ] = AAverage_gray_local( SLC_off_graph )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
SIZEOFIMAGE=size(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
Average_gray_local=double(zeros(M,N));
for i=1:M
    for j=1:N
        if i-8>0&&i+8<M&&j-8>0&&j+8<N
            Pixel_number_local=0;            
            for m=-8:8
                for n=-8:8
                    if SLC_off_graph(i+m,j+n)~=0
                        Average_gray_local(i,j)=Average_gray_local(i,j)+SLC_off_graph(i+m,j+n);%17*17窗口平均灰度
                        Pixel_number_local=Pixel_number_local+1;
                    end
                end
            end
            Average_gray_local(i,j)=Average_gray_local(i,j)/Pixel_number_local;%Pixel_number_local;            
        else
            Average_gray_local(i,j)=255/2;
        end
    end    
end
end
