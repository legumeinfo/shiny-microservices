# --------------------------------------------------------------
library(shiny)
# --------------------------------------------------------------
# For running in a Docker container
setwd("home/shiny-microservices/")
runApp(host = "0.0.0.0", port = 8180, launch.browser = TRUE)
# --------------------------------------------------------------
