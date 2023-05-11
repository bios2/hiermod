functions{
    matrix cov_GPL2(matrix x, real sq_alpha, real sq_rho, real sigma_intercept) {
        int N = dims(x)[1];
        matrix[N, N] K;
        for (i in 1:(N-1)) {
          K[i, i] = sq_alpha + sigma_intercept;
          for (j in (i + 1):N) {
            K[i, j] = sq_alpha * exp(-sq_rho * square(x[i,j]) );
            K[j, i] = K[i, j];
          }
        }
        K[N, N] = sq_alpha + sigma_intercept;
        return K;
    }
}
data {
  int<lower=0> N;
  array[N] int<lower=0,upper=1> presabs;
  int<lower=1> Np; // number of unique plot_id
  array[N] int<lower=1,upper=Np> plot_id;
  // n_row of generated matrix distance grid to predict the smooth spatial random effects
  int<lower=1> N_grid;
  // matrix of distance between plots and generated grid -- calculated in R
  matrix[Np + N_grid, Np + N_grid] dist;
}
transformed data {
  real sigma_intercept = 0.01;
  int<lower=1> N_total = Np + N_grid;
  vector[N_total] zeros = rep_vector(0, N_total);
}
parameters {
  real mu;
  vector[N_total] rPlot_logit;
  real<lower=0> sigma_obs;
  real<lower=0> sigma_f;       // scale of f (maximum covariance)
  real<lower=0> lengthscale_f; // lengthscale of f (rate of decline)
  real<lower=0> sigman;        // noise sigma
}
model {
  // covariances and Cholesky decompositions
  matrix[N_total, N_total] K_f = cov_GPL2(dist, sigma_f, lengthscale_f, sigma_intercept);
  matrix[N_total, N_total] L_f = cholesky_decompose(add_diag(K_f, sigman));
  
  // smooth distribution over observed data AND the grid
  // BOTH a prior AND a likelihood at the same time!
  rPlot_log ~ multi_normal_cholesky(zeros, L_f);
  
  // What matters here:
  vector[N] log_prob = 
    mu + // intercept
    rPlot_log[1:Np][plot_id]; // plot random effect

  // priors for average occurance
  mu ~ normal(0, .2);
  // prior for GP parameters
  lengthscale_f ~ normal(0, 1);
  sigma_f ~ normal(0, 1);
  sigman ~ normal(0, 1);

  // likelihood
  presabs ~ poisson_log(log_prob);
}
