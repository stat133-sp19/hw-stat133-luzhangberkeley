context("summary measurement functions work as expected")

test_that("test for aux_mean",{
  trials=3
  prob=0.5
  expect_type(aux_mean(trials,prob),'double')
  expect_length(aux_mean(trials,prob),1)
  expect_equal(aux_mean(trials,prob),trials*prob)
})

test_that("test for aux_variance",{
  trials=7
  prob=0.7
  expect_type(aux_variance(trials,prob),'double')
  expect_equal(aux_variance(trials,prob),trials*prob*(1-prob))
  expect_length(aux_variance(trials,prob),1)
})

test_that("test for aux_mode",{
  trials=10
  prob=0.3
  expect_type(aux_mode(trials,prob),'double')
  expect_length(aux_mode(trials,prob),1)
  expect_equal(aux_mode(trials,prob),3)
})

test_that("test for aux_skewness",{
  trials=10
  prob=0.3
  expect_type(aux_skewness(trials,prob),'double')
  expect_length(aux_skewness(trials,prob),1)
  expect_equal(aux_skewness(trials,prob),(1-2*prob)/sqrt(trials*prob*(1-prob)))
  })

test_that("test for aux_kurtosis",{
  trials=10
  prob=0.3
  expect_type(aux_kurtosis(trials,prob),'double')
  expect_length(aux_kurtosis(trials,prob),1)
  expect_equal(aux_kurtosis(trials,prob),(1-6*prob*(1-prob))/(trials*prob*(1-prob)))
})
