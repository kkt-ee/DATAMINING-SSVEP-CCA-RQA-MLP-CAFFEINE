FILENAME: README.txt

CONTENTS
    run_RQA_v2.m
    main_RQA.m          [main]
    RQA.m               [core]
    CreateTable.m       [supporting]
    mutual.m            [core]
    false_nearest.m     [core]
    phasespace.m        [core]
    cerecurr_y.m        [core]
    tdrecurr_y.m        [core]
    recurrqa_y.m        [----]  (6 parameters [discard])
    recurrqa_y_all.m    [core]  (11 parameters [New])
    fftfilter.m         [supporting]
    rescale_data.m      [supporting]
    README.txt


SCRIPTS & fUNCTIONS:
    RQA_v2MAIN.m
        RQAstatistics = RQA(ecg,filename,folname)
            tau = mutual(ecg,filename)
            dim = false_nearest(signal,mindim,maxdim,tau,rt,eps0)
            y = phasespace(ecg,dim,tau)
            recurdata = cerecurr_y(y,filename,folname)
            recurrpt = tderecurr_y(recurrdata,0.3,folname)
            RQAstatistics=recurrqa_y_all(recurrpt)

NOTE: 'filename' is the name of the file to be savad in the folder 'folname'