function [A_mn_sum, A_mn_matrix]=function_Amn(D_BS, centers_RIS, D_MR_Trajectory, T_total_time)
% Author: Ke(Ken)WANG from Macao Polytechnic Institute
% Email: ke.wang@ipm.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2020/11/20), v0.2(2021/08/26), v0.3(2021/09/04)
%
% This function aims to calculate A_mn, i.e., eq(6) in the GC paper 2021
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% TBD

global c0 fc M_total_elements_number;

lambda_c = c0/fc;

G_BS_to_RIS_direction = function_antenna_gain_TR(M_total_elements_number);

G_RIS_to_BS_direction = function_gain_RIS(M_total_elements_number);

A_BS_RIS = lambda_c/(4*pi) * sqrt(G_BS_to_RIS_direction.*G_RIS_to_BS_direction)./vecnorm((centers_RIS-D_BS)');

A_mn_sum = [];

A_mn_matrix = [];

G_MR_to_RIS=[];

G_RIS_to_MR=[];

for t = 1 : T_total_time
    
    temp_G_MR_to_RIS = function_antenna_gain_TR(M_total_elements_number);
    G_MR_to_RIS =[G_MR_to_RIS; temp_G_MR_to_RIS];
    
    temp_G_RIS_to_MR = function_gain_RIS(M_total_elements_number);
    G_RIS_to_MR =[G_RIS_to_MR; temp_G_RIS_to_MR];
    
end

for t = 1 : T_total_time
    
    temp_A_RIS_MR = ...
        lambda_c/(4*pi) * sqrt(G_MR_to_RIS(t,:) .* G_RIS_to_MR(t,:)) ./ vecnorm((D_MR_Trajectory(t,:)-centers_RIS).');
    
    temp_A_mn_sum = sum(A_BS_RIS .* temp_A_RIS_MR);
    
    A_mn_sum = [A_mn_sum; temp_A_mn_sum];
    
    temp_A_mn_matrix = A_BS_RIS .* temp_A_RIS_MR;
    
    A_mn_matrix = [A_mn_matrix; temp_A_mn_matrix];
    
end

end
