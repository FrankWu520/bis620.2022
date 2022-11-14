test_that(
  "The accel_plot() returns a ggplot object.",
  {
    data(ukb_accel)
    p <- accel_plot(ukb_accel[1:100, ])
    expect_true(inherits(p, "gg"))
  }
)

test_that(
  "The accel_plot() errors when no time or freq column.",
  {
    data(iris)
    expect_error(accel_plot(iris))
  }
)

test_that(
  "The accel_plot() is correct for time-series data.",
  {
    data(ukb_accel)
    p <- accel_plot(ukb_accel[1:100, ])
    vdiffr::expect_doppelganger("first-100-samples", p)
  }
)

test_that(
  "The accel_plot() returns a ggplot object.",
  {
    data(ukb_accel)
    ukb_accel <- ukb_accel |> select(X, Y, Z)
    ukb_accel$freq <- 1
    p <- accel_plot(ukb_accel[1:100, ])
    expect_true(inherits(p, "gg"))
  }
)

test_that(
  "The accel_plot() returns a ggplot object with a freq column.",
  {
    data(ukb_accel)
    ukb_accel <- ukb_accel |> select(X, Y, Z)
    ukb_accel$freq <- 1
    p <- accel_plot(ukb_accel[1:100, ])
    expect_true(inherits(p, "gg"))
  }
)

test_that(
  "The hello() sets invisible and returns a character.",
  {
    ret <- hello(invisible = TRUE)
    expect_true(inherits(ret, "character"))
  }
)

test_that(
  "The hello() receives a name and returns a character.",
  {
    ret <- hello(name = "Frank", invisible = FALSE)
    expect_true(inherits(ret, "character"))
  }
)

test_that(
  "The spectral() returns a tbl object.",
  {
    data(ukb_accel)
    p <- spectral_signature(ukb_accel[1:100, ], take_log = TRUE)
    expect_true(inherits(p, "tbl"))
  }
)
