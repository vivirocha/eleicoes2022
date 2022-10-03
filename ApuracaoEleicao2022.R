
######################################################################
###                                                                ###
###                                                                ###
###                   ELEIÇÕES 2022 - BRASIL                       ###
###                                                                ###
###                                                                ###
#####################################################################


      "Resultados da eleição presidencial 2022 - PRIMEIRO TURNO"

"Apuração obtida pelo site do TSE (Tribunal Superior Eleitoral)"


######################################################################

#Instalação da biblioteca rjson e RJSONIO
install.packages("rjson")
install.packages('RJSONIO')
install.packages("ggplot2")
library(rjson)
library(RJSONIO)
require(dplyr)
library(ggplot2)

#Extraindo dados do site do TSE
eleicoes2022 <- httr::GET('https://resultados.tse.jus.br/oficial/ele2022/544/dados-simplificados/br/br-c0001-e000544-r.json') |>
httr::content()

apuracoes <- tibble::tribble(
  ~Numero, ~candidato,~VotosTotais, ~Percentual,
  eleicoes2022$cand[[1]]$seq, eleicoes2022$cand[[1]]$nm, eleicoes2022$cand[[1]]$vap, eleicoes2022$cand[[1]]$pvap,
  eleicoes2022$cand[[2]]$seq, eleicoes2022$cand[[2]]$nm, eleicoes2022$cand[[2]]$vap, eleicoes2022$cand[[2]]$pvap,
  eleicoes2022$cand[[3]]$seq, eleicoes2022$cand[[3]]$nm, eleicoes2022$cand[[3]]$vap, eleicoes2022$cand[[3]]$pvap,
  eleicoes2022$cand[[4]]$seq, eleicoes2022$cand[[4]]$nm, eleicoes2022$cand[[4]]$vap, eleicoes2022$cand[[4]]$pvap,
  eleicoes2022$cand[[5]]$seq, eleicoes2022$cand[[5]]$nm, eleicoes2022$cand[[5]]$vap, eleicoes2022$cand[[5]]$pvap,
  eleicoes2022$cand[[6]]$seq, eleicoes2022$cand[[6]]$nm, eleicoes2022$cand[[6]]$vap, eleicoes2022$cand[[6]]$pvap,
  eleicoes2022$cand[[7]]$seq, eleicoes2022$cand[[7]]$nm, eleicoes2022$cand[[7]]$vap, eleicoes2022$cand[[7]]$pvap,
  eleicoes2022$cand[[8]]$seq, eleicoes2022$cand[[8]]$nm, eleicoes2022$cand[[8]]$vap, eleicoes2022$cand[[8]]$pvap,
  eleicoes2022$cand[[9]]$seq, eleicoes2022$cand[[9]]$nm, eleicoes2022$cand[[9]]$vap, eleicoes2022$cand[[9]]$pvap,
  eleicoes2022$cand[[10]]$seq, eleicoes2022$cand[[10]]$nm, eleicoes2022$cand[[10]]$vap, eleicoes2022$cand[[10]]$pvap,
  eleicoes2022$cand[[11]]$seq, eleicoes2022$cand[[11]]$nm, eleicoes2022$cand[[11]]$vap, eleicoes2022$cand[[11]]$pvap)
print(apuracoes)

grafico <- ggplot(apuracoes, aes(x = candidato, y = Percentual, fill = candidato, label = Percentual)) +
  geom_bar(stat = "identity", position="dodge") + 
  geom_label(position = position_dodge(width = 1)) +
  theme(axis.text = element_text(size = 5, angle=0)) +
  scale_fill_viridis_d()

plot(grafico)

apuracoes2 <- data.frame(
  Numero = as.character(apuracoes$Numero),
  candidato = as.character(apuracoes$candidato),
  VotosTotais = as.numeric(apuracoes$VotosTotais),
  Percentual = as.character(apuracoes$Percentual))

str(apuracoes2)

soma <- sum(apuracoes2$VotosTotais)
soma

sprintf("Total de votos válidos: %s", soma)
