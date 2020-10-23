##Download Data
library(dplyr)
if (!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile = "./data/PM25emissions.zip")
unzip(zipfile = "./data/PM25emissions.zip", exdir = "./data")


##Read into R
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

##Summarize emissions data by year
year_em <- NEI %>%
            group_by(year) %>%
            summarise(sum = sum(Emissions))

total_em <- year_em[['sum']]

##Create bar plot
options(scipen = 999)
png(file = 'plot1.png')
barplot(height = total_em,
        names.arg = c("1999", "2002", "2005", "2008"),
        xlab = "Year", ylab = "Total Emissions (in tons)",
        main = "Total Emissions by Year",
        ylim = c(0, 8000000))
dev.off()
