"
@author Nirupama Benis
@author Rajaram Kaliyaperumal

@version 0.1
@since 03-02-2015

<p>
...... 
</p>

Input Required : Gene name and taxoID
Output : List with proteinURIs
"

library('SPARQL')

uniprot.getProteinUriByGeneNameAndTaxoID <- function(geneName, taxonID){

# URL of the SPARQL enpoint
endpoint <- "http://ep.dbcls.jp/fantom5/sparql"

# SPARQL to retrieve protein URIs for a given gene name and taxoID.
queryStr <- "
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX up:<http://purl.uniprot.org/core/> 
PREFIX taxon:<http://purl.uniprot.org/taxonomy/> 

SELECT ?proteinURI WHERE {   
  
  SERVICE <http://beta.sparql.uniprot.org/> {    
    
    ?gene skos:prefLabel 'geneName'.
    
    ?proteinURI a up:Protein;                   
               up:encodedBy ?gene;              
               up:organism taxon:tID .     
  
  }
}
"

# Substitute the geneName and taxonID in the SPARQL query string.
queryStr <- gsub("geneName", geneName, queryStr)
queryStr <- gsub("tID", taxonID, queryStr)

# Execute SPARQL query
d <- SPARQL(url=endpoint, query=queryStr)

# Attach results to a list
proteinURIs <- unname(unlist(d[[1]]))
return(proteinURIs)
}