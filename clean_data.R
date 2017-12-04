library(readr)
library(dplyr)

CleanMeteorData <- function(meteorite.landings.clean) {
  #Categorize the recclass observation as part of a main meteorite group.
  OrdinaryChondrite <- "^L|^H|^LL|^Chondrite-fusion crust|^OC|^Chondrite"
  CarbonaceousChondrite <-  "^CI|^CM-CO|^CM|^CO|^CV-CK|^CV|^CK|^CV-oxA|^CV-oxB|^CV-red|^CR|^CH|^CB|^CBa|^CBb|^C3-ung|^C2-ung|^C4-ung|^C"
  EnstatiteChondrite <- "^EH|^EL|^E3|^E-an|^E4|^E5|^E6|^E"
  OtherMinorCondrites <- "^R|^K"
  Achondrites <- "^Acapulcoite|^Lodranite|^Winonaite|^Howardite|^Eucrite|^Diogenite|^Angrite|^Aubrite|^Ureilite|^Brachinite|^Lunar|^Martian|^Shergottites|^Nakhlites|^Chassignites|^Achondrite-ung|^Enst achon"
  StonyIron <- "^Pallasites|^Pyroxene|^Eagle|^Mesosiderite|^Pallasite"
  Iron <- "^Magmatic|^Iron|^IC|^IIAB|^IIC|^IID|^IIF|^IIG|^IIIAB|^IIIE|^IIIF|^IVA|^IVB|^Non-magmatic|^sLL|^sLM|^sLH|^sHH|^sHL"
  StoneUncl <- "^Stone-uncl|^Stone-ung"
  Unknown <- "^Unknown"
  
  #Create a new dataframe for each meteorite group and assign the Class column to it
  OrdinaryChondrite.DF <- meteorite.landings.clean[grep(OrdinaryChondrite, meteorite.landings.clean$recclass),]
  OrdinaryChondrite.DF$Class <- "Ordinary Chondrite"
  
  CarbonaceousChondrite.DF <- meteorite.landings.clean[grep(CarbonaceousChondrite, meteorite.landings.clean$recclass),]
  CarbonaceousChondrite.DF$Class <- "Carbonaceous Chondrite"
  
  EnstatiteChondrite.DF <- meteorite.landings.clean[grep(EnstatiteChondrite, meteorite.landings.clean$recclass),]
  EnstatiteChondrite.DF$Class <- "Enstatite Chondrite"
  
  OtherMinorCondrites.DF <- meteorite.landings.clean[grep(OtherMinorCondrites, meteorite.landings.clean$recclass),]
  OtherMinorCondrites.DF$Class <- "Other Minor Condrites"
  
  Achondrites.DF <- meteorite.landings.clean[grep(Achondrites, meteorite.landings.clean$recclass),]
  Achondrites.DF$Class <- "Achondrites"
  
  StonyIron.DF <- meteorite.landings.clean[grep(StonyIron, meteorite.landings.clean$recclass),]
  StonyIron.DF$Class <- "Stony Iron"
  
  Iron.DF <- meteorite.landings.clean[grep(Iron, meteorite.landings.clean$recclass),]
  Iron.DF$Class <- "Iron"
  
  StoneUncl.DF <- meteorite.landings.clean[grep(StoneUncl, meteorite.landings.clean$recclass),]
  StoneUncl.DF$Class <- "Stone Uncl"
  
  Unknown.DF <- meteorite.landings.clean[grep(Unknown, meteorite.landings.clean$recclass),]
  Unknown.DF$Class <- "Unknown"
  
  #Now merge of all the dataframes into one
  rbind(OrdinaryChondrite.DF,CarbonaceousChondrite.DF,EnstatiteChondrite.DF,OtherMinorCondrites.DF,Achondrites.DF,
        StonyIron.DF,Iron.DF,StoneUncl.DF,Unknown.DF) %>% 
    return()
}
