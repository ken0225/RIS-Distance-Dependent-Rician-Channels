function [h_d]=function_h_d(A_0, h_d_NLoS, tau_0, K_1, K_2) 
% Author: Ke(Ken)WANG from Macao Polytechnic Institute
% Email: ke.wang@ipm.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2020/11/20), v0.2(2021/08/26), v0.3(2021/09/04)
%
% This function aims to calculate S_0(t), i.e., eq(4) in the GC paper 2021
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% TBD

global fc;

h_d = A_0.*(K_1.*exp(-1i*2*pi*fc.*tau_0) + K_2.*h_d_NLoS);

end