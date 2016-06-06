### Getting and Cleaning Data

## Introduction
The objective of this project is to demonstrate collecting, working with and 
cleaning a wearable computing dataset. This was designed for the Course Project 
Assignment for the Coursera Data Science Specialization - Getting and Cleaning Data.

## Files
- run_analysis.R - The primary script to tidy the dataset. This script does not 
have any prereqisites other than the installation of the packages listed below.

The script performs the following actions:
        - Loads relevant packages
        - Downloads source data and unzips files to a data folder in the working directory
        - Performs required merging and transformations to tidy the dataset
        - Writes the final tidy dataset to the working directory
        
- CodeBook.md - Contains a detailed description of the variables, the data, and transformations/work performed on the data by the run_analysis.R script

- newMeanStd.txt - Final tidy dataset produced by the run_analysis.R script

## Packages
This script requires the following packages to be installed:
- plyr
- dplyr