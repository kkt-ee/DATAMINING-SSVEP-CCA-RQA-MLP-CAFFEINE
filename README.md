# DATAMINING-SSVEP-CCA-RQA-MLP-CAFFEINE 

The archived codes are of my Masters of Technology Thesis research work titled, "Data mining based approach to study the effect of consumption of caffeinated coffee on the generation of the steady-state visual evoked potential signals". Please refer to the following articles to audit the complete work:

[1] Main article:  https://doi.org/10.1016/j.compbiomed.2019.103526
My complete thesis.

[2] Supporting article: https://doi.org/10.1016/j.dib.2020.105174
A few extra words on the creation of the dataset for the work in [1].

Feel free to reuse the code segments and cite the above articles [1] and [2].  

-------
GLOSSARY
-------

SSVEP: Steady state visual evoked potentials (observed in EEG recordings with photic stimulus)

CCA: Canonical correlation analysis (https://youtu.be/rZoKH4fT-FE)

RQA: Recurrence quantification analysis

MLP: Multilayer perceptron network (ANN)

CAFFEINE: Data mining carried out with caffeinated and non-caffeinated SSVEP signals of 7 different frequencies.

-------

DATASET: 22 x 5120 x 6 x 7 (array)

  22: Number of EEG channels
  
  5120: Number of sample points in each EEG channel
  
  6: Number of volunteers
  
  7: Number of differnt photic stimulus used to capture SSVEP signals
  
------

SSVEPs are a special type of biosignal used in Rehabilitation Engineering for remote actuation of switches. The purpose of this study is to check the effects of caffeine consumption on these signals to verify an alternate hypothesis that, "Caffeine enhances the SSVEP activations". This is indeed found to be true from the results but mostly the enhancement was for high frequency SSVEPs (greater than 30 Hz).  
