function [output_function_MR_moving_xdir]=function_MR_moving_xdir(v_speed, t)
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
%Example:
%
% [output_function_vehicle_moving_xdir]=function_vehicle_moving_xdir(83.3,100)
% 
% output_function_vehicle_moving_xdir =
% 
%         8330           0           0

    output_function_MR_moving_xdir = [v_speed.*t, 0, 0];

end