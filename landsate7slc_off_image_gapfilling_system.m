function varargout = landsate7slc_off_image_gapfilling_system(varargin)
% LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM M-file for landsate7slc_off_image_gapfilling_system.fig
%      LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM, by itself, creates a new LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM or raises the existing
%      singleton*.
%
%      H = LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM returns the handle to a new LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM or the handle to
%      the existing singleton*.
%
%      LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM.M with the given input arguments.
%
%      LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM('Property','Value',...) creates a new LANDSATE7SLC_OFF_IMAGE_GAPFILLING_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before landsate7slc_off_image_gapfilling_system_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to landsate7slc_off_image_gapfilling_system_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help landsate7slc_off_image_gapfilling_system

% Last Modified by GUIDE v2.5 07-Oct-2020 15:34:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @landsate7slc_off_image_gapfilling_system_OpeningFcn, ...
                   'gui_OutputFcn',  @landsate7slc_off_image_gapfilling_system_OutputFcn, ...
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


% --- Executes just before landsate7slc_off_image_gapfilling_system is made visible.
function landsate7slc_off_image_gapfilling_system_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to landsate7slc_off_image_gapfilling_system (see VARARGIN)

% Choose default command line output for landsate7slc_off_image_gapfilling_system
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes landsate7slc_off_image_gapfilling_system wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = landsate7slc_off_image_gapfilling_system_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc Unsupervised_classes;%����ȫ�ֱ���
[file,path]=uigetfile({'*.bmp';'*.jpg';'*.tif'},'ѡ��ԭʼͼ��');%,'ѡ��ͼƬ'
str=[path,file];%�ϲ�·����ͼ���ļ���
im=imread(str);%��ͼ
ss=size(im);
if ss(1,3)==3
    im1=rgb2gray(im);
else
    im1=im;
end
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im_proc Unsupervised_classes;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);


tic;                                % tic;��toc;���ʹ���ܹ����س�������ʱ��

h=waitbar(0,'ͼ��Ԥ�������Ժ�');

