#' Retrieve 1st Degree LinkedIn Connections
#'
#' @description
#' \code{getMyConnections} returns information about your 1st degree 
#' connections who do not have their profile set to private.
#' 
#' You cannot "browse connections." That is, you cannot get connections 
#' of your connections (2nd degree connections).
#'
#' @author
#' Michael Piccirilli \email{michael.r.piccirilli@@gmail.com}
#' @seealso \code{\link{getProfile}}, \code{\link{searchPeople}}
#'
#' @param token Authorization token.
#' @param partner Indicate whether you belong to the Partnership Program. Values: 0 or 1
#' 
#' @return Returns a dataframe of your 1st degree LinkedIn connections.
#' 
#' @examples
#' \dontrun{
#' 
#' my.connections <- getMyConnections(in.auth)
#' }
#' @export


getMyConnections <- function(token, partner = 0)
{ 
  
  if(partner == 0){
    stop("This function is no longer available through LinkedIn's open API.  \n
  If you are a member of the Partnership Program, set the 'partner' input of this function equal to 1 (default: 0).")
  }
  
  # returns default fields
  base_url <- "http://api.linkedin.com/v1/people/~/connections"
  query <- GET(base_url, config(token = token))
  q.content <- content(query) 
  xml <- xmlTreeParse(q.content, useInternalNodes=TRUE)
  if(!is.na(xml[["number(//error/status)"]]==404)){
    stop(xml[["string(//error/message)"]])
  }
  q.df <- connectionsToDF(q.content)
  return(q.df)
}
