#' Compare by ID
#'
#' this function compares to tables by ID column.
#' @param table1 First data frame
#' @param table2 Second data frame
#' @param id Name of the ID column
#' @return A data frame with discrepancies
#' @export

compare.tables <- function(table1, table2, id) {
  # check data.frame
  if(! (is.data.frame(table1) & is.data.frame(table2))) {
    stop(message = "error: supplied tables do not fail condition is.data.frame()")
  }
  # check ID variable
  if(! (id %in% names(table1) & id %in% names(table2))) {
    stop(message = "error: ID variable does not match supplied tables")
  }
  # check supplied variables in tables (length)
  if(length(names(table1)) != length(names(table2))) {
    stop(message = "error: tables have different variable count. Compare 'names(table)'")
  }
  # check supplied variables in tables (names)
  if(!all(names(table1) == names(table2))) {
        print("Unmatched variable names")
        print(c("table1: ", names(table1)[!(names(table1) == names(table2))]))
        print(c("table2: ", names(table2)[!(names(table1) == names(table2))]))
        stop("supplied tables have different variable names. If you wish to continue, set 'continue_if_diff_names = TRUE'")
  }
  # check if supplied data frames have different observations
  if(nrow(table1) != nrow(table2)) {
    warning("supplied tables have differences in nrow()")
  }
  # main function
  merged <- merge(table1, table2, by = id, suffixes = c("_A", "_B"))
  result <- as.data.frame(x = merged[,id])
  names(result) <- id
  final <- result
  var_names <- setdiff(names(table1), id)
  # pasting compared cols into one df
  for(var in var_names) {
    col1 <- merged[[paste0(var, "_A")]]
    col2 <- merged[[paste0(var, "_B")]]
    result <- ifelse(is.na(col1) & is.na(col2), NA,
                ifelse(xor(is.na(col1), is.na(col2)), -88,
                   ifelse(col1 == col2, col1, -99)))
# creating the final table
    final[[var]] <- result
  }
  return(final)
}
