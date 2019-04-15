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

read.csv("circ.csv", sep = ";", header = T)

######txt######

#Para ler arquivos em .txt, devemos usar a função read.delim(.)
?read.delim

read.delim("cisp.txt")

#Também é possível utilizar essas funções para extrair arquivos da web
read.csv("https://raw.githubusercontent.com/Fabio-Vieira/R-Curso/master/circ.csv",
         header = T, sep = ";")

read.delim("https://raw.githubusercontent.com/Fabio-Vieira/R-Curso/master/cisp.txt", sep = "\t")

#####xlsx######

#Para abrir arquivos de Excel (.xlsx), podemos usar o pacote xlsx

library(xlsx)

#Perceba que se tentarmos abrir assim, não funcionará, pois precisamos especificar qual aba do arquivos desejamos
#abrir
read.xlsx("Descricao.xlsx") 

#Portanto

read.xlsx("Descricao.xlsx", sheetIndex = 1) 

read.xlsx("Automovel.xlsx", sheetIndex = 1, encoding = "UTF-8") #Nota: o parâmetro enconding serva para os acentos apareçam nas palavras


