# Hierarchical models in ecology

* one-parameter models
  * simulation
    * what simulation is and why we do it
    * simulation in R
    * simulation in Stan -- first intro to Stan syntax
  * model fit to simulated data
    * simple example: number of birds we see in a day
    * recovering a parameter
    * bayesplot
    * tidybayes
    * possible exercise: effect of sample size
    * making predictions -- for new observers
    * real data application: mite abundance (ONE species)
* hierarchical models
    * learning the prior from the data -- one way to think about hyperpriors
    * random-intercept model for our bird example -- differing birding skill among participants
    * simulate data and fit 
    * real data application: random intercept model for ONE mite species (no predictors)
    * making predictions -- hierarchical models and "focus".
    * regularization and sample size -- simulated differences
    * random intercepts have information: intercepts correlate with plot variables (water)
    * When not to do a hierachical model: negative binomial distribution
* Univariate regression (one slope)
    * What poisson regression looks like
    * Intro to matrix multiplication in linear models
    * fitting in Stan
    * Predictions -- plotting in tidybayes
    * Comparison with intercept-only model: random effect is "smaller"
* Other models: Binomial GLM
    * redo the workflow from above:
    * prior simulations (narrow on the logit scale)
    * parameter recovery
    * fit to real data
    * plotting
* Multiple regression
    * form of the model (math)
    * code for the model (using matrix multiplication)
    * Causal inference with DAGs
    
    
    

    
  

-   simple linear regression
    -   data simulation
    -   parameter recovery
-   simple logistic regression (1 species)
    -   link functions
    -   posterior predictive checks
-   multiple species logistic regression
    -   parameter distributions
    -   "secret weapon"
    -   log likelihood / IC
-   multiple species
