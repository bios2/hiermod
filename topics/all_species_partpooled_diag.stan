data {
  int<lower=0> Nsites;         // num of sites in the dataset
  int<lower=1> K;              // num of site predictors
  int<lower=1> S;              // num of species
  matrix[Nsites, K] x;         // site-level predictors
  array[Nsites, S] int<lower=0, upper=1> y;  // species presence or absence
}
parameters {
  matrix[K, S] z;               // species departures from the average
  vector[K] gamma;              // AVERAGE of slopes and intercepts
  vector<lower=0>[K] sd_params;          // standard deviations of species departures
}
transformed parameters {
  matrix[K, S] beta = rep_matrix(gamma, S) + diag_pre_multiply(sd_params, z);
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
  gamma ~ normal(0, 2);
}
