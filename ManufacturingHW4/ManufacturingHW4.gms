$ontext
CEE 6410 - Water Resources Systems Analysis
HW4 Problem 2

THE PROBLEM:

Shelving units are distributed from manufacturers to suppliers to recipients. Data is as follows:

Maximum number of shelves manufacturers can produce:
Arnold: 75
Supershelf: 75

Minimum number of shelves needed at recipients:
Zrox: 50
Hewes: 60
Rock-Wright: 40

Cost to ship from manufacturer to supplier
                 Thomas    Wash-Burn  
 Arnold             5          8     
 Supershelf         7          4
 
Cost to ship from supplier to recipient
                  Zrox        Hewes     Rock-Wright
Thomas              1           5           8
Wash-Burn           3           4           4

                Determine the optimal path for delivery that will minimize cost of shipping.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

Izzy Hinton
isabel.hinton@usu.edu
October 04, 2026
$offtext

* 1. DEFINE the SETS
SETS man manufacturers /Arnold, Supershelf/
     sup suppliers /Thomas, Wash-Burn/
     recip recipients /Zrox, Hewes, Rock-Wright/;

* 2. DEFINE input data

TABLE MantoSupCosts(man,sup) Costs to ship from each manufacturer to each supplier objective function coefficients
                 Thomas    Wash-Burn  
 Arnold             5          8     
 Supershelf         7          4;
 
TABLE SuptoRecipCosts(sup, recip) Costs to ship from each supplier to each recipient objective function coeffiecients
                  Zrox        Hewes     Rock-Wright
Thomas              1           5           8
Wash-Burn           3           4           4;

Parameters mintorecips(recip) minimum number of shelves that need to be delivered to each recipient
    /Zrox   50,
    Hewes   60,
    Rock-Wright 40/;

* 3. DEFINE the variables
VARIABLES X(man,sup) shelves shipped from a manufacturer to a supplier (Number)
          Y(sup, recip) shelves shipped from a supplier to a recipient (Number)
          VCOST  total cost ($);

* Non-negativity constraints
POSITIVE VARIABLES X, Y;

* 4. COMBINE variables and data in equations
EQUATIONS
   COST Total cost ($) and objective function value
   MAN_CONSTRAIN(man) Constraints on manufacturing supplies
   SUP_CONSTRAIN(sup) Constraints on what suppliers are able to ship to recipients
   RECIP_CONSTRAIN(recip) Constraints on minimum shelves that need to be delivered to recipients;

COST..                   VCOST =E= SUM((man,sup), MantoSupCosts(man,sup)*X(man,sup)) + SUM((sup, recip), SuptoRecipCosts(sup, recip)*Y(sup, recip));
MAN_CONSTRAIN(man)..     Sum(sup, X(man, sup)) =L= 75;
SUP_CONSTRAIN(sup)..     Sum(man, X(man, sup)) =G= Sum(recip, Y(sup,recip));
RECIP_CONSTRAIN(recip).. Sum(sup, Y(sup, recip)) =G= mintorecips(recip);


* 5. DEFINE the MODEL from the EQUATIONS
MODEL DELIVERING /ALL/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;


* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE DELIVERING USING LP MINIMIZING VCOST;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
