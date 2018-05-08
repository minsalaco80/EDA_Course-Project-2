##Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?## 

##Answer 6:  Baltimore City has seen the greater chane over time in motor vehicle emissions.##

unzip("exdata%2Fdata%2FNEI_data (1).zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Vehicle<- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
VehicleSCC<- SCC[Vehicle,]$SCC
VehicleNEI<- NEI[NEI$SCC %in% VehicleSCC,]
BCVehicle<- subset(VehicleNEI, fips == 24510, select = c("Emissions", "year"))
BCVehicleTotal<- aggregate(Emissions ~ year, BCVehicle, sum)
BCVT<- transform(BCVehicleTotal, Place = 'Baltimore City')

Vehicle<- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
VehicleSCC<- SCC[Vehicle,]$SCC
VehicleNEI<- NEI[NEI$SCC %in% VehicleSCC,]
LAVehicle<- subset(VehicleNEI, fips == "06037", select = c("Emissions", "year"))
LAVehicleTotal<- aggregate(Emissions ~ year, LAVehicle, sum)
LAVT<- transform(LAVehicleTotal, Place = 'Los Angeles County')

LA_BC_PMTotal<- rbind(BCVT,LAVT)
colnames(LA_BC_PMTotal)<- c('Year', 'Emissions', 'Place')
LA_BC_PMTotal$Year<- as.factor(LA_BC_PMTotal$Year)

png(filename="plot6.png")
ggplot(LA_BC_PMTotal, aes(x=Year, y=Emissions, fill=Year)) +
geom_bar(aes(fill=Year), stat="identity") + 
facet_grid(.~Place) +
labs(y=expression("PM"[2.5]*" Emission (t)")) +
labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emisssion")) +
labs(x=expression("Year")) +
theme(plot.title= element_text(hjust=0.5)) +
scale_x_discrete(breaks = c(1999,2002,2005,2008)) 
dev.off()
