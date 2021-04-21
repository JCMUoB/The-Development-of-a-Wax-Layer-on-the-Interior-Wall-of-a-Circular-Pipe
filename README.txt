README

This file was authored on 21/04/21. 
The attached codes have been written using MATLAB 2020b.
Certain parts of the code may not behave as intended when run on alternative versions of MATLAB.
This file is related to the pre-print and journal submission (under review) for the related paper.
To solve single cases of [IBVP*] use items 3 or 4 with parameters and Diffusivity defined in items 5 and 2.
To solve cases of [IBVP*] in bulk (and output various graphs) use Conversion_times.

The following is a brief description of the files within the folder. 

1. 	Conversion_times
	This file is used to compute solutions the [IBVP*] in bulk.
	Here one can specify a selection of k, epsilon and Diffusivity function.
	This file also computes the conversion times, errors, and the SUMMARY_DATA.
	
2.	Diffusivity
	Where D(u) is defined.
	In the paper only option 3 is used.

3.	explicitmethod
	Solves [IBVP*] via explicit finite difference method.
	Notably this is used in item 1 to compute the SUMMARY_DATA.

4.	explicitmethod_par
	Similar to item 3. but parallelized. 
	This ran slower on the device used for computations within the paper but faster on other devices.

5. 	Parameters
	Stores key parameters used in the solvers in items 3 and 4 above, as well as in item 1.

6.	Plot_discrepancy
	Graphs ||v(:,t) - vs(:)||_{\infty}.

7.	Plot_h
	Graphs h(t) against t.
	Here h(t) is a component of the solution to [IBVP] and [IBVP*]

8.	Plot_u
	Surface plot of u(x,t) against (x,t).
	Here u is a component of the solution to [IBVP].

9.	Plot_v
	Surface plot of v(X,t) against (X,t).
	Here v is a component of the solution to [IBVP*].

10.	Plot_vvs
	Plots the discrepancy between v and vs once convergence criteria has been met.
	Here v is a component of the solution to [IBVP*] and vs is the steady state for [IBVP*].	

11.	steadystate_u
	Computes the steady state (us,hs) of [IBVP].
	Here (us,hs) is the steady state solution to solution to [IBVP].	

12.	steadystate_v	
	Computes the steady state (vs,hs) of [IBVP*].
	Here (vs,hs) is the steady state solution to solution to [IBVP*].	

13. 	0_Summary_Data
	This is summary data output from running Conversion_Times.
	Note this required 2 runs with Nx=161 and Nx=201 (to obtain satisfactorily convergence criteria).
	Files fromthe 2 runs were subsequently merged.