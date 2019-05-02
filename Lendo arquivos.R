######################################################################################################
######################################Estabelecendo Diretório#########################################
######################################################################################################

#Nesse módulo vamos aprender a abrir arquivos de diversas extensões no R.

#Assim como no SPSS, o R também necessita de um diretório que aponte o caminho para os arquivos que vo-
#cê deseja abrir, para tanto é necessário que você especifique seu diretório antes de tentar abrir o 
#arquivo.

#Para especificar um diretório usamos a função setwd(.)

?setwd
setwd('//10.230.13.14/Aulas/Curso R') #O caminho do diretório precisa estar entre aspas e a barra
#a barra deve ser invertida / ou duplas \\

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

base_dp <- read.csv("Base_DP_parcial.csv", sep = ";", header = T, nrows = 10)
base_dp
class(base_dp) #Retorna um data frame do arquivo lido

######txt######

#Para ler arquivos em .txt convencionais, devemos usar a função read.delim(.)
?read.delim

codmun <- read.delim("codmun.txt", sep = ";", header = T)
codmun
class(codmun) #Retorna um data frame do arquivo lido

#Para ler arquivos em .txt com espaços fixos (fixed widths), devemos usar a função read.fwf(.)
?read.fwf

armas_pm <- read.fwf("ARMAS PM 01 JAN19.txt",sep = "\t",widths = c(20,25,23,23,33,32,16,15,64), nrows = 200)
armas_pm
class(armas_pm) #Retorna um data frame do arquivo lido

#Também é possível utilizar essas funções para extrair arquivos da web
base_dp2 <- read.csv("http://www.ispdados.rj.gov.br/Arquivos/BaseDPEvolucaoMensalCisp.csv",
                  header = T, sep = ";", nrows = 10)
base_dp2

#Também podemos ler os arquivos especificando o caminho da pasta

base_dp3 <- read.csv("//ESTATISTICA-08/Bases/Base_DP_parcial.csv", sep = ";", header = T, nrows = 10)
base_dp3

#Nesse caso, como estamos deixando claro de onde o R está puxando o arquivo, a especificação do diretório não tem
#tanta importância
getwd()

base_dp3 <- read.csv("//ESTATISTICA-08/Bases/Base_DP_parcial.csv", sep = ";", header = T, nrows = 10)
base_dp3


#####xlsx######

#Para abrir arquivos de Excel (.xlsx), podemos usar o pacote xlsx

library(xlsx)

#Perceba que se tentarmos abrir assim, não funcionará, pois precisamos especificar qual aba do arquivos desejamos
#abrir
desc <- read.xlsx("Descricao.xlsx") 

#Portanto

desc <- read.xlsx("Descricao.xlsx", sheetIndex = 1) 
desc

inscritos <- read.xlsx("//10.230.13.14/Pública/Dossiê mulher/DOSSIÊ MULHER 2018/Lista de inscritos (as)  Lançamento Dossiê Mulher  2018 (final).xlsx", sheetIndex = 1, header = T, encoding = "UTF-8")
#Nota: o parâmetro enconding serve para que os acentos apareçam nas palavras


######sav######

#Para abrirmos arquivos de SPSS (.sav) no R, precisamos carregar o pacote foreign e usar a função read.spss(.)

library(foreign)

monitoramento_aisp <- read.spss("Monitoramento_AISP(novo).sav", to.data.frame = TRUE)
monitoramento_aisp$datc <- as.POSIXct(monitoramento_aisp$datc, origin="1582-10-14", tz="GMT")
monitoramento_aisp$datf <- as.POSIXct(monitoramento_aisp$datf, origin="1582-10-14", tz="GMT")
monitoramento_aisp #Esse conjunto de dados já é bem maior, tanto que o R não imprime na tela todos os valores

#####dta#####

#No caso de arquivos do STATA (.dta) vamos usar a função read.dta(.), também do pacote foreign

read.dta("conferencia2018m6.dta") #Não lê pois o arquivo foi salvo na versão 13 do STATA

#Vamos então usar o pacote readstata13 e a função read.dta13(.) para abrir esse arquivo

#install.packages("readstata13")

library(readstata13)

conf <- read.dta13("conferencia2018m6.dta")
conf


#####Área de Transferência#####

#Podemos querer abrir dados copiados para o computador usando o comando ctrl + c. Nesse caso basta utilizar a função
#read.delim usando o parâmetro clipboard
#abra https://cidades.ibge.gov.br/brasil/sintese/rj?indicadores=30255

base <- read.delim("clipboard", header = F)
base <- read.delim("clipboard")


####################################################################################################################
##############################################Visualizando a base de dados##########################################
####################################################################################################################

#Agora que já sabemos como abrir bases de dados no R, vamos ver como faremos para fazer as primeiras análises em 
#nossas bases.

#Iremos utilizar a base de armas para introduzir as primeiras análises estatísticas.

#Recapitulando o início da aula, precisamos estabelecer o diretório onde se encontra o nosso arquivo. Além disso,
#ele está em formato .xlsx, o que necessitará de um pacote

setwd("//10.230.13.14/Aulas/Curso R")
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

#O argumento sheet da função xlsx fala qual é a aba do arquivo que deve ser lida

explosivos <- read.xlsx("base_armas_site.xlsx", sheet = 3, startRow = 1)

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
