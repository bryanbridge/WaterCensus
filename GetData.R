# Clear workspace... Remember to setwd() to the folder this file is in
rm(list = ls(all = TRUE))

# Load libraries needed to parse webpage and spreadsheet
library(XML)
library(xlsx)

# Declare vectors the data frame will be made of
countyName = character()
population = numeric()
homeOwnRate = numeric()
medValOwnOccHous = numeric()
persPerHous = numeric()
medHousInc = numeric()
landArea = numeric()
persPerSqMi = numeric()
pubWatSuppUse = numeric()

# Set counter (i) and number of counties (n)
n = 58
i = 0

# Loop through webpages for CA Census information
while(i <= ((n * 2) - 2) ){
  # Set URL
  url = paste0("http://quickfacts.census.gov/qfd/states/06/0", i + 6001, ".html")

  # Pull tables needed
  tablePeople = readHTMLTable(url, stringsAsFactors = FALSE)[[3]]
  tableGeo = readHTMLTable(url, stringsAsFactors = FALSE)[[5]]

  # Store wanted information to vectors. A bit of regex...
  countyName = c(countyName, gsub(" County", "", names(tablePeople)[3]))
  population = c(population, as.numeric(gsub(",","",tablePeople[4,3])))
  homeOwnRate = c(homeOwnRate, as.numeric(gsub("%","",tablePeople[28,3])))
  medValOwnOccHous = c(medValOwnOccHous, as.numeric(gsub("\\$|,","",tablePeople[30,3])))
  persPerHous = c(persPerHous, as.numeric(tablePeople[32,3]))
  medHousInc = c(medHousInc, as.numeric(gsub("\\$|,","",tablePeople[34,3])))
  landArea = c(landArea, as.numeric(gsub(",","",tableGeo[1,3])))
  persPerSqMi = c(persPerSqMi, as.numeric(gsub(",","",tableGeo[2,3])))

  # Increment
  i = i + 2
}


# Load spreadsheet
tableWater = read.xlsx2("data/2010-california-water-use-data-usgs.xlsx", sheetName = "2010")

# Store public water use in Mgal per day for each county
pubWatSuppUse = as.numeric(as.character(tableWater[2:(n+1), 39]))

# Store per capita water use in gal per day for each county
perCapWatSuppUse = 1000000 * pubWatSuppUse / population


# Create data frame with the vectors
output = data.frame(countyName, population, homeOwnRate, medValOwnOccHous, persPerHous, medHousInc, landArea, persPerSqMi, perCapWatSuppUse, pubWatSuppUse)

# Save data frame
saveRDS(output, file = "data/census-water-data.rds")
