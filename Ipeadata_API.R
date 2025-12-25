# ============================================ #
# === DATA COLLECT FUNCTION - IPEADATA API === #
# ============================================ #

# --- Script by Paulo Icaro --- #


# ------------------------------ #
# --- Packages and Libraries --- #
# ------------------------------ #
library(httr)         # R API connection function (Base Version)
library(httr2)        # R API connection function (Modern Version)
library(jsonlite)     # Library for converting JSON data to a readable format
library(dplyr)        # Library for data manipulation


# --------------------------- #
# --- API Access Function --- #
# --------------------------- #
ipeadata_api = function(url, httr = TRUE){
  message('Iniciando a conexão com a API ... \n')
  Sys.sleep(3)
  flag = 0
  
  # --- API Connection - Using httr --- #
  if(httr == TRUE){
    
    # --- API Connection --- #
    api_connection = tryCatch(expr = GET(url = url), 
                              error = function(e){return(NULL)})
    
    # --- Connection Flags --- #
    if(api_connection$status_code != 200 || is.null(api_connection)){
      while(flag < 3 & (api_connection$status_code != 200 || is.null(api_connection))){
        flag = flag + 1
        api_connection = tryCatch(expr = GET(url = url), 
                                  error = function(e){message("Falha na conexão. Tentando novamente ...\n")})
        Sys.sleep(flag)           # Progressive delay
        }
      
      # --- Fail Case --- #
      if(flag == 3 && is.null(api_connection)){
        message('Falha ao conectar com o API. Verifique sua conexão de internet.')
      } else { 
        message('A API pode estar indisponível no momento. Tente novamente mais tarde.')}
    }
    
    # --- Successfull Case --- #
    else{message('Conexão bem sucedida ! Os dados foram coletados.')}
  }
  
  
  # --- Output --- #
  return(api_connection)
  }