%text(0.5,0.5,'���ż����ȱ�ˮ','FontSize',8);
%[fn,pn]=uigetfile({'*.bmp';'*.jpg';'*.tif'},'Please check the image to be recovered!');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Recover the stripe graph by chosing the most prominent pixels in the least 
%Linear Fitting slope randomly direction 
%���±߽������ȡ���㣬�м䲿λ�����������߲�ֵ���ڲ��������������У�ѡ��ӽ��ĵ����
%%%%%%%%SLC_off_graph is a map to be recovered.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SLC_off_graph = im;%('C:\Users\Cyjun\Desktop\����202006052012������\2012_color.bmp');
%SLC_off_graph=SLC_off_graph(1:240,1:5433,:);
%SLC_off_graph_original = imread('C:\Users\Cyjun\Desktop\����ǰ����ͬ�ߴ�base��warp\������������ͼ�ʹ�������7654321\fangzhen2_original.bmp');
%[fn,pn]=uigetfile('*.bmp','������ENVI�Ǽල����ͼ��!');
%tiaodai_location_graph
%=SLC_off_graph(:,:,1);
%%%%%%Unsupervised_classes = imread('C:\Users\Cyjun\Desktop\����ǰ����ͬ�ߴ�base��warp\������������ͼ�ʹ�������7654321\fangzhen_Kmean_unsupervise_classes.bmp');
%Unsupervised_classes = imread([pn,fn]);('C:\Users\Cyjun\Desktop\����202006052012������\2012_color_unsupervised.bmp');
%SLC_off_graph_original = SLC_off_graph;
%Unsupervised_classes = Unsupervised_classes(1:240,1:5433,:);
SIZEOFIMAGE=size(SLC_off_graph);
%tiaodai_location_graph = imread('C:\Users\Cyjun\Desktop\����ǰ����ͬ�ߴ�base��warp\������������ͼ�ʹ�������7654321\tiaodai_location_graph.bmp');
%ss=size(SIZEOFIMAGE);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
[ tiaodai_location_graph ] = tiaodai_location_graph_produce_zhalong( SLC_off_graph );
str=['ͼ��Ԥ�������Ժ�',num2str(10),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.1,h,str);
SLC_off_recovered_color=SLC_off_graph;
SLC_off_recovered=double(SLC_off_graph);%%%%%%%%���������ѻָ���ͼ
SLC_off_graph=rgb2gray(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
%�õ�ÿ�����ص����±߽�,��ֱ����б�ʣ���ֱƽ���Ҷȡ�
[ UP_boundary DOWN_boundary ] = UP_DOWN_boundary( tiaodai_location_graph );
[K_Vertical regress_n_v]=KK_Vertical_regress( SLC_off_graph, UP_boundary, DOWN_boundary );
%[ AVERAGE_gray_Vertical ] = AAVERAGE_gray_Vertical( SLC_off_graph, UP_boundary,DOWN_boundary );
%�õ�ÿ�����ص��������±߽����꣬��б������б�ʣ���б��ƽ���Ҷ�
str=['ͼ��Ԥ�������Ժ�',num2str(20),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.2,h,str);


[ LEFTUP_boundary_I LEFTUP_boundary_J RIGHTDOWN_boundary_I RIGHTDOWN_boundary_J] = LEFTUP_RIGHTDOWN_boundary( tiaodai_location_graph );

str=['ͼ��Ԥ�������Ժ�',num2str(30),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.3,h,str);

[ K_Rightline regress_n_r]=KK_Rightline_regress( SLC_off_graph, LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J );
%[ AVERAGE_gray_Rightline ] = AAVERAGE_gray_Rightline( SLC_off_graph, LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J );
%�õ�ÿ�����ص��������±߽����꣬��б������б�ʣ���б��ƽ���Ҷ�

str=['ͼ��Ԥ�������Ժ�',num2str(40),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.4,h,str);
[ RIGHTUP_boundary_I RIGHTUP_boundary_J LEFTDOWN_boundary_I LEFTDOWN_boundary_J ] = RIGHTUP_LEFTDOWN_boundary( tiaodai_location_graph );%�õ�ÿ�����ص��������±߽�

str=['ͼ��Ԥ�������Ժ�',num2str(50),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.5,h,str);
    
[ K_Leftline regress_n_l]=KK_Leftline_regress( SLC_off_graph, RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J );
%[ AVERAGE_gray_Leftline ] = AAVERAGE_gray_Leftline( SLC_off_graph, RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J );
%�õ�ͼ���ϸ��㣨���������㣩��ƽ���Ҷȣ�����ƽ���Ҷ�ʱ�������ػҶȲ��������
%regress_n=regress_n_v+regress_n_r+regress_n_l;
tiaodai_pixel_numbers=0;
%[ Average_gray_local ] = AAverage_gray_local( SLC_off_graph );
%Average_gray_local=double(Average_gray_local);
%����б���и�ֵ�����Զ���ɾ���ֵ

str=['ͼ��Ԥ�������Ժ�',num2str(60),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.6,h,str);
K_Vertical=abs(K_Vertical);
K_Leftline=abs(K_Leftline);

str=['ͼ��Ԥ�������Ժ�',num2str(70),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.7,h,str);
    
K_Rightline=abs(K_Rightline);


str=['ͼ��Ԥ�������Ժ�',num2str(80),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.8,h,str);
[ Is_gap_in_the_middle ] = IIs_gap_in_the_middle( UP_boundary,DOWN_boundary,M,N );
%�ж����±߽��Ƿ���ͬһ����
str=['ͼ��Ԥ�������Ժ�',num2str(90),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.9,h,str);
[ class_difference_situation ] = class_difference( Unsupervised_classes,UP_boundary,DOWN_boundary,LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J,RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J);
str=['ͼ��Ԥ�������Ժ�',num2str(95),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.95,h,str);

close(h);
bar = waitbar(0,'���ڼ�����...');    % waitbar��ʾ������
for i= 3 : M-3
    for j = 3 : N-3
        if tiaodai_location_graph(i,j)==0&&(UP_boundary(i,j)- DOWN_boundary(i,j)<54)&&(LEFTUP_boundary_I(i,j)-RIGHTDOWN_boundary_I(i,j)<54)&&(RIGHTUP_boundary_I(i,j)-LEFTDOWN_boundary_I(i,j)<50)%���ָ�ͼ��(i,j)Ϊ�����ϵ�
         tiaodai_pixel_numbers=tiaodai_pixel_numbers+1;
         %%%%%%%%%����һ�ν����ƺ�����ɾ������Ȼ����Ŀǰ������Ҫ
           % if class_difference_situation(i,j)==12
            %    KKK=[K_Vertical(i,j),K_Rightline(i,j)];
            %elseif class_difference_situation(i,j)==13
            %    KKK=[K_Vertical(i,j),K_Leftline(i,j)];
            %elseif class_difference_situation(i,j)==23
            %    KKK=[K_Rightline(i,j),K_Leftline(i,j)];
            %elseif class_difference_situation(i,j)==1
            %    KKK=K_Vertical(i,j);
            %elseif class_difference_situation(i,j)==3
            %    KKK=K_Leftline(i,j);
            %elseif class_difference_situation(i,j)==2
            %    KKK=K_Rightline(i,j);
            %else
            % KKK=[K_Vertical(i,j),K_Rightline(i,j),K_Leftline(i,j)];
            %end

            %MIN_K = min(KKK);%MIN_K��б����С�ķ����ж�б��K_Vertical,б��K_Rightline,б��K_Leftline��С��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            %%����12,13,23,1,2,3�������ֱ���
            %%12ʱ����ֱ����б�߷�����������Ϊͬ�࣬��ѡ��������б����С�ķ���Ϊ��䷽�򣬽������            
            %%13ʱ����ֱ����б�߷�����������Ϊͬ�࣬��ѡ��������б����С�ķ���Ϊ��䷽�򣬽������            
            %%12ʱ����б�ߺ���б�߷�����������Ϊͬ�࣬��ѡ��������б����С�ķ���Ϊ��䷽�򣬽������            
            %%1ʱ����ֱ������������Ϊͬ�࣬��ѡ��÷���Ϊ��䷽�򣬽������            
            %%2ʱ����б�߷�����������Ϊͬ�࣬��ѡ��÷���Ϊ��䷽�򣬽������             
            %%3ʱ����б�߷�����������Ϊͬ�࣬��ѡ��÷���Ϊ��䷽�򣬽������
            %%��������£��Ƚ�����б�ʷ����С��
                 %%�����ֱ����б����С�����ڴ�ֱ����������
                 %%�����б�߷���б����С��������б�߷���������
                 %%�����б�߷���б����С��������б�߷���������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            %%12ʱ����ֱ����б�߷�����������Ϊͬ�࣬��ѡ��������б����С�ķ���Ϊ��䷽�򣬽������
            if class_difference_situation(i,j)==12
                KKK=[K_Vertical(i,j),K_Rightline(i,j)];
                MIN_K = min(KKK);%MIN_K��б��K_Vertical��б��K_Rightline��б����С�ķ���
                if K_Vertical(i,j)==MIN_K%%��ֱ����б����С
                    %%���ڴ�ֱ�����Ͻ������ص����
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                         %����ע�ʹ��������ڲ�ɫͼ��
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
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
                    
                else%%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                    %����ע�ʹ��������ڲ�ɫͼ��
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
                                %��������б�߷�������%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)λ�������в����ϣ������������������м��
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
                        %%%(i,j)λ�������в����£�����������������м��                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %�м��������������ѡȡ����ֵ���
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
                MIN_K = min(KKK);%MIN_K��б��K_Vertical��б��K_Rightline��б����С�ķ���
                if K_Vertical(i,j)==MIN_K%%��ֱ����б����С
                    %%���ڴ�ֱ�����Ͻ������ص����
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                         %����ע�ʹ��������ڲ�ɫͼ��
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
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
                    
                else%%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                            %����ע�ʹ��������ڲ�ɫͼ��
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
                            %��������б�߷�������%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
                end
            elseif class_difference_situation(i,j)==23
                KKK=[K_Rightline(i,j),K_Leftline(i,j)];
                MIN_K = min(KKK);%MIN_K��б��K_Vertical��б��K_Rightline��б����С�ķ���
                if  MIN_K ==K_Rightline(i,j)%%%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                    %����ע�ʹ��������ڲ�ɫͼ��
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
                                %��������б�߷�������%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)λ�������в����ϣ������������������м��
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
                        %%%(i,j)λ�������в����£�����������������м��                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %�м��������������ѡȡ����ֵ���
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
                else%%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                            %����ע�ʹ��������ڲ�ɫͼ��
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
                            %��������б�߷�������%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
                end
            elseif class_difference_situation(i,j)==1
                KKK=K_Vertical(i,j);
                %%���ڴ�ֱ�����Ͻ������ص����
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                         %����ע�ʹ��������ڲ�ɫͼ��
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
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
            elseif class_difference_situation(i,j)==3
                KKK=K_Leftline(i,j);
                %%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                            %����ע�ʹ��������ڲ�ɫͼ��
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
                            %��������б�߷�������%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
            elseif class_difference_situation(i,j)==2
                KKK=K_Rightline(i,j);
                %%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                    %����ע�ʹ��������ڲ�ɫͼ��
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
                                %��������б�߷�������%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)λ�������в����ϣ������������������м��
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
                        %%%(i,j)λ�������в����£�����������������м��                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %�м��������������ѡȡ����ֵ���
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
             if MIN_K==K_Vertical(i,j)%��ֱ�������
                 %%���ڴ�ֱ�����Ͻ������ص����
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                         %����ע�ʹ��������ڲ�ɫͼ��
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
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end
             elseif MIN_K==K_Rightline(i,j)%��б�߷������
                 %%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                    %����ע�ʹ��������ڲ�ɫͼ��
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
                                %��������б�߷�������%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)λ�������в����ϣ������������������м��
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
                        %%%(i,j)λ�������в����£�����������������м��                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M-3&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N-3&&i>=LEFTUP_boundary_I(i,j)+right
                                    %�м��������������ѡȡ����ֵ���
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
             else%��б�߷������
                 %%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                            %����ע�ʹ��������ڲ�ɫͼ��
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
                            %��������б�߷�������%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
             end
            end
        end

        
    end
    str=['ȥ�������������...',num2str(100*i/M),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(i/M,bar,str)
       
        
end
close(bar);
axes(handles.axes2);
SLC_off_recovered=uint8(SLC_off_recovered);
SLC_off_recovered_color=SLC_off_recovered;
threshold_magnitude=0.1;
[ SLC_off_graph_Max_Min_filt ] = my_medfilt( SLC_off_recovered_color,tiaodai_location_graph,threshold_magnitude );
imshow(SLC_off_graph_Max_Min_filt);%title('SLC OFF GRAPH RECOVED FLTERED') ;
im_proc=SLC_off_graph_Max_Min_filt;

toc;
%figure;imshow(SLC_off_graph_original);title('SLC OFF GRAPH ORIGINAL') ;



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc,clear,close all%�˳�ϵͳ

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
fun=get(handles.popupmenu1,'value');%��ȡ����ʽ�˵�1��ֵ
%im=rgb2gray(im);
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
switch fun
    case 1
        im_proc=imcrop();%�����ü�ͼ��
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��
    case 2           
        
        im_proc=imresize(im1,0.5);%ͼ����Сһ��
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��
    case 3  
        
        im_proc=imresize(im1,2,'bilinear');%ͼ��Ŵ�һ��
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��
    case 4
                
        im_proc=fliplr(im1);%ͼ��������ת
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��        
    case 5
                
        im_proc=flipud(im1);%ͼ��������ת
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��        
    case 6
                
        im_proc=rot90(im1);%ͼ����ʱ����ת90��
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��
    case 7
                
        im_proc=rot90(im1,-1);%ͼ��˳ʱ����ת90��
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��
end



% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

fun=get(handles.popupmenu2,'value');%��ȡ����ʽ�˵�1��ֵ
switch fun
    case 1
        im_proc=imnoise(im1,'salt & pepper',0.02);%��ӽ�������
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��
    case 2        
        im_proc=imnoise(im1,'gaussian',0.02);%��Ӹ�˹����
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��
    case 3        
        im_proc=imnoise(im1,'speckle',0.02);%��Ӱߵ�����
        axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc);%��ʾ������ͼ��    
