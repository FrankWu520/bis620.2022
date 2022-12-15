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
  "The fit4() returns a matrix object.",
  {
    data(svi)
    data(covid)
    f <- fit4(svi, covid)
    expect_true(inherits(f, "numeric"))
  }
)

test_that(
  "The rf() returns a mv.multiclass.roc object.",
  {
    data(svi)
    rf <- rf(svi)
    expect_true(inherits(rf, "mv.multiclass.roc"))
  }
)

test_that(
  "The model_plot() returns a ggplot object.",
  {
    data(svi)
    data(covid)
    p <- model_plot(svi, covid, model = 1)
    expect_true(inherits(p, "gg"))
  }
)

test_that(
  "The model_plot() returns a ggplot object.",
  {
    data(svi)
    data(covid)
    p <- model_plot(svi, covid, model = 2)
    expect_true(inherits(p, "gg"))
  }
)

test_that(
  "The model_plot() returns a ggplot object.",
  {
    data(svi)
    data(covid)
    p <- model_plot(svi, covid, model = 3)
    expect_true(inherits(p, "gg"))
  }
)

test_that(
  "The model_plot() returns a ggplot object.",
  {
    data(svi)
    data(covid)
    p <- model_plot(svi, covid, model = 4)
    expect_true(inherits(p, "gg"))
  }
)
