function [ RIGHTUP_boundary_I RIGHTUP_boundary_J LEFTDOWN_boundary_I LEFTDOWN_boundary_J ] = RIGHTUP_LEFTDOWN_boundary( tiaodai_location_graph )
%RIGHTUP_LEFTDOWN_boundary search right up and left down boundary and return them.
%RIGHTUP_LEFTDOWN_boundary means up right boundary and down left boundary in the strip
%district.
SIZEOFIMAGE=size(tiaodai_location_graph);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
RIGHTUP_boundary_I=zeros(M,N);
RIGHTUP_boundary_J=zeros(M,N);
LEFTDOWN_boundary_I=zeros(M,N);
LEFTDOWN_boundary_J=zeros(M,N);
tiaodai_location_RIGHTUP_LEFTDOWN_flag=tiaodai_location_graph;%%%%%%%�ж������Ƿ��ѱ��ָ������������1
%SLC_off_recovered=double(SLC_off_graph);%%%%%%%%���������ѻָ���ͼ
for i=1:M
    for j=1:N
      if (tiaodai_location_RIGHTUP_LEFTDOWN_flag(i,j))==0 
          local_gap_number=0;
          while (tiaodai_location_graph(i+local_gap_number,j-local_gap_number))==0&&j-local_gap_number>1&&i+local_gap_number<M
              local_gap_number=local_gap_number+1;
          end
          for m=0:local_gap_number-1
              if i-1>0&&i+local_gap_number<=M&&j-1>0&&j-local_gap_number>0
                RIGHTUP_boundary_I(i+m,j-m)=i;
                RIGHTUP_boundary_J(i+m,j-m)=j;                
                LEFTDOWN_boundary_I(i+m,j-m)=i+local_gap_number-1;
                LEFTDOWN_boundary_J(i+m,j-m)=j-local_gap_number+1;                
                tiaodai_location_RIGHTUP_LEFTDOWN_flag(i+m,j-m) = 1;                 
              end
          end

      end
    end
end

end

