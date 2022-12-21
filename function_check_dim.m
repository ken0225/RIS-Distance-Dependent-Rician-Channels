function [coordinate_of_D_3D] = function_check_dim(coordinate_of_D)
% Author: Ke(Ken)WANG from Macao Polytechnic Institute
% Email: ke.wang@ipm.edu.mo, kewang0225@gmail.com
% Update infomation: v0.1(2020/11/20), v0.2(2021/08/26)
%
% This function aims to check the 3D coordinate; We define
% each row of a matrix stands for a 3D coordinate. In other words, coordinate_of_p_3D
% must be a 3 x X matrix.
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% The INPUT is the coordinate and the OUTPUT is a 3D coordinate.
%
% Example:
%
% coordinate_of_p = eye(2,3); function_check_dim(coordinate_of_p)
%
% ans =
%
%      1     0     0
%      0     1     0

size_coordinate_of_p = size(coordinate_of_D);

if ismatrix(coordinate_of_D)
    
    if size_coordinate_of_p(2) == 3
        
        coordinate_of_D_3D = coordinate_of_D;
        
    elseif size_coordinate_of_p(1) == 3
        
        coordinate_of_D_3D = coordinate_of_D.';
        
    else
        
        error('The input is NOT an Euclidean vector.')
        
    end
    
else
    
    error('Only matrix supported.')
    
end

end
