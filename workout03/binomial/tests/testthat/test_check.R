context("checkers work as expected")

test_that("test for check_prob",{
  x=0.4
  y=4
  expect_true(check_prob(x))
  expect_length(check_prob(x),1)
  expect_type(check_prob(x),'logical')
  expect_error(check_prob(y),"\n 'prob' has to be a number betwen 0 and 1")
}
          )

test_that("test for check_trials",{
  x=4
  y=0.4
  z=-1
  expect_true(check_trials(x))
  expect_type(check_trials(x),'logical')
  expect_error(check_trials(y),"\n 'trials' value should be integer")
  expect_error(check_trials(z),"\n 'trials' should be non-negative")
})

test_that("test for check_success",{
  trial=6
  x=4
  y=7
  z=0.5
  expect_type(check_success(x,trial),'logical')
  expect_true(check_success(x,trial))
  expect_error(check_success(y,trial),"\n 'success' should be less than or equal to 'trials'.")
  expect_error(check_success(z,trial),"\n 'success' should be an integer.")
})
