#use any font, utilize the 'extrafont' package. just Symbola for now
import_fonts <- function() {
	library(extrafont) # "This package is used for using and embedding fonts other than the basic Postscript fonts."
	font_import(paths="C:/Windows/Fonts",pattern="Symbola",prompt=FALSE) # "Presently only supports TrueType fonts."
	loadfonts(device="win") # "This registers fonts so that they can be used with the pdf, postscript, or Windows bitmap output device. It must be run once in each R session."
}