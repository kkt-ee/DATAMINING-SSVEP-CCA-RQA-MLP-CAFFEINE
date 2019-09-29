OBJECTIVE: To extract the R-R Interval data from the original ECG data
                               ......[STEP 1 : -R-R INTERVAL EXTRACT-]
CONTENTS: 
        run.m
        main_rri.m
        rri.m
        amptfs.m
        locateR.m
        vizresults.m
        figsave.m
        README.txt

STRUCTURE:
----------------------------6 fUNCTIONS-------------------------------------------------------------
   1. main_rri()      : [rrintervalVector] = rrintV(path,figsavefolpath)                |[main] 
   2. rri()           : [RRinterval] = rr(t_r)                                          |[core]     
   3. amptfs()        : [A t Fs]=amptfs(loadfiledata)                                   |[supporting]
   4. locateR()       : [A_r, t_r,augmentedR] = locateR(A,t,Fs)                         |[filter]
   5. vizresults()    : vizresults(t,A,augmentedR, A_r, t_r, data_vname,figsavefolpath) |[optional]  
   6. figsave()       : figsave(f,data_vname,figsavefolpath)                            |[optional]  
====================================================================================================

RUN (GUIDE):
  A. USER INPUT >> :
       path             = "_________";    % Enter path of lvm files (i.e. signal files)
       figsavefolpath   = "_________";    % Enter path to save the generated figures
       threshold        = "_________";    % Enter Threshold value for min height of R-Peak

  B. Call main fUNCTION : main_rri() >> :
       [RRIvector] = main_rri(path,figsavefolpath,threshold);



EOF  