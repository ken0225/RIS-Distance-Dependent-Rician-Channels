function [output_antenna_gain_TR]=function_antenna_gain_TR(temp)  % p2 denotes Receiver and p1 denotes Transmitter
% Author: Ke(Ken)WANG from Macao Polytechnic Institute
% Email: ke.wang@ipm.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2020/11/19), v0.2(2021/08/26), v0.3(2021/09/04)
%
% This function aims to calculate the gain of transceiver.
% Note that since we suppose the transceiver is isotropic, then the gain
% always equals to 1.
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% [output_antenna_gain_TR]=function_antenna_gain_TR(eye(3), [1,2,3;4,5,6;7,8,9])
% 
% output_antenna_gain_TR =
% 
%      1     1     1
    
    
    % Note that since we suppose the transceiver is isotropic, then the gain
    % always equals to 1.
    output_antenna_gain_TR = ones(1, temp);
   
end
