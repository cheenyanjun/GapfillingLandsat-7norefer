function varargout = recover20201005(varargin)
% RECOVER20201005 M-file for recover20201005.fig
%      RECOVER20201005, by itself, creates a new RECOVER20201005 or raises the existing
%      singleton*.
%
%      H = RECOVER20201005 returns the handle to a new RECOVER20201005 or the handle to
%      the existing singleton*.
%
%      RECOVER20201005('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOVER20201005.M with the given input arguments.
%
%      RECOVER20201005('Property','Value',...) creates a new RECOVER20201005 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before recover20201005_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to recover20201005_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help recover20201005

% Last Modified by GUIDE v2.5 05-Oct-2020 19:55:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @recover20201005_OpeningFcn, ...
                   'gui_OutputFcn',  @recover20201005_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before recover20201005 is made visible.
function recover20201005_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recover20201005 (see VARARGIN)

% Choose default command line output for recover20201005
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes recover20201005 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = recover20201005_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.show)
[fn,pn]=uigetfile('*.bmp','Please check the image to be recovered!');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Recover the stripe graph by chosing the most prominent pixels in the least 
%Linear Fitting slope randomly direction 
%上下边界随机各取两点，中间部位三次样条曲线插值后，在参与计算的六个点中，选最接近的点填充
%%%%%%%%SLC_off_graph is a map to be recovered.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SLC_off_graph = imread([pn,fn]);%('C:\Users\Cyjun\Desktop\伊捷202006052012有条带\2012_color.bmp');
%SLC_off_graph=SLC_off_graph(1:240,1:5433,:);
%SLC_off_graph_original = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\矫正的扎龙地图和带条带的7654321\fangzhen2_original.bmp');
[fn,pn]=uigetfile('*.jpg','Please check the unsupervised image!');
%tiaodai_location_graph
%=SLC_off_graph(:,:,1);
%%%%%%Unsupervised_classes = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\矫正的扎龙地图和带条带的7654321\fangzhen_Kmean_unsupervise_classes.bmp');
Unsupervised_classes = imread([pn,fn]);('C:\Users\Cyjun\Desktop\伊捷202006052012有条带\2012_color_unsupervised.bmp');
%SLC_off_graph_original = SLC_off_graph;
%Unsupervised_classes = Unsupervised_classes(1:240,1:5433,:);
SIZEOFIMAGE=size(SLC_off_graph);
%tiaodai_location_graph = imread('C:\Users\Cyjun\Desktop\矫正前后相同尺寸base和warp\矫正的扎龙地图和带条带的7654321\tiaodai_location_graph.bmp');
ss=size(SIZEOFIMAGE);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
[ tiaodai_location_graph ] = tiaodai_location_graph_produce_yijie( SLC_off_graph );

