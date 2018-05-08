##Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, 
Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to 
make a plot answering this question.##

##Answer 2:  There is an overrall decrease in the Baltimore City, Maryland PM2.5 emissions.##

unzip("exdata%2Fdata%2FNEI_data (1).zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png(filename="plot2.png")
BaltimorePM<- subset(NEI, fips == 24510, select= c("Emissions","year")
BaltimorePMTotals<- aggregate(Emissions ~ year,BaltimorePM, sum)
plot(BaltimorePMTotals$year,(BaltimorePMTotals$Emissions)/10^3, "b", pch = 16,
main = "Total Baltimore PM2.5 Emission",
xlab = "Year",
ylab = "PM2.5 Emissions (kt)",
xaxt="n", yaxt="n", ylim=c(1,4), xlim = c(1999,2008)) 
axis(side=1, at=seq(1999, 2008, by=3))
axis(side=2, at=seq(1, 4, by=1))
dev.off()
