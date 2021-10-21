#' Evaluate Lung Adenocarcinoma Survival Risk
#'
#' @param genes_expr Gene expression matrix. Rownames of the input matrix are genes, and colnames of the input matrix are sample names
#' @param parallel Set calculation parallel numbers
#' @return Data frame includes signature score, survival risk and gene expression.
#'
#' @examples
#' library(LUADrisk)
#' Sample_risk <- LUADrisk(genes_expr)
#' @export
LUADrisk <- function(genes_expr, parallel = 1){
  checkmate::assert_matrix(genes_expr)
  options(warn=-1)
  load("~/lungcancer/package/LUADrisk/R/sysdata.rda")
  genes <- rownames(genes_expr)
  if(TRUE %in% (genes %in% gene_list)){
    genes_expr <- genes_expr[intersect(gene_list, genes),]
    res_es <- GSVA::gsva(genes_expr, res_select, mx.diff=T, verbose=T, method="gsva", parallel.sz=parallel)
    signature <- as.matrix(t(res_es)) %*% as.matrix(TCGA_gene$beta)
    res_es <- as.data.frame(t(res_es))
    res_es$Signature_Score <- signature
    res_es$Risk <- ifelse(signature > stats::median(signature_TCGA),"High","Low")
    res_es <- res_es %>%
      dplyr::select("Risk", "Signature_Score", everything())
    return(res_es)
  }else{
    stop("Error: Please check the matrix. Rownames of the input matrix are genes, and colnames of the input matrix are sample names")
  }
}
