function varargout = recover20201005_export(varargin)
% RECOVER20201005_EXPORT M-file for recover20201005_export.fig
%      RECOVER20201005_EXPORT, by itself, creates a new RECOVER20201005_EXPORT or raises the existing
%      singleton*.
%
%      H = RECOVER20201005_EXPORT returns the handle to a new RECOVER20201005_EXPORT or the handle to
%      the existing singleton*.
%
%      RECOVER20201005_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOVER20201005_EXPORT.M with the given input arguments.
%
%      RECOVER20201005_EXPORT('Property','Value',...) creates a new RECOVER20201005_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before recover20201005_export_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to recover20201005_export_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help recover20201005_export

% Last Modified by GUIDE v2.5 05-Oct-2020 20:08:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @recover20201005_export_OpeningFcn, ...
                   'gui_OutputFcn',  @recover20201005_export_OutputFcn, ...
                   'gui_LayoutFcn',  @recover20201005_export_LayoutFcn, ...
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


% --- Executes just before recover20201005_export is made visible.
function recover20201005_export_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recover20201005_export (see VARARGIN)

% Choose default command line output for recover20201005_export
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes recover20201005_export wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = recover20201005_export_OutputFcn(hObject, eventdata, handles) 
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
[fn,pn]=uigetfile('*.jpg','Please check the image to be recovered!');

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


% --- Creates and returns a handle to the GUI figure. 
function h1 = recover20201005_export_LayoutFcn(policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

appdata = [];
appdata.GUIDEOptions = struct(...
    'active_h', [], ...
    'taginfo', struct(...
    'figure', 2, ...
    'pushbutton', 2, ...
    'axes', 2), ...
    'override', 1, ...
    'release', 13, ...
    'resize', 'simple', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0, ...
    'lastSavedFile', 'C:\Users\Cyjun\Documents\MATLAB\recover20201005_export.m', ...
    'lastFilename', 'C:\Users\Cyjun\Documents\MATLAB\recover20201005.fig');
appdata.lastValidTag = 'figure1';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'figure1');

