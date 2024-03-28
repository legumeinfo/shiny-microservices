<!-- --------------------------------------------------------------------------------- -->

# shiny-microservices

R/Shiny application for testing [LIS microservices](https://github.com/legumeinfo/microservices) instances.

### Setup

List the URLs of your running microservices instances in `microservices-urls.txt`.

### Build (non-containerized)

In R or RStudio,
```
source("startup.R")
```

### Build (containerized)

```
docker compose up -d
```

### Example

View the application [here](http://dev.lis.ncgr.org:50080/shiny/shiny-microservices/).

<!-- --------------------------------------------------------------------------------- -->

