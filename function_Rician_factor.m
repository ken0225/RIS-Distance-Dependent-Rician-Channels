function [kappa_d, rho_m, kappa_m]=function_Rician_factor(centers_RIS, D_BS, D_MR_Trajectory, varrho, iota)
% Author: Ke(Ken)WANG from Macao Polytechnic Institute
% Email: ke.wang@ipm.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2022/Oct/12)
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% TBD

if ismatrix(centers_RIS) && ismatrix(D_BS) && ismatrix(D_MR_Trajectory)
    
    %Check the center_RIS is suitable or not
    centers_RIS = function_check_dim(centers_RIS);
    
    %Check the coordinate of BS is suitable or not
    D_BS = function_check_dim(D_BS);
    
    %Check the coordinate of the trajectory of vehicle is suitable or not
    D_MR_Trajectory = function_check_dim(D_MR_Trajectory);
    
else
    
    error('Only matrix supported! ')
    
end

%tau_0
d_0 = vecnorm((D_MR_Trajectory-D_BS).');

kappa_d = db2pow(varrho - iota.*d_0);

d_BS_RIS = [];

d_RIS_MR = [];

for aa = 1 : size(centers_RIS,1)
    
    temp1 = vecnorm((centers_RIS(aa,:)-D_BS).'); 
    
    d_BS_RIS(aa,:) = temp1;
    
end

rho_m = db2pow(varrho - iota.*d_BS_RIS);

for bb = 1 : size(centers_RIS,1)

    %size(temp2) = [1, total_time].
    temp2 = vecnorm((D_MR_Trajectory-centers_RIS(bb,:)).');
    
    d_RIS_MR(bb,:) = temp2;
    
end

kappa_m = db2pow(varrho - iota.*d_RIS_MR);

end
