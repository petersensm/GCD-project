Course project Codebook
========================================================
Coursera Johns Hopkins Data Science course #3 Getting and Cleaning Data
________________________________________________________

# Description
This codebook is a companion to the Tidydata.txt dataset generated for the course project. 

Details about the project, the original data source, and how the data were cleaned and summarized can be found in the ReadMe.md file in this repository. Similarly, the script for generating Tidydata.txt can be found in the run_analysis.R file. Further information about study design and variable calculations can be found in the ReadMe.txt that accompanies the original datasource:  

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012  

which can be obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Codes
Tinydata.txt contains 11880 obs. of  9 variables. Note, the variables domain, motion, sensor, derivation, summarystatistic, and vector were all concatenated into one variable called feature in the original dataset. The run_analysis.R script can optionally be run to maintain this convention.  

**subject**        

An integer indicating the person data were collected from.  
    
values: 1:30  
    
**activity**  

The activity being performed.  
    
values:  
* walking  
* walkingupstairs   
* walkingdownstairs 
* sitting          
* standing 
* laying  
        
**domain**  

The signal domain. Also, the first component of the feature variable.  
    
values:  
* frequency = frequency domain, the result of applying a Fast Fourier Transform on the time domain signals  
* time = time domain  
        
**motion**  

The motion component captured. The second component of the feature variable.  
    
values:  
* body  
* gravity    
        
**sensor**  

The smartphone sensor used to capture the data, and indicator of the general data type. The third component of the feature variable.  
    
values:  
* acceleration = accelerometer; linear acceleration  
* gyroscope = the gyroscope; angular velocity  
        
**derivation**  

Whether linear acceleration of angular velocity were derived in time (i.e. jerk signals) or not. The fourth component of the feature variable (but only indicated if jerk signal).  
    
values:  
* no  
* yes   
        
**vector**  

Indicates signal direction or magnitude. The fourth or fifth component of the feature variable (where magnitude); otherwise the final component of the feature varaible (where direction).  
    
values:  
* mag = magnitude of the three dimensional signals  
* x = X direction  
* y = y direction  
* z = z direction  

**summarystatistic**  

The summary statsitic used to summarize values over the previous variables. The second-to-last component of the feature variable.  
    
values:  
* mean = mean  
* std = standard deviation  

**mean**        

The mean of the replicate values of variables  
    
values: continuous numeric ranging from -0.99770 to 0.97450; according to the original data authors, all variables were normalized and bounded within [-1,1]
    
