##Download Data
library(dplyr)
library(ggplot2)

if (!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile = "./data/PM25emissions.zip")
unzip(zipfile = "./data/PM25emissions.zip", exdir = "./data")


##Read into R
NEI <- readRDS("./data/summarySCC_PM25.rds")

##Summarize emissions data
year_em <- NEI %>%
    group_by(type, year) %>%
    summarise(total = sum(Emissions))

##Create Chart
options(scipen = 999)
png(file = 'plot3.png')
p1 <- qplot(year, total, data = year_em, color = type, 
            geom = c("line", "point"), main = "Emissions by Type",
            ylab = "total emissions (tons)", xlab = "year",
            ylim = c(0,7000000)
      )

p1 + scale_x_continuous(breaks = c(1999, 2002, 2005, 2008))
dev.off()
      