end

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
global im im1 im_proc;


fun=get(handles.popupmenu3,'value');%��ȡ����ʽ�˵�1��ֵ
switch fun
    case 1
        im_proc1=imnoise(im1,'salt & pepper',0.02);%��ӽ�������
        axes(handles.axes1);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc1);%��ʾ������ͼ��
        im_proc=filter2(fspecial('average',3),im_proc1)/255;%3*3����ƽ���˲�
        axes(handles.axes2);
        imshow(im_proc);
    case 2        
        im_proc1=imnoise(im1,'salt & pepper',0.02);%��ӽ�������
        axes(handles.axes1);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc1);%��ʾ������ͼ��
        im_proc=medfilt2(im_proc1);%��ֵ�˲�
        axes(handles.axes2);
        imshow(im_proc);
    case 3        
        im_proc1=imnoise(im1,'gaussian',0.02);%��ӽ�������
        axes(handles.axes1);%�ڵڶ�����ϵ�»�ͼ
        imshow(im_proc1);%��ʾ������ͼ��
        im_proc=wiener2(im_proc1,[5,5]);%5*5����ά���˲�
        axes(handles.axes2);
        imshow(im_proc);
end


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

fun=get(handles.popupmenu4,'value');%��ȡ����ʽ�˵�1��ֵ
switch fun
    case 1
        im_proc=edge(im1,'roberts',0.04);%ʹ��Robert����
        axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
        imshow(im);%��ʾԭʼͼ��
        axes(handles.axes2);
        imshow(im_proc);
        im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���
    case 2        
        im_proc=edge(im1,'sobel');%ʹ��Sobel����
        axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
        imshow(im);%��ʾԭʼͼ��
        axes(handles.axes2);
        imshow(im_proc);
        im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���
    case 3        
        im_proc=edge(im1,'prewitt');%ʹ��Prewitt����
        axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
        imshow(im);%��ʾԭʼͼ��
        axes(handles.axes2);
        imshow(im_proc);
        im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���
    case 4
        im_proc=edge(im1,'log');%ʹ��LoG����
        axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
        imshow(im);%��ʾԭʼͼ��
        axes(handles.axes2);
        imshow(im_proc);
        im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���
    case 5
        im_proc=edge(im1,'canny');%ʹ��Canny����
        axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
        imshow(im);%��ʾԭʼͼ��
        axes(handles.axes2);
        imshow(im_proc);
        im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���
