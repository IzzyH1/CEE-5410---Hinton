$ontext
CEE 6410 - Water Resources Systems Analysis
Example Coups Minivans from Lecture Example 2 

THE PROBLEM:

A vehicle manufacturer can produce two different kinds of vehicles: Coups and Minivans.  Data are as follows:


                        Coups                       Minivans            Availability
Metal               1x103 lb/vehicle           2x103 lb/vehicle        4x106 lb/year
Circuit Boards      4 number/vehicle           3 number/vehicle        1.2x104 number
Labor             5 worker days/vehicle     2.5 worker days/vehicle    17,500 worker days
Profit/vehicle          $6,000                       $7,000

                Determine the optimal manufacturing for the two vehicles.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

David E Rosenberg
david.rosenberg@usu.edu
September 15, 2015
$offtext

* 1. DEFINE the SETS
SETS vehicles Type of vehicle to produce /Coup, Minivan/
     res resources /Metal, CircuitBoards, Labor/;

* 2. DEFINE input data
PARAMETERS
   c(vehicles) Objective function coefficients ($ per vehicle)
         /Coup 6000,
        Minivan 7000 /

   b(res) Right hand constraint values (per resource)
          /Metal 4000000,
           CircuitBoards  12000,
           Labor  17500/;

TABLE A(vehicles,res) Left hand side constraint coefficients
                 Metal    CircuitBoards   Labor
 Coup           1000      4                 5
 Minivan        2000      3                 2.5;


* 3. DEFINE the variables
VARIABLES X(vehicles) vehicles manufactured (Number)
          VPROFIT  total profit ($);

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   RES_CONSTRAIN(res) Resource Constraints;

PROFIT..                 VPROFIT =E= SUM(vehicles, c(vehicles)*X(vehicles));
RES_CONSTRAIN(res) ..    SUM(vehicles, A(vehicles,res)*X(vehicles)) =L= b(res);


* 5. DEFINE the MODEL from the EQUATIONS
MODEL Vehicle_Manufacturing /PROFIT, RES_CONSTRAIN/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;


* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE Vehicle_Manufacturing USING LP MAXIMIZING VPROFIT;

* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
