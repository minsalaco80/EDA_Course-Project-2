##4 Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?##

unzip("exdata%2Fdata%2FNEI_data (1).zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Comb<- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
Coal<- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)
CombCoal<- (Comb & Coal)
CombSCC<- SCC[CombCoal,]$SCC
CombNEI<- NEI[NEI$SCC %in% CombSCC,] 
CombCoalUSPM<- aggregate(Emissions ~ year,CombNEI,sum)
png(filename="plot4.png")
plot(CombCoalUSPM$year, (CombCoalUSPM$Emissions)/10^3, "b", pch = 16, 
                  main = "US PM2.5 Emissions From Coal Combustion",
                  xlab = "Year",
                  ylab = "Emissions (kt)", 
                  xaxt="n", yaxt="n", ylim = c(300,600), xlim = c(1999,2008)
                   )
axis(side=1, at=seq(1999, 2008, by=3))
axis(side=2, at=seq(300, 600, by=100))
dev.off()

