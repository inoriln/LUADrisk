# LUADrisk

The goal of LUADrisk is to evaluate lung adenocarcinoma survival risk.

## Installation

You can install the released version of LUADrisk from [Github](https://github.com/) with:

``` r
install_github("inoriln/LUADrisk")
```

## Example

This is a basic example which shows you how to solve a common problem:

```{r example}
library(LUADrisk)
## basic example code
#GSE31210
Sample_risk <- LUADrisk(genes_expr)
```