function [ SLC_off_graph_Max_Min_filt] = Max_Min_filt_suiji(threshold_magnitude, SLC_off_graph,Is_gap_in_the_middle )
%threshold_magnitude will multiple by SLC_off_graph
%   Detailed explanation goes here
SLC_off_graph=double(SLC_off_graph);
%SLC_off_graph_Max_Min_filt=SLC_off_graph;
SIZEOFIMAGE=size(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
magnitude=threshold_magnitude;
Average_gray_local=zeros(M,N);

for i=1:M
   for j=1:N
       if i-1>0&&i+1<M&&j-1>0&&j+1<N
            Pixel_number_local=0;            
            for m=-1:1
                for n=-1:1
                    if SLC_off_graph(i+m,j+n)~=0
                        Average_gray_local(i,j)=Average_gray_local(i,j)+SLC_off_graph(i+m,j+n);%3*3窗口平均灰度
                        Pixel_number_local=Pixel_number_local+1;
                    end
                end
            end
            Average_gray_local(i,j)=Average_gray_local(i,j)/Pixel_number_local;%Pixel_number_local;            
        else
            Average_gray_local(i,j)=255/2;
        end
       if i>1&&i<M&&j>1&&j<N&&Is_gap_in_the_middle(i,j)==0&&...
               (Average_gray_local(i,j)<150&&SLC_off_graph(i,j)>Average_gray_local(i,j)*(1+magnitude)||Average_gray_local(i,j)>90&&SLC_off_graph(i,j)<Average_gray_local(i,j)*(1-magnitude));%
           suijishu=(round(rand(1,1)*7)+1);
           switch(suijishu)
               case 1
                   SLC_off_graph(i,j)=SLC_off_graph(i,j+1);%东侧
               case 2
                   SLC_off_graph(i,j)=SLC_off_graph(i+1,j+1);%东南侧                   
               case 3
                   SLC_off_graph(i,j)=SLC_off_graph(i+1,j);%南侧                   
               case 4
                   SLC_off_graph(i,j)=SLC_off_graph(i+1,j-1);%西南侧                   
               case 5
                   SLC_off_graph(i,j)=SLC_off_graph(i,j-1);%西侧                   
               case 6
                   SLC_off_graph(i,j)=SLC_off_graph(i-1,j-1);%西北侧                   
               case 7
                   SLC_off_graph(i,j)=SLC_off_graph(i-1,j);%北侧                   
               otherwise%case 8
                   SLC_off_graph(i,j)=SLC_off_graph(i-1,j+1);%东北侧                   
           end
       end
   end
end
SLC_off_graph_Max_Min_filt=uint8(SLC_off_graph);
end