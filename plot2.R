##Download Data
library(dplyr)
if (!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile = "./data/PM25emissions.zip")
unzip(zipfile = "./data/PM25emissions.zip", exdir = "./data")


##Read into R
NEI <- readRDS("./data/summarySCC_PM25.rds")

##Summarize emissions data by year
year_em <- NEI %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarise(sum = sum(Emissions))

total_em <- year_em[['sum']]

##Create bar plot
options(scipen = 999)
png(file = 'plot2.png')
barplot(height = total_em,
        names.arg = c("1999", "2002", "2005", "2008"),
        xlab = "Year", ylab = "Total Emissions (in tons)",
        main = "Baltimore Emissions by Year",
        ylim = c(0, 3500))
dev.off()
