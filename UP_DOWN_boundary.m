function [ UP_boundary DOWN_boundary ] = UP_DOWN_boundary( tiaodai_location_graph )
%UP_DOWN_boundary search up and down boundary and return them.
%UP_DOWN_boundary means up boundary and down boundary in the strip
%district.
SIZEOFIMAGE=size(tiaodai_location_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
UP_boundary=zeros(M,N);
DOWN_boundary=zeros(M,N);
tiaodai_location_UP_DOWN_flag=tiaodai_location_graph;%%%%%%%判断条带是否已被恢复，若填充则置1
%SLC_off_recovered=double(SLC_off_graph);%%%%%%%%条带像素已恢复的图
for i=1:M
    for j=1:N
      if (tiaodai_location_UP_DOWN_flag(i,j))==0 
          local_gap_number=0;
          while (tiaodai_location_UP_DOWN_flag(i+local_gap_number,j))==0&&i+local_gap_number<M
              local_gap_number=local_gap_number+1;
          end
          for m=0:local_gap_number-1
              if i-1>0&&i+local_gap_number<=M
                UP_boundary(i+m,j)=i;
                DOWN_boundary(i+m,j)=i+local_gap_number-1;
                tiaodai_location_UP_DOWN_flag(i+m,j) = 1;                 
              end
          end

      end
    end
end

end

