options(error = function() { traceback(2); quit(status = 1) })
suppressMessages(devtools::load_all('.', quiet = TRUE))
result <- tryCatch({

  espn_mbb_event_powerindex(event_id = 401256760)
}, error = function(e) { cat('ERROR:', conditionMessage(e), '\n'); quit(status = 2) })
cat('---RESULT---\n')
if (is.data.frame(result)) {
  cat('class:', paste(class(result), collapse=','), '\n')
  cat('dim:', nrow(result), 'x', ncol(result), '\n')
  cat('cols:', paste(head(colnames(result), 12), collapse=', '), if(ncol(result) > 12) ' ...' else '', '\n')
} else if (is.list(result)) {
  cat('list with', length(result), 'elements:', paste(head(names(result), 10), collapse=', '), '\n')
  for (nm in head(names(result), 5)) {
    el <- result[[nm]]
    if (is.data.frame(el)) cat(' ', nm, ':', nrow(el), 'x', ncol(el), '\n')
    else cat(' ', nm, ':', class(el)[1], 'len=', length(el), '\n')
  }
} else {
  cat('class:', paste(class(result), collapse=','), '\n')
  cat('length:', length(result), '\n')
}
