%% Program Information
% Author: Ke"Ken"WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update Infomation: v0.91, 2022/Oct.

%% Clean All & Timer
close all;
clear;
tic;

%% System Parameters Initialization

% -------- Changeable Parameters Begin -------- 
% You CAN change the parameters below to obtain different figures

global c0 fc v_speed M_total_elements_number T_total_time; % Global parameters

kappa_t = 0; % Transceiver HWI (Transmitter side)

kappa_r = kappa_t; % Transceiver HWI (Receiver side)

realization_Rician_number = 5e3; % The number of realizations. 5e3 or 1e4 are reasonable values

sqrt_M = 64;

% Rician Factors Parameters
varrho=13;

iota=0.03;

M_total_elements_number = sqrt_M^2; 

c0 = physconst('Lightspeed'); % Light v_speed

fc = 2.4e9; % Carrier frequency is 2.4 GHz

disp('Step 1: Parameter Initialization Begin.');

dx = (c0/fc)/2; dy = dx; % dx=dy=\lambda/2

r_RIS = 15; % Height of the RIS

r_MR = 2; % Height of the vehicle

r_BS = 20; % Height of the BS

v_speed = 50; % v_speed of the vehicle

T_total_time = 10; % Total time slots for one vehicle pass

Pt_transmit_power = 0.1; % Transmit power is 0.1W = 20dBm

sigma_square_noise_power = 10e-12; % sigma_square = -80dBm

% The coordinate of the vehicle, i.e., the receiver
x_MR_start = -v_speed*T_total_time/2;
y_MR = 0+r_MR;
z_MR = 20; 

% The coordinate of the Base Station, i.e., the transmitter
x_BS = 0;
y_BS = 0+r_BS;
z_BS = 50; 

%  -------- Changeable Parameters End -------- 

%% Compute the trajectory for one vehicle pass

%disp(['Step 2: Compute the trajectory for one vehicle pass. The v_speed is ' num2str(v_speed) ' m/s.']);
disp('Step 2: Compute the trajectory for one vehicle pass.');

D_BS = [x_BS, y_BS, z_BS];

D_MR_start = [x_MR_start, y_MR, z_MR];

% Total trajectory = starting point + moving trajectory per second (we start from 1s rather than 0s)
D_MR_Trajectory = [];

% The vehicle starts at p_vehicle_start, and travels at the v_speed during T_total_time period
for aa = 1 : T_total_time
    
    temp_D_MR_Trajectory =  D_MR_start+function_MR_moving_xdir(v_speed, aa);
    
    D_MR_Trajectory = [D_MR_Trajectory; temp_D_MR_Trajectory];
    
end

% 'A_0' is the gain for the direct path without Rayleigh component.
[A_0] = function_A0(D_BS, D_MR_Trajectory);

%% Step 3: Compute the Phase Shift Set of the RIS.
disp('Step 3: Compute the Phase Shift Set of the RIS.');

% Compute the position for K RISs
[centers_RIS]=function_centers_single_RIS(sqrt_M, sqrt_M, dx, dy, r_RIS);

% Compute the delays
[tau_0, tau_mn, tau_BS_RIS, tau_RIS_MR] = function_time_delay(centers_RIS, D_BS, D_MR_Trajectory); 

% Compute Dynamic Rician Factors
[kappa_d, rho_mn, kappa_mn]=function_Rician_factor(centers_RIS, D_BS, D_MR_Trajectory, varrho, iota);

K_1 = sqrt(kappa_d ./ (kappa_d+1)); % Rician factor for the LoS part of the direct link
K_2 = sqrt(1 ./ (kappa_d+1)); % Rician factor for the NLoS part of the direct link

K_3 = sqrt(mean(kappa_mn,1) ./ (mean(kappa_mn,1)+1)); % Rician factor for the LoS part of the RIS-User link
K_4 = sqrt(1 ./ (mean(kappa_mn,1)+1)); % Rician factor for the NLoS part of the RIS-User link

G_1 = sqrt(mean(rho_mn) ./ (mean(rho_mn)+1)); % Rician factor for the LoS part of the BS-RIS link
G_2 = sqrt(1 ./ (mean(rho_mn)+1)); % Rician factor for the NLoS part of the BS-RIS link

% Optimal phase shift
zeta_mn = ceil(-(fc*(tau_0-tau_mn))); 

% Final phase shift after optimized
phi_optimal = 2*pi*(fc*(tau_0-tau_mn)+zeta_mn);

% Final phase part after optimized
exp_phi_optimal = exp(-1i.*phi_optimal); %tau_BS_RIS+tau_RIS_MR ==  tau_mn

