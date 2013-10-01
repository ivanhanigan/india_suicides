# code to obtain info on Suicides by Region & Profession
# obtain data from National Crime Records Bureau, http://ncrb.nic.in/
# http://ncrb.nic.in/adsi/main.htm

# from 1967 to 1995
# sample url: http://ncrb.nic.in/adsi/data/ADSI1994/suicides-94.pdf
# 1997 - 2000
# sample url: http://ncrb.nic.in/adsi/data/ADSI1999/table-23.pdf
# 2001 - downloaded manually


# for (each_year in c(seq(1967, 2000), seq(2002, 2012))) {
for (each_year in seq(2009, 2012)) {
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
