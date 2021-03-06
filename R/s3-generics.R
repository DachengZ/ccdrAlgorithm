#
#  s3-generics.R
#  ccdrAlgorithm
#
#  Created by Bryon Aragam (local) on 1/22/16.
#  Copyright (c) 2014-2016 Bryon Aragam. All rights reserved.
#

#
# PACKAGE CCDRALGORITHM: Generics
#
#   CONTENTS:
#

# Generics for SparseBlockMatrixR ------------------------------------------------------------
SparseBlockMatrixR <- function(x, ...) UseMethod("SparseBlockMatrixR", x)
as.SparseBlockMatrixR <- function(x) UseMethod("as.SparseBlockMatrixR", x)
to_B <- function(x) UseMethod("to_B", x)