SLC_off_recovered_color=SLC_off_graph;
SLC_off_recovered=double(SLC_off_graph);%%%%%%%%条带像素已恢复的图
SLC_off_graph=rgb2gray(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
%得到每个像素的上下边界,垂直像素斜率，垂直平均灰度。
[ UP_boundary DOWN_boundary ] = UP_DOWN_boundary( tiaodai_location_graph );
[K_Vertical regress_n_v]=KK_Vertical_regress( SLC_off_graph, UP_boundary, DOWN_boundary );
[ AVERAGE_gray_Vertical ] = AAVERAGE_gray_Vertical( SLC_off_graph, UP_boundary,DOWN_boundary );
%得到每个像素的左上右下边界坐标，右斜线像素斜率，右斜线平均灰度
[ LEFTUP_boundary_I LEFTUP_boundary_J RIGHTDOWN_boundary_I RIGHTDOWN_boundary_J] = LEFTUP_RIGHTDOWN_boundary( tiaodai_location_graph );
[ K_Rightline regress_n_r]=KK_Rightline_regress( SLC_off_graph, LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J );
[ AVERAGE_gray_Rightline ] = AAVERAGE_gray_Rightline( SLC_off_graph, LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J );
%得到每个像素的右上左下边界坐标，左斜线像素斜率，左斜线平均灰度
[ RIGHTUP_boundary_I RIGHTUP_boundary_J LEFTDOWN_boundary_I LEFTDOWN_boundary_J ] = RIGHTUP_LEFTDOWN_boundary( tiaodai_location_graph );%得到每个像素的右上左下边界
[ K_Leftline regress_n_l]=KK_Leftline_regress( SLC_off_graph, RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J );
[ AVERAGE_gray_Leftline ] = AAVERAGE_gray_Leftline( SLC_off_graph, RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J );
%得到图像上各点（包括条带点）的平均灰度，计算平均灰度时条带像素灰度不参与计算
regress_n=regress_n_v+regress_n_r+regress_n_l;
tiaodai_pixel_numbers=0;
[ Average_gray_local ] = AAverage_gray_local( SLC_off_graph );
Average_gray_local=double(Average_gray_local);
%由于斜率有负值，所以都变成绝对值
K_Vertical=abs(K_Vertical);
K_Leftline=abs(K_Leftline);
K_Rightline=abs(K_Rightline);
[ Is_gap_in_the_middle ] = IIs_gap_in_the_middle( UP_boundary,DOWN_boundary,M,N );
%判断上下边界是否是同一分类
[ class_difference_situation ] = class_difference( Unsupervised_classes,UP_boundary,DOWN_boundary,LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J,RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J);

for i= 1 : M
    for j = 1 : N
 %i=18,j=73,
        if tiaodai_location_graph(i,j)==0&&(UP_boundary(i,j)- DOWN_boundary(i,j)<54)&&(LEFTUP_boundary_I(i,j)-RIGHTDOWN_boundary_I(i,j)<54)&&(RIGHTUP_boundary_I(i,j)-LEFTDOWN_boundary_I(i,j)<50)%待恢复图像(i,j)为条带上点
         tiaodai_pixel_numbers=tiaodai_pixel_numbers+1;
         %%%%%%%%%下面一段将来似乎可以删掉，虽然他们目前看很重要
            if class_difference_situation(i,j)==12
                KKK=[K_Vertical(i,j),K_Rightline(i,j)];
            elseif class_difference_situation(i,j)==13
                KKK=[K_Vertical(i,j),K_Leftline(i,j)];
            elseif class_difference_situation(i,j)==23
                KKK=[K_Rightline(i,j),K_Leftline(i,j)];
            elseif class_difference_situation(i,j)==1
                KKK=K_Vertical(i,j);
            elseif class_difference_situation(i,j)==3
                KKK=K_Leftline(i,j);
            elseif class_difference_situation(i,j)==2
                KKK=K_Rightline(i,j);
            else
             KKK=[K_Vertical(i,j),K_Rightline(i,j),K_Leftline(i,j)];
            end

            MIN_K = min(KKK);%MIN_K是斜率最小的方向判断斜率K_Vertical,斜率K_Rightline,斜率K_Leftline大小，
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            %%根据12,13,23,1,2,3，其他分别处理
            %%12时，垂直和右斜线方向条带两侧为同类，则选择两者中斜率最小的方向为填充方向，进行填充            
            %%13时，垂直和左斜线方向条带两侧为同类，则选择两者中斜率最小的方向为填充方向，进行填充            
            %%12时，左斜线和右斜线方向条带两侧为同类，则选择两者中斜率最小的方向为填充方向，进行填充            
            %%1时，垂直方向条带两侧为同类，则选择该方向为填充方向，进行填充            
            %%2时，右斜线方向条带两侧为同类，则选择该方向为填充方向，进行填充             
            %%3时，左斜线方向条带两侧为同类，则选择该方向为填充方向，进行填充
            %%其他情况下，比较三个斜率方向大小，
                 %%如果垂直方向斜率最小，则在垂直方向进行填充
                 %%如果右斜线方向斜率最小，则在右斜线方向进行填充
                 %%如果左斜线方向斜率最小，则在左斜线方向进行填充
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            %%12时，垂直和右斜线方向条带两侧为同类，则选择两者中斜率最小的方向为填充方向，进行填充
            if class_difference_situation(i,j)==12
                KKK=[K_Vertical(i,j),K_Rightline(i,j)];
                MIN_K = min(KKK);%MIN_K是斜率K_Vertical和斜率K_Rightline中斜率最小的方向。
                if K_Vertical(i,j)==MIN_K%%垂直方向斜率最小
                    %%则在垂直方向上进行像素的填充
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if UP_boundary(i,j)-3>0&&DOWN_boundary(i,j)+3<=M
                            UP_three_x=[ UP_boundary(i,j)-3,UP_boundary(i,j)-2,UP_boundary(i,j)-1 ];
                            Down_three_x=[ DOWN_boundary(i,j)+1,DOWN_boundary(i,j)+2,DOWN_boundary(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(UP_boundary(i,j)-3,j),SLC_off_graph(UP_boundary(i,j)-2,j),SLC_off_graph(UP_boundary(i,j)-1,j)];
                            Down_three_y=[SLC_off_graph(DOWN_boundary(i,j)+1,j),SLC_off_graph(DOWN_boundary(i,j)+2,j),SLC_off_graph(DOWN_boundary(i,j)+3,j)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                temp=2;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                temp=3;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                temp=4;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                temp=5;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                temp=6;
                            end
                         %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-3,j,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-2,j,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-1,j,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+1,j,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+2,j,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+3,j,:);
                                otherwise
                            end
                        end                
                    else
                        if DOWN_boundary(i,j)>0&&UP_boundary(i,j)>0&&DOWN_boundary(i,j)<=M&&UP_boundary(i,j)<=M
                            local_gap_number=DOWN_boundary(i,j)-UP_boundary(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %中间点从条带下面随机选取像素值填充
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
                    
                else%%右斜线方向斜率最小
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if LEFTUP_boundary_I(i,j)-3>0&&RIGHTDOWN_boundary_I(i,j)+3<=M&&RIGHTDOWN_boundary_J(i,j)+3<=N&&LEFTUP_boundary_J(i,j)-3>0
                            UP_three_x=[ LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_I(i,j)-1 ];
                            Down_three_x=[ DOWN_boundary(i,j)+1,DOWN_boundary(i,j)+2,DOWN_boundary(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_J(i,j)-3),SLC_off_graph(LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_J(i,j)-2),SLC_off_graph(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1)];
                            Down_three_y=[SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1),SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+2,RIGHTDOWN_boundary_J(i,j)+2),SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+3,RIGHTDOWN_boundary_J(i,j)+3)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                temp=2;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                temp=3;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                temp=4;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                temp=5;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                temp=6;
                            end
                    %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_J(i,j)-3,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_J(i,j)-2,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+2,RIGHTDOWN_boundary_J(i,j)+2,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+3,RIGHTDOWN_boundary_J(i,j)+3,:);
                                otherwise
                            end
                        end      
                    else
                            if RIGHTDOWN_boundary_I(i,j)>0&&LEFTUP_boundary_I(i,j)>0&&...
                                RIGHTDOWN_boundary_I(i,j)<=M&&LEFTUP_boundary_I(i,j)<=M&&...
                                    RIGHTDOWN_boundary_J(i,j)>0&&LEFTUP_boundary_J(i,j)>0&&...
                                        RIGHTDOWN_boundary_J(i,j)<=N&&LEFTUP_boundary_J(i,j)<=N
                                %随机填充右斜线方向像素%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                                SUIJISHU=round(rand(1,1))+1;
                                if LEFTUP_boundary_I(i,j)-SUIJISHU>2&&LEFTUP_boundary_J(i,j)-SUIJISHU>2&&...
                                    i<LEFTUP_boundary_I(i,j)+right 
                                        if tiaodai_location_graph(LEFTUP_boundary_I(i,j)-SUIJISHU,LEFTUP_boundary_J(i,j)-SUIJISHU)==0
                                            SUIJISHU=SUIJISHU-1; 
                                            if SUIJISHU<1
                                                SUIJISHU=SUIJISHU+2;
                                            end
                                        end
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-SUIJISHU,LEFTUP_boundary_J(i,j)-SUIJISHU,:);
                                end
                        %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %中间点从条带下面随机选取像素值填充
                                    if tiaodai_location_graph(RIGHTDOWN_boundary_I(i,j)+SUIJISHU,RIGHTDOWN_boundary_J(i,j)+SUIJISHU)==0
                                        SUIJISHU=SUIJISHU+2; 
                                        if SUIJISHU>M
                                            SUIJISHU=SUIJISHU-2;
                                        end
                                    end
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+SUIJISHU,RIGHTDOWN_boundary_J(i,j)+SUIJISHU,:);
                                end
                            end   
                    end
                end
            elseif class_difference_situation(i,j)==13
                KKK=[K_Vertical(i,j),K_Leftline(i,j)];
                MIN_K = min(KKK);%MIN_K是斜率K_Vertical和斜率K_Rightline中斜率最小的方向。
                if K_Vertical(i,j)==MIN_K%%垂直方向斜率最小
                    %%则在垂直方向上进行像素的填充
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if UP_boundary(i,j)-3>0&&DOWN_boundary(i,j)+3<=M
                            UP_three_x=[ UP_boundary(i,j)-3,UP_boundary(i,j)-2,UP_boundary(i,j)-1 ];
                            Down_three_x=[ DOWN_boundary(i,j)+1,DOWN_boundary(i,j)+2,DOWN_boundary(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(UP_boundary(i,j)-3,j),SLC_off_graph(UP_boundary(i,j)-2,j),SLC_off_graph(UP_boundary(i,j)-1,j)];
                            Down_three_y=[SLC_off_graph(DOWN_boundary(i,j)+1,j),SLC_off_graph(DOWN_boundary(i,j)+2,j),SLC_off_graph(DOWN_boundary(i,j)+3,j)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                temp=2;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                temp=3;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                temp=4;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                temp=5;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                temp=6;
                            end
                         %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-3,j,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-2,j,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-1,j,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+1,j,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+2,j,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+3,j,:);
                                otherwise
                            end
                        end                
                    else
                        if DOWN_boundary(i,j)>0&&UP_boundary(i,j)>0&&DOWN_boundary(i,j)<=M&&UP_boundary(i,j)<=M
                            local_gap_number=DOWN_boundary(i,j)-UP_boundary(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %中间点从条带下面随机选取像素值填充
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
                    
                else%%左斜线方向斜率最小
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if RIGHTUP_boundary_I(i,j)-3>0&&LEFTDOWN_boundary_I(i,j)+3<=M&&RIGHTUP_boundary_J(i,j)+3<=N&&LEFTDOWN_boundary_J(i,j)-3>0
                            UP_three_x=[ RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_I(i,j)-1 ];
                            Down_three_x=[ LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_I(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_J(i,j)+3),SLC_off_graph(RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_J(i,j)+2),SLC_off_graph(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1)];
                            Down_three_y=[SLC_off_graph(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1),SLC_off_graph(LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_J(i,j)-2),SLC_off_graph(LEFTDOWN_boundary_I(i,j)+3,LEFTDOWN_boundary_J(i,j)-3)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                                elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                    temp=2;
                                elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                    temp=3;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                    temp=4;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                    temp=5;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                    temp=6;
                            end
                            %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_J(i,j)+3,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_J(i,j)+2,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_J(i,j)-2,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+3,LEFTDOWN_boundary_J(i,j)-3,:);
                                otherwise
                            end
                        end     
                    else
                        if LEFTDOWN_boundary_I(i,j)>0&&RIGHTUP_boundary_I(i,j)>0&&...
                            LEFTDOWN_boundary_I(i,j)<=M&&RIGHTUP_boundary_I(i,j)<=M&&...
                                LEFTDOWN_boundary_J(i,j)>0&&RIGHTUP_boundary_J(i,j)>0&&...
                                    LEFTDOWN_boundary_J(i,j)<=N&&RIGHTUP_boundary_J(i,j)<=N
                            %随机填充左斜线方向像素%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %中间点从条带下面随机选取像素值填充
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
                end
            elseif class_difference_situation(i,j)==23
                KKK=[K_Rightline(i,j),K_Leftline(i,j)];
                MIN_K = min(KKK);%MIN_K是斜率K_Vertical和斜率K_Rightline中斜率最小的方向。
                if  MIN_K ==K_Rightline(i,j)%%%右斜线方向斜率最小
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if LEFTUP_boundary_I(i,j)-3>0&&RIGHTDOWN_boundary_I(i,j)+3<=M&&RIGHTDOWN_boundary_J(i,j)+3<=N&&LEFTUP_boundary_J(i,j)-3>0
                            UP_three_x=[ LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_I(i,j)-1 ];
                            Down_three_x=[ DOWN_boundary(i,j)+1,DOWN_boundary(i,j)+2,DOWN_boundary(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_J(i,j)-3),SLC_off_graph(LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_J(i,j)-2),SLC_off_graph(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1)];
                            Down_three_y=[SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1),SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+2,RIGHTDOWN_boundary_J(i,j)+2),SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+3,RIGHTDOWN_boundary_J(i,j)+3)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                temp=2;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                temp=3;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                temp=4;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                temp=5;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                temp=6;
                            end
                    %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_J(i,j)-3,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_J(i,j)-2,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+2,RIGHTDOWN_boundary_J(i,j)+2,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+3,RIGHTDOWN_boundary_J(i,j)+3,:);
                                otherwise
                            end
                        end      
                    else
                            if RIGHTDOWN_boundary_I(i,j)>0&&LEFTUP_boundary_I(i,j)>0&&...
                                RIGHTDOWN_boundary_I(i,j)<=M&&LEFTUP_boundary_I(i,j)<=M&&...
                                    RIGHTDOWN_boundary_J(i,j)>0&&LEFTUP_boundary_J(i,j)>0&&...
                                        RIGHTDOWN_boundary_J(i,j)<=N&&LEFTUP_boundary_J(i,j)<=N
                                %随机填充右斜线方向像素%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                                SUIJISHU=round(rand(1,1))+1;
                                if LEFTUP_boundary_I(i,j)-SUIJISHU>2&&LEFTUP_boundary_J(i,j)-SUIJISHU>2&&...
                                    i<LEFTUP_boundary_I(i,j)+right 
                                        if tiaodai_location_graph(LEFTUP_boundary_I(i,j)-SUIJISHU,LEFTUP_boundary_J(i,j)-SUIJISHU)==0
                                            SUIJISHU=SUIJISHU-1; 
                                            if SUIJISHU<1
                                                SUIJISHU=SUIJISHU+2;
                                            end
                                        end
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-SUIJISHU,LEFTUP_boundary_J(i,j)-SUIJISHU,:);
                                end
                        %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %中间点从条带下面随机选取像素值填充
                                    if tiaodai_location_graph(RIGHTDOWN_boundary_I(i,j)+SUIJISHU,RIGHTDOWN_boundary_J(i,j)+SUIJISHU)==0
                                        SUIJISHU=SUIJISHU+2; 
                                        if SUIJISHU>M
                                            SUIJISHU=SUIJISHU-2;
                                        end
                                    end
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+SUIJISHU,RIGHTDOWN_boundary_J(i,j)+SUIJISHU,:);
                                end
                            end   
                    end
                else%%左斜线方向斜率最小
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if RIGHTUP_boundary_I(i,j)-3>0&&LEFTDOWN_boundary_I(i,j)+3<=M&&RIGHTUP_boundary_J(i,j)+3<=N&&LEFTDOWN_boundary_J(i,j)-3>0
                            UP_three_x=[ RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_I(i,j)-1 ];
                            Down_three_x=[ LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_I(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_J(i,j)+3),SLC_off_graph(RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_J(i,j)+2),SLC_off_graph(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1)];
                            Down_three_y=[SLC_off_graph(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1),SLC_off_graph(LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_J(i,j)-2),SLC_off_graph(LEFTDOWN_boundary_I(i,j)+3,LEFTDOWN_boundary_J(i,j)-3)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                                elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                    temp=2;
                                elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                    temp=3;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                    temp=4;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                    temp=5;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                    temp=6;
                            end
                            %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_J(i,j)+3,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_J(i,j)+2,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_J(i,j)-2,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+3,LEFTDOWN_boundary_J(i,j)-3,:);
                                otherwise
                            end
                        end     
                    else
                        if LEFTDOWN_boundary_I(i,j)>0&&RIGHTUP_boundary_I(i,j)>0&&...
                            LEFTDOWN_boundary_I(i,j)<=M&&RIGHTUP_boundary_I(i,j)<=M&&...
                                LEFTDOWN_boundary_J(i,j)>0&&RIGHTUP_boundary_J(i,j)>0&&...
                                    LEFTDOWN_boundary_J(i,j)<=N&&RIGHTUP_boundary_J(i,j)<=N
                            %随机填充左斜线方向像素%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %中间点从条带下面随机选取像素值填充
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
                end
            elseif class_difference_situation(i,j)==1
                KKK=K_Vertical(i,j);
                %%则在垂直方向上进行像素的填充
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if UP_boundary(i,j)-3>0&&DOWN_boundary(i,j)+3<=M
                            UP_three_x=[ UP_boundary(i,j)-3,UP_boundary(i,j)-2,UP_boundary(i,j)-1 ];
                            Down_three_x=[ DOWN_boundary(i,j)+1,DOWN_boundary(i,j)+2,DOWN_boundary(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(UP_boundary(i,j)-3,j),SLC_off_graph(UP_boundary(i,j)-2,j),SLC_off_graph(UP_boundary(i,j)-1,j)];
                            Down_three_y=[SLC_off_graph(DOWN_boundary(i,j)+1,j),SLC_off_graph(DOWN_boundary(i,j)+2,j),SLC_off_graph(DOWN_boundary(i,j)+3,j)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                temp=2;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                temp=3;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                temp=4;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                temp=5;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                temp=6;
                            end
                         %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-3,j,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-2,j,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-1,j,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+1,j,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+2,j,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+3,j,:);
                                otherwise
                            end
                        end                
                    else
                        if DOWN_boundary(i,j)>0&&UP_boundary(i,j)>0&&DOWN_boundary(i,j)<=M&&UP_boundary(i,j)<=M
                            local_gap_number=DOWN_boundary(i,j)-UP_boundary(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %中间点从条带下面随机选取像素值填充
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
            elseif class_difference_situation(i,j)==3
                KKK=K_Leftline(i,j);
                %%左斜线方向斜率最小
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if RIGHTUP_boundary_I(i,j)-3>0&&LEFTDOWN_boundary_I(i,j)+3<=M&&RIGHTUP_boundary_J(i,j)+3<=N&&LEFTDOWN_boundary_J(i,j)-3>0
                            UP_three_x=[ RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_I(i,j)-1 ];
                            Down_three_x=[ LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_I(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_J(i,j)+3),SLC_off_graph(RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_J(i,j)+2),SLC_off_graph(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1)];
                            Down_three_y=[SLC_off_graph(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1),SLC_off_graph(LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_J(i,j)-2),SLC_off_graph(LEFTDOWN_boundary_I(i,j)+3,LEFTDOWN_boundary_J(i,j)-3)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                                elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                    temp=2;
                                elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                    temp=3;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                    temp=4;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                    temp=5;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                    temp=6;
                            end
                            %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_J(i,j)+3,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_J(i,j)+2,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_J(i,j)-2,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+3,LEFTDOWN_boundary_J(i,j)-3,:);
                                otherwise
                            end
                        end     
                    else
                        if LEFTDOWN_boundary_I(i,j)>0&&RIGHTUP_boundary_I(i,j)>0&&...
                            LEFTDOWN_boundary_I(i,j)<=M&&RIGHTUP_boundary_I(i,j)<=M&&...
                                LEFTDOWN_boundary_J(i,j)>0&&RIGHTUP_boundary_J(i,j)>0&&...
                                    LEFTDOWN_boundary_J(i,j)<=N&&RIGHTUP_boundary_J(i,j)<=N
                            %随机填充左斜线方向像素%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %中间点从条带下面随机选取像素值填充
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
            elseif class_difference_situation(i,j)==2
                KKK=K_Rightline(i,j);
                %%右斜线方向斜率最小
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if LEFTUP_boundary_I(i,j)-3>0&&RIGHTDOWN_boundary_I(i,j)+3<=M&&RIGHTDOWN_boundary_J(i,j)+3<=N&&LEFTUP_boundary_J(i,j)-3>0
                            UP_three_x=[ LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_I(i,j)-1 ];
                            Down_three_x=[ DOWN_boundary(i,j)+1,DOWN_boundary(i,j)+2,DOWN_boundary(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_J(i,j)-3),SLC_off_graph(LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_J(i,j)-2),SLC_off_graph(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1)];
                            Down_three_y=[SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1),SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+2,RIGHTDOWN_boundary_J(i,j)+2),SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+3,RIGHTDOWN_boundary_J(i,j)+3)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                temp=2;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                temp=3;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                temp=4;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                temp=5;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                temp=6;
                            end
                    %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_J(i,j)-3,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_J(i,j)-2,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+2,RIGHTDOWN_boundary_J(i,j)+2,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+3,RIGHTDOWN_boundary_J(i,j)+3,:);
                                otherwise
                            end
                        end      
                    else
                            if RIGHTDOWN_boundary_I(i,j)>0&&LEFTUP_boundary_I(i,j)>0&&...
                                RIGHTDOWN_boundary_I(i,j)<=M&&LEFTUP_boundary_I(i,j)<=M&&...
                                    RIGHTDOWN_boundary_J(i,j)>0&&LEFTUP_boundary_J(i,j)>0&&...
                                        RIGHTDOWN_boundary_J(i,j)<=N&&LEFTUP_boundary_J(i,j)<=N
                                %随机填充右斜线方向像素%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                                SUIJISHU=round(rand(1,1))+1;
                                if LEFTUP_boundary_I(i,j)-SUIJISHU>2&&LEFTUP_boundary_J(i,j)-SUIJISHU>2&&...
                                    i<LEFTUP_boundary_I(i,j)+right 
                                        if tiaodai_location_graph(LEFTUP_boundary_I(i,j)-SUIJISHU,LEFTUP_boundary_J(i,j)-SUIJISHU)==0
                                            SUIJISHU=SUIJISHU-1; 
                                            if SUIJISHU<1
                                                SUIJISHU=SUIJISHU+2;
                                            end
                                        end
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-SUIJISHU,LEFTUP_boundary_J(i,j)-SUIJISHU,:);
                                end
                        %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %中间点从条带下面随机选取像素值填充
                                    if tiaodai_location_graph(RIGHTDOWN_boundary_I(i,j)+SUIJISHU,RIGHTDOWN_boundary_J(i,j)+SUIJISHU)==0
                                        SUIJISHU=SUIJISHU+2; 
                                        if SUIJISHU>M
                                            SUIJISHU=SUIJISHU-2;
                                        end
                                    end
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+SUIJISHU,RIGHTDOWN_boundary_J(i,j)+SUIJISHU,:);
                                end
                            end   
                    end
            else
             KKK=[K_Vertical(i,j),K_Rightline(i,j),K_Leftline(i,j)];
             MIN_K = min(KKK);
             if MIN_K==K_Vertical(i,j)%垂直方向填充
                 %%则在垂直方向上进行像素的填充
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if UP_boundary(i,j)-3>0&&DOWN_boundary(i,j)+3<=M
                            UP_three_x=[ UP_boundary(i,j)-3,UP_boundary(i,j)-2,UP_boundary(i,j)-1 ];
                            Down_three_x=[ DOWN_boundary(i,j)+1,DOWN_boundary(i,j)+2,DOWN_boundary(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(UP_boundary(i,j)-3,j),SLC_off_graph(UP_boundary(i,j)-2,j),SLC_off_graph(UP_boundary(i,j)-1,j)];
                            Down_three_y=[SLC_off_graph(DOWN_boundary(i,j)+1,j),SLC_off_graph(DOWN_boundary(i,j)+2,j),SLC_off_graph(DOWN_boundary(i,j)+3,j)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                temp=2;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                temp=3;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                temp=4;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                temp=5;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                temp=6;
                            end
                         %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-3,j,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-2,j,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-1,j,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+1,j,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+2,j,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+3,j,:);
                                otherwise
                            end
                        end                
                    else
                        if DOWN_boundary(i,j)>0&&UP_boundary(i,j)>0&&DOWN_boundary(i,j)<=M&&UP_boundary(i,j)<=M
                            local_gap_number=DOWN_boundary(i,j)-UP_boundary(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %中间点从条带下面随机选取像素值填充
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end
             elseif MIN_K==K_Rightline(i,j)%右斜线方向填充
                 %%右斜线方向斜率最小
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if LEFTUP_boundary_I(i,j)-3>0&&RIGHTDOWN_boundary_I(i,j)+3<=M&&RIGHTDOWN_boundary_J(i,j)+3<=N&&LEFTUP_boundary_J(i,j)-3>0
                            UP_three_x=[ LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_I(i,j)-1 ];
                            Down_three_x=[ DOWN_boundary(i,j)+1,DOWN_boundary(i,j)+2,DOWN_boundary(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_J(i,j)-3),SLC_off_graph(LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_J(i,j)-2),SLC_off_graph(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1)];
                            Down_three_y=[SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1),SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+2,RIGHTDOWN_boundary_J(i,j)+2),SLC_off_graph(RIGHTDOWN_boundary_I(i,j)+3,RIGHTDOWN_boundary_J(i,j)+3)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                temp=2;
                            elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                temp=3;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                temp=4;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                temp=5;
                            elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                temp=6;
                            end
                    %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-3,LEFTUP_boundary_J(i,j)-3,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-2,LEFTUP_boundary_J(i,j)-2,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-1,LEFTUP_boundary_J(i,j)-1,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+1,RIGHTDOWN_boundary_J(i,j)+1,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+2,RIGHTDOWN_boundary_J(i,j)+2,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+3,RIGHTDOWN_boundary_J(i,j)+3,:);
                                otherwise
                            end
                        end      
                    else
                            if RIGHTDOWN_boundary_I(i,j)>0&&LEFTUP_boundary_I(i,j)>0&&...
                                RIGHTDOWN_boundary_I(i,j)<=M&&LEFTUP_boundary_I(i,j)<=M&&...
                                    RIGHTDOWN_boundary_J(i,j)>0&&LEFTUP_boundary_J(i,j)>0&&...
                                        RIGHTDOWN_boundary_J(i,j)<=N&&LEFTUP_boundary_J(i,j)<=N
                                %随机填充右斜线方向像素%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                                SUIJISHU=round(rand(1,1))+1;
                                if LEFTUP_boundary_I(i,j)-SUIJISHU>2&&LEFTUP_boundary_J(i,j)-SUIJISHU>2&&...
                                    i<LEFTUP_boundary_I(i,j)+right 
                                        if tiaodai_location_graph(LEFTUP_boundary_I(i,j)-SUIJISHU,LEFTUP_boundary_J(i,j)-SUIJISHU)==0
                                            SUIJISHU=SUIJISHU-1; 
                                            if SUIJISHU<1
                                                SUIJISHU=SUIJISHU+2;
                                            end
                                        end
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTUP_boundary_I(i,j)-SUIJISHU,LEFTUP_boundary_J(i,j)-SUIJISHU,:);
                                end
                        %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M-3&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N-3&&i>=LEFTUP_boundary_I(i,j)+right
                                    %中间点从条带下面随机选取像素值填充
                                    if tiaodai_location_graph(RIGHTDOWN_boundary_I(i,j)+SUIJISHU,RIGHTDOWN_boundary_J(i,j)+SUIJISHU)==0
                                        SUIJISHU=SUIJISHU+2; 
                                        if SUIJISHU>M
                                            SUIJISHU=SUIJISHU-2;
                                        end
                                    end
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTDOWN_boundary_I(i,j)+SUIJISHU,RIGHTDOWN_boundary_J(i,j)+SUIJISHU,:);
                                end
                            end   
                    end
             else%左斜线方向填充
                 %%左斜线方向斜率最小
                    if Is_gap_in_the_middle(i,j)==1%若待恢复图像点(i,j)为条带中间缝隙上点
                        if RIGHTUP_boundary_I(i,j)-3>0&&LEFTDOWN_boundary_I(i,j)+3<=M&&RIGHTUP_boundary_J(i,j)+3<=N&&LEFTDOWN_boundary_J(i,j)-3>0
                            UP_three_x=[ RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_I(i,j)-1 ];
                            Down_three_x=[ LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_I(i,j)+3 ];
                            UP_three_y=[ SLC_off_graph(RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_J(i,j)+3),SLC_off_graph(RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_J(i,j)+2),SLC_off_graph(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1)];
                            Down_three_y=[SLC_off_graph(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1),SLC_off_graph(LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_J(i,j)-2),SLC_off_graph(LEFTDOWN_boundary_I(i,j)+3,LEFTDOWN_boundary_J(i,j)-3)];
                            gap_x=i;
                            [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x );
                            six_pixels_value=[ UP_three_y Down_three_y ];
                            [ first_two ] = whose_value_closer( Chazhi,six_pixels_value );
                            suijishu=round(rand(1,1))+1;
                            temp=0;
                            if first_two(1,suijishu)==abs(UP_three_y(1,1)-Chazhi)
                                temp=1;
                                elseif first_two(1,suijishu)==abs(UP_three_y(1,2)-Chazhi)
                                    temp=2;
                                elseif first_two(1,suijishu)==abs(UP_three_y(1,3)-Chazhi)
                                    temp=3;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,1)-Chazhi)
                                    temp=4;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,2)-Chazhi)
                                    temp=5;
                                elseif first_two(1,suijishu)==abs(Down_three_y(1,3)-Chazhi)
                                    temp=6;
                            end
                            %下面注释代码适用于彩色图像
                            switch temp
                                case 1
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-3,RIGHTUP_boundary_J(i,j)+3,:);
                                case 2
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-2,RIGHTUP_boundary_J(i,j)+2,:);
                                case 3
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-1,RIGHTUP_boundary_J(i,j)+1,:);                                
                                case 4
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+1,LEFTDOWN_boundary_J(i,j)-1,:);
                                case 5
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+2,LEFTDOWN_boundary_J(i,j)-2,:);
                                case 6
                                    SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+3,LEFTDOWN_boundary_J(i,j)-3,:);
                                otherwise
                            end
                        end     
                    else
                        if LEFTDOWN_boundary_I(i,j)>0&&RIGHTUP_boundary_I(i,j)>0&&...
                            LEFTDOWN_boundary_I(i,j)<=M&&RIGHTUP_boundary_I(i,j)<=M&&...
                                LEFTDOWN_boundary_J(i,j)>0&&RIGHTUP_boundary_J(i,j)>0&&...
                                    LEFTDOWN_boundary_J(i,j)<=N&&RIGHTUP_boundary_J(i,j)<=N
                            %随机填充左斜线方向像素%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)位于条带中部以上，若条带奇数宽不包括中间点
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)位于条带中部以下，若条带奇数宽包括中间点                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %中间点从条带下面随机选取像素值填充
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
             end
            end
        end
    end
end
SLC_off_recovered=uint8(SLC_off_recovered);
SLC_off_recovered_color=SLC_off_recovered;
threshold_magnitude=0.1;
[ SLC_off_graph_Max_Min_filt ] = my_medfilt( SLC_off_recovered_color,tiaodai_location_graph,threshold_magnitude );
imshow(SLC_off_graph_Max_Min_filt);title('SLC OFF GRAPH RECOVED FLTERED') ;
%figure;imshow(SLC_off_graph_original);title('SLC OFF GRAPH ORIGINAL') ;


% --------------------------------------------------------------------
function f1_Callback(hObject, eventdata, handles)
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
