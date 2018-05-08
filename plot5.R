##Question 5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?## 
##Answer 5: Emissions from motor vehicle sources have seen an overrall decrease##

unzip("exdata%2Fdata%2FNEI_data (1).zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Vehicle<- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
VehicleSCC<- SCC[Vehicle,]$SCC
VehicleNEI<- NEI[NEI$SCC %in% VehicleSCC,]
BCVehicle<- subset(VehicleNEI, fips == 24510, select = c("Emissions", "year"))
BCVehicleTotal<- aggregate(Emissions ~ year, BCVehicle, sum)
png(filename="plot5.png")
plot(BCVehicleTotal$year, BCVehicleTotal$Emissions, "b", pch=16,
			main = "Baltimore City Motor Vehicle PM2.5 Emission",
			xlab = "Year",
			ylab = "Emissions (t)",
			xaxt="n", yaxt="n", ylim = c(0,400), xlim = c(1999,2008)
			)
axis(side=1, at=seq(1999, 2008, by=3))
axis(side=2, at=seq(0, 400, by=100))
dev.off()
