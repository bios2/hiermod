data {
  int<lower=0> Nsites;         // num of sites in the dataset
  int<lower=1> S;              // num of species
  matrix[Nsites, 2] x;         // site-level predictors
  array[Nsites, S] int<lower=0, upper=1> y;  // species presence or absence
}
parameters {
  // species departures from the average
  matrix[2, S] z;               
  // AVERAGE of slopes and intercepts
  vector[2] gamma;              
  // standard deviations of species departures
  vector<lower=0>[2] sd_params; 
  // add the correlations between slope and intercept
  cholesky_factor_corr[2] slope_inter_corr;
}
transformed parameters {
  matrix[2, S] beta = rep_matrix(gamma, S) + 
    diag_pre_multiply(sd_params, slope_inter_corr) * z;
}
model {
  matrix[Nsites, S] mu;
  // calculate the model average
  mu = x * beta;
  // Likelihood
  for (s in 1:S) {
    y[,s] ~ bernoulli_logit(mu[,s]);
  }
  // priors
  to_vector(z) ~ std_normal();
  sd_params ~ exponential(2);
  gamma ~ normal(0, .5);
  slope_inter_corr ~ lkj_corr_cholesky(2);
}

