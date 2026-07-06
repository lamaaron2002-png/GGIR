writeCatigraphyPartErrors = function(errors, metadatadir, part) {
  results_dir = file.path(metadatadir, "results")
  if (!dir.exists(results_dir)) dir.create(results_dir, recursive = TRUE)
  output_file = file.path(results_dir, "catigraphy_participant_errors.csv")
  stage_name = paste0("GGIR Part ", part)
  new_rows = data.frame(
    file = names(errors),
    stage = stage_name,
    error = as.character(unlist(errors)),
    stringsAsFactors = FALSE
  )
  if (file.exists(output_file)) {
    existing_rows = tryCatch(
      data.table::fread(output_file, data.table = FALSE),
      error = function(...) NULL
    )
    if (!is.null(existing_rows) && all(names(new_rows) %in% names(existing_rows))) {
      existing_rows = existing_rows[existing_rows$stage != stage_name, names(new_rows)]
      new_rows = unique(rbind(existing_rows, new_rows))
    }
  }
  if (nrow(new_rows) == 0) {
    if (file.exists(output_file)) unlink(output_file)
  } else {
    data.table::fwrite(new_rows, output_file)
  }
  invisible(output_file)
}
