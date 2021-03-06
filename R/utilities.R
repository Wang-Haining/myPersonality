getDisplayName <- function(db_name) {
  # Get usr-friendly table name based on the actual table name
  if (exists(".meta.tables")) {
    # Local cache
    return(as.character(.meta.tables[as.character(.meta.tables$db_name) == as.character(db_name),]$display_name))
  } else {
    # Fetch from db
    sql <- sprintf('SELECT display_name FROM _meta_tables WHERE db_name = "%s"', db_name)
    return(as.character(myPersonalitySQL(sql)$display_name))
  }
}

getDbName <- function(display_name) {
  # Get usr-friendly table name based on the actual table name
  if (exists(".meta.tables")) {
    # Local cache
    return(as.character(.meta.tables[as.character(.meta.tables$display_name) == as.character(display_name),]$db_name))
  } else {
    sql <- sprintf('SELECT db_name FROM _meta_tables WHERE display_name = "%s"', display_name)
    return(myPersonalitySQL(sql)$db_name)
  }
}

showInfo <- function(x, prefix = "", postfix = "\n") {
  if (is.null(x)) {return(invisible(x))}
  if (!x %in% c(NA, "", " ")) {
    if (!prefix == "") {cat(prefix)}
    cat(as.character(x), postfix, sep = "")
  }
}

defactor <- function(df) {
  for (i in 1:ncol(df)) {
    if (class(df[, i]) == "factor") {
      df[, i] <- as.character(df[, i])
    }
  }
  return(df)
}