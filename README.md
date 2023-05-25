# Rainfall detection
Code for a ShinyApps application for a not device specific, smart, vision-based rain sensors system.

## Description
This repository implements a novel method for rainfall detection proposed in the paper: Notarangelo, N.M.; Hirano, K.; Albano, R.; Sole, A. Transfer Learning with Convolutional Neural Networks for Rainfall Detection in Single Images. *Water* 2021, 13, 588. https://doi.org/10.3390/w13050588. The method is based on a convolutional neural network (CNN) architecture and achieves state-of-the-art results. The repository includes the code required for running an interactive web application that provides real-time inferences and Gradient-weighted Class Activation Mapping (Grad-CAM) visualizations, which dynamically update as inputs change. 

## Transfer Learning with Convolutional Neural Networks for Rainfall Detection in Single Images
Near real-time rainfall monitoring at local scale is essential for urban flood risk mitigation. Previous research on precipitation visual effects supports the idea of vision-based rain sensors, but tends to be device-specific. We aimed to use different available photographing devices to develop a dense network of low-cost sensors. Using Transfer Learning with a Convolutional Neural Network, the rainfall detection was performed on single images taken in heterogeneous conditions by static or moving cameras without adjusted parameters. The chosen images encompass unconstrained verisimilar settings of the sources: Image2Weather dataset, dash-cams in the Tokyo Metropolitan area and experiments in the NIED Large-scale Rainfall Simulator. The model reached a test accuracy of 85.28% and an F1 score of 0.86. The applicability to real-world scenarios was proven with the experimentation with a pre-existing surveillance camera in Matera (Italy), obtaining an accuracy of 85.13% and an F1 score of 0.85. This model can be easily integrated into warning systems to automatically monitor the onset and end of rain-related events, exploiting pre-existing devices with a parsimonious use of economic and computational resources. The limitation is intrinsic to the outputs (detection without measurement). Future work concerns the development of a CNN based on the proposed methodology to quantify the precipitation intensity.

[![DOI](https://img.shields.io/badge/DOI-10.3390%2Fw13050588-blue.svg)](https://doi.org/10.3390/w13050588)

## Bibtex Record: 
If you use the code, please cite our paper:

```
@article{Notarangelo2021,
  doi = {10.3390/w13050588},
  url = {https://doi.org/10.3390/w13050588},
  year = {2021},
  month = feb,
  publisher = {{MDPI} {AG}},
  volume = {13},
  number = {5},
  pages = {588},
  author = {Nicla Notarangelo and Kohin Hirano and Raffaele Albano and Aurelia Sole},
  title = {Transfer Learning with Convolutional Neural Networks for Rainfall Detection in Single Images},
  journal = {Water}
}
```

## Installation
The app requires the installation of the following packages:

```
install.packages("shiny")
install.packages("shinymaterial")
install.packages("shinycssloaders")
install.packages("magick")
install.packages("viridis")
```

The app requires also TesorFlow and Keras packages, for installation please refer to the official documentation: https://tensorflow.rstudio.com/install/.

## Usage

The app can be called directly via 

```
shiny::runGitHub(repo = "niclanota/rainfall-detection-shiny")
```
or downloaded and run in RStudio as a Shiny application.
   
## Acknowledgments
The research was supported by the “Casa delle Tecnologie Emergenti di Matera” project.
The assistance provided by the staff of the National Research Institute for Earth Science and Disaster Resilience (NIED), the Storm, Flood and Landslide Research Division and the Large-scale Rainfall Simulator with the different datasets and the experiments was greatly appreciated. Matera camera frames were provided by TIM s.p.a..

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

****
