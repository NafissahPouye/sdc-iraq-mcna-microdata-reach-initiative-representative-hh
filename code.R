#Load required libraries
library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-iraq-mcna-microdata-reach-initiative-representative-hh")
data <- read_excel("data.xlsx", sheet = "hh_data_representative")


#Select key variables                   
selectedKeyVars <- c( 'population_group','governorate_mcna',
                      'district', 'hhh', 'age_respondent',
                      'gender_respondent', 'governorate_origin',
                      'district_origin', 'num_hh_member',
                      'inc_employment', 'tot_income')

#select weights
weightVars <- c('weights')

#Convert variables to factors
cols =  c('population_group','governorate_mcna',
          'district', 'hhh', 'age_respondent',
          'gender_respondent', 'governorate_origin',
          'district_origin', 'num_hh_member',
          'inc_employment', 'tot_income')

data[,cols] <- lapply(data[,cols], factor)

#Convert sub file to a dataframe
subVars <- c(selectedKeyVars, weightVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars, weightVar = weightVars
                       )

#print the risk
print(objSDC, "risk")

#Generate an internal (extensive) report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 


