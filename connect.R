library(sparklyr)
cluster_url <- paste0("spark://", system("hostname -i", intern = TRUE), ":7077")
sc <- spark_connect(master = cluster_url)