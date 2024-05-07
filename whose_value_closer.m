function [ first_two ] = whose_value_closer( y,y0 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

MM=abs([y-y0(1,1) y-y0(1,2) y-y0(1,3) y-y0(1,4) y-y0(1,5) y-y0(1,6)]);SORT_MM=sort(MM);
first_two=SORT_MM(1,1:2);
end

