Graphing 2010 CA census data against water use for each county
--------------------------------------------------------------
**My first foray into the R language**


Notes:
- For the script or the app to run correctly set working directory to the folder enclosing the code, or move data folder to your working directory…
- Uses packages xlsx, shiny, xml, mblm
- GetData.R has already been run, so census-water-data.rds already exists in the data folder, it’s not necessary to run it again unless the script is changed


There are some dynamic options in the app: y-axis can be changed from per person water use
to total, the type of linear regression can be switched, there are several choices for the
census data (x-axis) to compare. MSE and MAE are given for the regression formulas to compare
levels of correlation when changing the x-axis. There really isn't much in the way of
impressive findings, although some census stats seem to relate more than others. There is a
high correlation between population size and total water use (big surprise).

The server side of the app uses a saved data frame generated using the included R script.
The script pulls census data from a series of webpages of the form:
http://quickfacts.census.gov/qfd/states/06/06001.html, and water use data from the Excel
spreadsheet included in the data folder. This spreadsheet can be downloaded at
http://ca.water.usgs.gov/water_use/2010-california-water-use.html.
