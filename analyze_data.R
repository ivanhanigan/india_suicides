# code to read suicide rates in india 
# national data was compiled to obtain rates by education level, rates by
# gender and age
#
# Data  Sources
# by education	http://ncrb.nic.in/adsi/main.htm
# by age: Pop & Suicide totals	http://ncrb.nic.in/adsi/data/ADSI2005/atable%202.1.pdf
# by age: Pop & Suicide totals	http://ncrb.nic.in/CD-ADSI-2012/table-2.1.pdf
# by age: number by age group	http://ncrb.nic.in/adsi/main.htm
# 2001 Age distribution	http://censusindia.gov.in/Tables_Published/C-Series/C-Series_link/C2_India.pdf
# 2011 Age distribution	http://www.censusindia.gov.in/2011census/Age_level_data/Age_level_data.html
# Education Attainment	http://www.barrolee.com/

# load libraries
library(reshape2)
library(googleVis)

# overall totals and child rates -----------------------------------------------
rates_by_age <- read.delim("by_age.txt", as.is = TRUE)
rates_by_age$Suicides_Child_pers <- NULL
rates_by_age$Suicides_Child <- rates_by_age$Suicides_Male_Child + 
  rates_by_age$Suicides_Female_Child

# rates by education level -----------------------------------------------------
data_by_edu <- read.delim("by_education.txt", as.is = TRUE)

# "Total" education level is redundant, already present in rates_by_age
data_by_edu <- subset(data_by_edu, Education.Level != "Total")

# education level is 1 if less than or equal to middle school
# consistent with Barro-Lee's education attainment data for 15+ age group
data_by_edu$Edu_Type <- ifelse(data_by_edu$Education.Level %in% 
                                  c("No Education", "Primary", "Middle"),
                                "Edu1",
                                "Edu2")

# totals by gender and education level
agg_rates_male <- aggregate(Male_Suicides ~ Edu_Type * Year, 
                            data = data_by_edu, 
                            FUN = sum)
agg_rates_male <- dcast(data = agg_rates_male, 
                        Year ~ Edu_Type, 
                        value.var = "Male_Suicides")

agg_rates_female <- aggregate(Female_Suicides ~ Edu_Type * Year, 
                              data = data_by_edu, 
                              FUN = sum)
agg_rates_female <- dcast(data = agg_rates_female, 
                          Year ~ Edu_Type, 
                          value.var = "Female_Suicides")

# merge totals by gender and education level
rates_by_edu <- merge(agg_rates_male, agg_rates_female, by = "Year")
colnames(rates_by_edu)[-1] <- c("Male_Edu1", "Male_Edu2", "Female_Edu1", "Female_Edu2")

# merge rates_by_age and rates_by_edu
rates_all <- merge(rates_by_age, rates_by_edu, by = "Year")

# estimate separate rates for children, men (adult males), women (adult females)
rates_final <- rates_all[, c("Year", "Suicides_Total", "Pop_Total", "Suicides_Child")]
rates_final$Men_Edu1 <- rates_all$Male_Edu1 - rates_all$Suicides_Male_Child
rates_final$Men_Edu2 <- rates_all$Male_Edu2
rates_final$Women_Edu1 <- rates_all$Female_Edu1 - rates_all$Suicides_Female_Child
rates_final$Women_Edu2 <- rates_all$Female_Edu2
rates_final$National_Average <- rates_all$Suicides_Total / rates_all$Pop_Total

# age gender distribution ------------------------------------------------------
data_age_gender <- read.delim("age_gender_dist.txt", as.is = TRUE)

# merge suicides and population data by group
rates_final <- merge(rates_final, data_age_gender, by = "Year")

rates_final$Rate_Children <- rates_final$Suicides_Child / rates_final$Pop_Child
rates_final$Rate_Men_Edu1 <- rates_final$Men_Edu1 / rates_final$Pop_Men_Edu1
rates_final$Rate_Men_Edu2 <- rates_final$Men_Edu2 / rates_final$Pop_Men_Edu2
rates_final$Rate_Women_Edu1 <- rates_final$Women_Edu1 / rates_final$Pop_Women_Edu1
rates_final$Rate_Women_Edu2 <- rates_final$Women_Edu2 / rates_final$Pop_Women_Edu2

# pretty pictures --------------------------------------------------------------
# keep rates only, for plotting
rates_final <- rates_final[, c("Year", "Rate_Children", "Rate_Men_Edu1", 
                               "Rate_Men_Edu2", "Rate_Women_Edu1", 
                               "Rate_Women_Edu2", "National_Average")]

# significant figures for plotting
rates_final$Rate_Children <- as.numeric(sprintf("%.1f", rates_final$Rate_Children))
rates_final$Rate_Men_Edu1 <- as.numeric(sprintf("%.1f", rates_final$Rate_Men_Edu1))
rates_final$Rate_Men_Edu2 <- as.numeric(sprintf("%.1f", rates_final$Rate_Men_Edu2))
rates_final$Rate_Women_Edu1 <- as.numeric(sprintf("%.1f", rates_final$Rate_Women_Edu1))
rates_final$Rate_Women_Edu2 <- as.numeric(sprintf("%.1f", rates_final$Rate_Women_Edu2))
rates_final$National_Average <- as.numeric(sprintf("%.1f", rates_final$National_Average))

# re-name columns for plotting
colnames(rates_final)[-1] <- c("Children (Boys & Girls, age < 15)", 
                               "Adult Men, Less-educated (Grades <= 8) ", 
                               "Adult Men, More-educated (Grades > 8)", 
                               "Adult Women, Less-educated (Grades <= 8)",
                               "Adult Women, More-educated (Grades > 8)",
                               "National Average")

# googlevis chart
plot_rates <- gvisLineChart(rates_final,
                            options = list(width = 900, 
                                           height = 600,
                                           pointSize = 4,
                                           title = 'India Suicide Rate (per 100,000 people): National Average vs Subgroups',
                                           hAxis = "{title: 'Year'}",
                                           vAxis = "{title: 'Suicides per 100,000 people within relevant group'}"))
plot(plot_rates)


