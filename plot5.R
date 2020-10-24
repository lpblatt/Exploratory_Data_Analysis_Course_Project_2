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
    filter(fips == "24510" & type == "ON-ROAD") %>%
    group_by(year) %>%
    summarise(total = sum(Emissions))

##Create Chart
options(scipen = 999)
png(file = 'plot5.png')
p1 <- qplot(year, total, data = year_em, 
            geom = c("line","point"), 
            main = "Motor Vehicle Emissions",
            ylab = "total emissions (tons)", xlab = "year"
)
p1 + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))
dev.off()