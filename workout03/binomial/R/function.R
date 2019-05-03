# check if an input prob is a valid probability value (i.e. 0 <= p <= 1).
check_prob <- function(prob){
  if (prob<0|prob>1){
    stop("\n 'prob' has to be a number betwen 0 and 1")}
  else if (length(prob)!=1){
    stop("\n 'prob' has to be single number")
  }
  else{return(TRUE)}
}
#-------------------------------------------------------------------------

#check if an input trials is a valid value for number of trials (i.e. n is a non-negative integer).
check_trials <- function(trials){
  if (!(round(trials)==trials)){
    stop("\n 'trials' value should be integer")
  }else if (trials<0){
    stop("\n 'trials' should be non-negative")
  }else if (length(trials)!=1){
    stop("\n 'trials' has to be a single number")
  } else {
    return(TRUE)}

}

#----------------------------------------------------------------------------

# check est if an input success is a valid value for number of successes (i.e. 0 <= k <= n).
check_success <- function(success,trials){
  if (!all(success>=0)){
    stop("\n 'success' should be non-negative.")
  }else if (!all(success<=trials)){
    stop("\n 'success' should be less than or equal to 'trials'.")
  }else if(!all(round(success)==success)){
    stop("\n 'success' should be an integer.")
  }else{return(TRUE)}
}

#---------------------------------------------------------------------------

# Mean of Binomial Distribution
aux_mean <- function(trials,prob){
  mean <- trials*prob
  return(mean)
}

# Variance of Binomial Distribution
aux_variance <- function(trials,prob){
  variance <- trials*prob*(1-prob)
  return(variance)
}

# Mode of Binomial Distribution
aux_mode <- function(trials,prob){
  if (round(trials*prob+prob)==trials*prob+prob){
    mode=c(trials*prob+prob,trials*prob+prob-1)
  } else{
    mode=floor(trials*prob+prob)
  }
  return(mode)
}

# Skewness of Binomial Distribution
aux_skewness <- function(trials,prob){
  skewness <- (1-2*prob)/sqrt(trials*prob*(1-prob))
  return(skewness)
}

# Kurtosis of Binomial Distribution
aux_kurtosis <- function(trials,prob){
  kurtosis <- (1-6*prob*(1-prob))/(trials*prob*(1-prob))
  return(kurtosis)
}

#----------------------------------------------------------------------------

#' @title Function bin_choose
#' @description calculates the number of combinations in which k successes can occur in n trials.
#' @param k times of success
#' @param n number of trials
#' @return the bumber of combinations
#' @export
#' @examples
#' # calculates the number of combinations in which 2 successes can occur in 5 trials.
#' bin_choose(n = 5, k = 2)

bin_choose<- function(n,k){
  if (any(k>n)){
    stop("k can't be greater than n.")} else{
      choose <- factorial(n)/(factorial(k)*factorial(n-k))
      return(choose)
    }

}

#---------------------------------------------------------------------------------

#' @title Function bin_probability()
#' @description calculates the probability when k successes can occur in n trials.
#' @param success number of success
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the probability when such situation occurs
#' @export
#' @examples
#' #probability of getting 2 successes in 5 trials
#' # (assuming prob of success = 0.5)
#' bin_probability(success = 2, trials = 5, prob = 0.5)

bin_probability <- function(success,trials,prob){
  check_trials(trials)
  check_prob(prob)
  check_success(success,trials)
  probability <- bin_choose(trials,success)*prob^success*(1-prob)^(trials-success)
  return(probability)
}

#----------------------------------------------------------------------------------

#' @title Function bin_distribution()
#' @description dispaly the probability of different success times.
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the probability distribution data frame
#' @export
#' @examples
#' # binomial probability distribution
#'bin_distribution(trials = 5, prob = 0.5)

bin_distribution <- function(trials,prob){
  distribution <- data.frame(
    success = 0:trials,
    probability = bin_probability(success=0:trials,trials=trials,prob=prob))
  class(distribution) <- c("bindis","data.frame")
  return(distribution)
}
#--------------------------------------------------------------------------------

#' @export
plot.bindis <- function(x,...){
  barplot(x$probability,names.arg=x$success,xlab="successes",ylab="probability",border=NA)
}

# plotting binomial probability distribution
dis1 <- bin_distribution(trials = 5, prob = 0.5)
plot(dis1)

#----------------------------------------------------

