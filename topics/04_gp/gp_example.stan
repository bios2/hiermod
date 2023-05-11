// Fit the hyperparameters of a latent-variable Gaussian process with an
// exponentiated quadratic kernel and a Bernoulli likelihood
// This code is from https://github.com/stan-dev/example-models/blob/master/misc/gaussian-process/gp-fit-logit.stan
data {
  int<lower=1> N;
  array[N] real x;
  array[N] int<lower=0, upper=1> z;
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
model {
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
  
  rho ~ inv_gamma(5, 15`);
  alpha ~ normal(0, .8);
  a ~ normal(0, 1);
  eta ~ normal(0, 1);
  
  z ~ bernoulli_logit(a + f);
}
generated quantities {
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
  vector[N] logit_mu = a + f;
}