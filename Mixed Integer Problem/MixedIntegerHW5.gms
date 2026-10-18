$ontext
CEE 6410 Fall 2015
Example 6 in the Lecture notes for 9/29

Minimize cost to supply water by a new treatment plant or wholesale contract
This is the relaxed version that treats the interger decision variables
as standard, positive, continuous variables.
With the additional $35,000 capital cost for establishing the wholesale contract.

Integer version using INTEGER VARIABLES statement and SOLVE as MIP.

David E Rosenberg
david.rosenberg@usu.edu
September 28, 2015
$offtext

* 1. DEFINE the SETS
SETS
src irrigation water sources /hd "high dam", ld "low dam", rd "river diversion"/
time season that irrigation occurs in /w "winter", s "spring"/;

* 2. DEFINE input data
PARAMETERS
   CapCost(src) capital cost ($ to build)
         /hd 10000,
          ld 6000,
          rd 8000/
   OpCost(src) operating cost ($ per ac-ft)
         /hd 0,
          ld 0,
          rd 20/
  WaterDemand(time) volume of water required for an acre of crop (ac-ft per acre)
        /w 1,
         s 3/
* river diversion capacity was given in ac-ft/day multiplying by 365/2 gives the semi-annual capacity  
    Capacity(src) maximum volume of water that can be extraced from a source (ac-ft)
        /hd 700,
        ld 300,
        rd 401.5/
    Inflow(time) volume of water flowing into the reservoir each season (ac-ft)
        /w 600,
         s 200/
    Revenue rate of revenue produced from each irrigated acre ($ per acre) /300/
*GroundWater is 2 ac-ft/day multiplied by 365/2 for the gw recharge for 1 time step
    GroundWater volume of water that is added to the river flow through groundwater (ac-ft) /365/;

* 3. DEFINE the variables
VARIABLES I(src) binary decision to build or develop project from source src (1=yes 0=no)
          X(src,time) volume of water provided by source src (ac-ft per year)
          TPROFIT total profit (revenue from irrigation minus cost to irrigate) ($);

BINARY VARIABLES I;

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   TotalRev             Total revenue ($) and objective function value
   OneDam              Only one dam can be built
   MassBalance         Mass Balance for river diversion
   CapacityConstraint  The water from each source must be less than its' maximum capacity;

TotalRev..                 TPROFIT =E= SUM((src,time), Revenue*WaterDemand(time)*X(src,time))-Sum(src, CapCost(src)*I(src)) - SUM((src,time), OpCost(src)*X(src,time));
OneDam..              I("hd") + I("ld") =L= 1;
MassBalance(time)..         X("rd", time) =L= Inflow(time) - X("hd",time) - X("ld", time) + GroundWater;
CapacityConstraint(src,time)..    X(src,time) =L= Capacity(src)*I(src);

* 5. DEFINE the MODEL from the EQUATIONS
MODEL IrrigationSources /ALL/;

* 6. Solve the Model as an LP (relaxed IP)
SOLVE IrrigationSources USING MIP MAXIMIZING TPROFIT;