h1 = figure(...
'Units','characters',...
'PaperUnits',get(0,'defaultfigurePaperUnits'),...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','recover20201005',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'PaperSize',[20.98404194812 29.67743169791],...
'PaperType',get(0,'defaultfigurePaperType'),...
'Position',[103.833333333333 29.125 112 32.3125],...
'HandleVisibility','callback',...
'Tag','figure1',...
'UserData',[],...
'Visible','on',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'pushbutton1';

h2 = uicontrol(...
'Parent',h1,...
'Units','normalized',...
'Callback',@(hObject,eventdata)recover20201005_export('pushbutton1_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[0.0714285714285714 0.938104448742747 0.150297619047619 0.0599613152804642],...
'String',{  'Push Button' },...
'Tag','pushbutton1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'show';

h3 = axes(...
'Parent',h1,...
'Position',[-0.00148809523809524 -0.00193423597678917 0.994047619047619 0.928433268858801],...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'LooseInset',[0.125697841726619 0.112613861386139 0.0918561151079137 0.0767821782178218],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'Tag','show',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.SerializedAnnotationV7 = struct(...
    'LegendInformation', struct(...
    'IconDisplayStyle', 'on'));

h4 = get(h3,'title');

set(h4,...
'Parent',h3,...
'Units','data',...
'FontUnits','points',...
'BackgroundColor','none',...
'Color',[0 0 0],...
'DisplayName',blanks(0),...
'EdgeColor','none',...
'EraseMode','normal',...
'DVIMode','auto',...
'FontAngle','normal',...
'FontName','Helvetica',...
'FontSize',10,...
'FontWeight','normal',...
'HorizontalAlignment','center',...
'LineStyle','-',...
'LineWidth',0.5,...
'Margin',2,...
'Position',[0.499251497005988 1.01354166666667 1.00005459937205],...
'Rotation',0,...
'String',blanks(0),...
'Interpreter','tex',...
'VerticalAlignment','bottom',...
'ButtonDownFcn',[],...
'CreateFcn', {@local_CreateFcn, [], appdata} ,...
'DeleteFcn',[],...
'BusyAction','queue',...
'HandleVisibility','off',...
'HelpTopicKey',blanks(0),...
'HitTest','on',...
'Interruptible','on',...
'SelectionHighlight','on',...
'Serializable','on',...
'Tag',blanks(0),...
'UserData',[],...
'Visible','on',...
'XLimInclude','on',...
'YLimInclude','on',...
'ZLimInclude','on',...
'CLimInclude','on',...
'ALimInclude','on',...
'IncludeRenderer','on',...
'Clipping','off');

appdata = [];
appdata.SerializedAnnotationV7 = struct(...
    'LegendInformation', struct(...
    'IconDisplayStyle', 'on'));

h5 = get(h3,'xlabel');

set(h5,...
'Parent',h3,...
'Units','data',...
'FontUnits','points',...
'BackgroundColor','none',...
'Color',[0 0 0],...
'DisplayName',blanks(0),...
'EdgeColor','none',...
'EraseMode','normal',...
'DVIMode','auto',...
'FontAngle','normal',...
'FontName','Helvetica',...
'FontSize',10,...
'FontWeight','normal',...
'HorizontalAlignment','center',...
'LineStyle','-',...
'LineWidth',0.5,...
'Margin',2,...
'Position',[0.499251497005988 -0.0489583333333334 1.00005459937205],...
'Rotation',0,...
'String',blanks(0),...
'Interpreter','tex',...
'VerticalAlignment','cap',...
'ButtonDownFcn',[],...
'CreateFcn', {@local_CreateFcn, [], appdata} ,...
'DeleteFcn',[],...
'BusyAction','queue',...
'HandleVisibility','off',...
'HelpTopicKey',blanks(0),...
'HitTest','on',...
'Interruptible','on',...
'SelectionHighlight','on',...
'Serializable','on',...
'Tag',blanks(0),...
'UserData',[],...
'Visible','on',...
'XLimInclude','on',...
'YLimInclude','on',...
'ZLimInclude','on',...
'CLimInclude','on',...
'ALimInclude','on',...
'IncludeRenderer','on',...
'Clipping','off');

appdata = [];
appdata.SerializedAnnotationV7 = struct(...
    'LegendInformation', struct(...
    'IconDisplayStyle', 'on'));

h6 = get(h3,'ylabel');

set(h6,...
'Parent',h3,...
'Units','data',...
'FontUnits','points',...
'BackgroundColor','none',...
'Color',[0 0 0],...
'DisplayName',blanks(0),...
'EdgeColor','none',...
'EraseMode','normal',...
'DVIMode','auto',...
'FontAngle','normal',...
'FontName','Helvetica',...
'FontSize',10,...
'FontWeight','normal',...
'HorizontalAlignment','center',...
'LineStyle','-',...
'LineWidth',0.5,...
'Margin',2,...
'Position',[-0.0426646706586826 0.496875 1.00005459937205],...
'Rotation',90,...
'String',blanks(0),...
'Interpreter','tex',...
'VerticalAlignment','bottom',...
'ButtonDownFcn',[],...
'CreateFcn', {@local_CreateFcn, [], appdata} ,...
'DeleteFcn',[],...
'BusyAction','queue',...
'HandleVisibility','off',...
'HelpTopicKey',blanks(0),...
'HitTest','on',...
'Interruptible','on',...
'SelectionHighlight','on',...
'Serializable','on',...
'Tag',blanks(0),...
'UserData',[],...
'Visible','on',...
'XLimInclude','on',...
'YLimInclude','on',...
'ZLimInclude','on',...
'CLimInclude','on',...
'ALimInclude','on',...
'IncludeRenderer','on',...
'Clipping','off');

appdata = [];
appdata.SerializedAnnotationV7 = struct(...
    'LegendInformation', struct(...
    'IconDisplayStyle', 'on'));

h7 = get(h3,'zlabel');

set(h7,...
'Parent',h3,...
'Units','data',...
'FontUnits','points',...
'BackgroundColor','none',...
'Color',[0 0 0],...
'DisplayName',blanks(0),...
'EdgeColor','none',...
'EraseMode','normal',...
'DVIMode','auto',...
'FontAngle','normal',...
'FontName','Helvetica',...
'FontSize',10,...
'FontWeight','normal',...
'HorizontalAlignment','right',...
'LineStyle','-',...
'LineWidth',0.5,...
'Margin',2,...
'Position',[0.000748502994011976 1.07604166666667 1.00005459937205],...
'Rotation',0,...
'String',blanks(0),...
'Interpreter','tex',...
'VerticalAlignment','middle',...
'ButtonDownFcn',[],...
'CreateFcn', {@local_CreateFcn, [], appdata} ,...
'DeleteFcn',[],...
'BusyAction','queue',...
'HandleVisibility','off',...
'HelpTopicKey',blanks(0),...
'HitTest','on',...
'Interruptible','on',...
'SelectionHighlight','on',...
'Serializable','on',...
'Tag',blanks(0),...
'UserData',[],...
'Visible','off',...
'XLimInclude','on',...
'YLimInclude','on',...
'ZLimInclude','on',...
'CLimInclude','on',...
'ALimInclude','on',...
'IncludeRenderer','on',...
'Clipping','off');

appdata = [];
appdata.lastValidTag = 'f1';

h8 = uimenu(...
'Parent',h1,...
'Callback',@(hObject,eventdata)recover20201005_export('f1_Callback',hObject,eventdata,guidata(hObject)),...
'Label','file',...
'Tag','f1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );


hsingleton = h1;


% --- Set application data first then calling the CreateFcn. 
function local_CreateFcn(hObject, eventdata, createfcn, appdata)

if ~isempty(appdata)
   names = fieldnames(appdata);
   for i=1:length(names)
       name = char(names(i));
       setappdata(hObject, name, getfield(appdata,name));
   end
end

if ~isempty(createfcn)
   if isa(createfcn,'function_handle')
       createfcn(hObject, eventdata);
   else
       eval(createfcn);
   end
end


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)

gui_StateFields =  {'gui_Name'
    'gui_Singleton'
    'gui_OpeningFcn'
    'gui_OutputFcn'
    'gui_LayoutFcn'
    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error('MATLAB:gui_mainfcn:FieldNotFound', 'Could not find field %s in the gui_State struct in GUI M-file %s', gui_StateFields{i}, gui_Mfile);
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [gui_State.(gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
    % RECOVER20201005_EXPORT
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % RECOVER20201005_EXPORT(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallbak(gui_State, varargin{:})
    % RECOVER20201005_EXPORT('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % RECOVER20201005_EXPORT(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = true;
end

if ~gui_Create
    % In design time, we need to mark all components possibly created in
    % the coming callback evaluation as non-serializable. This way, they
    % will not be brought into GUIDE and not be saved in the figure file
    % when running/saving the GUI from GUIDE.
    designEval = false;
    if (numargin>1 && ishghandle(varargin{2}))
        fig = varargin{2};
        while ~isempty(fig) && ~isa(handle(fig),'figure')
            fig = get(fig,'parent');
        end
        
        designEval = isappdata(0,'CreatingGUIDEFigure') || isprop(fig,'__GUIDEFigure');
    end
        
    if designEval
        beforeChildren = findall(fig);
    end
    
    % evaluate the callback now
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else       
        feval(varargin{:});
    end
    
    % Set serializable of objects created in the above callback to off in
    % design time. Need to check whether figure handle is still valid in
    % case the figure is deleted during the callback dispatching.
    if designEval && ishandle(fig)
        set(setdiff(findall(fig),beforeChildren), 'Serializable','off');
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end

    % Check user passing 'visible' P/V pair first so that its value can be
    % used by oepnfig to prevent flickering
    gui_Visible = 'auto';
    gui_VisibleInput = '';
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        % Recognize 'visible' P/V pair
        len1 = min(length('visible'),length(varargin{index}));
        len2 = min(length('off'),length(varargin{index+1}));
        if ischar(varargin{index+1}) && strncmpi(varargin{index},'visible',len1) && len2 > 1
            if strncmpi(varargin{index+1},'off',len2)
                gui_Visible = 'invisible';
                gui_VisibleInput = 'off';
            elseif strncmpi(varargin{index+1},'on',len2)
                gui_Visible = 'visible';
                gui_VisibleInput = 'on';
            end
        end
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.

    
    % Do feval on layout code in m-file if it exists
    gui_Exported = ~isempty(gui_State.gui_LayoutFcn);
    % this application data is used to indicate the running mode of a GUIDE
    % GUI to distinguish it from the design mode of the GUI in GUIDE. it is
    % only used by actxproxy at this time.   
    setappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]),1);
    if gui_Exported
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);

        % make figure invisible here so that the visibility of figure is
        % consistent in OpeningFcn in the exported GUI case
        if isempty(gui_VisibleInput)
            gui_VisibleInput = get(gui_hFigure,'Visible');
        end
        set(gui_hFigure,'Visible','off')

        % openfig (called by local_openfig below) does this for guis without
        % the LayoutFcn. Be sure to do it here so guis show up on screen.
        movegui(gui_hFigure,'onscreen');
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        end
    end
    if isappdata(0, genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]))
        rmappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]));
    end

    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);

    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    % Singleton setting in the GUI M-file takes priority if different
    gui_Options.singleton = gui_State.gui_Singleton;

    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA. If there is
        % user set GUI data already, keep that also.
        data = guidata(gui_hFigure);
        handles = guihandles(gui_hFigure);
        if ~isempty(handles)
            if isempty(data)
                data = handles;
            else
                names = fieldnames(handles);
                for k=1:length(names)
                    data.(char(names(k)))=handles.(char(names(k)));
                end
            end
        end
        guidata(gui_hFigure, data);
    end

    % Apply input P/V pairs other than 'visible'
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        len1 = min(length('visible'),length(varargin{index}));
        if ~strncmpi(varargin{index},'visible',len1)
            try set(gui_hFigure, varargin{index}, varargin{index+1}), catch break, end
        end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end

    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});

    if isscalar(gui_hFigure) && ishandle(gui_hFigure)
        % Handle the default callbacks of predefined toolbar tools in this
        % GUI, if any
        guidemfile('restoreToolbarToolPredefinedCallback',gui_hFigure); 
        
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);

        % Call openfig again to pick up the saved visibility or apply the
        % one passed in from the P/V pairs
        if ~gui_Exported
            gui_hFigure = local_openfig(gui_State.gui_Name, 'reuse',gui_Visible);
        elseif ~isempty(gui_VisibleInput)
            set(gui_hFigure,'Visible',gui_VisibleInput);
        end
        if strcmpi(get(gui_hFigure, 'Visible'), 'on')
            figure(gui_hFigure);
            
            if gui_Options.singleton
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        if isappdata(gui_hFigure,'InGUIInitialization')
            rmappdata(gui_hFigure,'InGUIInitialization');
        end

        % If handle visibility is set to 'callback', turn it on until
        % finished with OutputFcn
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end

    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end

    if isscalar(gui_hFigure) && ishandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end

function gui_hFigure = local_openfig(name, singleton, visible)

% openfig with three arguments was new from R13. Try to call that first, if
% failed, try the old openfig.
if nargin('openfig') == 2
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = openfig(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
else
    gui_hFigure = openfig(name, singleton, visible);
end

function result = local_isInvokeActiveXCallback(gui_State, varargin)

try
    result = ispc && iscom(varargin{1}) ...
             && isequal(varargin{1},gcbo);
catch
    result = false;
end

function result = local_isInvokeHGCallbak(gui_State, varargin)

try
    fhandle = functions(gui_State.gui_Callback);
    result = ~isempty(findstr(gui_State.gui_Name,fhandle.file)) || ...
             (ischar(varargin{1}) ...
             && isequal(ishandle(varargin{2}), 1) ...
             && (~isempty(strfind(varargin{1},[get(varargin{2}, 'Tag'), '_'])) || ...
                ~isempty(strfind(varargin{1}, '_CreateFcn'))) );
catch
    result = false;
end


