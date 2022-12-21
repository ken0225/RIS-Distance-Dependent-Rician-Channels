
### Disclaimer

The simulation code is licensed under the GPLv2 license and is delivered as it is. The authors encourage you to reuse the code in your research, but we cannot give any support. The readme file contains the instructions on how to run the code. As soon as you edit the code, you are on your own. My GitHub page is the only way that we are sharing simulation code, so there is no need to send us emails and ask for code related to other papers. The code is either openly available for everyone or it is not available at all.

### This code package is licensed under the GPLv2 license. If you in any way use this code for research that results in publications, please cite the original article listed above.

```
@article{wang2022risdd,
  title={RIS-Assisted High-Speed Communications with Time-Varying Distance-Dependent Rician Channels},
  author={Wang, Ke and Lam, Chan-Tong and Ng, Benjamin K},
  journal={Applied Sciences},
  volume={12},
  number={22},
  pages={11857},
  year={2022},
}
```

# RIS-Distance-Dependent-Rician-Channels

This is a code package is related to the follow scientific article:

## K. Wang, C. -T. Lam and B. K. Ng, "[RIS-Assisted High-Speed Communications with Time-Varying Distance-Dependent Rician Channels](https://www.mdpi.com/2076-3417/12/22/11857)," in _Applied Sciences_, 12, no.22: 11857, 2022.

### Abstract

Reconfigurable intelligent surface (RIS) has been envisioned as one of the promising solutions for enhancing signal transmissions in high-speed communications (HSC). In this paper, we present a time-varying channel model with distance-dependent Rician factors for the RIS-assisted HSC. Our model not only contains Rayleigh components and Doppler shift (DS) terms but also distance-dependent Rician factors, for characterizing time-varying features. In particular, we show that when the vehicle is far from the base station and the RIS, the channel contains only Rayleigh fading. However, when they are close enough, the channel can be considered as a light-of-sight channel. Based on the proposed model, it is proven that using RIS phase shift optimization, the DS of the cascaded links can be aligned with the DS of the direct link; and if the direct link is blocked, the DS can be removed entirely. Furthermore, we derive the closed-form expressions for the ergodic spectral efficiency and the outage probability of the proposed system. Besides, it is observed that the deployment strategy also affects the system performance. Simulation results validate all analyses.

### Result 

![image](https://github.com/ken0225/Multi-RIS-Doppler-Mitigation-Hardware-Impairments/blob/main/plot_result.png)

### How to use this code?

Please run "Figure_3.m" to obtain the Figure 3 of the paper. By modifying the parameters, other figures can be obtained easily.