end

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im_proc Unsupervised_classes;%����ȫ�ֱ���
axes(handles.axes1);%������ϵ1�ϻ�ͼ
imshow(Unsupervised_classes);


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im_proc);

% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc Unsupervised_classes;%����ȫ�ֱ���
[file,path]=uigetfile({'*.bmp';'*.jpg';'*.tif'},'ѡ��ԭʼͼ��');%,'ѡ��ͼƬ'
str=[path,file];%�ϲ�·����ͼ���ļ���
im=imread(str);%��ͼ
ss=size(im);
if ss(1,3)==3
    im1=rgb2gray(im);
else
    im1=im;
end
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fn,pn]=uigetfile('*.bmp','������ENVI�Ǽල����ͼ��!');
Unsupervised_classes = imread([pn,fn]);%('C:\Users\Cyjun\Desktop\����202006052012������\2012_color_unsupervised.bmp');
axes(handles.axes1);%������ϵ1�ϻ�ͼ
imshow(Unsupervised_classes);


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_proc;
[path]=uigetdir('','����ȥ����������ͼ��');
imwrite(im_proc,strcat(path,'\','recovered_image.bmp'),'bmp');


% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im_proc Unsupervised_classes;%����ȫ�ֱ���
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_17_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im_proc Unsupervised_classes;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);


tic;                                % tic;��toc;���ʹ���ܹ����س�������ʱ��

h=waitbar(0,'ͼ��Ԥ�������Ժ�');

%text(0.5,0.5,'���ż����ȱ�ˮ','FontSize',8);
%[fn,pn]=uigetfile({'*.bmp';'*.jpg';'*.tif'},'Please check the image to be recovered!');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Recover the stripe graph by chosing the most prominent pixels in the least 
%Linear Fitting slope randomly direction 
%���±߽������ȡ���㣬�м䲿λ�����������߲�ֵ���ڲ��������������У�ѡ��ӽ��ĵ����
%%%%%%%%SLC_off_graph is a map to be recovered.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SLC_off_graph = im;%('C:\Users\Cyjun\Desktop\����202006052012������\2012_color.bmp');
%SLC_off_graph=SLC_off_graph(1:240,1:5433,:);
%SLC_off_graph_original = imread('C:\Users\Cyjun\Desktop\����ǰ����ͬ�ߴ�base��warp\������������ͼ�ʹ�������7654321\fangzhen2_original.bmp');
%[fn,pn]=uigetfile('*.bmp','������ENVI�Ǽල����ͼ��!');
%tiaodai_location_graph
%=SLC_off_graph(:,:,1);
%%%%%%Unsupervised_classes = imread('C:\Users\Cyjun\Desktop\����ǰ����ͬ�ߴ�base��warp\������������ͼ�ʹ�������7654321\fangzhen_Kmean_unsupervise_classes.bmp');
%Unsupervised_classes = imread([pn,fn]);('C:\Users\Cyjun\Desktop\����202006052012������\2012_color_unsupervised.bmp');
%SLC_off_graph_original = SLC_off_graph;
%Unsupervised_classes = Unsupervised_classes(1:240,1:5433,:);
SIZEOFIMAGE=size(SLC_off_graph);
%tiaodai_location_graph = imread('C:\Users\Cyjun\Desktop\����ǰ����ͬ�ߴ�base��warp\������������ͼ�ʹ�������7654321\tiaodai_location_graph.bmp');
%ss=size(SIZEOFIMAGE);
M=SIZEOFIMAGE(1,1);
N=SIZEOFIMAGE(1,2);
[ tiaodai_location_graph ] = tiaodai_location_graph_produce_zhalong( SLC_off_graph );
str=['ͼ��Ԥ�������Ժ�',num2str(10),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.1,h,str);
SLC_off_recovered_color=SLC_off_graph;
SLC_off_recovered=double(SLC_off_graph);%%%%%%%%���������ѻָ���ͼ
SLC_off_graph=rgb2gray(SLC_off_graph);
SLC_off_graph=double(SLC_off_graph);
%�õ�ÿ�����ص����±߽�,��ֱ����б�ʣ���ֱƽ���Ҷȡ�
[ UP_boundary DOWN_boundary ] = UP_DOWN_boundary( tiaodai_location_graph );
[K_Vertical regress_n_v]=KK_Vertical_regress( SLC_off_graph, UP_boundary, DOWN_boundary );
%[ AVERAGE_gray_Vertical ] = AAVERAGE_gray_Vertical( SLC_off_graph, UP_boundary,DOWN_boundary );
%�õ�ÿ�����ص��������±߽����꣬��б������б�ʣ���б��ƽ���Ҷ�
str=['ͼ��Ԥ�������Ժ�',num2str(20),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.2,h,str);


[ LEFTUP_boundary_I LEFTUP_boundary_J RIGHTDOWN_boundary_I RIGHTDOWN_boundary_J] = LEFTUP_RIGHTDOWN_boundary( tiaodai_location_graph );

str=['ͼ��Ԥ�������Ժ�',num2str(30),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.3,h,str);

[ K_Rightline regress_n_r]=KK_Rightline_regress( SLC_off_graph, LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J );
%[ AVERAGE_gray_Rightline ] = AAVERAGE_gray_Rightline( SLC_off_graph, LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J );
%�õ�ÿ�����ص��������±߽����꣬��б������б�ʣ���б��ƽ���Ҷ�

str=['ͼ��Ԥ�������Ժ�',num2str(40),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.4,h,str);
[ RIGHTUP_boundary_I RIGHTUP_boundary_J LEFTDOWN_boundary_I LEFTDOWN_boundary_J ] = RIGHTUP_LEFTDOWN_boundary( tiaodai_location_graph );%�õ�ÿ�����ص��������±߽�

str=['ͼ��Ԥ�������Ժ�',num2str(50),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.5,h,str);
    
[ K_Leftline regress_n_l]=KK_Leftline_regress( SLC_off_graph, RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J );
%[ AVERAGE_gray_Leftline ] = AAVERAGE_gray_Leftline( SLC_off_graph, RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J );
%�õ�ͼ���ϸ��㣨���������㣩��ƽ���Ҷȣ�����ƽ���Ҷ�ʱ�������ػҶȲ��������
%regress_n=regress_n_v+regress_n_r+regress_n_l;
tiaodai_pixel_numbers=0;
%[ Average_gray_local ] = AAverage_gray_local( SLC_off_graph );
%Average_gray_local=double(Average_gray_local);
%����б���и�ֵ�����Զ���ɾ���ֵ

str=['ͼ��Ԥ�������Ժ�',num2str(60),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.6,h,str);
K_Vertical=abs(K_Vertical);
K_Leftline=abs(K_Leftline);

str=['ͼ��Ԥ�������Ժ�',num2str(70),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.7,h,str);
    
K_Rightline=abs(K_Rightline);


str=['ͼ��Ԥ�������Ժ�',num2str(80),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.8,h,str);
[ Is_gap_in_the_middle ] = IIs_gap_in_the_middle( UP_boundary,DOWN_boundary,M,N );
%�ж����±߽��Ƿ���ͬһ����
str=['ͼ��Ԥ�������Ժ�',num2str(90),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.9,h,str);
[ class_difference_situation ] = class_difference( Unsupervised_classes,UP_boundary,DOWN_boundary,LEFTUP_boundary_I,LEFTUP_boundary_J,RIGHTDOWN_boundary_I,RIGHTDOWN_boundary_J,RIGHTUP_boundary_I,RIGHTUP_boundary_J,LEFTDOWN_boundary_I,LEFTDOWN_boundary_J);
str=['ͼ��Ԥ�������Ժ�',num2str(95),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(0.95,h,str);

close(h);
bar = waitbar(0,'���ڼ�����...');    % waitbar��ʾ������
for i= 1 : M
    
    for j = 1 : N
 %i=18,j=73,
                              % ���½�����bar�����barʹ��
        if tiaodai_location_graph(i,j)==0&&(UP_boundary(i,j)- DOWN_boundary(i,j)<54)&&(LEFTUP_boundary_I(i,j)-RIGHTDOWN_boundary_I(i,j)<54)&&(RIGHTUP_boundary_I(i,j)-LEFTDOWN_boundary_I(i,j)<50)%���ָ�ͼ��(i,j)Ϊ�����ϵ�
         tiaodai_pixel_numbers=tiaodai_pixel_numbers+1;
         %%%%%%%%%����һ�ν����ƺ�����ɾ������Ȼ����Ŀǰ������Ҫ
            %if class_difference_situation(i,j)==12
            %    KKK=[K_Vertical(i,j),K_Rightline(i,j)];
            %elseif class_difference_situation(i,j)==13
            %    KKK=[K_Vertical(i,j),K_Leftline(i,j)];
            %elseif class_difference_situation(i,j)==23
            %    KKK=[K_Rightline(i,j),K_Leftline(i,j)];
            %elseif class_difference_situation(i,j)==1
            %    KKK=K_Vertical(i,j);
            %elseif class_difference_situation(i,j)==3
            %    KKK=K_Leftline(i,j);
            %elseif class_difference_situation(i,j)==2
            %    KKK=K_Rightline(i,j);
            %else
            % KKK=[K_Vertical(i,j),K_Rightline(i,j),K_Leftline(i,j)];
            %end

            %MIN_K = min(KKK);%MIN_K��б����С�ķ����ж�б��K_Vertical,б��K_Rightline,б��K_Leftline��С��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            %%����12,13,23,1,2,3�������ֱ���
            %%12ʱ����ֱ����б�߷�����������Ϊͬ�࣬��ѡ��������б����С�ķ���Ϊ��䷽�򣬽������            
            %%13ʱ����ֱ����б�߷�����������Ϊͬ�࣬��ѡ��������б����С�ķ���Ϊ��䷽�򣬽������            
            %%12ʱ����б�ߺ���б�߷�����������Ϊͬ�࣬��ѡ��������б����С�ķ���Ϊ��䷽�򣬽������            
            %%1ʱ����ֱ������������Ϊͬ�࣬��ѡ��÷���Ϊ��䷽�򣬽������            
            %%2ʱ����б�߷�����������Ϊͬ�࣬��ѡ��÷���Ϊ��䷽�򣬽������             
            %%3ʱ����б�߷�����������Ϊͬ�࣬��ѡ��÷���Ϊ��䷽�򣬽������
            %%��������£��Ƚ�����б�ʷ����С��
                 %%�����ֱ����б����С�����ڴ�ֱ����������
                 %%�����б�߷���б����С��������б�߷���������
                 %%�����б�߷���б����С��������б�߷���������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            %%12ʱ����ֱ����б�߷�����������Ϊͬ�࣬��ѡ��������б����С�ķ���Ϊ��䷽�򣬽������
            if class_difference_situation(i,j)==12
                KKK=[K_Vertical(i,j),K_Rightline(i,j)];
                MIN_K = min(KKK);%MIN_K��б��K_Vertical��б��K_Rightline��б����С�ķ���
                if K_Vertical(i,j)==MIN_K%%��ֱ����б����С
                    %%���ڴ�ֱ�����Ͻ������ص����
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                         %����ע�ʹ��������ڲ�ɫͼ��
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
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
                    
                else%%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                    %����ע�ʹ��������ڲ�ɫͼ��
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
                                %��������б�߷�������%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)λ�������в����ϣ������������������м��
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
                        %%%(i,j)λ�������в����£�����������������м��                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %�м��������������ѡȡ����ֵ���
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
                MIN_K = min(KKK);%MIN_K��б��K_Vertical��б��K_Rightline��б����С�ķ���
                if K_Vertical(i,j)==MIN_K%%��ֱ����б����С
                    %%���ڴ�ֱ�����Ͻ������ص����
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                         %����ע�ʹ��������ڲ�ɫͼ��
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
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
                    
                else%%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                            %����ע�ʹ��������ڲ�ɫͼ��
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
                            %��������б�߷�������%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
                end
            elseif class_difference_situation(i,j)==23
                KKK=[K_Rightline(i,j),K_Leftline(i,j)];
                MIN_K = min(KKK);%MIN_K��б��K_Vertical��б��K_Rightline��б����С�ķ���
                if  MIN_K ==K_Rightline(i,j)%%%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                    %����ע�ʹ��������ڲ�ɫͼ��
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
                                %��������б�߷�������%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)λ�������в����ϣ������������������м��
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
                        %%%(i,j)λ�������в����£�����������������м��                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %�м��������������ѡȡ����ֵ���
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
                else%%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                            %����ע�ʹ��������ڲ�ɫͼ��
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
                            %��������б�߷�������%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
                end
            elseif class_difference_situation(i,j)==1
                KKK=K_Vertical(i,j);
                %%���ڴ�ֱ�����Ͻ������ص����
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                         %����ע�ʹ��������ڲ�ɫͼ��
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
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end 
            elseif class_difference_situation(i,j)==3
                KKK=K_Leftline(i,j);
                %%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                            %����ע�ʹ��������ڲ�ɫͼ��
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
                            %��������б�߷�������%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
            elseif class_difference_situation(i,j)==2
                KKK=K_Rightline(i,j);
                %%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                    %����ע�ʹ��������ڲ�ɫͼ��
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
                                %��������б�߷�������%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)λ�������в����ϣ������������������м��
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
                        %%%(i,j)λ�������в����£�����������������м��                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N&&i>=LEFTUP_boundary_I(i,j)+right
                                    %�м��������������ѡȡ����ֵ���
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
             if MIN_K==K_Vertical(i,j)%��ֱ�������
                 %%���ڴ�ֱ�����Ͻ������ص����
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                         %����ע�ʹ��������ڲ�ɫͼ��
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
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if UP_boundary(i,j)-SUIJISHU>0 &&i<UP_boundary(i,j)+right                   
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(UP_boundary(i,j)-SUIJISHU,j,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if DOWN_boundary(i,j)+SUIJISHU<=M&&i>=UP_boundary(i,j)+right
                            %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(DOWN_boundary(i,j)+SUIJISHU,j,:);
                            end
                        end 
                    end
             elseif MIN_K==K_Rightline(i,j)%��б�߷������
                 %%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                    %����ע�ʹ��������ڲ�ɫͼ��
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
                                %��������б�߷�������%   
                                local_gap_number=RIGHTDOWN_boundary_I(i,j)-LEFTUP_boundary_I(i,j)+1;
                                left=local_gap_number/2;
                                right=round(local_gap_number/2);
                                %%%(i,j)λ�������в����ϣ������������������м��
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
                        %%%(i,j)λ�������в����£�����������������м��                    
                                SUIJISHU=round(rand(1,1))+1;
                                if RIGHTDOWN_boundary_I(i,j)+SUIJISHU<=M-3&&RIGHTDOWN_boundary_J(i,j)+SUIJISHU<=N-3&&i>=LEFTUP_boundary_I(i,j)+right
                                    %�м��������������ѡȡ����ֵ���
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
             else%��б�߷������
                 %%��б�߷���б����С
                    if Is_gap_in_the_middle(i,j)==1%�����ָ�ͼ���(i,j)Ϊ�����м��϶�ϵ�
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
                            %����ע�ʹ��������ڲ�ɫͼ��
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
                            %��������б�߷�������%   
                            local_gap_number=-RIGHTUP_boundary_I(i,j)+LEFTDOWN_boundary_I(i,j)+1;
                            left=local_gap_number/2;
                            right=round(local_gap_number/2);
                            %%%(i,j)λ�������в����ϣ������������������м��
                            SUIJISHU=round(rand(1,1))+1;
                            if RIGHTUP_boundary_I(i,j)-SUIJISHU>0&&RIGHTUP_boundary_J(i,j)+SUIJISHU<N&&i<RIGHTUP_boundary_I(i,j)+right 
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(RIGHTUP_boundary_I(i,j)-SUIJISHU,RIGHTUP_boundary_J(i,j)+SUIJISHU,:);
                            end
                            %%%(i,j)λ�������в����£�����������������м��                    
                            SUIJISHU=round(rand(1,1))+1;
                            if LEFTDOWN_boundary_I(i,j)+SUIJISHU<=M&&LEFTDOWN_boundary_J(i,j)-SUIJISHU>0&&i>=RIGHTUP_boundary_I(i,j)+right
                                 %�м��������������ѡȡ����ֵ���
                                SLC_off_recovered(i,j,:)=SLC_off_recovered_color(LEFTDOWN_boundary_I(i,j)+SUIJISHU,LEFTDOWN_boundary_J(i,j)-SUIJISHU,:);
                            end
                        end   
                    end
             end
            end
        end

        
    end
    str=['ȥ�������������...',num2str(100*i/M),'%'];    % �ٷֱ���ʽ��ʾ�������,����Ҫɾ�����д������
    waitbar(i/M,bar,str)
       
        
end
close(bar);
axes(handles.axes2);
SLC_off_recovered=uint8(SLC_off_recovered);
SLC_off_recovered_color=SLC_off_recovered;
threshold_magnitude=0.1;
[ SLC_off_graph_Max_Min_filt ] = my_medfilt( SLC_off_recovered_color,tiaodai_location_graph,threshold_magnitude );
imshow(SLC_off_graph_Max_Min_filt);%title('SLC OFF GRAPH RECOVED FLTERED') ;
im_proc=SLC_off_graph_Max_Min_filt;

toc;


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_proc;
[path]=uigetdir('','����ȥ����������ͼ��');
imwrite(im_proc,strcat(path,'\','recovered_image.bmp'),'bmp');


% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc,clear,close all%�˳�ϵͳ

% --------------------------------------------------------------------
function Untitled_30_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

im_proc=edge(im1,'roberts',0.04);%ʹ��Robert����
axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
imshow(im);%��ʾԭʼͼ��
axes(handles.axes2);
imshow(im_proc);
im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���

% --------------------------------------------------------------------
function Untitled_32_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

im_proc=edge(im1,'sobel');%ʹ��Sobel����
axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
imshow(im);%��ʾԭʼͼ��
axes(handles.axes2);
imshow(im_proc);
im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���

% --------------------------------------------------------------------
function Untitled_33_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

im_proc=edge(im1,'prewitt');%ʹ��Prewitt����
axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
imshow(im);%��ʾԭʼͼ��
axes(handles.axes2);
imshow(im_proc);
im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���

% --------------------------------------------------------------------
function Untitled_31_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

im_proc=edge(im1,'log');%ʹ��LoG����
axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
imshow(im);%��ʾԭʼͼ��
axes(handles.axes2);
imshow(im_proc);
im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���

% --------------------------------------------------------------------
function Untitled_26_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;

im_proc1=imnoise(im1,'salt & pepper',0.02);%��ӽ�������
axes(handles.axes1);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc1);%��ʾ������ͼ��
im_proc=filter2(fspecial('average',3),im_proc1)/255;%3*3����ƽ���˲�
axes(handles.axes2);
imshow(im_proc);

% --------------------------------------------------------------------
function Untitled_27_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;


im_proc1=imnoise(im1,'salt & pepper',0.02);%��ӽ�������
axes(handles.axes1);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc1);%��ʾ������ͼ��
im_proc=medfilt2(im_proc1);%��ֵ�˲�
axes(handles.axes2);
imshow(im_proc);

% --------------------------------------------------------------------
function Untitled_28_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;


im_proc1=imnoise(im1,'gaussian',0.02);%��ӽ�������
axes(handles.axes1);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc1);%��ʾ������ͼ��
im_proc=wiener2(im_proc1,[5,5]);%5*5����ά���˲�
axes(handles.axes2);
imshow(im_proc);

