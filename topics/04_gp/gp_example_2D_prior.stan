// Fit the hyperparameters of a latent-variable Gaussian process with an
// exponentiated quadratic kernel and a Bernoulli likelihood
// This code is from https://github.com/stan-dev/example-models/blob/master/misc/gaussian-process/gp-fit-logit.stan
data {
  // int<lower=1> Nobs;
  int<lower=1> N;
  array[N] vector[2] x;
  real rho_a;
  real rho_b;
  // array[Nobs] int<lower=0, upper=1> z;
}
transformed data {
  real delta = 1e-9;
}
parameters {
  real<lower=0> rho;
  real<lower=0> alpha;
  real a;
  vector[N] eta;
}
transformed parameters {
  vector[N] f;
  {
    matrix[N, N] L_K;
    matrix[N, N] K = gp_exp_quad_cov(x, alpha, rho);
    
    // diagonal elements
    for (n in 1 : N) {
      K[n, n] = K[n, n] + delta;
    }
    
    L_K = cholesky_decompose(K);
    f = L_K * eta;
  }
}
model {
  rho ~ inv_gamma(rho_a, rho_b);
  alpha ~ normal(0, .8);
  a ~ normal(0, .2);
  eta ~ std_normal();
  // z ~ bernoulli_logit(a + f[1:Nobs]);
}