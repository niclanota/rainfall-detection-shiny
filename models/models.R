# Load the model
model <- load_model_hdf5(filepath       = "models/WR_vs_NR_mixed.h5",
                         custom_objects = NULL,
                         compile        = TRUE)


# Load the model for the grad-CAM
model_grad <- load_model_hdf5(filepath       = "models/model_grad.h5",
                         custom_objects = NULL,
                         compile        = TRUE)
