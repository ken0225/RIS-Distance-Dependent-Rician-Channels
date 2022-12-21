function [A0]=function_A0(D_1,D_2)  % D_2 denotes Receiver and D_1 denotes Transmitter
% Author: Ke(Ken)WANG from Macao Polytechnic Institute
% Email: ke.wang@ipm.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2020/11/19), v0.2(2021/08/26)
%
% This function aims to calculate the vehicle coordinate increment.
% Note that we suppose the vehicle only moves along the positive x-axis direction
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% lambda_c = 3e8/2.4e9; p1=[1,2,3], p2=[0,0,0]; [A0]=function_A0(p1,p2)
%
% A0 =
%
%     0.0019


global c0 fc T_total_time;

lambda_c = c0/fc;

%The gain of transmitter, from the direction of receiver
G_T_to_R_direction = function_antenna_gain_TR(T_total_time);

%The gain of receiver, from the direction of transmitter
G_R_to_T_direction = function_antenna_gain_TR(T_total_time);

A0 = lambda_c/(4*pi) .* sqrt(G_T_to_R_direction.*G_R_to_T_direction)./vecnorm((D_2-D_1).'); %eq(3) in GC2021 paper

end
