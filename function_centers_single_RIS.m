function [output_centers_RIS]=function_centers_single_RIS(X, Y, dx, dy, h_RIS)
% Author: Ke(Ken)WANG from Macao Polytechnic Institute
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2020/Mar.), v0.2(2021/Sep.)
%
% This function aims to calculate an RIS with M x N elements, and each of
% which with the size of dx x dy. Note that before use this function, you
% have to know the RIS is isotropic or not, and the inputs are correct.
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example: 
%
%[output_function_centers_RIS]=function_centers_single_RIS(2, 2, 1, 2, 10)
%
%    -0.5000    9.0000         0
%    -0.5000   11.0000         0
%     0.5000    9.0000         0
%     0.5000   11.0000         0

X_interval = function_interval(X);

Y_interval = function_interval(Y);

X_range = (X_interval(1) : X_interval(2));

Y_range = (Y_interval(1) : Y_interval(2));

for aa = 1 : length(X_range)
    
    gX(aa) = X_range(aa)*dx - 0.5*dx*mod(X+1, 2);
    
end

for bb = 1 : length(Y_range)
    
    gY(bb) = Y_range(bb)*dy - 0.5*dy*mod(Y+1, 2);
    
end

output_centers_RIS = function_cartprod(gX, gY);

output_centers_RIS(:, end+1) = 0;

output_centers_RIS = sortrows(output_centers_RIS, 1);

output_centers_RIS(:,2) = output_centers_RIS(:,2) + h_RIS;

end
