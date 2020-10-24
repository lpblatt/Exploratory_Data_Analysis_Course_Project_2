##Download Data
library(dplyr)
library(ggplot2)

if (!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile = "./data/PM25emissions.zip")
unzip(zipfile = "./data/PM25emissions.zip", exdir = "./data")


##Read into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

##Summarize emissions data by year
year_em <- NEI %>%
    filter(fips == "24510" | fips == "06037") %>%
    filter(type == "ON-ROAD") %>%
    group_by(fips, year) %>%
    summarise(total = sum(Emissions))

year_em$fips[year_em$fips == "24510"] <- "Baltimore"
year_em$fips[year_em$fips == "06037"] <- "Los Angeles"

##Create Chart
options(scipen = 999)
png(file = 'plot6.png')
qplot(year, total, data = year_em,
        facets = .~fips,
        geom = c("line","point"), 
        main = "Motor Vehicle Emissions in Baltimore vs Los Angeles",
        ylab = "total emissions (tons)", xlab = "year")
dev.off()