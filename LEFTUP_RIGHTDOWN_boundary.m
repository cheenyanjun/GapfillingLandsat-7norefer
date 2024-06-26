function [ LEFTUP_boundary_I LEFTUP_boundary_J RIGHTDOWN_boundary_I RIGHTDOWN_boundary_J] = LEFTUP_RIGHTDOWN_boundary( tiaodai_location_graph )
%UP_DOWN_boundary search up and down boundary and return them.
%UP_DOWN_boundary means up boundary and down boundary in the strip
%district.
SIZEOFIMAGE=size(tiaodai_location_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
LEFTUP_boundary_I=zeros(M,N);
LEFTUP_boundary_J=zeros(M,N);
RIGHTDOWN_boundary_I=zeros(M,N);
RIGHTDOWN_boundary_J=zeros(M,N);
tiaodai_location_LEFTUP_RIGHTDOWN_flag=tiaodai_location_graph;%%%%%%%�ж������Ƿ��ѱ��ָ������������1
%SLC_off_recovered=double(SLC_off_graph);%%%%%%%%���������ѻָ���ͼ
for i=1:M
    for j=1:N
      if (tiaodai_location_LEFTUP_RIGHTDOWN_flag(i,j))==0 
          local_gap_number=0;
          while (tiaodai_location_graph(i+local_gap_number,j+local_gap_number))==0&&i+local_gap_number<M&&j+local_gap_number<N
              local_gap_number=local_gap_number+1;
          end
          for m=0:local_gap_number-1
              if i-1>0&&i+local_gap_number<=M&&j-1>0&&j+local_gap_number<=N
                LEFTUP_boundary_I(i+m,j+m)=i;
                LEFTUP_boundary_J(i+m,j+m)=j;                
                RIGHTDOWN_boundary_I(i+m,j+m)=i+local_gap_number-1;
                RIGHTDOWN_boundary_J(i+m,j+m)=j+local_gap_number-1;                
                tiaodai_location_LEFTUP_RIGHTDOWN_flag(i+m,j+m) = 1;                 
              end
          end

      end
    end
end

end

