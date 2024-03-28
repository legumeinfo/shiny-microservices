# Base R Shiny image
FROM rocker/shiny

# Make a directory in the container
RUN mkdir /home/shiny-microservices

# Install R dependencies
RUN R -e "install.packages(c('shiny', 'jsonlite', 'RCurl', 'stringr'))"

# Copy the Shiny application code
COPY app.R server.R ui.R microservices-urls.txt /home/shiny-microservices/

# Expose the application's port
EXPOSE 8180

# Run the Shiny application
CMD Rscript /home/shiny-microservices/app.R
