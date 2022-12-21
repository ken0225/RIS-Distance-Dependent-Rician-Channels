function [mean_SE_MC, mean_SNR_MC]=function_compute_SE(realization_result, Pt_transmit_power, sigma_square_noise_power, kappa_t, kappa_r)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: N/A
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% TBD

received_power_all_realization = Pt_transmit_power .* mean((abs(realization_result)) .^ 2);

mean_SNR_MC = received_power_all_realization ./ ...
    (kappa_t .* received_power_all_realization + kappa_r .* received_power_all_realization + sigma_square_noise_power);

mean_SE_MC = log2(1 + mean_SNR_MC);

end