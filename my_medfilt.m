function [ SLC_off_recovered_filted ] = my_medfilt( SLC_off_graph,Is_gap_in_the_middle,threshold_magnitude )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
SLC_off_recovered_filted=SLC_off_graph;
%SLC_off_graph_Max_Min_filt=SLC_off_graph;
SIZEOFIMAGE=size(SLC_off_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
ss=size(SIZEOFIMAGE);
magnitude=threshold_magnitude;
Average_gray_local=zeros(M,N);
%magnitude=0;
if ss(1,2)==3

    SLC_off_graph1=rgb2gray(SLC_off_graph);
    SLC_off_graph1=double(SLC_off_graph1);
    SLC_off_graph=double(SLC_off_graph);
 for i=1:M
   for j=1:N
       if i-1>0&&i+1<M&&j-1>0&&j+1<N
            Pixel_number_local=0;            
            for m=-1:1
                for n=-1:1
                    if SLC_off_graph(i+m,j+n)~=0
                        Average_gray_local(i,j)=Average_gray_local(i,j)+SLC_off_graph1(i+m,j+n);%3*3窗口平均灰度
                        Pixel_number_local=Pixel_number_local+1;
                    end
                end
            end
            Average_gray_local(i,j)=Average_gray_local(i,j)/Pixel_number_local;%Pixel_number_local;            
        else
            Average_gray_local(i,j)=255/2;
        end
       if i-1>0&&i+1<M&&j-1>0&&j+1<N&&Is_gap_in_the_middle(i,j)==0&&(SLC_off_graph1(i,j)>Average_gray_local(i,j)*(1+magnitude)||SLC_off_graph1(i,j)<Average_gray_local(i,j)*(1-magnitude));%
           m1=SLC_off_graph1(i-1,j-1);
           m2=SLC_off_graph1(i-1,j);
           m3=SLC_off_graph1(i-1,j+1);
           m4=SLC_off_graph1(i,j-1);
           m6=SLC_off_graph1(i,j+1);
           m7=SLC_off_graph1(i+1,j-1);
           m8=SLC_off_graph1(i+1,j);
           m9=SLC_off_graph1(i+1,j+1);
           middle_values= [m1,m2,m3,m4,m6,m7,m8,m9];
           middle_value=sort(middle_values);
           if m1==middle_value(1,4)
                   SLC_off_recovered_filted(i,j,:)=SLC_off_graph(i-1,j-1,:);
           elseif m2==middle_value(1,4)
                   SLC_off_recovered_filted(i,j,:)=SLC_off_graph(i-1,j,:);               
           elseif m3==middle_value(1,2)
                  SLC_off_recovered_filted(i,j,:)=SLC_off_graph(i-1,j+1,:);
           elseif m4==middle_value(1,4)
                   SLC_off_recovered_filted(i,j,:)=SLC_off_graph(i,j-1,:);
           elseif m6==middle_value(1,4)
                   SLC_off_recovered_filted(i,j,:)=SLC_off_graph(i,j+1,:);
           elseif m7==middle_value(1,5)
                   SLC_off_recovered_filted(i,j,:)=SLC_off_graph(i+1,j-1,:);
           elseif m8==middle_value(1,4)
                   SLC_off_recovered_filted(i,j,:)=SLC_off_graph(i+1,j,:);
           elseif m9==middle_value(1,4)
                   SLC_off_recovered_filted(i,j,:)=SLC_off_graph(i+1,j+1,:);
   
           end
               
           
       end
   end
end
SLC_off_recovered_filted=uint8(SLC_off_recovered_filted);

else
    SLC_off_graph=double(SLC_off_graph);
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
       if i>1&&i+1<M&&j>1&&j+1<N&&Is_gap_in_the_middle(i,j)==0&&(SLC_off_graph(i,j)>Average_gray_local(i,j)*(1+magnitude));%
           middle_values= [SLC_off_graph(i-1,j-1),SLC_off_graph(i-1,j),SLC_off_graph(i-1,j+1),SLC_off_graph(i,j-1),SLC_off_graph(i,j+1),SLC_off_graph(i+1,j-1),SLC_off_graph(i+1,j),SLC_off_graph(i+1,j+1)];
           middle_value=sort(middle_values);
           %suijishu=(round(rand(1,1)*7)+1);
                   SLC_off_recovered_filted(i,j)=middle_value(1,5);%SLC_off_graph(i-1,j+1);%东北侧    
       elseif i>1&&i+1<M&&j>1&&j+1<N&&Is_gap_in_the_middle(i,j)==0&&SLC_off_graph(i,j)<Average_gray_local(i,j)*(1-magnitude)
           middle_values= [SLC_off_graph(i-1,j-1),SLC_off_graph(i-1,j),SLC_off_graph(i-1,j+1),SLC_off_graph(i,j-1),SLC_off_graph(i,j+1),SLC_off_graph(i+1,j-1),SLC_off_graph(i+1,j),SLC_off_graph(i+1,j+1)];
           middle_value=sort(middle_values);
           %suijishu=(round(rand(1,1)*7)+1);
                   SLC_off_recovered_filted(i,j)=middle_value(1,4);%SLC_off_graph(i-1,j+1);%东北侧
       end
   end
end
SLC_off_recovered_filted=uint8(SLC_off_recovered_filted);

end
imshow(uint8(Average_gray_local));
end