##Question 1##

unzip("exdata%2Fdata%2FNEI_data (1).zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
PMTotals<- aggregate(Emissions ~ year,NEI, sum)
png(filename="plot1.png")
plot(PMTotals$year,(PMTotals$Emissions)/10^6, "b", pch = 16, 
                  main = "Total US PM2.5 Emission",
                  xlab = "Year",
                  ylab = "PM2.5 Emissions (Mt)", 
                  xaxt="n", yaxt="n", ylim=c(3,8), xlim = c(1999,2008)
                   )
axis(side=1, at=seq(1999, 2008, by=3))
axis(side=2, at=seq(3, 8, by=1))
dev.off()
