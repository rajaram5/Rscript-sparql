"
@author Nirupama Benis
@author Rajaram Kaliyaperumal

@version 0.1
@since 20-11-2014

<p>
  This rscript query kegg pathway SPARQL endpoint to retrieve the pathways associated with the given Entrez GeneID  
</p>

Input Required : Entrez GeneID
Output : dataframe with Entrez GeneID, Pathway name and Pathway class
"

library('SPARQL')

# URL of the SPARQL enpoint
endpoint <- "http://cu.kegg.bio2rdf.org/sparql"

# SPARQL to retrieve pathwayName and pathwayClass for a given entrez geneID.
queryStr <- "PREFIX void: <http://rdfs.org/ns/void#>
PREFIX dv: <http://bio2rdf.org/bio2rdf.dataset_vocabulary:>
PREFIX keggv: <http://bio2rdf.org/kegg_vocabulary:> 


SELECT DISTINCT ?pathway (str(?pathwayName) as ?pathwayNameStr) (str(?pathwayClass) as ?pathwayClassStr)   {

<http://bio2rdf.org/kegg:hsa_geneID> keggv:pathway ?pathway.


?pathway keggv:class ?pathwayClass;
dcterms:title ?pathwayName.

}"

# Substitute the entrez geneID in the SPARQL query string.
EntrezGeneID <- "3350"
queryStr <- gsub("geneID", EntrezGeneID, queryStr)

# Execute SPARQL query
d <- SPARQL(url=endpoint, query=queryStr)

# Attach results to a data frame
df <- data.frame(GeneID=EntrezGeneID, Pathwayname=d$results$pathwayNameStr, PathwayClass=factor(d$results$pathwayClassStr), stringsAsFactors=FALSE)