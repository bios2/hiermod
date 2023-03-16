size_from_time <- function(l1, lm, r, x){
  l1 * exp(-r * x) + lm * (1 - exp(-r * x))
}

curve(size_from_time(35, 120, r = 0.92, x = x))

dead_from_size <- function(m, q, S){
  m * exp(-q * S)
}

curve(dead_from_size(.6, .05, S = x), xlim = c(0, 100))


curve(dead_from_size(.6, .05,
                     S = size_from_time(35, 90, r = .92, x = x)),
      xlim = c(0, 1))

