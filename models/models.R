# download mode wb (Windows)
download.file("https://drive.google.com/u/1/uc?id=1J7rDJRGRIbUEnAtn7MbmivYJJWFK0QhK&export=download&confirm=t&uuid=63b106a0-260e-4096-bc34-976a98d33a73&at=AKKF8vyAs5mDPEw0pBMWZQRASc9Y:1684873058322", 
              destfile = "models/WR_vs_NR_mixed.h5", mode = "wb")

download.file("https://drive.google.com/u/1/uc?id=1ZBEWSJaUrdJDvNyk-A7ues5wHBcMGwjN&export=download", 
              destfile = "models/model_grad.h5", mode="wb")

# Load the model
model <- load_model_hdf5(filepath       = "models/WR_vs_NR_mixed.h5",
                         custom_objects = NULL,
                         compile        = TRUE)


# Load the model for the grad-CAM
model_grad <- load_model_hdf5(filepath       = "models/model_grad.h5",
                         custom_objects = NULL,
                         compile        = TRUE)
