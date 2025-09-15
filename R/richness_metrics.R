#============================================================================
#'EPT Richness Excluding Tolerant Taxa
#'
#'@param Long Taxonomic count data in a long data format.
#'@param Level Typically, "FINAL_ID".
#'@return The number of Ephemeroptera, Plecoptera, and Trichoptera (EPT)
#' taxa excluding tolerant taxa.
#'@export
#'
ept_rich <- function(Long, Level) {
  wide.df <- wide(Long, Level)
  Order <- split(Long[, Level], Long$ORDER)
  ephem <- unique(Order$EPHEMEROPTERA)
  plecop <- unique(Order$PLECOPTERA)
  trichop <- unique(Order$TRICHOPTERA)
  ept.list <- list(ephem, plecop, trichop)
  taxa.list <- unlist(ept.list)
  #taxa.list[which(c(1, diff(taxa.list)) != 0)]
  idx <- match(taxa.list, names(wide.df))
  idx <- idx[! is.na(idx)]
  data <- data.frame(wide.df[, idx])
  data$names <- rownames(data)
  fam.copy <- data.frame(wide.df)
  fam.copy$names <- rownames(fam.copy)
  fam.copy <- fam.copy[, c("EVENT_ID", "names")]
  taxa.x <- merge(fam.copy, data, by.x = "names", by.y = "names",
                  all.x = TRUE)
  taxa.x[is.na(taxa.x)] <- 0 #NA = zero
  taxa.x <- data.frame(with(taxa.x, taxa.x[order(EVENT_ID), ]))
  final.df <- vegan::specnumber(taxa.x[, 3:ncol(taxa.x)])
  return(final.df)
}


#'COE Richness
#'
#'@param Long Taxonomic count data in a long data format.
#'@param Level Typically, "FINAL_ID".
#'@return The number of Coleoptera, Odonata, and Ephmeroptera (COE)
#'@export
#'
coe_rich <- function(Long, Level) {
  wide.df <- wide(Long, Level)
  Order <- split(Long[, Level], Long$ORDER)

  coleop <- unique(Order$COLEOPTERA)
  odonata <- unique(Order$ODONATA)
  ephem <- unique(Order$EPHEMEROPTERA)

  ept.list <- list(coleop, odonata, ephem)
  taxa.list <- unlist(ept.list)
  #taxa.list[which(c(1, diff(taxa.list)) != 0)]
  idx <- match(taxa.list, names(wide.df))
  idx <- idx[! is.na(idx)]
  data <- data.frame(wide.df[, idx])
  data$names <- rownames(data)
  fam.copy <- data.frame(wide.df)
  fam.copy$names <- rownames(fam.copy)
  fam.copy <- fam.copy[, c("EVENT_ID", "names")]
  taxa.x <- merge(fam.copy, data, by.x = "names", by.y = "names",
                  all.x = TRUE)
  taxa.x[is.na(taxa.x)] <- 0 #NA = zero
  taxa.x <- data.frame(with(taxa.x, taxa.x[order(EVENT_ID), ]))
  rich_vec <- vegan::specnumber(taxa.x[, 3:ncol(taxa.x)])
  final_vec <- unname(rich_vec)
  return(final_vec)
}

#'Insect Richness
#'
#'@param Long Taxonomic count data in a long data format.
#'@param Level Typically, "FINAL_ID".
#'@return The number of insect (INSECTA) taxa.
#'@export
#'
insect_rich <- function(Long, Level) {
  wide.df <- wide(Long, Level)
  group <- split(Long[, Level], Long$CLASS)

  taxa.list <- unique(group$INSECTA)
  #taxa.list[which(c(1, diff(taxa.list)) != 0)]
  idx <- match(taxa.list, names(wide.df))
  idx <- idx[! is.na(idx)]
  data <- data.frame(wide.df[, idx])
  data$names <- rownames(data)
  fam.copy <- data.frame(wide.df)
  fam.copy$names <- rownames(fam.copy)
  fam.copy <- fam.copy[, c("EVENT_ID", "names")]
  taxa.x <- merge(fam.copy, data, by.x = "names", by.y = "names",
                  all.x = TRUE)
  taxa.x[is.na(taxa.x)] <- 0 #NA = zero
  taxa.x <- data.frame(with(taxa.x, taxa.x[order(EVENT_ID), ]))
  rich_vec <- vegan::specnumber(taxa.x[, 3:ncol(taxa.x)])
  final_vec <- unname(rich_vec)
  return(final_vec)
}

#' Calculate Richness
#'
#' @param Long a long data frame.
#' @param Level the taxonomic level of interest.
#'
#' @returns a vector of richness values.
#' @export

richness <- function(Long, Level) {
  wide_df <- wide(Long, Level)
  #==============================================================================
  # Species Richness
  unname(vegan::specnumber(wide_df[, 6:ncol(wide_df)]))
}
