

wanted_ids <- find_down(atl,node(subset(atl$nodes$tags,v=="police")$id))
police <- subset(atl,node_ids=wanted_ids$node_ids)
police <- as_sp(police, "points")


#example call
#supports filtering using tags: key=k, value=v
police <- osm_to_spatial(input=atl,type="points",key_filter="*",value_filter="police")


osm_to_spatial <- function(input,type,key_filter,value_filter) {
  
  require(osmar)
  
  if(missing(input) || missing(type)) {
    stop("You must specify the osmar object (input) and the spatial type (type) of your output in your function call.")
  }
  
  if(!missing(key_filter) || !(missing(value_filter))) {
    key_filter <- ifelse(missing(key_filter),"*",key_filter)
    value_filter <- ifelse(missing(value_filter),"*",value_filter)
    
    wanted_ids <- find_down(input,node(subset(input$nodes$tags,k==key_filter || v==value_filter)$id))
    input <- subset(input,node_ids=wanted_ids$node_ids) #just re-assigning "input" a bad idea?
    #input <- as_sp(input, type)
    
    
  }
  
  output <- as_sp(input, type)
  
}