% --------------------------------------------------------------------
function Untitled_22_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
im_proc=imnoise(im,'salt & pepper',0.02);%��ӽ�������
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��

% --------------------------------------------------------------------
function Untitled_23_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
im_proc=imnoise(im,'gaussian',0.02);%��Ӹ�˹����
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��


% --------------------------------------------------------------------
function Untitled_24_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
im_proc=imnoise(im,'speckle',0.02);%��Ӱߵ�����
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��    

% --------------------------------------------------------------------
function Untitled_18_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;

%im=rgb2gray(im);
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
im_proc=imcrop();%�����ü�ͼ��
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��


% --------------------------------------------------------------------
function Untitled_19_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

im_proc=imresize(im1,0.5);%ͼ����Сһ��
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��

% --------------------------------------------------------------------
function Untitled_20_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

im_proc=imresize(im1,2,'bilinear');%ͼ��Ŵ�һ��
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��
    

% --------------------------------------------------------------------
function Untitled_21_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
        
im_proc=fliplr(im1);%ͼ��������ת
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��        
    
% --------------------------------------------------------------------
function Untitled_34_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
        
im_proc=flipud(im1);%ͼ��������ת
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��        


% --------------------------------------------------------------------
function Untitled_35_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
        
im_proc=rot90(im1);%ͼ����ʱ����ת90��
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��

