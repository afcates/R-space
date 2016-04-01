\name{import_shp}
\alias{import_shp}
\title{Import ESRI Shapefiles}
\description{Basically a wrapper of readOGR and ogrInfo with additional options for spatial transformations, subsetting (in SQL syntax), and fortifying to data.frame}
\usage{import_shp(location = NULL, layer = NULL, transform = , fortify = FALSE)}
\arguments{
	\item{location}{the location of the}
	\item{layer}{the file name of the shp file set. defaults to last directory of location}
	\item{id}{the 'GEOID'}
	\item{filter}{SQL syntax / list() for multiple conditions}
	\item{info}{output the column names of the dbf file instead}
}
\details{}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{area-man}
\note{}
%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
# http://www2.census.gov/geo/tiger/GENZ2014/shp/cb_2014_us_county_500k.zip
detroit_mi_counties <- import_shp(
	location = "C:/gis/data/cb_2014_us_county_500k",
	layer = "cb_2014_us_county_500k",
	transform="+proj=longlat +datum=WGS84",
	filter=list(
		"STATEFP = '26'",
		"COUNTYFP IN ('147','163','093','115','099','125')"))

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
