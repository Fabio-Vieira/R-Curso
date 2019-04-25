####################################################################################################################
##############################################Analisando a base de dados############################################
####################################################################################################################

#Agora que já sabemos como abrir bases de dados no R, vamos ver como faremos para fazer as primeiras análises em 
#nossas bases.

#Iremos utilizar a base de armas para introduzir as primeiras análises estatísticas.

#Recapitulando a aula passada, precisaremos estabelecer o diretório onde se encontra o nosso arquivo. Além disso,
#ele está em formato .xlsx, o que necessitará de um pacote

setwd("C:/Users/Estatistica/Desktop/Curso-R")
getwd() #Verificando se estamos no diretório correto

dir() #Conferindo se o nosso arquivo de fato está no nosso diretório

#Repare que ao tentarmos abrir o conjunto de dados sem invocarmos o pacote que contém a função read.xlsx(.),
#o arquivo não irá abrir!

armas <- read.xlsx("base_armas_site.xlsx", sheet = 1, startRow = 1)

library(openxlsx) #A função desse pacote abre arquivos de Excel de tamanhos muito maiores do que a função do pacote xlsx

?read.xlsx

armas <- read.xlsx("base_armas_site.xlsx", sheet = 1, startRow = 1)

#Para visualizarmos a base, vamos utilizar a função View(.)
?View

View(armas) #O mesmo resultado pode ser produzido se clicarmos no nome da base na aba environment

#Como já vimos anteriormente se tentarmos imprimir toda a base no console, o R omitirá parte dela por ser grande 
#demais

armas #Ou print(data_publica)

#Dessa forma, podemos usar as funções head(.) e tail(.) para verificar apenas as primeiras e últimas linhas do banco
?head
?tail

head(armas)

tail(armas)

#O número de linhas padrão é 6, no entando se quisermos aumentar esse número, podemos passar o parâmetro 'n' nas funções
#acima

#Aumentando para 10

head(armas, n = 10L) #o uso do L no R tem apenas o objetivo de deixar explícito que o número é inteiro

tail(armas, n = 10L)

####################################################################################################################
###############################################Estatísticas Descritivas#############################################
####################################################################################################################

#Agora vamos calcular algumas estatísticas descritivas de uma base de dados

#Não esquecer de estabelecer o diretório setwd("C:/Users/Estatistica/Desktop/Curso-R")

#A função summary(.) retorna máximo, mínimo, média, mediana, primeiro e terceiro quartis

?summary

summary(armas$total)

summary(armas$revolver)

#Se quisermos calcular apenas a média, usamos a função mean(.)
?mean

mean(armas$total)

mean(armas$revolver)

#Para calcular o máximo e o mínimo usamos as funções max(.) e min(.)
?max
?min

max(armas$total)
min(armas$total)

max(armas$revolver)
min(armas$revolver)

#Para calcular o desvio padrão de uma variável, utilizamos a funçõa sd(.)
?sd

sd(armas$total)

sd(armas$fuzil) #Podemos calcular essa quantidade para qualquer variável

#Se quiser arredondar os resultados para um número menor de casas decimais, podemos usar a função round(.),
#vamos também passar o argumento 'digits' que representa o número de casas decimais que queremos mostrar
?round

sd(armas$total)

round(sd(armas$total), digits = 2)


####################################################################################################################
################################################Tabelas de Frequências##############################################
####################################################################################################################


#Podemos também, criar tabelas de frequência para verificar quantos casos desse crime foram registrados em cada mês
#usando a função table(.)
?table

table(armas$vano, armas$mes)

table(armas$mes, armas$garruchao)

#Caso seja de interesse verificar quais cidades registraram ocorrências podemos usar a função unique(.) para ver quais
#nomes de cidades aparecem ao menos uma vez no banco
?unique

unique(armas$risp) 

#Vemos que os números das Rips não saem ordenados, se quisermos ordenar o output, vamos utilizar a função sort(.)
?sort

sort(unique(armas$risp))

#Agora vamos introduzir o conceito de collapse no banco de dados, para que a construção de tabelas de frequências
#mais elaboradas seja possível. Para tanto, vamos usar o pacote doBy e a função summaryBy(.)

library(doBy)

?summaryBy

collapsed <- summaryBy(arma_fabricacao_caseira + carabina + espingarda + fuzil + garrucha + garruchao + metralhadora +           
         outros+ pistola + revolver + submetralhadora ~ mes + vano, data = armas, FUN = sum)


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
