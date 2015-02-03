proteinURIs <- uniprot.getProteinUriByGeneNameAndTaxoID("Gtf2b", "10090")

for (i in 1:length(proteinURIs)) {
  
  pathwayURIs <- reactome.getPathwayUriByProteinUri(proteinURIs[i])
  print(i)
  print(pathwayURIs)
}