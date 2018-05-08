##Question 3 Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.## 

##Answer 3: Of the four types of sources indicated nonpoint, onroad, and nonroad have seen decreases.  Of the four types of sources indicated point has seen an increase.##
 




unzip("exdata%2Fdata%2FNEI_data (1).zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png(filename="plot3.png", width=560, height=480)
BCPMType<- subset(NEI, fips == 24510, select= c("Emissions","type","year"))
BCPMTypePlot<- ggplot(BCPMType, aes(x=year, y=Emissions, fill=type)) + geom_bar(stat="identity", width=2, aes(colour=type))
BCPMTypePlot$year<- as.factor(BCPMTypePlot$year)
BCPMTypePlot + facet_grid(. ~ type) + 
ggtitle("Baltimore PM2.5 Emissions by Type (1999 - 2008)") + 
theme(plot.title= element_text(hjust=0.5)) + 
scale_x_continuous(breaks = c(1999,2002,2005,2008))
dev.off()
