test_that(
  "The fit1() returns a matrix object.",
  {
    data(svi)
    f <- fit1(svi)
    expect_true(inherits(f, "numeric"))
  }
)

test_that(
  "The fit2() returns a matrix object.",
  {
    data(svi)
    f <- fit2(svi)
    expect_true(inherits(f, "numeric"))
  }
)

test_that(
  "The fit3() returns a matrix object.",
  {
    data(svi)
    f <- fit3(svi)
    expect_true(inherits(f, "numeric"))
  }
)

test_that(
  "The model_plot() returns a ggplot object.",
  {
    data(svi)
    p <- model_plot(svi, model = 1)
    expect_true(inherits(p, "gg"))
  }
)

test_that(
  "The model_plot() returns a ggplot object.",
  {
    data(svi)
    p <- model_plot(svi, model = 2)
    expect_true(inherits(p, "gg"))
  }
)

test_that(
  "The model_plot() returns a ggplot object.",
  {
    data(svi)
    p <- model_plot(svi, model = 3)
    expect_true(inherits(p, "gg"))
  }
)
