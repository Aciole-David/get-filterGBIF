#install.packages('rgbif')

library('rgbif')

# 1: Cadastrar no geonames. É um recurso gratuito!!!
#https://www.geonames.org

# 2: Liberar serviço web:
#https://www.geonames.org/enablefreewebservice

# 3.1: Carregar coordenadas de tabela:
#A tabela tem q ser assim:
#decimalLatitude	decimalLongitude
#-23.516814518815195,	-46.18264158747329

coords_df=data.frame(read.table("coords.txt", header = T))
elevation(input = coords_df, username = "acioled")
umc<-elevation(input = coords_df, username = "acioled")

# 3.2: Carregar coordenadas como lista:
coords <- list(c(-23.516814518815195, -46.18264158747329))
elevation(latlong=coords, username = "acioled")
umc<-elevation(latlong=coords, username = "acioled")


