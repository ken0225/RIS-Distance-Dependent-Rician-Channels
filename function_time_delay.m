function [tau_0, tau_cascaded, tau_BS_RIS, tau_RIS_MR]=function_time_delay(centers_RIS, D_BS, D_MR_Trajectory)
% Author: Ke(Ken)WANG from Macao Polytechnic Institute
% Email: ke.wang@ipm.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2020/11/20), v0.2(2021/08/26), v0.3(2021/09/04)
%
% This function aims to calculate tau_0 and tau_mn, i.e., eq(5) and eq(7), in the GC paper 2021
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% TBD

global c0;

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
tau_0 = vecnorm((D_MR_Trajectory-D_BS).') ./ c0;

tau_BS_RIS = [];

tau_RIS_MR = [];

for aa = 1 : size(centers_RIS,1)
    
    %Calculate the propagation time between the i-th element of the RIS and the BS. 
    temp1 = vecnorm((centers_RIS(aa,:)-D_BS).') ./ c0; 
    
    tau_BS_RIS(aa,:) = temp1;

    %Calculate the propagation time between the vehicle and the i-th element of the RIS
    %every second, so size(temp2) = [1, total_time].
    temp2 = vecnorm((D_MR_Trajectory-centers_RIS(aa,:)).') ./ c0;
    
    tau_RIS_MR(aa,:) = temp2;
    
    %size(tau_mn) = [MxN, total_time]. 
    tau_cascaded(aa,:) = (temp1+temp2).';
   
end

end
