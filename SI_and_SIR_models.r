install.packages("EpiModel")
library(EpiModel)


# Running a Basic Susceptible-Infected (SI) disease model in which there is random mixing within the population
#`contact’ has been defined several ways in the modeling literature, we use the word act to represent the action, 
# such as face-to-face discussion or sexual intercourse, by which disease may be transmitted

# To simulate a deterministic model in EpiModel, use the dcm function
# Prior to running the model, it is necessary to parameterize it. 

# param.dcm, the epidemic model parameters are entered
# inf.prob argument sets the transmission probability per act
# act.rate sets the acts (aka contact) per person per unit time
# init.dcm function collects the initial conditions for the model
# control.dcm finally collects other structural model controls like the model type and number of time steps for the simulation
# nsteps is the amount of time
# type is the type of model, in this case Susceptible-Infected (SI) disease model

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
  

  
# New model    

  # Simulation
# SIR Model with Demography
  
  # param.dcm: parameters for the recovery rate, birth rate, and state-specific death rates
# init.dcm: number of initially recovered
# control.dcm: dt:  model results in fractional time units

  
param <- param.dcm(inf.prob = 0.2, act.rate = 1, rec.rate = 1/20,
                     a.rate = 1/95, ds.rate = 1/100, di.rate = 1/80, dr.rate = 1/100)
init <- init.dcm(s.num = 1000, i.num = 1, r.num = 0)
control <- control.dcm(type = "SIR", nsteps = 500, dt = 0.5)
mod <- dcm(param, init, control)

# Plotting

# popfrac=FALSE argument plots the compartment size (rather than prevalence) 
# alpha increases the transparency of the lines for better visualization
# By default, the plot function will plot the prevalences for all compartments in the model, 
# but in the right plot we override that using the
# si.flow - y argument to specify that disease incidence 

# legend options are set using the legend
# specify a single line color, a vector of colors, or a color palette using the col
par(mar = c(3.2, 3, 2, 1), mgp = c(2, 1, 0), mfrow = c(1, 2))
plot(mod, popfrac = FALSE, alpha = 0.5,
     lwd = 4, main = "Compartment Sizes")
plot(mod, y = "si.flow", lwd = 4, col = "firebrick",
     main = "Disease Incidence", legend = "n")

# Summaries
# Previously, the time-specific model values were calculated with the summary function. To visualize that information, use the comp_plot function. 
# This plot provides astate-flow diagram that is often presented in the epidemiological literature. 

par(mfrow = c(1, 1))
comp_plot(mod, at = 50, digits = 1)

