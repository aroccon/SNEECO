# SNEECO
Simulations of sneezing and coughing.
Covid-19 droplets are considered as pointwise particles (LPT).

The code tracks:
-Position (x,y)
-Mass (evaporation, minimal radius d=0.3*d_0)
-Temperature

References:
Particle Tracking:
Marchioli et al. (2008), "Statistics of particle dispersion in Direct Numerical Simulations of wall-bounded turbulence: results of an international collaborative benchmark test".

Evaporation model:
Abramzon and Siringano (1989), "Droplet vaporization model for spray combustion calculations, International Journal of Heat and Mass Transfer".

Virus behavior:
Oliveira et al. (----), "Evolution of spray and aerosol from respiratory releases: theoretical estimates for insight on viral transmission".

To run the code:
Execute the bash script ./go.sh.
Via the go.sh file, the most important parameters can be set.
Physical properties are hard-coded (see main.f90).

OS supported:
-MAC OS X Catalina.
-UNIX systems (ready, should be tested)
