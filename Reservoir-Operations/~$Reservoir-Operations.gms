$ontext
CEE 6410 - Water Resources Systems Analysis
HW3 - Problem 1

THE PROBLEM:

A reservoir operator wants a release schedule that will maximize profit.

                Determine the optimal volume of water to divert each month.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Isabel I. Hinton
isabel.hinton@usu.edu
September 28, 2026
$offtext

* 1. DEFINE the SETS
SETS time time at the end of the month /June, July, August/
     place place the water is being stored /reservoir, spill, diversion/;
     
Alias (time,tprev);

* 2. DEFINE input data
PARAMETERS
   Table c(time, place) Objective function constants
            reservoir   spill   diversion
   June         0         0       150
   July         0         0       170
   August       0         0       425;
         

   Parameters
   b(time) Right hand constraint values (per month) 
    /June    9000,       
     July    9000,        
    August   9000/
    
    i(time) Inflow constraints (per month)
    /June    5000,
    July     3200,
    August   2000/;

  TABLE A(time,place) Left hand side constraint coefficients
            reservoir     spill     diversion
    June     1              0          0
    July     1              0          0
    August   1              0          0;


* 3. DEFINE the variables
VARIABLES X(time,place) Water released by the end of the month to each place
          VPROFIT  total profit ($);

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   MAX_STORAGE(time) Resource Constraints
   MIN_STORAGE minimum storage constraint for august
   MASS_BALANCE(time);

PROFIT..                 VPROFIT =E= SUM((time,place), c(time,place)*X(time,place));
MAX_STORAGE(time) ..    SUM(place, A(time,place)*X(time, "reservoir")) =L= b(time);
MIN_STORAGE..           X("August", "reservoir") =G= 3000; 
MASS_BAlANCE(time)..         X(time, "reservoir") 
                           - sum(tprev$(ord(tprev) = ord(time)-1), X(tprev,"reservoir")) - 3000$(ord(time)=1)
                           + X(time, "spill")
                           + X(time, "diversion")
                           =E= i(time);


* 5. DEFINE the MODEL from the EQUATIONS
MODEL RELEASE /PROFIT, MAX_STORAGE, MIN_STORAGE, MASS_BALANCE/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;


* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE RELEASE USING LP MAXIMIZING VPROFIT;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
