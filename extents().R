#convenient and quick way to get x and y extents from a data frame
extents <- function(y_id,x_id) { 
  ymin <- min(y_id)
  ymax <- max(y_id)
  xmin <- min(x_id)
  xmax <- max(x_id)
  data.frame(ymin=ymin,ymax=ymax,xmin=xmin,xmax=xmax)
}

#extents() returns a data frame of x-y extents, e.g.
#lims <- extents(atl_boundary,"lat","long")
#atl_osm <- corner_bbox(lims$xmin, lims$ymin, lims$xmax, lims$ymax)