%% Step 4: Compute the SE under the Rician Channel.
disp('Step 4: Compute the SE under the Rician Channel.');

h_d_NLoS = sqrt(1/2)*(randn(realization_Rician_number, T_total_time)+1i*randn(realization_Rician_number, T_total_time));

g_mn_NLoS = sqrt(1/2)*(randn(M_total_elements_number, T_total_time, realization_Rician_number)...
    +1i*randn(M_total_elements_number, T_total_time, realization_Rician_number));

h_mn_NLoS = sqrt(1/2)*(randn(M_total_elements_number, T_total_time, realization_Rician_number)...
    +1i*randn(M_total_elements_number, T_total_time, realization_Rician_number));

% g_m(t)
exp_BS_RIS = exp(-1i*2*pi*fc*tau_BS_RIS); % size(exp_BS_RIS) = M_total_elements_number x 1
% h_m(t)
exp_RIS_MR = exp(-1i*2*pi*fc*tau_RIS_MR); % size(exp_RIS_Vehicle) = M_total_elements_number x T_total_time

signal_all_realization_direct = [];

signal_total_all_realization_Rician = [];

% for-loop for realizations
for bb = 1 : realization_Rician_number

disp(['           =============This is the ',num2str(bb), '-th Rician realiztion=============']);

[signal_Rayleigh_direct]=function_h_d(A_0, h_d_NLoS(bb,:), tau_0, K_1, K_2);

[signal_Rayleigh_cascaded] = function_h_RIS(D_BS, centers_RIS, D_MR_Trajectory, T_total_time, exp_BS_RIS, exp_RIS_MR, ...
    exp_phi_optimal, g_mn_NLoS(:,:,bb), h_mn_NLoS(:,:,bb), K_3, K_4, G_1, G_2);

signal_total_all_realization_Rician(bb,:) = signal_Rayleigh_cascaded + signal_Rayleigh_direct;
% size(signal_total_all_realization_Rician) = M_total_elements_number x T_total_time

signal_all_realization_direct(bb,:) = signal_Rayleigh_direct;
% size(signal_all_realization_direct) = M_total_elements_number x T_total_time

end

[SE_no_RIS_Rician_Simulated, SNR_no_RIS_Rician_Simulated]=function_compute_SE(signal_all_realization_direct, Pt_transmit_power, sigma_square_noise_power, kappa_t, kappa_r);

[SE_RIS_Rician_Simulated, SNR_RIS_Rician_Simulated]=function_compute_SE(signal_total_all_realization_Rician, Pt_transmit_power, sigma_square_noise_power, kappa_t, kappa_r);

%% Analytical Results

[A_mn_sum, A_mn_matrix]=function_Amn(D_BS, centers_RIS, D_MR_Trajectory, T_total_time);

A_mn_sum = A_mn_sum';
A_mn_matrix = A_mn_matrix';

Received_power_analytical = Pt_transmit_power.*((K_1.^2+K_2.^2).*A_0.^2 + K_3.^2.*G_1.^2.*(A_mn_sum).^2+...
    (K_3.^2 .* K_4.^2+K_4.^2.*G_1.^2+K_4.^2.*G_2.^2).*sum(A_mn_matrix.^2,1)+2.*A_0.*K_1.*K_3.*G_1.*A_mn_sum); 

SNR_RIS_Rician_Analytical = Received_power_analytical ./ ...
    (kappa_t .* Received_power_analytical + kappa_r .* Received_power_analytical + sigma_square_noise_power);

SE_RIS_Rician_Analytical = log2(1 + SNR_RIS_Rician_Analytical);

%% Plot the simulation results
close all;

disp('Step 5: Plot the simulation results.');

figure(1); hold on; box on; grid on;

moving_distance = linspace(1,T_total_time,T_total_time) .* v_speed; 

p1 = plot(moving_distance, SE_no_RIS_Rician_Simulated, 'b-', 'LineWidth', 1.5);
p2 = plot(moving_distance, SE_RIS_Rician_Simulated, 'r--', 'LineWidth', 1.5);
p3 = plot(moving_distance, SE_RIS_Rician_Analytical, 'ko', 'LineWidth', 1.5);

xlabel('Moving Distance (m)','Interpreter','LaTex');
ylabel('Ergodic SE (bit/s/Hz)','Interpreter','LaTex');

legend([p1(1), p2(1), p3(1)],...
    'w/o RIS','w/ RIS Monte Carlo','w/ RIS Analytical','Interpreter','LaTex','Location','SouthEast');

axis([100-20, 400+20, 4, 12.3]); 

%% Timer ends
toc;
