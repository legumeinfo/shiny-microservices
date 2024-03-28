# --------------------------------------------------------------
library(jsonlite)
library(RCurl)
library(stringr)
# --------------------------------------------------------------

# split comma-separated string and trim extra whitespace
stringToVector <- function(s) {
  str_trim(str_split_1(s, ","))
}

server = function(input, output, session) {
  observeEvent(input$genesExample, {
    updateTextInput(session, "gGenes", value = "glyma.Wm82.gnm4.ann1.Glyma.06G088000, glyma.Wm82.gnm4.ann1.Glyma.06G089000")
  })
  observeEvent(input$genes, {
    pf <- list(genes = stringToVector(input$gGenes))
    tryCatch({
      btg <- basicTextGatherer()
      curlPerform(url = sprintf("%s/genes", input$microservicesUrl), postfields = toJSON(pf), writefunction = btg$update)
      updateTextAreaInput(session, "genesResults", value = btg$value())
    }, warning = function(w) {
      updateTextAreaInput(session, "genesResults", value = as.character(w))
    }, error = function(e) {
      updateTextAreaInput(session, "genesResults", value = as.character(e))
    })
  })

  observeEvent(input$chromosomeExample, {
    updateTextInput(session, "chrChromosome", value = "glyma.Wm82.gnm4.Gm06")
  })
  observeEvent(input$chromosome, {
    tryCatch({
      btg <- basicTextGatherer()
      curlPerform(url = sprintf("%s/chromosome?chromosome=%s", input$microservicesUrl, input$chrChromosome), writefunction = btg$update)
      updateTextAreaInput(session, "chromosomeResults", value = btg$value())
    }, warning = function(w) {
      updateTextAreaInput(session, "chromosomeResults", value = as.character(w))
    }, error = function(e) {
      updateTextAreaInput(session, "chromosomeResults", value = as.character(e))
    })
  })

  observeEvent(input$mssExample, {
    updateTextInput(session, "mssQuery",
      value = "legfed_v1_0.L_PLNLH7,legfed_v1_0.L_KF0HCQ,legfed_v1_0.L_C77RQ4"
    )
    updateNumericInput(session, "mssMatched", value = 0.6)
    updateNumericInput(session, "mssIntermediate", value = 3)
  })
  observeEvent(input$mss, {
    pf <- list(query = stringToVector(input$mssQuery), matched = unbox(input$mssMatched), intermediate = unbox(input$mssIntermediate))
    tryCatch({
      btg <- basicTextGatherer()
      curlPerform(url = sprintf("%s/micro-synteny-search", input$microservicesUrl), postfields = toJSON(pf), writefunction = btg$update)
      updateTextAreaInput(session, "mssResults", value = btg$value())
    }, warning = function(w) {
      updateTextAreaInput(session, "mssResults", value = as.character(w))
    }, error = function(e) {
      updateTextAreaInput(session, "mssResults", value = as.character(e))
    })
  })

  observeEvent(input$msbExample, {
    updateTextInput(session, "msbFamilies",
      value = "legfed_v1_0.L_PLNLH7,legfed_v1_0.L_KF0HCQ,legfed_v1_0.L_C77RQ4,legfed_v1_0.L_C5RRH2,legfed_v1_0.L_11ST28,legfed_v1_0.L_11ST28,legfed_v1_0.L_Q99YLX,legfed_v1_0.L_Y9G2MW,legfed_v1_0.L_KM3B7J,legfed_v1_0.L_L4DQCN,legfed_v1_0.L_3BRTF7,legfed_v1_0.L_V3KYCK,legfed_v1_0.L_K3JLC3,legfed_v1_0.L_44SC0D,legfed_v1_0.L_1H1D40,legfed_v1_0.L_90SB75,legfed_v1_0.L_47GRWC,legfed_v1_0.L_P7VG8V,legfed_v1_0.L_GBX3JW,legfed_v1_0.L_LS6NTD,legfed_v1_0.L_HQQ459"
    )
    updateNumericInput(session, "msbMatched", value = 10)
    updateNumericInput(session, "msbIntermediate", value = 2)
    updateNumericInput(session, "msbMask", value = 100)
    updateTextInput(session, "msbTargets", value = "glyma.Wm82.gnm4.Gm02")
  })
  observeEvent(input$msb, {
    pf <- list(chromosome = stringToVector(input$msbFamilies), matched = unbox(input$msbMatched), intermediate = unbox(input$msbIntermediate), mask = unbox(input$msbMask), optionalMetrics = "jaccard") # "levenshtein"
    if (nchar(trimws(input$msbTargets)) > 0) {
      pf$targets <- stringToVector(input$msbTargets)
    }
    tryCatch({
      btg <- basicTextGatherer()
      curlPerform(url = sprintf("%s/macro-synteny-blocks", input$microservicesUrl), postfields = toJSON(pf), writefunction = btg$update)
      updateTextAreaInput(session, "msbResults", value = btg$value())
    }, warning = function(w) {
      updateTextAreaInput(session, "msbResults", value = as.character(w))
    }, error = function(e) {
      updateTextAreaInput(session, "msbResults", value = as.character(e))
    })
  })

  observeEvent(input$searchExample, {
    updateTextInput(session, "searchQuery",
      value = "Phvul.G19833.gnm1.002G100400 phavu.G19833.gnm1.Chr02:13142457-13496658"
    )
  })
  observeEvent(input$search, {
    tryCatch({
      btg <- basicTextGatherer()
      curlPerform(url = sprintf("%s/search?q=%s", input$microservicesUrl, URLencode(input$searchQuery)), writefunction = btg$update)
      updateTextAreaInput(session, "searchResults", value = btg$value())
    }, warning = function(w) {
      updateTextAreaInput(session, "searchResults", value = as.character(w))
    }, error = function(e) {
      updateTextAreaInput(session, "searchResults", value = as.character(e))
    })
  })

  observeEvent(input$crExample, {
    updateTextInput(session, "crChromosome", value = "phavu.G19833.gnm1.Chr02")
    updateNumericInput(session, "crStart", value = 13142457)
    updateNumericInput(session, "crStop", value = 13496658)
  })
  observeEvent(input$cr, {
    tryCatch({
      btg <- basicTextGatherer()
      curlPerform(url = sprintf("%s/chromosome-region?chromosome=%s&start=%f&stop=%f",
        input$microservicesUrl, input$crChromosome, input$crStart, input$crStop), writefunction = btg$update)
      updateTextAreaInput(session, "crResults", value = btg$value())
    }, warning = function(w) {
      updateTextAreaInput(session, "crResults", value = as.character(w))
    }, error = function(e) {
      updateTextAreaInput(session, "crResults", value = as.character(e))
    })
  })
}

# --------------------------------------------------------------
