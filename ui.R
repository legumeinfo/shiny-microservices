# --------------------------------------------------------------

# read available LIS microservices URLs
readURLs <- function(fin) {
  urls <- readLines(fin)
  urls <- trimws(urls)
  # Ignore blank or commented lines
  urls[!(nchar(urls) == 0 | startsWith(urls, "#"))]
}
microservices_urls <- readURLs("microservices-urls.txt")

ui <- fluidPage(
  h2("Shiny LIS Microservices Interface"),
  p(HTML("<a href='https://github.com/legumeinfo/microservices' target='_blank'>LIS microservices on GitHub</a>")),
  selectInput(inputId = "microservicesUrl", label = "Microservices URL:", choices = microservices_urls, width = "320px"),

  tabsetPanel(id = "tabs",
    tabPanel(
      title = "Genes",
      style = "background-color: #FFC0C0; padding: 8px;",
      h4("Genes"),
      p("This microservice takes a list of gene names and returns the gene objects corresponding to the names."),
      p(HTML("<a href='https://github.com/legumeinfo/microservices/tree/main/genes' target='_blank'>View on GitHub</a>")),
      textInput(inputId = "gGenes", label = "Genes:", width = "100%"),
      actionButton("genesExample", "Example"),
      actionButton("genes", "Go"),
      p(),
      textAreaInput(inputId = "genesResults", label = "Results", width = "100%", height = "256px")
    ),
    tabPanel(
      title = "Chromosome",
      style = "background-color: #FFC080; padding: 8px;",
      h4("Chromosome"),
      p("This microservice takes a chromosome name and returns the chromosome object that corresponds to the name."),
      p(HTML("<a href='https://github.com/legumeinfo/microservices/tree/main/chromosome' target='_blank'>View on GitHub</a>")),
      textInput(inputId = "chrChromosome", label = "Chromosome:", width = "100%"),
      actionButton("chromosomeExample", "Example"),
      actionButton("chromosome", "Go"),
      p(),
      textAreaInput(inputId = "chromosomeResults", label = "Results", width = "100%", height = "256px")
    ),
    tabPanel(
      title = "Micro-Synteny Search",
      style = "background-color: #FFFFC0; padding: 8px;",
      h4("Micro-Synteny Search"),
      p("This microservice takes a track as an ordered list of functional annotations and returns tracks that have similar annotation content. The minimum number (or percentage) of matching annotations and maximum number (or percentage) of intermediate genes between any two matches in a result track must also be provided."),
      p(HTML("<a href='https://github.com/legumeinfo/microservices/tree/main/micro_synteny_search' target='_blank'>View on GitHub</a>")),
      textInput(inputId = "mssQuery", label = "Gene families:", width = "100%"),
      # matched and intermediate must be positive floats
      numericInput(inputId = "mssMatched", label = "Matched", value = 4, min = 0.1, max = 20, step = 0.1, width = 96),
      numericInput(inputId = "mssIntermediate", label = "Intermediate", value = 5, min = 0, max = 20, step = 0.1, width = 96),
      actionButton("mssExample", "Example"),
      actionButton("mss", "Go"),
      p(),
      textAreaInput(inputId = "mssResults", label = "Results", width = "100%", height = "256px")
    ),
    tabPanel(
      title = "Macro-Synteny Blocks",
      style = "background-color: #C0FFC0; padding: 8px;",
      h4("Macro-Synteny Blocks"),
      p("This microservice takes a chromosome as an ordered list of functional annotations and returns a set of synteny blocks computed on-demand from chromosome in the database. The minimum number of matching annotations in a block and the maximum number of intermediate genes between any two matches in a block must also be provided. Optionally, the maximum number of members in a family and target chromosomes can be provided."),
      p(HTML("<a href='https://github.com/legumeinfo/microservices/tree/main/macro_synteny_blocks' target='_blank'>View on GitHub</a>")),
      textInput(inputId = "msbFamilies", label = "Gene families:", width = "100%"),
      # matched, intermediate, mask must be positive integers
      numericInput(inputId = "msbMatched", label = "Matched", value = 4, min = 1, max = 20, width = 96),
      numericInput(inputId = "msbIntermediate", label = "Intermediate", value = 5, min = 0, max = 20, width = 96),
      numericInput(inputId = "msbMask", label = "Mask", value = 100, min = 1, max = 100, width = 96),
      textInput(inputId = "msbTargets", label = "Target chromosomes (optional):", width = "100%"),
      actionButton("msbExample", "Example"),
      actionButton("msb", "Go"),
      p(),
      textAreaInput(inputId = "msbResults", label = "Results", width = "100%", height = "256px")
    ),
    tabPanel(
      title = "Search",
      style = "background-color: #C0C0FF; padding: 8px;",
      h4("Search"),
      p("This microservice takes a query and returns gene names and chromosome regions that are similar to the given query."),
      p(HTML("<a href='https://github.com/legumeinfo/microservices/tree/main/search' target='_blank'>View on GitHub</a>")),
      textInput(inputId = "searchQuery", label = "Query:", width = "100%"),
      actionButton("searchExample", "Example"),
      actionButton("search", "Go"),
      p(),
      textAreaInput(inputId = "searchResults", label = "Results", width = "100%", height = "256px")
    ),
    tabPanel(
      title = "Chromosome Region",
      style = "background-color: #FFC0FF; padding: 8px;",
      h4("Chromosome Region"),
      p("This microservice takes a chromosome name and a region and returns the name of the gene at the center of the region and the number of genes that flank it."),
      p(HTML("<a href='https://github.com/legumeinfo/microservices/tree/main/chromosome_region' target='_blank'>View on GitHub</a>")),
      textInput(inputId = "crChromosome", label = "Chromosome:", width = "100%"),
      numericInput(inputId = "crStart", label = "Start location", value = 10000000, min = 1, max = 100000000, width = 128),
      numericInput(inputId = "crStop", label = "Stop location", value = 10500000, min = 1, max = 100000000, width = 128),
      actionButton("crExample", "Example"),
      actionButton("cr", "Go"),
      p(),
      textAreaInput(inputId = "crResults", label = "Results", width = "100%", height = "256px")
    )
  )
)

# --------------------------------------------------------------
