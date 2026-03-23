suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(Biostrings))
suppressPackageStartupMessages(library(ShortRead))

args <- commandArgs(trailingOnly = TRUE)
print(args[1])
print(args[2])

# convert I1/I2 to quality scores via Biostrings:

qualI1 <- readQualityScaledDNAStringSet(args[1])
q1_phred <- quality(qualI1)
q1_names <- names(qualI1)
qualI1 <- as(q1_phred, "IntegerList")
qualI1 <- sapply(qualI1, mean) # average quality of each index
Q1 <- cbind(qualI1, q1_names) %>%
  as.data.frame()

qualI2 <- readQualityScaledDNAStringSet(args[2])
q2_phred <- quality(qualI2)
q2_names <- names(qualI2)
qualI2 <- as(q2_phred, "IntegerList")
qualI2 <- sapply(qualI2, mean) # average quality of each index
Q2 <- cbind(qualI2, q2_names) %>%
  as.data.frame()

# cutoff <- 30
# w <- which(Q1$qualI1 >= cutoff & Q2$qualI2 >= cutoff)

Q1_sub <- subset(Q1, qualI1 < 32)
Q2_sub <- subset(Q2, qualI2 < 32)

lowQ_reads <- c(Q1_sub$q1_names, Q2_sub$q2_names)
lowQ_reads <- as.data.frame(unique(lowQ_reads))

# save lowQ_reads list as .txt file (input for filterbyname.sh)
write.table(lowQ_reads, "./lowQ_reads.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)




