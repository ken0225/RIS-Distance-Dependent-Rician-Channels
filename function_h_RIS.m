function [h_RIS]=function_h_RIS(D_BS, centers_RIS, D_MR_Trajectory, T_total_time, exp_BS_RIS, exp_RIS_MR, exp_phi_optimal,...
    g_mn_NLoS_Each, h_mn_NLoS_Each, K_3, K_4, G_1, G_2) % size(g_m_NLoS(:,:,bb)) = M_total_elements_number x total_time
% Author: Ke(Ken)WANG from Macao Polytechnic Institute %size(exp_BS_RIS) = M_total_elements_number x 1
% Email: ke.wang@ipm.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2020/11/20), v0.2(2021/08/26), v0.3(2021/09/04)
%
% This function aims to calculate S_mn(t), i.e., eq(8) in the GC paper 2021
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% TBD

global c0 fc M_total_elements_number;

% ============================================== BS to RIS Link ==============================================

lambda_c = c0/fc;

%     %This gain is $G_T^{mn}$
%     %This is the gain from BS to RIS, that means this gain always euqals to 1
%     %since we assume the transceiver is isotropic
%     G_BS_to_RIS_direction = function_antenna_gain_TR(total_time);

G_BS_to_RIS = function_antenna_gain_TR(M_total_elements_number);

%This gain is $G_{mn}^T$. If the RIS is isotropic, the gain is 1, otherwise we use
%"function_gain_RIS" to calculate the gain.
G_RIS_to_BS = function_gain_RIS(M_total_elements_number);

A_BS_m_RIS = (lambda_c/(4*pi) .* sqrt(G_BS_to_RIS.*G_RIS_to_BS)./vecnorm((centers_RIS-D_BS).'));

g_m = [];

for aa = 1 : T_total_time

temp_g_m =  A_BS_m_RIS.* (G_1 .* exp_BS_RIS.' + G_2 .* g_mn_NLoS_Each(:,aa).');

g_m = [g_m;temp_g_m]; 

clear temp_g_m

end
% ============================================== RIS to MR Link ==============================================

G_MR_to_RIS=[];

G_RIS_to_MR=[];


for bb = 1 : T_total_time
    
    temp_G_MR_to_RIS_direction = function_antenna_gain_TR(M_total_elements_number);

    G_MR_to_RIS =[G_MR_to_RIS; temp_G_MR_to_RIS_direction];

    temp_G_RIS_to_MR_direction = function_gain_RIS(M_total_elements_number);
    
    G_RIS_to_MR =[G_RIS_to_MR; temp_G_RIS_to_MR_direction];
    
    clear temp_G_MR_to_RIS_direction temp_G_RIS_to_MR_direction
   
end

h_m= [];

for cc = 1 : T_total_time
    
    A_m_RIS_MR = (lambda_c/(4*pi)*sqrt(G_MR_to_RIS(cc,:).*G_RIS_to_MR(cc,:))./ ...
        vecnorm((D_MR_Trajectory(cc,:) - centers_RIS).'));
    
    temp_h_m = A_m_RIS_MR .* (K_3(cc) .* (exp_RIS_MR(:,cc).') + K_4(cc) .* (h_mn_NLoS_Each(:,cc).'));
    
    h_m = [h_m;temp_h_m];
    
    clear temp_h_m
    
end

% ============================================== Compute h_RIS ==============================================
    
h_RIS = [];

for dd = 1 : T_total_time

    temp_h_RIS = sum(g_m(dd,:) .* h_m(dd,:) .* (exp_phi_optimal(:,dd).'));

    h_RIS(:,dd) = temp_h_RIS;
    
    clear temp_h_RIS
    
end


end
