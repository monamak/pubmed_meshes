#install.packages('easyPubMed')

library(easyPubMed)
library(dplyr)
library(kableExtra)
library(readxl)

# reading the xlsx file:
df <- read.csv('C:/Users/Mona/Downloads/ids.csv')
df$X0[1:1]
df$mesh[1:994838]<-0

colnames(df)

# ________________ mesh function

#install.packages('rentrez')
library(rentrez)
library(XML)
MeSH_from_pmid <- function(pmid){
  rec <- entrez_fetch(db="pubmed", id=pmid, rettype = "xml", parsed=TRUE)
  if(length(xpathSApply(rec, "//MeshHeadingList/MeshHeading/DescriptorName",xmlValue))>0)
  {
    m_names <- xpathSApply(rec, "//MeshHeadingList/MeshHeading/DescriptorName",xmlValue)
    # m_ui <- xpathSApply(rec, "//MeshHeadingList/MeshHeading/DescriptorName", xmlAttrs)[1,]
    
    #data.frame(mesh_ui = m_ui, descriptor = m_names
    t = data.frame(descriptor = m_names)
    meshes <- paste(apply(t, 1, function(row) paste(dQuote(row), collapse=",")), collapse=',')
    meshes
  }
  else
  {
    meshes <- 'null'
    meshes
  }
}

#________________  get meshes (save 10000 at each time)

MeSH_from_pmid(8616674)

df$mesh[1:5] <- lapply(df$X0[1:5],MeSH_from_pmid)
df$mesh[5:10000] <- lapply(df$X0[5:10000],MeSH_from_pmid)
df$mesh[10000:20000] <- lapply(df$X0[10000:20000],MeSH_from_pmid)
df$mesh[20000:30000] <- lapply(df$X0[20000:30000],MeSH_from_pmid)
df$mesh[30000:40000] <- lapply(df$X0[30000:40000],MeSH_from_pmid)
df$mesh[40000:50000] <- lapply(df$X0[50000:50000],MeSH_from_pmid)
df$mesh[50000:60000] <- lapply(df$X0[50000:60000],MeSH_from_pmid)
df$mesh[60000:70000] <- lapply(df$X0[60000:70000],MeSH_from_pmid)
df$mesh[70000:80000] <- lapply(df$X0[70000:80000],MeSH_from_pmid)

df$mesh[1:5]

#save
df1 <- apply(df,2,as.character)
write.csv(df1,"C:/Users/Mona/Downloads/meshes_1-10k.csv", row.names = FALSE)

# ________________ load concept table and add meshes

concept_df <- read.csv('C:/Users/Mona/Downloads/vocabulary_download_v5_{2b97a5ea-3f9b-46e1-8c07-367d9abe7201}_1636818886213/CONCEPT.csv'
                       , header=TRUE, sep = '\t')

meshes_df <- read.csv('C:/Users/Mona/Downloads/meshes.csv'
                      , header=TRUE)

head(concept_df, n=1)
head(meshes_df, n=1)
colnames(meshes_df)
sapply(meshes_df, class)

# separate concepts with or when having /
# before /
regmatches(concept_df$concept_name[3:3],gregexpr("(?<=/).*",concept_df$concept_name[3:3],perl=TRUE))
# after /
regmatches(concept_df$concept_name[3:3],gregexpr("(?<=/).*",concept_df$concept_name[3:3],perl=TRUE))
# in between 2 /

# ____________ the function to map

concept_df$pubmedid<-'Null'
map_concept_mesh <- function(concept_name){
  s <- vector(mode = "list")     # empty list
  j=-1     #  to add to the list
  for (i in 1:3){
  ifelse (regexpr(concept_name, meshes_df[i:i,2])>0, 
          { 
             s[[j]] <- meshes_df[i:i,1]
              j <- j + 1
          },
          s[[j]])
  s}
}

map_concept_mesh('Amylases')

# _______________ go over all concepts
concept_df$pubmed_id[1:3] <- lapply(concept_df$concept_name[1:3],map_concept_mesh)

concept_df$concept_name[1:3]
head(df,2)
df[1:3,]
for (i in 1:3) print(meshes_df[i,1])

# test regex
if (regexpr('Pulmonary', meshes_df$mesh[2:2])>0) concept_df$pubmedid[2:2] <- meshes_df$X0[2:2]
colnames(concept_df)
head(concept_df, n=2)
