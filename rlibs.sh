#!/bin/bash
R --slave <<EOF
source("http://bioconductor.org/biocLite.R")
biocLite("xcms", dep=TRUE, ask=FALSE)
biocLite("faahKO", dep=TRUE, ask=FALSE)
EOF