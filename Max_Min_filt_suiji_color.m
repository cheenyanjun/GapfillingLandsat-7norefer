function [ SLC_off_graph_Max_Min_filt bug] = Max_Min_filt_suiji_color(threshold_magnitude, SLC_off_graph,tiaodai_location_graph )
%threshold_magnitude will multiple by SLC_off_graph
%   Detailed explanation goes here


bug=0;bug1=0;bug2=0;bug3=0;bug4=0;bug5=0;bug6=0;bug7=0;bug8=0;
SLC_off_graph_color=double(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
%SLC_off_graph_Max_Min_filt=SLC_off_graph;
SIZEOFIMAGE=size(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
magnitude=threshold_magnitude;
Average_gray_local=zeros(M,N);
%SLC_off_graph_color=SLC_off_graph;
SLC_off_graph=rgb2gray(SLC_off_graph);
for i=1:M
   for j=1:N
       if i-3>0&&i+3<M&&j-3>0&&j+3<N
            Pixel_number_local=0;            
            for m=-3:3
                for n=-3:3
                    if SLC_off_graph(i+m,j+n)~=0
                        Average_gray_local(i,j)=Average_gray_local(i,j)+SLC_off_graph(i+m,j+n);%7*7窗口平均灰度
                        Pixel_number_local=Pixel_number_local+1;
                    end
                end
            end
            Average_gray_local(i,j)=Average_gray_local(i,j)/Pixel_number_local;%Pixel_number_local;            
        else
            Average_gray_local(i,j)=255/2;
        end
       if i>1&&i<M&&j>1&&j<N&&tiaodai_location_graph(i,j)==0&&...
               (Average_gray_local(i,j)<200&&SLC_off_graph(i,j)>Average_gray_local(i,j)*(1+magnitude)||Average_gray_local(i,j)>90&&SLC_off_graph(i,j)<Average_gray_local(i,j)*(1-magnitude));%
           suijishu=(round(rand(1,1)*7)+1);

           switch(suijishu)
               case 1
                   SLC_off_graph_color(i,j,:)=SLC_off_graph_color(i,j+1,:);bug1=bug1+1;%东侧
               case 2
                   SLC_off_graph_color(i,j,:)=SLC_off_graph_color(i+1,j+1,:);bug2=bug2+1;%东南侧                   
               case 3
                   SLC_off_graph_color(i,j,:)=SLC_off_graph_color(i+1,j,:);bug3=bug3+1;%南侧                   
               case 4
                   SLC_off_graph_color(i,j,:)=SLC_off_graph_color(i+1,j-1,:);bug4=bug4+1;%西南侧                   
               case 5
                   SLC_off_graph_color(i,j,:)=SLC_off_graph_color(i,j-1,:);bug5=bug5+1;%西侧                   
               case 6
                   SLC_off_graph_color(i,j,:)=SLC_off_graph_color(i-1,j-1,:);bug6=bug6+1;%西北侧                   
               case 7
                   SLC_off_graph_color(i,j,:)=SLC_off_graph_color(i-1,j,:);bug7=bug7+1;%北侧                   
               otherwise%case 8
                   SLC_off_graph_color(i,j,:)=SLC_off_graph_color(i-1,j+1,:);bug8=bug8+1;%东北侧                   
           end
       end
   end
end
SLC_off_graph_Max_Min_filt=uint8(SLC_off_graph_color);
bug=bug1+bug2+bug3+bug4+bug5+bug6+bug7+bug8;
end