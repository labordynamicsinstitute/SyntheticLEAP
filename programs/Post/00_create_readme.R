# Map the data
# This can be run from the command line as 
#  Rscript --vanilla master.R 


source(here::here("programs","Post","config.R"),echo=TRUE)
source(file.path(programs,"config.R"), echo=FALSE)

# for pandoc, when not running in Rstudio
source(file.path(programs,"get_os.R"))
pandoc.tmp <- Sys.getenv("RSTUDIO_PANDOC")
if ( pandoc.tmp == "") {
  print("setting pandoc path")
  if ( get_os() == "osx" ) {
    Sys.setenv(RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/MacOS/pandoc")
  }
  # add any other strange cases here
  print(Sys.getenv("RSTUDIO_PANDOC"))
}

print(Sys.getenv("RSTUDIO_PANDOC"))

render_report = function(document) {
  print(paste0("Processing "))
    #setwd(text)
    rmarkdown::render(
      file.path(basedir,paste0(document,".Rmd")), 
      output_format = "all"
    )
}

render_report("index")

