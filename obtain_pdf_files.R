# code to obtain PDF files from the National Crime Records Bureau, 
# http://ncrb.nic.in/, archives - http://ncrb.nic.in/adsi/main.htm

# urls of pdf files vary with time
# 2001 not in pdf format - downloaded manually and exported to pdf for consistency

# Suicides by Region & Profession ----------------------------------------------
for (each_year in c(seq(1967, 2000), seq(2002, 2012))) {
  
  # construct URL
  if (each_year %in% seq(1967, 1995)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/suicides-",
                         each_year - 1900,
                         ".pdf")    
  } else if (each_year %in% c(1996)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/table-5s.pdf")
  } else if (each_year %in% seq(1997, 2000)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/table-23.pdf")
  } else if (each_year %in% seq(2002, 2005)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/atable 2.11.pdf")
  } else if (each_year %in% seq(2006, 2007)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/Table-2.11.pdf")    
  } else if (each_year %in% c(2008, 2010)) {
    url_string <- paste0("http://ncrb.nic.in/ADSI", 
                         each_year, 
                         "/table-2.11.pdf")     
  } else if (each_year %in% c(2009)) {
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI", 
                         each_year, 
                         "/Table-2.11.pdf")     
  } else if (each_year %in% c(2011)) {
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI", 
                         each_year, 
                         "/table-2.6.pdf")         
  } else { # 2012
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI-", 
                         each_year, 
                         "/table-2.6.pdf")             
  }
  
  # output file
  dest_file <- paste0("ADSI_", each_year, ".pdf")
  
  # obtain file
  download.file(url = url_string, 
                destfile = paste0("pdf_files/", dest_file), 
                mode = "wb")  
}

# Educational status of suicide victims – 2012 (All–India) ---------------------
# data available only from 1997 for both All India & states
for (each_year in c(2000, seq(2002, 2012))) {
  
  # construct URL
  if (each_year %in% c(2000)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI",
                         each_year, 
                         "/table-20.pdf")
  } else if (each_year %in% seq(2002, 2005)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/atable 2.8.pdf")
  } else if (each_year %in% seq(2006, 2007)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/Table-2.8.pdf")
  } else if (each_year %in% c(2008, 2010)) {
    url_string <- paste0("http://ncrb.nic.in/ADSI", 
                         each_year, 
                         "/table-2.8.pdf")    
  } else if (each_year %in% c(2009, 2011)) {
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI", 
                         each_year, 
                         "/table-2.8.pdf")     
  } else { # 2012
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI-", 
                         each_year, 
                         "/table-2.8.pdf")             
  }
  
  # output file
  dest_file <- paste0("ADSI_Edu_India_", each_year, ".pdf")
  
  # obtain file
  download.file(url = url_string, 
                destfile = paste0("pdf_files/", dest_file), 
                mode = "wb")  
}


# Suicidal deaths categorized by sex & age group (State, UT & City–wise) -------
for (each_year in seq(2002, 2012)) {
  
  # construct URL
  if (each_year %in% seq(2002, 2005)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/atable 2.5.pdf")
  } else if (each_year %in% seq(2006, 2007)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/Table-2.5.pdf")
  } else if (each_year %in% c(2008, 2010)) {
    url_string <- paste0("http://ncrb.nic.in/ADSI", 
                         each_year, 
                         "/table-2.5.pdf")    
  } else if (each_year %in% c(2009, 2011)) {
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI", 
                         each_year, 
                         "/table-2.5.pdf")     
  } else { # 2012
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI-", 
                         each_year, 
                         "/table-2.5.pdf")             
  }
  
  # output file
  dest_file <- paste0("ADSI_AgeGender_States_", each_year, ".pdf")
  
  # obtain file
  download.file(url = url_string, 
                destfile = paste0("pdf_files/", dest_file), 
                mode = "wb")  
}



# Educational status of suicide victims – 2012 (States) ------------------------
for (each_year in seq(2002, 2012)) {
  
  # construct URL
  if (each_year %in% seq(2002, 2005)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/atable 2.13.pdf")
  } else if (each_year %in% seq(2006, 2007)) {
    url_string <- paste0("http://ncrb.nic.in/adsi/data/ADSI", 
                         each_year, 
                         "/Table-2.13.pdf")
  } else if (each_year %in% c(2008, 2010)) {
    url_string <- paste0("http://ncrb.nic.in/ADSI", 
                         each_year, 
                         "/table-2.13.pdf")    
  } else if (each_year %in% c(2009, 2011)) {
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI", 
                         each_year, 
                         "/table-2.13.pdf")     
  } else { # 2012
    url_string <- paste0("http://ncrb.nic.in/CD-ADSI-", 
                         each_year, 
                         "/table-2.13.pdf")             
  }
  
  # output file
  dest_file <- paste0("ADSI_Edu_States_", each_year, ".pdf")
  
  # obtain file
  download.file(url = url_string, 
                destfile = paste0("pdf_files/", dest_file), 
                mode = "wb")  
}


