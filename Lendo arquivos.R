###ATENÇÃO!!!! COLOCAR EXEMPLOS QUE POSTERIORMENTE FUNCIONEM NOS COMPUTADORES QUE SERÃO USADOS NO CURSO

######################################################################################################
######################################Estabelecendo Diretório#########################################
######################################################################################################

#Nesse módulo vamos aprender a abrir arquivos de diversas extensões no R.

#Assim como no SPSS o R também necessita de um diretório que aponte o caminho para os arquivos que vo-
#cê deseja abrir, para tanto é necessário que você especifique seu diretório antes de tentar abrir o 
#arquivo.

#Para especificar um diretório usamos a função setwd(.)

?setwd
setwd('C:/Users/Estatistica/Desktop/Curso-R') #O caminho do diretório precisa estar entre aspas

#Para verificar se o diretório correto está estabelecido, usamos função getwd(.)
getwd() #Não é necessário nenhum parêmetro para essa função

#Para observar uma lista dos arquivos que estão presentes no diretório, bastar utilizar a função dir(.)
?dir
dir() #Também não necessita de nenhum parâmetro

#A função list.files, mostrada no help da dir(.), também possui a mesma função
list.files()


######################################################################################################
#########################################Lendo Arquivos no R##########################################
######################################################################################################


#Definido o diretório onde seu arquivo se encontra, você pode usar funções do R para abri-lo

######csv######

#Para abrir .csv, vamos usar a função read.csv(.)
?read.csv

circ <- read.csv("circ.csv", sep = ";", header = T)
circ
class(circ) #Retorna um data frame do arquivo lido

######txt######

#Para ler arquivos em .txt, devemos usar a função read.delim(.)
?read.delim

cisp <- read.delim("cisp.txt")
cisp
class(cisp) #Retorna um data frame do arquivo lido

#Também é possível utilizar essas funções para extrair arquivos da web
circ2 <- read.csv("https://raw.githubusercontent.com/Fabio-Vieira/R-Curso/master/circ.csv",
         header = T, sep = ";")
circ2

cisp2 <- read.delim("https://raw.githubusercontent.com/Fabio-Vieira/R-Curso/master/cisp.txt", sep = "\t")
cisp2

#Também podemos ler os arquivos especificando o caminho da pasta


circ3 <- read.csv("C:/Users/Estatistica/Desktop/Curso-R/circ.csv", sep = ";", header = TRUE)
circ3

cisp3 <- read.csv("C:/Users/Estatistica/Desktop/Curso-R/cisp.txt", sep = "\t")
cisp3

#Nesse caso, como estamos deixando claro de onde o R está puxando o arquivo, a especificação do diretório não tem
#tanta importância
getwd()

#
#
#COLOCAR UM EXEMPLO DE ALGUMA PASTA DOS COMPUTADORES DO LABORATÓRIO
#
#

#####xlsx######

#Para abrir arquivos de Excel (.xlsx), podemos usar o pacote xlsx

library(xlsx)

#Perceba que se tentarmos abrir assim, não funcionará, pois precisamos especificar qual aba do arquivos desejamos
#abrir
desc <- read.xlsx("Descricao.xlsx") 

#Portanto

desc <- read.xlsx("Descricao.xlsx", sheetIndex = 1) 
desc

auto <- read.xlsx("Automovel.xlsx", sheetIndex = 1, encoding = "UTF-8") #Nota: o parâmetro enconding serva para os acentos apareçam nas palavras

######sav######

#Para abrirmos arquivos de SPSS (.sav) no R, precisamos carregar o pacote foreign e usar a função read.spss(.)
 
library(foreign)

armas <- read.spss("rgocronu_limpa_armas.SAV", to.data.frame = TRUE)
armas #Esse conjunto de dados já é bem maior, tanto que o R não imprime na tela todos os valores

#####dta#####

#No caso de arquivos do STATA (.dta) vamos usar a função read.dta(.), também do pacote foreign

read.dta("conferencia2018m6.dta") #Não lê pois o arquivo foi salvo na versão 13 do STATA

#Vamos então usar o pacote readstata13 e a função read.dta13(.) para abrir esse arquivo

#install.packages("readstata13")

library(readstata13)

conf <- read.dta13("conferencia2018m6.dta")
conf


#####Área de Transferência#####

#Podemos querer abrir dados copiados para o computador usando o comando ctrl + c, nesse caso basta utilizar a função
#read.delim usando o parâmetro clipboard

base <- read.delim("clipboard")

####################################################################################################################
##############################################Visualizando a base de dados##########################################
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
