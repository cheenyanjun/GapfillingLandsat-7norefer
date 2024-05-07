function [ output_args ] = Vertical_suijitianchong(UP_boundary,(IU,j);
    %向下搜索边界==>DOWN_boundary(ID,j)SLC_off_recovered(,UP),I,J )
%Vertical_suijitianchong searches the up boundary and down boundary. Then fills in the pixel value randomly.
%   Detailed explanation goes here

i=I;j=J:
SLC_off_recovered=;
%%%%%%%Read in all the pictures. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%SLC_off_graph is a map to be recovered.%%%%%%%%%%%%
SLC_off_graph = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\矫正的扎龙地图和带条带的7654321\SLC_off_graph.bmp');
%%%%%%%%tiaodai_location_graph shows the location of the strips.%%%%%%%%%%%%
tiaodai_location_graph = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\矫正的扎龙地图和带条带的7654321\tiaodai_location_graph.bmp');
tiaodai_location_filled_flag=tiaodai_location_graph;%%%%%%%判断条带是否已被恢复，若填充则置1
SLC_off_recovered=double(SLC_off_graph);%%%%%%%%条带像素已恢复的图
       
      if (tiaodai_location_filled_flag(i,j))==0 
          local_gap_number=0;
          while (tiaodai_location_filled_flag(i+local_gap_number,j))==0
              local_gap_number=local_gap_number+1;
          end
          
          left=local_gap_number/2;
          right=round(local_gap_number/2);
          %%%奇数个待填充像素

          if  left ~= right
              for m=0:right-1

                    SUIJISHU=round(rand(1,1)*(floor(local_gap_number/2)-1))+1;
                  if i-SUIJISHU>0                    
                    SLC_off_recovered(i+m,j)=SLC_off_recovered(i-SUIJISHU,j);
                  end
              end
              for m=0:right-1
                  SUIJISHU=round(rand(1,1)*(floor(local_gap_number/2)-1))+1;
                  if i+local_gap_number-1+SUIJISHU<=400

                    SLC_off_recovered(i+right+m,j)=SLC_off_recovered(i+local_gap_number-1+SUIJISHU,j);
                  end
              end
          
          %%%偶数个待填充像素
          else  
              for m=0:right-1
                  SUIJISHU=round(rand(1,1)*(floor(local_gap_number/2)-1))+1;
                  if i-SUIJISHU>0                                                
                    SLC_off_recovered(i+m,j)=SLC_off_recovered(i-SUIJISHU,j);
                  end
              end
              for m=0:right-1
                  SUIJISHU=round(rand(1,1)*(floor(local_gap_number/2)-1))+1;
                  if i+local_gap_number-1+SUIJISHU<=400                            
                    SLC_off_recovered(i+right+m-1,j)=SLC_off_recovered(i+local_gap_number-1+SUIJISHU,j);
                  end
              end
              
          end
      end
%SLC_off_recovered=uint8(SLC_off_recovered);imshow(SLC_off_recovered);


end

