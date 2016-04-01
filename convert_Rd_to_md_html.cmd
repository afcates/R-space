R CMD Rdconv --type="html" -o "C:/Desktop/src/R-space/import_shp.html" "C:/Desktop/src/R-space/import_shp.Rd"
pandoc -f html -t markdown -o "C:/Desktop/src/R-space/import_shp.md" "C:/Desktop/src/R-space/import_shp.html"
PAUSE