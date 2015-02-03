"
@author Nirupama Benis
@author Rajaram Kaliyaperumal

@version 0.1
@since 03-02-2015

<p>
...... 
</p>

Input Required : Protien URI
Output : List with pathway URIs
"

library('SPARQL')

reactome.getPathwayUriByProteinUri <- function(protienURI){
  
  # URL of the SPARQL enpoint
  endpoint <- "http://www.ebi.ac.uk/rdf/services/reactome/sparql"
  
  # SPARQL to retrieve protein URIs for a given gene name and taxoID.
  queryStr <- "
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX dc: <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX biopax3: <http://www.biopax.org/release/biopax-level3.owl#>


SELECT DISTINCT ?pathWayURI WHERE {   
  
?pathWayURI a biopax3:Pathway;
biopax3:pathwayComponent ?pathwayComp.
  
?pathwayComp a <http://www.biopax.org/release/biopax-level3.owl#BiochemicalReaction>;
biopax3:right|biopax3:left|biopax3:product|biopax3:participant ?BiochemicalReaction.
  
?BiochemicalReaction biopax3:entityReference ?protienURI. 
}     

  "

# Substitute the protienURI. in the SPARQL query string.
queryStr <- gsub("?protienURI.", protienURI, queryStr)

# Execute SPARQL query
d <- SPARQL(url=endpoint, query=queryStr)

# Attach results to a list
pathWayURIs <- unname(unlist(d[[1]]))
return(pathWayURIs)
}