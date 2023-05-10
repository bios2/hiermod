data {
  int<lower=0> Nsites;         // num of sites in the dataset
  // int<lower=1> 2;              // num of site predictors
  int<lower=1> S;              // num of species
  matrix[Nsites, 2] x;         // site-level predictors
  array[Nsites, S] int<lower=0, upper=1> y;  // species presence or absence
}
transformed data {
 vector<lower=0>[2] sd_params = [0.5, 0.5]'; 
}
parameters {
  // species departures from the average
  matrix[2, S] z;               
  // AVERAGE of slopes and intercepts
  vector[2] gamma;
}
transformed parameters {
  matrix[2, S] beta = rep_matrix(gamma, S) + diag_pre_multiply(sd_params, z);
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
  gamma ~ normal(0, 2);
}
