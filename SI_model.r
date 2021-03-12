install.packages("EpiModel")
library(EpiModel)


# Running a Basic Susceptible-Infected (SI) disease model in which there is random mixing within the population
#`contact’’ has been defined several ways in the modeling literature, we use the word act to represent the action, 
# such as face-to-face discussion or sexual intercourse, by which disease may be transmitted

# To simulate a deterministic model in EpiModel, use the dcm function
# Prior to running the model, it is necessary to parameterize it. 

# param.dcm, the epidemic model parameters are entered
# inf.prob argument sets the transmission probability per act
# act.rate sets the acts per person per unit time
# init.dcm function collects the initial conditions for the model
# control.dcm finally collects other structural model controls like the model type and number of time steps for the simulation

param <- param.dcm(inf.prob = 0.5, act.rate = 0.25)
init <- init.dcm(s.num = 500, i.num = 1)
control <- control.dcm(type = "SI", nsteps = 100)

# model parameters, initial conditions, and controls are then entered as inputs into the dcm function to run the model 
# and save the output in our object mod
mod <- dcm(param, init, control)
mod

EpiModel Simulation
=======================
  Model class: dcm

Simulation Summary
-----------------------
  Model type: SI
No. runs: 1
No. time steps: 100
No. groups: 1

Model Parameters
-----------------------
  inf.prob = 0.5
act.rate = 0.25

Model Output
-----------------------
  Variables: s.num i.num si.flow num


# plot the results of the model we use the generic plot function
plot(mod)



# After examining the plot, one can investigate the the size of each compartment at a specific time step.
summary(mod, at = 50)

EpiModel Summary
=======================
  Model class: dcm

Simulation Summary
-----------------------
  Model type: SI
No. runs: 1
No. time steps:
  No. groups: 1

Model Statistics
------------------------------
  Time: 50	 Run: 1 
------------------------------ 
  n    pct
Suscept.  261.717  0.522
Infect.   239.283  0.478
Total     501.000  1.000
S -> I     15.648     NA
------------------------------
  
