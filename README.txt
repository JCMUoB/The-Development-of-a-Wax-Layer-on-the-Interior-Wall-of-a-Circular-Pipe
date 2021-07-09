README

To solve single cases of [IBVP*] use items 3 or 4 with parameters and Diffusivity defined in items 5 and 2.
To solve cases of [IBVP*] in bulk (and output various graphs) use Conversion_times.

The following is a brief description of the files within the folder. 

1. 	Conversion_times
	This file is used to compute solutions the [IBVP*] in bulk.
	Here one can specify a selection of k, epsilon and Diffusivity function.
	This file also computes the conversion times, errors, and the SUMMARY_DATA.
	
2.	Diffusivity
	Where D(u) is defined.
	In the paper only option 2 is used.

3.	Eigval_general
	Computes the eigenvalues lambda_0 from [S-L] in bulk.
	Here one can specify a selection of k and Diffusivity function.
	This file computes a SUMMARY_DATA file.

4.	Eigval_NJR
	Computes the eigenvalues for constant D=1 using the formula from reference [12] in bulk.
	Here one can specify k.
	This method is runs in a negligible amount of time.
	This file computes a SUMMARY_DATA file.

5.	eigvalsolver
	Applies the shooting method and bisection method to find lambda_0 for [S-L].

6.	Plot_Eigensurf_general
	Plots the surface y = lambda_0 (epsilon,k).
	
7.	explicitmethod
	Solves [IBVP*] via explicit finite difference method.
	Notably this is used in item 1 to compute the SUMMARY_DATA.

8.	explicitmethod_par
	Similar to item 8. but parallelized. 
	This ran slower on the device used for computations within the paper but faster on other devices.

9. 	Parameters
	Stores key parameters used in the solvers in many other items.

10.	Plot_discrepancy
	Graphs ||v(:,t) - vs(:)||_{\infty}.

11.	Plot_h
	Graphs h(t) against t.
	Here h(t) is a component of the solution to [IBVP] and [IBVP*]

12.	Plot_u
	Surface plot of u(x,t) against (x,t).
	Here u is a component of the solution to [IBVP].

13.	Plot_v
	Surface plot of v(X,t) against (X,t).
	Here v is a component of the solution to [IBVP*].

14.	Plot_vvs
	Plots the discrepancy between v and vs once convergence criteria has been met.
	Here v is a component of the solution to [IBVP*] and vs is the steady state for [IBVP*].	

15.	steadystate_u
	Computes the steady state (us,hs) of [IBVP].
	Here (us,hs) is the steady state solution to solution to [IBVP].	

16.	steadystate_v	
	Computes the steady state (vs,hs) of [IBVP*].
	Here (vs,hs) is the steady state solution to solution to [IBVP*].	

17. 	0_Summary_Data
	This is summary data output from running Conversion_Times.
	Note this required 2 runs with Nx=161 and Nx=201 (to obtain satisfactorily convergence criteria).

18. 	0_Eigval_data_c=0.7
	This stores data output from running Eigval_general (and used in the paper).