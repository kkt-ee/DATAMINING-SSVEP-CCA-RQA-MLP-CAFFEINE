
STEP 3: CLASSIFICATION (FOR IMPORTANT FEATURES)

CONTENTS:
        run.m
        classify_main.m
        classify.m

---------------------------------------------------------------------------
fUNCTIONS:
    impPredictors = main_classify(table2classify, classes)
    [tc,md1,Mdl,MdlCART,imp1,imp2,imp3,impCART] = classify(featuretable,class)
    viz_classified2(classificationtree, predictors,plottitle)
---------------------------------------------------------------------------


0. Code gap: Manually edit the xlsx file obtained from step2 for P1 P2 and P3 
             Set the data to two classes (before and after stimulus)
             save as a new xlsx file

1. Load the data from the new xlsx file 

2a. t-test:
    a. prettest.m 
    b. t_test.m

2b. Classification Trees:
    a. CART
    b. Boosted tree
    c. Random Forest
   
    To create a list of important predictors (each for P1 P2 and P3) using a,b,c