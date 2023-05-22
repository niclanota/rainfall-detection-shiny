###############################################################################
# Entrypoint for the Shiny app
#
# Author: Nicla M. Notarangelo (LabGIS UniBas)
# 
################################################################################

# Libraries ---------------------------------------------------------------
library(shiny)
library(shinymaterial)
library(shinycssloaders)
library(magick)
library(tensorflow)
library(keras)
library(viridis)
K <- backend()
set_random_seed(42)
tf$compat$v1$disable_eager_execution()


# Load modules and utils --------------------------------------------------
source("models/models.R")





