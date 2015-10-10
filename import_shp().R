########################################
#shorten reading in, subsetting, and fortifying shp files
########################################
#georgia <- import_shp(location="C:/Users/Anthony/Desktop/Map Projects/Tiger Shapefiles 2012/tl_2012_us_state",layer="tl_2012_us_state",transform="+init=epsg:3762",filter="NAME='Georgia'")
#geom_georgia <- geom_polygon(data=georgia,aes(long,lat,group=group), fill="darkblue", alpha = 1/2)
########################################

require("rgdal") #readOGR() et al
require("ggplot2") #fortify()

import_shp <- function(location,layer,id,filter,transform,fortify) {
  #stop() if missing core arguments
  if(missing(location) || missing(layer)) {
    stop("Missing the directory where the files are located (location=) or the name of the layer (layer=).")
  }
  
  #the only function that matters
  shp <- readOGR(dsn=location, layer=layer) #summary(shp)
  
  #
  if(missing(id)) {
    id <- "id"
  } else {
    names(shp)[which(names(shp) == id)] <- "id"
  }

  
  #filter argument unnecessary if you subset output after import, or if you subset shp beforehand in R or QGIS
  if(!missing(filter)) {
    #so users can get away with some english logic
    filter <- gsub(" AND "," && ",filter,ignore.case=TRUE)
    filter <- gsub(" OR "," || ",filter,ignore.case=TRUE)
    filter <- gsub("=","==",filter,ignore.case=TRUE)
    filter <- gsub(" IN "," %in% ",filter,ignore.case=TRUE)
    filter <- gsub("\\(","c(",filter,ignore.case=TRUE)
		if(substr(toupper(filter),0,4) == "NOT ") {
			negate <- "!"
			filter <- sub("NOT ","",filter,ignore.case=TRUE)
		} else {
			negate <- ""
		}
    #passing a logical argument from a function is not intuitive. see http://stackoverflow.com/questions/9057006/getting-strings-recognized-as-variable-names-in-r)
    shp <- try(shp[eval(parse(text=paste(negate,"shp$",filter,sep=""))), ]) #does as.formula(paste("shp$", filter, sep="")) work?
    if (inherits(shp, "try-error")) {
      cat(paste("*Attempting filter gave back preceding error. Make sure field name exists and is cased correctly. Filter string should use SQL style syntax, 'NOT' 'AND' 'OR' '=' 'IN', and 'NOT' should precede filter logic when negating is desired."))
    }
    cat(paste("\nFilter: ", "shapefile$", negate, filter, sep = ""))
  } else {
    #displaying this simple message is a little too late for large files, but would get the point across anyway
    cat(paste("No 'filter' argument, loading all geometry records. To view field names for potential filter: ogrInfo(dsn=",location,",layer=",layer,")",sep=""))
  }
  if(!missing(transform)) {
    #transform string examples: "+init=epsg:3762", "+proj=longlat +datum=WGS84"
    shp <- spTransform(shp,CRS(transform))
    cat(paste("\nproj4string:",CRSargs(CRS(transform))))
  } else {
    summary(shp)$proj4string
  }
	cat(paste("\n"))
  fortify <- ifelse(missing(fortify),TRUE,fortify)
  if(fortify == TRUE) {
    shp@data$id <- rownames(shp@data)
    shp.points <- fortify(shp, region="id")
    shp.df <- merge(shp.points, shp@data, by="id")
  } else {
    shp
  }
}
