####################################################################################################################
###############################################Estatísticas Descritivas#############################################
####################################################################################################################

#Agora vamos calcular algumas estatísticas descritivas de uma base de dados

#Não esquecer de estabelecer o diretório setwd("//10.230.13.14/Aulas/Curso R")

setwd("//10.230.13.14/Aulas/Curso R")

#Vamos utilizar o arquivo de veículos para os exemplos desta aula.

library(foreign) #A função desse pacote abre arquivos de Excel de tamanhos muito maiores do que a função do pacote xlsx

veiculos <- read.spss("veiculos_n_casados_2019.sav", to.data.frame = TRUE)
veiculos$datc <- as.POSIXct(veiculos$datc, origin="1582-10-14", tz="GMT")
veiculos$datf <- as.POSIXct(veiculos$datf, origin="1582-10-14", tz="GMT")

#A função summary(.) retorna máximo, mínimo, média, mediana, primeiro e terceiro quartis

?summary

summary(veiculos$mes)

summary(veiculos$ano_veiculo)

#Se quisermos calcular apenas a média, usamos a função mean(.)
?mean

mean(veiculos$mes)

mean(veiculos$ano_veiculo)

#Para calcular o máximo e o mínimo usamos as funções max(.) e min(.)
?max
?min

max(veiculos$mes)
min(veiculos$mes)

max(veiculos$ano_veiculo)
min(veiculos$ano_veiculo)

#Para calcular o desvio padrão de uma variável, utilizamos a funçõa sd(.)
?sd

sd(veiculos$mes)

sd(veiculos$ano_veiculo)
sd(veiculos$ano_veiculo, na.rm = T) # A função não calcula o sd caso tenha valores NA

#Se quiser arredondar os resultados para um número menor de casas decimais, podemos usar a função round(.),
#vamos também passar o argumento 'digits' que representa o número de casas decimais que queremos mostrar
?round

sd(veiculos$mes)

round(sd(veiculos$mes), digits = 2)


####################################################################################################################
################################################Tabelas de Frequências##############################################
####################################################################################################################


#Podemos também, criar tabelas de frequência para verificar quantos veículos foram subtraídos/recuperados em cada mês
#usando a função table(.)
?table

table(veiculos$mes)

table(veiculos$mes, veiculos$cor_veiculo)

#Caso seja de interesse verificar quais cidades registraram ocorrências podemos usar a função unique(.) para ver quais
#nomes de cidades aparecem ao menos uma vez no banco
?unique

unique(veiculos$fmun_cod) 

#Vemos que os números das Rips não saem ordenados, se quisermos ordenar o output, vamos utilizar a função sort(.)
?sort

sort(unique(veiculos$fmun_cod))

#Agora vamos introduzir o conceito de collapse no banco de dados, para que a construção de tabelas de frequências
#mais elaboradas seja possível. Primeiramente, vamos ver contagens dentro de um microdado.

library(plyr)

contagem <- count(veiculos, c('circ','indicadora'))

#isso é equivalente a:
table(veiculos$circ,veiculos$indicadora)

contagem <- count(veiculos, c('circ','indicadora','mes'))

#isso é equivalente a (só que mais complicado de visualizar):
table(veiculos$circ,veiculos$indicadora,veiculos$mes)


#Agora vamos para outras estatísticas de interesse. Para isso vamos usar o pacote doBy e a função summaryBy(.)

library(doBy)

?summaryBy

collapsed <- summaryBy(ano_veiculo ~ circ + indicadora, data = veiculos, FUN = mean)
collapsed <- summaryBy(ano_veiculo ~ circ + indicadora, data = veiculos, FUN = mean, na.rm = T)
collapsed <- summaryBy(ano_veiculo ~ circ + indicadora, data = veiculos, FUN = c(mean,median), na.rm = T)


prop.table(table(collapsed$garruchao.sum)) #Podemos retirar as proporção de frequências para uma arma específica


####################################################################################################################
##################################################Básico de Gráficos################################################
####################################################################################################################

#O R em sua base possui ferramentas gráficas bastante poderosas, que podem ser usadas para construir uma série de 
#representações

#####Histograma####

#Para construir um histograma no R vamos usar a função hist(.)
?hist

#Visualizando a distribuição de apreensão de armas de fabricação caseira
hist(collapsed$arma_fabricacao_caseira.sum)

#Vizualizando a distributição de apreensão de fuzis
hist(collapsed$fuzil.sum)

#####Plots#####

#Podemos também construir gráficos de pontos, linhas e etc. usando a função plot(.)
?plot

#Essa função aceita o parâmetro 'type', se não colocarmos nada, o default é um gráfico de pontos

plot(collapsed$espingarda.sum)

#Caso seja necessário visualizar um gráfico de linhas, podemos usar o parâmetro 'type'

