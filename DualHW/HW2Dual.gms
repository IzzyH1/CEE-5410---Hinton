$ontext
CEE 6410 - Water Resources Systems Analysis
Example 2.1 from Bishop Et Al Text (https://digitalcommons.usu.edu/ecstatic_all/76/)
Modifies Example to add a labor constraint

THE PROBLEM:

An irrigated farm can be planted in two crops:  eggplants and tomatoes.  Data are as fol-lows:

Seasonal Resource
Inputs or Profit        Crops        Resource
Availability
        Eggplant        Tomatoes
Water        1x103 gal/plant        2x103 gal/plant      4x106 gal/year
Land        4 ft2/plant        3 ft2/plant               1.2x104 ft2
Labor         5hr/plant        2.5/hr plant              17,500 hours
Profit/plant        $6        $7

                Determine the optimal planting for the two crops.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

David E Rosenberg
david.rosenberg@usu.edu
September 15, 2015
$offtext

* 1. DEFINE the SETS
SETS plnt crops growing /Hay, Grain/
     res resources /June, July, August, Land/;

* 2. DEFINE input data
PARAMETERS
   c(plnt) Objective function coefficients ($ per acre of crop)
         /Hay 100,
        Grain 120 /

   b(res) Right hand constraint values (per resource)
          /June 14000,
           July  18000,
           August 6000,
           Land   10000/;

TABLE A(plnt,res) Left hand side constraint coefficients
            June    July     August   Land
 Hay          2      1          1       1
 Grain        1      2          0       1;


* 3. DEFINE the variables
VARIABLES X(plnt) plants planted (Number)
          VPROFIT  total profit ($)
          Y(res) value of resources used
          VREDCOST total reduced cost;

* Non-negativity constraints
POSITIVE VARIABLES X, Y;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   RES_CONSTRAIN(res) Resource Constraints
   REDCOST_DUAL Reduced Cost ($) associated with using resources
   RES_CONS_DUAL(plnt) Profit levels ;

PROFIT..                 VPROFIT =E= SUM(plnt, c(plnt)*X(plnt));
RES_CONSTRAIN(res) ..    SUM(plnt, A(plnt,res)*X(plnt)) =L= b(res);

*Dual Equations
REDCOST_DUAL..                 VREDCOST =E= SUM(res,b(res)*Y(res));
RES_CONS_DUAL(plnt)..          sum(res,A(plnt,res)*Y(res)) =G= c(plnt);

* 5. DEFINE the MODEL from the EQUATIONS
MODEL PLANTING_PRIMAL /PROFIT, RES_CONSTRAIN/;
MODEL PLANTING_DUAL /REDCOST_DUAL, RES_CONS_DUAL/
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;


* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PLANTING_DUAL USING LP MINIMIZING VREDCOST;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
