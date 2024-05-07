function [ tiaodai_location_graph ] = tiaodai_location_graph_produce_zhalong( SLC_off_graph )
%根据已知的SLC_off_graph制作条带
%SLC_off_graph = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\扎龙真彩色543\fenqu_image.bmp');
%SLC_off_graph_original = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\扎龙真彩色543\caise400size.bmp');
%tiaodai_location_graph =SLC_off_graph(:,:,1);
%Unsupervised_classes = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\扎龙真彩色543\fenleifeijiandu1.bmp');
SIZEOFIMAGE=size(SLC_off_graph);
%tiaodai_location_graph = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\矫正的扎龙地图和带条带的7654321\tiaodai_location_graph.bmp');
%SLC_off_graph=rgb2gray(SLC_off_graph1);

M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
tiaodai_location_graph=ones(M,N)*255;
tiaodai_location_graph=uint8(tiaodai_location_graph);
k1=-0.2546;k2=-0.2524;k3=-0.24;k4=-0.2484;B1=4497.1;B2=4634.2;B3=5332.1;B4=5537;%B5=7249.6;k5=-0.0003574;

for i= 4 : M-3
 for j = 4 : N-3
        b1=j-k1*i;b2=j-k2*i;b3=j-k3*i;b4=j-k4*i;
        RR=SLC_off_graph(i,j,1);
        GG=SLC_off_graph(i,j,2);
        BB=SLC_off_graph(i,j,3);
        r1=(((RR==0)+(GG==0)+(BB==0))==2);%double color
        r5=(((RR==0)+(GG==0)+(BB==0))==1);%single color
        red=RR>10&&GG<10&&BB<10;
        r2=(RR==0&&GG==0&&BB==0)==1;%all 0
        r22=(SLC_off_graph(i-1,j,1)==0+SLC_off_graph(i-1,j,2)==0+SLC_off_graph(i-1,j,3)==0)==3;%quan0
        r23=(SLC_off_graph(i+1,j,1)==0+SLC_off_graph(i+1,j,2)==0+SLC_off_graph(i+1,j,3)==0)==3;%quan0
        orange=SLC_off_graph(i,j,1)>100&&SLC_off_graph(i,j,2)>100&&SLC_off_graph(i,j,3)==0;
        r33=SLC_off_graph(i-2,j,1)==0&&SLC_off_graph(i-2,j,2)==0&&SLC_off_graph(i-2,j,3)==0;%down row stripe 
        r34=SLC_off_graph(i+2,j,1)==0&&SLC_off_graph(i+2,j,2)==0&&SLC_off_graph(i+2,j,3)==0;%down row stripe      
        if b1<=B1||b4>=B4
            if r2||((r5||r1)&&(r22||r23||r33||r34))
                tiaodai_location_graph(i,j)=0;
            end
        elseif b1>B1&&b2<=B2
            if r2||r5||r1
                tiaodai_location_graph(i,j)=0;            
            end             
        elseif b3>=B3&&b4<B4
            if r2||red||orange
                tiaodai_location_graph(i,j)=0;            
            end
        end

 end
end

se=strel('disk',2);
%tiaodai_location_graph=imdilate(tiaodai_location_graph,se);
%tiaodai_location_graph=imerode(tiaodai_location_graph,se);
tiaodai_location_graph=imerode(tiaodai_location_graph,se);
tiaodai_location_graph=imdilate(tiaodai_location_graph,se);

