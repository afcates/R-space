  ------------- -----------------
  import\_shp   R Documentation
  ------------- -----------------

Import ESRI Shapefiles
----------------------

### Description

Basically a wrapper of readOGR and ogrInfo with additional options for
spatial transformations, subsetting (in SQL syntax), and fortifying to
data.frame

### Usage

    import_shp(location = NULL, layer = NULL, transform = , fortify = FALSE)

### Arguments

+--------------------------------------+--------------------------------------+
| `location`                           | the location of the                  |
+--------------------------------------+--------------------------------------+
| `layer`                              | the file name of the shp file set.   |
|                                      | defaults to last directory of        |
|                                      | location                             |
+--------------------------------------+--------------------------------------+
| `id`                                 | the 'GEOID'                          |
+--------------------------------------+--------------------------------------+
| `filter`                             | SQL syntax / list() for multiple     |
|                                      | conditions                           |
+--------------------------------------+--------------------------------------+
| `info`                               | output the column names of the dbf   |
|                                      | file instead                         |
+--------------------------------------+--------------------------------------+

### Examples

    ##---- Should be DIRECTLY executable !! ----
    ##-- ==>  Define data, use random,
    ##--    or do help(data=index) for the standard data sets.

    # http://www2.census.gov/geo/tiger/GENZ2014/shp/cb_2014_us_county_500k.zip
    detroit_mi_counties <- import_shp(
        location = "C:/gis/data/cb_2014_us_county_500k",
        layer = "cb_2014_us_county_500k",
        transform="+proj=longlat +datum=WGS84",
        filter=list(
            "STATEFP = '26'",
            "COUNTYFP IN ('147','163','093','115','099','125')"))

    ## The function is currently defined as
    function (x)
    {
      }