#' @title Function bin_cumulative()
#' @description dispaly the probability and cumulative probability of each success times
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the probability and cumulative probability distribution data frame
#' @export
#' @examples
#' # binomial cumulative distribution
#'  bin_cumulative(trials = 5, prob = 0.5)

bin_cumulative <- function(trials,prob){
  probability=bin_probability(success=0:trials,trials=trials,prob=prob)
  cumulative <- rep(0,trials+1)
  for (i in 1:(trials+1)){
    if (i==1){cumulative[i]=probability[i]}
    else{
      cumulative[i]=cumulative[i-1]+probability[i]
    }
  }
  cumulative_prob <- data.frame(
    success=0:trials,
    probability=probability,
    cumulative=cumulative
  )
  class(cumulative_prob)=c("bincum", "data.frame")
  return(cumulative_prob)
}

#----------------------------------------------------------------------------

#' @export
plot.bincum <- function(x,...){
  plot(x=x$success,y=x$cumulative,xlab='succcess',ylab='probability',type="o")
}

dis2 <- bin_cumulative(trials = 5, prob = 0.5)
plot(dis2)

#----------------------------------------------------------------------------

#' @title Function bin_variable()
#' @description dispaly the variable of binimial distribution
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the variable of binimial distribution
#' @export
#' @examples
#' bin_variable(3,0.5)


bin_variable <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  res <- list(
    trials=trials,
    prob=prob
  )

  class(res) <- "binvar"
  return(res)
}
#---------------------------------------------------------------------------

#' @export
print.binvar <- function(x,...){
  cat('"Binomial variable"\n\n')
  cat('Parameters\n')
  cat('- number of trials:',x$trials,'\n')
  cat('- prob of success:', x$prob,'\n')
}

#---------------------------------------------------------------------------

#' @export
summary.binvar <- function(object,...){
  summary <- list(
    trials=object$trials,
    prob=object$prob,
    mean=aux_mean(object$trials,object$prob),
    variance=aux_variance(object$trials,object$prob),
    mode=aux_mode(object$trials,object$prob),
    skewness=aux_skewness(object$trials,object$prob),
    kurtosis=aux_kurtosis(object$trials,object$prob)
  )
  class(summary) <- "summary.binvar"
  return(summary)
}

#' @export
print.summary.binvar <- function(x,...){
  cat('"Binomial variable"\n\n')
  cat('Parameters\n')
  cat('- number of trials:',x$trials,'\n')
  cat('- prob of success:', x$prob,'\n\n')
  cat('Measures\n')
  cat('- mean    :',x$mean,'\n')
  cat('- variance:',x$variance,'\n')
  cat('- mode    :',x$mode,'\n')
  cat('- skewness:',x$skewness,'\n')
  cat('- kurtosis:',x$kurtosis,'\n')
}

#---------------------------------------------------------------------------

#' @title Function bin_mean()
#' @description calculate the mean of the of binimial distribution
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the mean of the of binimial distribution
#' @export
#' @examples
#' bin_mean(3,0.5)

bin_mean <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  mean=aux_mean(trials,prob)
  return(mean)
}

#' @title Function bin_variance()
#' @description calculate the variance of the of binimial distribution
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the variance of the of binimial distribution
#' @export
#' @examples
#' bin_variance(3,0.5)

bin_variance <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  variance=aux_variance(trials,prob)
  return(variance)
}


#' @title Function bin_mode()
#' @description calculate the mode of the of binimial distribution
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the mode of the of binimial distribution
#' @export
#' @examples
#' bin_mode(3,0.5)

bin_mode <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  mode=aux_mode(trials,prob)
  return(mode)
}

#' @title Function bin_skewness()
#' @description calculate the skewness of the of binimial distribution
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the skewness of the of binimial distribution
#' @export
#' @examples
#' bin_skewness(3,0.5)

bin_skewness <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  skewness=aux_skewness(trials,prob)
  return(skewness)
}

#' @title Function bin_kurtosis()
#' @description calculate the kurtosis of the of binimial distribution
#' @param trials  number of trials
#' @param prob    the probability of success
#' @return the kurtosis of the of binimial distribution
#' @export
#' @examples
#' bin_kurtosis(3,0.5)

bin_kurtosis <- function(trials,prob){
  check_trials(trials)
  check_prob(prob)
  kurtosis=aux_kurtosis(trials,prob)
  return(kurtosis)
}
