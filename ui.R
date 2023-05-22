###############################################################################
# User interface (UI): visual front-end interface
#
# Author: Nicla M. Notarangelo (LabGIS UniBas)
#
################################################################################

# Shiny UI ----------------------------------------------------------------

ui <- shiny::htmlTemplate(
  # Index Page
  "www/index.html",

  # Input
  image_selector = material_card(
    fileInput("upload", "Upload new image", accept = c("image/png", "image/jpeg")),
    textInput("size", "Size", value = "500x500"),
    sliderInput(inputId = "rotation", label = "Rotation", min = -15, max = 15, value = 0, step = 1),
    checkboxGroupInput("effects", "Effects",
      choices = list("flop")
    )
  ),


  # Output ----
  # picture
  pic_out = imageOutput("img"),

  # prediction
  predicted = textOutput(outputId = "prediction"),


  # gradcam map
  gradcam_map = plotOutput(outputId = "gradcam")
)
