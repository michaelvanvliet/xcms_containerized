#!/bin/bash
R --slave <<EOF
source("http://bioconductor.org/biocLite.R")
biocLite("xcms", dep=TRUE, ask=FALSE)
biocLite("CAMERA", dep=TRUE, ask=FALSE)
biocLite("faahKO", dep=TRUE, ask=FALSE)
install.packages("rsm", repos='http://cran.us.r-project.org')
install.packages("devtools", repos='http://cran.us.r-project.org')

library("devtools")
install_github("glibiseller/IPO")
EOF