% --------------------------------------------------------------------
function Untitled_36_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
        
im_proc=rot90(im1,-1);%ͼ��˳ʱ����ת90��
axes(handles.axes2);%�ڵڶ�����ϵ�»�ͼ
imshow(im_proc);%��ʾ������ͼ��

% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_37_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_38_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on popupmenu1 and none of its controls.
function popupmenu1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_39_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im1 im_proc;
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);

im_proc=edge(im1,'canny');%ʹ��Canny����
axes(handles.axes1);%�ڵ�һ����ϵ�»�ͼ
imshow(im);%��ʾԭʼͼ��
axes(handles.axes2);
imshow(im_proc);
im_proc=255*im_proc;%��01ͼ���Ϊ0255ͼ����ڱ���


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im_proc Unsupervised_classes;%����ȫ�ֱ���
[fn,pn]=uigetfile('*.bmp','������ENVI�Ǽල����ͼ��!');
Unsupervised_classes = imread([pn,fn]);%('C:\Users\Cyjun\Desktop\����202006052012������\2012_color_unsupervised.bmp');
axes(handles.axes1);%������ϵ1�ϻ�ͼ
imshow(Unsupervised_classes);


% --------------------------------------------------------------------
function Untitled_40_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im im1 im_proc Unsupervised_classes;%����ȫ�ֱ���
[file,path]=uigetfile({'*.bmp';'*.jpg';'*.tif'},'ѡ��Ҫ�����ԭʼͼ��');%,'ѡ��ͼƬ'
str=[path,file];%�ϲ�·����ͼ���ļ���
im=imread(str);%��ͼ
ss=size(im);
if ss(1,3)==3
    im1=rgb2gray(im);
else
    im1=im;
end
axes(handles.axes1)%������ϵ1�ϻ�ͼ
imshow(im);
