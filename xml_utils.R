fill_empty_cube <- function(data) {
  doc <- XML::xmlParse("data_samples/001_empty_cube.xml")
  cube <- XML::getNodeSet(doc, "//cube")[[1]]

  create_kf_nodes <- function(row_number) {
    kf_nodes <- lapply(names(data), XML::newXMLNode)
    for (j in 1:length(kf_nodes)) {
      if (!(is.na(data[row_number, j]))) {
        XML::xmlValue(kf_nodes[[j]]) <- data[row_number, j]
      }
    }
    return(kf_nodes)
  }

  for (i in 1:nrow(data)) {
    XML::addChildren(cube, XML::newXMLNode("row", create_kf_nodes(i)))
  }

  XML::saveXML(doc, file = "data_samples/001_data.xml")

}


create_kf_nodes <- function(col_names, values) {
  char_count <- length(grep("^char", col_names))
  kf_nodes <- lapply(col_names, XML::newXMLNode)

  if (char_count > 0) {
    for (j in 1:char_count) {
      XML::xmlValue(kf_nodes[[j]]) <- "Some data, whatever"
      XML::xmlAttrs(kf_nodes[[j]]) <- c(key = "1234")
    }
  }
  for (j in 1:(length(kf_nodes) - char_count)) {
    if (not(is.na(values[j]))) {
      XML::xmlValue(kf_nodes[[char_count + j]]) <- values[j]
      XML::xmlAttrs(kf_nodes[[char_count + j]]) <- c(u = "EUR")
    }
  }
  return(kf_nodes)
}
