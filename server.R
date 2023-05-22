###############################################################################
# Server logic: the back-end of the app that handles user interactions and data processing.
#
# Author: Nicla M. Notarangelo (LabGIS UniBas)
#
################################################################################

# Shiny Server ------------------------------------------------------------
server <- function(input, output, session) {
  # Start with placeholder img
  # image <- image_read("https://cdn.getyourguide.com/img/tour/5c1cd69416d30.jpeg/97.jpg")
  image <- image_read("samples/1.jpg")
  observeEvent(input$upload, {
    if (length(input$upload$datapath)) {
      image <<- image_read(input$upload$datapath)
    }
    info <- image_info(image)
    updateCheckboxGroupInput(session, "effects", selected = "")
    updateTextInput(session, "size", value = paste(info$width, info$height, sep = "x"))
  })

  # A plot of fixed size
  output$img <- renderImage({
    # Boolean operators
    if ("flop" %in% input$effects) {
      image <- image_flop(image)
    }
    # Numeric operators
    tmpfile <- image %>%
      image_rotate(input$rotation) %>%
      image_resize(input$size) %>%
      image_write(tempfile(fileext = "jpg"), format = "jpg")

    # Return a list
    list(src = tmpfile, contentType = "image/jpeg")
  })

  # Prediction
  output$prediction <- renderText({
    # Boolean operators
    if ("flop" %in% input$effects) {
      image <- image_flop(image)
    }
    # Numeric operators
    tmpfile <- image %>%
      image_rotate(input$rotation) %>%
      image_resize(input$size) %>%
      image_write(tempfile(fileext = "jpg"), format = "jpg")

    img <-
      image_load(tmpfile, target_size = c(200, 200)) %>%
      image_to_array() %>%
      array_reshape(dim = c(1, 200, 200, 3))
    img <- img / 255


    ifelse(
      predict(model, img) > 0.6,
      paste0(
        "The picture contains RAIN with ",
        round(predict(model, img), 2),
        " score."
      ),
      paste0(
        "The picture does NOT contain RAIN with ",
        round(predict(model, img), 2),
        " score."
      )
    )
  })
  # GradCAM
  output$gradcam <- renderPlot({
    # Boolean operators
    if ("flop" %in% input$effects) {
      image <- image_flop(image)
    }
    # Numeric operators
    tmpfile <- image %>%
      image_rotate(input$rotation) %>%
      image_resize(input$size) %>%
      image_write(tempfile(fileext = "jpg"), format = "jpg")

    img <-
      image_load(tmpfile, target_size = c(200, 200)) %>%
      image_to_array() %>%
      array_reshape(dim = c(1, 200, 200, 3)) %>%
      imagenet_preprocess_input()

    # preds <- model_grad %>% predict(img)
    preds <- model %>% predict(img)

    max <- which.max(preds[1, ])

    rain_output <- model_grad$output[, max]
    last_conv_layer <- model_grad %>% get_layer("block5_conv3")
    # rain_output <- model$output[, max]
    # last_conv_layer <- model  %>% get_layer("vgg16") %>% get_layer("block5_conv3")
    grads <- K$gradients(rain_output, last_conv_layer$output)[[1]]

    pooled_grads <- K$mean(grads, axis = c(0L, 1L, 2L))
    iterate <- K$`function`(
      list(model_grad$input),
      list(pooled_grads, last_conv_layer$output[1, , , ])
    )
    # iterate <- K$`function`(list(model$input),
    #                         list(pooled_grads, last_conv_layer$output[1, , ,]))

    c(pooled_grads_value, conv_layer_output_value) %<-% iterate(list(img))

    for (i in 1:2) {
      conv_layer_output_value[, , i] <-
        conv_layer_output_value[, , i] * pooled_grads_value[[i]]
    }

    heatmap <- apply(conv_layer_output_value, c(1, 2), mean)
    heatmap <- pmax(heatmap, 0)
    heatmap <- heatmap / max(heatmap)
    heatmap_m <- 255 * heatmap
    # heatmap_vir <- viridis(256)[heatmap_m + 1]
    heatmap_vir <- inferno(256)[heatmap_m + 1]
    heatmap_vir <-
      c(
        substr(heatmap_vir, 2, 3),
        substr(heatmap_vir, 4, 5),
        substr(heatmap_vir, 6, 7),
        substr(heatmap_vir, 8, 9)
      )
    heatmap_vir <- as.numeric(as.hexmode(heatmap_vir)) / 255
    dim(heatmap_vir) <- c(dim(heatmap_m), 4)


    base <- image %>%
      image_rotate(input$rotation) %>%
      image_resize(input$size)
    info <- image_info(base)
    geometry <- sprintf("%dx%d!", info$width, info$height)

    image_read(heatmap_vir) %>%
      image_rotate(input$rotation) %>%
      image_resize(geometry, filter = "quadratic") %>%
      image_composite(base, operator = "blend", compose_args = "20") %>%
      plot()
  })
}
