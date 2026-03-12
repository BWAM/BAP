#==============================================================================
#'Non-Chironomidae and Oligochaeta Taxa Richness
#'
#'@param Long = Taxonomic count data in a long data format.
#'@param Level = The taxonomic level to preform the analysis.  This metric must
#'specify a taxonomic rank below family.
#'@return Taxa richness excluding Chironomidae or Oligochaeta taxa.
#'@export
#'

rich_nco <- function(Long, Level = "GENUS"){
  Taxa.df <- wide(Long, Level)

  # Get Chiro taxa
  FAM <- split(Long[, Level], Long$FAMILY)
  taxa.list_c <- unique(FAM$CHIRONOMIDAE)

  # Get Oligo Taxa
  Order <- split(Long[, Level], Long$ORDER)
  lumbriculida <- unique(Order$LUMBRICULIDA)
  tubificida <- unique(Order$TUBIFICIDA)
  enchytraeidae <- unique(FAM$ENCHYTRAEIDAE)
  taxa.list_o <- list(lumbriculida, tubificida, enchytraeidae)

  # Combine the lists
  taxa.list <- list(taxa.list_c, taxa.list_o)
  group.rich <- group_rich(NameList = taxa.list, taxa.df = Taxa.df)
  total.rich <- vegan::specnumber(Taxa.df[, 6:ncol(Taxa.df)])
  return(total.rich - group.rich)
}
