source_https <- function(url, ...) {
  require(RCurl)
  sapply(c(url, ...), function(u) { #parse and evaluate each .R script url in list (credit http://tonybreyal.wordpress.com/2011/11/24/source_https-sourcing-an-r-script-from-github/#comment-2342)
    eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}

#example:
#source_https("https://raw.github.com/area-man/R-space/master/README.md")