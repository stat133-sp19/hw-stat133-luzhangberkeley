context("binomial functions work as expected")

test_that("test for bin_choose",{
  trials1=3
  success1=2
  trials2=5
  success2=7
  expect_type(bin_choose(trials1,success1),'double')
  expect_length(bin_choose(trials1,success1),1)
  expect_error(bin_choose(trials2,success2),"k can't be greater than n.")
})

test_that("test for bin_probability",{
  success1=4
  trials1=5
  prob1=0.7
  success2=6
  expect_type(bin_probability(success1,trials1,prob1),'double')
  expect_length(bin_probability(success1,trials1,prob1),1)
  expect_error(bin_probability(success2,trials1,prob1),"\n 'success' should be less than or equal to 'trials'.")
})

test_that("test for bin_distribution",{
  trials=8
  prob=0.7
  prob1=2
  expect_is(bin_distribution(trials,prob),'bindis')
  expect_error(bin_distribution(trials,prob1),"\n 'prob' has to be a number betwen 0 and 1")
  expect_type(bin_distribution(trials,prob),'list')
})

test_that("test for bin_cumulative",{
  trials=8
  prob=0.7
  prob1=2
  expect_is(bin_cumulative(trials,prob),'bincum')
  expect_error(bin_cumulative(trials,prob1),"\n 'prob' has to be a number betwen 0 and 1")
  expect_type(bin_cumulative(trials,prob),'list')
})
