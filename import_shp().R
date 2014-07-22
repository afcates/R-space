########################################
#shorten reading in, subsetting, and fortifying shp files
########################################
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
    #passing a logical argument from a function is not intuitive. see http://stackoverflow.com/questions/9057006/getting-strings-recognized-as-variable-names-in-r)
    shp <- try(shp[eval(parse(text=paste("shp$",filter,sep=""))), ]) #does as.formula(paste("shp$", filter, sep="")) work?
    if (inherits(shp, "try-error")) {
      cat(paste("*Attempting filter gave back preceding error. Filter string is probably bad. Use 'AND' 'OR' '=' 'IN' and make sure field name exists."))
    }
    cat(paste("\nFilter: ",filter))
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
  fortify <- ifelse(missing(fortify),TRUE,fortify)
  if(fortify == TRUE) {
    shp@data$id <- rownames(shp@data)
    shp.points <- fortify(shp, region="id")
    shp.df <- merge(shp.points, shp@data, by="id")
  } else {
    shp
  }
}
