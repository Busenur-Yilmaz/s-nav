install.packages(c("httr", "base64enc"))
library(httr)
library(base64enc)

spotify_token <- function() {
  
  # Spotify uygulamasından alınan client ID ve client secret
  client_id <- "4792bb44480a4cab84ee7ee93d1db36c"
  client_secret <- "493133d569af4383a08ecec41c26daf7"
  
  # Spotify Web API token almak için gereken URL
  token_url <- "https://accounts.spotify.com/api/token"
  
  # Base64 kodlama işlemi
  credentials <- base64encode(paste0(client_id, ":", client_secret))
  
  # Token isteği için gerekli parametreler
  token_params <- list(
    grant_type = "client_credentials"
  )
  
  # Token isteği başlıkları
  token_headers <- c(
    Authorization = paste("Basic", credentials)
  )
  
  # Token isteği gönderme
  token_response <- POST(
    url = token_url,
    body = token_params,
    add_headers(.headers = token_headers),
    encode = "form"
  )
  
  # HTTP status code'u alma
  status_code <- status_code(token_response)
  
  # Yanıtı JSON formatına çözme
  token_data <- content(token_response)
  
  # Erişim token'ını oluşturma
  access_token <- paste("Bearer", token_data$access_token)
  
  # Sonuçları liste olarak döndürme
  result <- list(
    status_code = status_code,
    token = access_token
  )
  
  return(result)
}

# Fonksiyonu kullanarak erişim token'ını alma
token_result <- spotify_token()

# Elde edilen sonuçları yazdırma
print(token_result$status_code)
print(token_result$token)

