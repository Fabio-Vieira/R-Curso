######################################################################################################
############################################Introdução################################################
######################################################################################################

#As funções apresentadas nesse script não representam uma lista exaustiva. Existem inúmeras formas
#de se produzir os resultados apresentados, utilizando funções e métodos completamente diferentes.


#########Calculadora########

#Operações básicas

15 + 35 #Soma
42 - 28 #Subtração
10 / 2  #Divisão
32 * 5  #Multiplicação
4 ^ 2   #Potenciação

#########Classes##########

#Podemos usar a função class() para descobrir a classe ou tipo de um objeto

#Pedindo ajuda sobre a função
?class
help(class)

class(4)
class("ISP dados") #Caracteres devem ser declarados entre aspas
class(TRUE)

####Criação de sequências####
#Podemos usar ":" para criar uma sequência no R
1:10
1:50
-5:5

#Caso seja necessário criar sequências que não sejam de números inteiros, podemos usar a função
#seq(.)

#Pedindo ajuda sobre a função
?seq
help(seq)

seq(from = 1, to = 10, by = 0.5)
seq(from = -10, to = 10, 0.1)

##################################################################################################
########################################Estrutura de dados########################################
##################################################################################################

#Estrutura de dados pode ser definida como uma forma específica de armazenar e organizar dados.
#O R suporta 5 tipos básicos de estrutura: vetor, matriz, lista, data frame e fator.

#####Vetor######

#Utilizamos a função c(.) (concatenate) para construir vetores
?c

c(1, 2, 3, 4, 5, 10, 14, 21)
class(c(1, 2, 3, 4, 5, 10, 14, 21))

c(43, 32, 25, 67, 9, 93, 52, 8)
class(c(1, 2, 3, 4, 5, 10, 14, 21))

c(TRUE, FALSE, TRUE, TRUE)
class(c(TRUE, FALSE, TRUE, TRUE))

####Matriz#####

#Utilizamos a função matrix(.) para construit matrizes
?matrix

matrix(1:9, ncol = 3)

matrix(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), nrow = 3, ncol = 4)
class(matrix(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), nrow = 3, ncol = 4))

#Usando a função array para criar uma matrix
?array

array(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), dim = c(3, 4))
class(array(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), dim = c(3, 4)))

#Matrizes e vetores armazenam dados de apenas uma classe
c(1, 2, 3, 4, 5, "Jonas", 14, 21)
class(c(1, 2, 3, 4, 5, "Jonas", 14, 21))

matrix(c(10, 34, 45, 52, "Bárbara", 101, 73, 90, 45, 66, 23, 11), nrow = 3, ncol = 4)

######Lista#####

#Vamos usar a função list(.) nesse caso
?list

list(Nomes = c("João", "Maria"), Idades = c(23, 25))
class(list(Nomes = c("João", "Maria"), Idades = c(23, 25)))

#Elementos dentro da lista podem ter cumprimentos diferences
list(Nomes = c("João", "Maria", "Carlos"), Idades = c(23, 25))

#Uma lista também pode conter elementos de diferentes dimensões
list(Vetor = c(1, 2, 3, 4, 5, 10, 14, 21),
     Matriz = matrix(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), nrow = 3, ncol = 4))

####Data Frame#####
#Data frame armazena classes e tipos diferentes em um formato semelhante ao de uma matriz

#Para criar um data frame utilizamos a função data.frame(.)

data.frame(Id = c(1, 2, 3, 4, 5, 6, 7, 8),
           Nomes = c("Mariana", "Lucas", "Daniel", "Carlinhos", "Zeca", "Fred", "Dentinho", "Josivaldo"))

class(data.frame(Id = c(1, 2, 3, 4, 5, 6, 7, 8),
                 Nomes = c("Mariana", "Lucas", "Daniel", "Carlinhos", "Zeca", "Fred", "Dentinho", "Josivaldo")))


#####Fator######

#Para comunicar o R que uma variável possui valores nominais, vamos utilizar a função factor
?factor

c(rep("Masculino", 5), rep("feminino", 8)) #A função rep(.) produz repetições de um elemento, para ver o help digite ?rep no console

factor(c(rep("Masculino", 5), rep("feminino", 8)))


##################################################################################################
#################################Instalação e carregamentos de pacotes############################
##################################################################################################

#O R possui uma série de bibliotecas disponíveis na internet de maneira gratuita, sendo necessário
#apenas realizar o download e o carregamento dessa bibliotecas para que todas as funções disponíveis
#nelas possam ser utilizadas.

#Para instalar um pacote vamos utilizar a função install.packages(.)
?install.packages

install.packages("gglopt2") #repare que o nome do pacote deve estar entre aspas

#Para verificar se o pacote está de fato instalado, basta usar a função installed.packages(.)
?installed.packages

installed.packages("ggplot2")

#Para ativar o pacote e começar a utilizar suas funções, podemos utilizar tanto a função require(.)
#como a função library(.)

#No caso de um conjunto de dados presente em algum pacote, devemos carregar o pacote para invocar os
#dados

cane #O pacote onde o conjunto de dados 'cane' está, ainda não foi carregado

#install.packages("boot")

library(boot) 
?cane
head(cane)
tapply(cane$r, cane$block, mean)

#O mesmo vale para funções

#Um exemplo pode ser o Augmented Dickey-Fuller test, que testa a estacionariedade de uma série tem-
#poral
set.seed(1) #Comando para fixar a geração de valores aleatórios

?adf.test #O R não encontra a função, pois está dentro de um pacote ainda não carregado

#install.packages("aTSA")

library(aTSA)

?adf.test

plot(arima.sim(list(order = c(1,0,0), ar = 0.2), n = 100))
adf.test(arima.sim(list(order = c(1,0,0), ar = 0.2), n = 100))

