#' Create a Random Forest Model.
#' This function creates a random forest model:
#' EP_POV ~ EP_DISABL + EP_LIMENG + EP_MINRTY + EP_NOHSDP + EP_SNGPNT
#' @param x an object inherited from svi data.frame.
#' @return the summary table of the random forest model, the plot of the error
#' rate, the ROC table, and the AUC score.
#' @importFrom dplyr filter mutate select
#' @importFrom caret createDataPartition confusionMatrix
#' @importFrom randomForest randomForest
#' @importFrom stats na.omit predict
#' @importFrom utils head
#' @importFrom pROC multiclass.roc
#' @examples
#' data(svi)
#' randforest(svi)
#' @export

randforest <- function(x) {
  # Data cleaning
  x[x == -999] <- NA
  x <- x|>
    filter(E_TOTPOP != 0) |>
    mutate(EP_DISABL = EP_DISABL / 100, EP_LIMENG = EP_LIMENG / 100,
           EP_MINRTY = EP_MINRTY / 100, EP_NOHSDP = EP_NOHSDP / 100,
           EP_POV = EP_POV / 100, EP_SNGPNT = EP_SNGPNT / 100) |>
    select(EP_DISABL, EP_LIMENG, EP_MINRTY, EP_NOHSDP, EP_POV, EP_SNGPNT) |>
    na.omit()
  # Categorize EP_POV (poverty)
  x$EP_POV[x$EP_POV >= 0.25] <- "Poor"
  x$EP_POV[(x$EP_POV < 0.25) & (x$EP_POV >= 0.1)] <- "Medium"
  x$EP_POV[x$EP_POV < 0.1] <- "Rich"
  # Prepare training set and test set
  set.seed(2022)
  trainlist <- createDataPartition(x$EP_POV, p = 0.8, list = FALSE)
  trainset <- x[trainlist, ]
  testset <- x[-trainlist, ]
  # Random forest model
  rf_train <- randomForest(as.factor(EP_POV) ~ ., data = trainset,
                           importance = TRUE)
  print("Model Result")
  print(rf_train)
  # Create confusion matrix
  rf_test <- predict(rf_train, newdata = testset, type = "class")
  con_mat <- confusionMatrix(as.factor(rf_test), as.factor(testset$EP_POV))
  cat("\n")
  cat("\n")
  print("Predicting Result")
  print(con_mat)
  # Create ROC table
  rf_test2 <- predict(rf_train, newdata = testset, type = "prob")
  cat("\n")
  cat("\n")
  print("ROC Table")
  print(head(rf_test2))
  # Find AUC score
  auc <- multiclass.roc(testset$EP_POV, rf_test2)
  cat("\n")
  cat("\n")
  print("AUC Score")
  print(auc)
  # Plot error rate
  plot(rf_train, main = "Error vs Number of Trees")
}
