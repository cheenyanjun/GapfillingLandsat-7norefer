function [ Chazhi ] = Bspline_interp( UP_three_x,Down_three_x,UP_three_y,Down_three_y,gap_x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
x0=[UP_three_x,Down_three_x];
y0=[UP_three_y,Down_three_y];
x=gap_x;
y=spline(x0,y0,x);
Chazhi=y;
end

