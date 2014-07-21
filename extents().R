#convenient and quick way to get x and y extents from a data frame
extents <- function(table,y_id,x_id) { 
  y <- which(colnames(table)==y_id)
  x <- which(colnames(table)==x_id)
  ymin <- min(table[y])
  ymax <- max(table[y])
  xmin <- min(table[x])
  xmax <- max(table[x])
  data.frame(ymin=ymin,ymax=ymax,xmin=xmin,xmax=xmax)
}

#extents() returns a data frame of x-y extents so you can do stuff like...
#lims <- extents(atl_boundary,"lat","long")
#atl_osm <- corner_bbox(lims$xmin, lims$ymin, lims$xmax, lims$ymax)