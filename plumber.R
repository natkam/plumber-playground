library(plumber)

#* @apiTitle Plumber Example API

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}

#* Return a response
#* @serializer contentType list(type = "text/xml")
#* @post /xml
function(res) {
  browser()
  result <- c(file = "data_samples/001_data.xml")
  res$body <- result
  # res$status_code <- 200L
  res$headers = c(
    "Access-Control-Allow-Origin: *",
    "Content-disposition: attachment; filename=result.xml"
  )
  res
}