plot(collapsed$espingarda.sum, type = 'l') #L minúsculo entre aspas

#Existem outras opções para o parâmetro 'type', caso seja de interesse olha a ajuda da função

####Bar plots####

#Podemos também fazer gráficos de barras, para tanto vamos usar a função barplot
?barplot

barplot(collapsed$fuzil.sum[which(collapsed$vano == 2018)])

barplot(collapsed$arma_fabricacao_caseira.sum[which(collapsed$vano == 2018)])

####Boxplot#####

#Podemos também verificar a distribuição da apreensão de determinado tipo de arma através de um boxplot, esse gráfico
#permite a visualização de algumas estatísticas importantes, como a mediana e primeiro e terceiro quartis

?boxplot

boxplot(collapsed$garrucha.sum) #AQUI EXPLICAR OS LIMITES SUPERIOR E INFERIOR E A VISUALIZAÇÃO DE VALORES EXTREMOS

#####Gráfico de pizza####

#Esse gráfico representa as proporções de determinada variável em relação ao todo que está sendo comparado. Por exemplo,
#podemos estar interessados em comparar o total apreendido de pistola, fuzis e revólveres 

total_fuzil <- sum(collapsed$fuzil.sum)
total_revolver <- sum(collapsed$revolver.sum)
total_pistola <- sum(collapsed$pistola.sum)

#Vamos usar a função pie(.) para construir esse gráfico
?pie

pie(c(total_fuzil, total_pistola, total_revolver))

#Os números 1, 2 e 3 representam fuzil, pistola e revólver, respectivamente, na ordem que foram colocados na função.
#Se desejarmos visualizar labels nesse gráfico podemos usar o parâmetro 'labels' de maneira muito simples

lbs <- c('Fuzil', 'Pistola', 'Revolver')

pie(c(total_fuzil, total_pistola, total_revolver), labels = lbs)


####################################################################################################################
#############################################Embelezando nossos gráficos############################################
####################################################################################################################

#Os gráficos vistos na seção anterior carecem de algumas características básicas, como título e legendas. Veremos
#agora como colocar esses atributos para deixar nossos gráficos mais atraentes.

#O R possui um conjunto de parâmetros conhecidos comos parâmetros gráficos. Esses parâmetros são genéricos, sendo, por-
#tanto, usualmente aceitos em qualquer uma das funções vistas anteriormente.

#Vamos começar colocando títulos, o parâmetro que utilizaremos é chamado de 'main'

hist(collapsed$fuzil.sum, main = 'Distribuição de Apreensões - Fuzil')

#Podemos também querer modificar o que está escrito nos eixos dos nossos gráficos, para tanto, vamos utilizar os 
#parâmetros xlab e ylab

hist(collapsed$fuzil.sum, main = 'Distribuição de Apreensões - Fuzil', xlab = 'Fuzil',
     ylab = 'Apreensões')

#E se quisermos colocar cor no gráfico? Para isso existe o parâmetro 'col'

hist(collapsed$fuzil.sum, main = 'Distribuição de Apreensões - Fuzil', xlab = 'Fuzil',
     ylab = 'Apreensões', col = 'lightgray')

#Podemos ainda colocar uma caixa em torno do gráfico com a função box
?box #Clique em 'Draw a Box around a Plot'

box(which = 'plot')

#Vamos construir um barplot utilizando alguns dos conceitos ja vistos anteriormente

total_fuzil <- sum(collapsed$fuzil.sum)
total_revolver <- sum(collapsed$revolver.sum)
total_pistola <- sum(collapsed$pistola.sum)
total_metralhadora <- sum(collapsed$metralhadora.sum)
total_arma_caseira <- sum(collapsed$arma_fabricacao_caseira.sum)

#Dando cores para as barras e nomes

cols <- c('blue', 'red', 'green', 'lightgray', 'brown')
names <- c('Fuzil', 'Revólver', 'Pistola', 'Metr', 'Caseira')

barplot(c(total_fuzil, total_revolver, total_pistola, total_arma_caseira, total_metralhadora),
        main = 'Comparação total de apreensões', col = cols, names.arg = names)
abline(h=6) #Desenha linha no eixo x do gráfico

#Caso seja necessário colocar legenda no gráfico, vamos usar a função legend(.)
?legend

plot(collapsed$fuzil.sum, type = 'l', ylim = c(0, 100), main = 'Fuzil',
     xlab = '', ylab = 'Apreensões') #ylim estabelece os limites do eixo vertical do gráfico
abline(h = mean(collapsed$fuzil.sum), col = 'red', lty = 2) #Traça a média horizontalmente no gráfico
legend(0, 100, c('Série Histórica', 'Média'), col = 1:2, lty = 1:2, cex = 0.75)
