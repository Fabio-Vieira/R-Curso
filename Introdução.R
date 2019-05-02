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
sqrt(16)#Raiz quadrada
abs(-1) #absoluto

##################################################################################################
###################################Operadores Relacionais no R####################################
##################################################################################################

#Os operadores são: < Menor que
#                   > Maior que
#                   <= Menor ou igual
#                   >= Maior ou igual
#                   == Igual a
#                   != Diferente de
#Esses operadores retornam TRUE se a relação for verdadeira e FALSE se for falsa
2 < 0
5 > 4
4 >= 4
4 <= 6
1 == 2
1 == 1
1 != 1
1 != 2

#########Classes##########

#Podemos usar a função class() para descobrir a classe ou tipo de um objeto

#Pedindo ajuda sobre a função
?class #também é possível pedir ajuda clicando em "F1" com o cursor no nome da função
help(class)

class(4)
class("ISP dados") #Caracteres devem ser declarados entre aspas
class(TRUE)

####Criação de sequências####
#Podemos usar ":" para criar uma sequência no R
1:10
1:50
-5:5

#Caso seja necessário criar sequências que não sejam de números inteiros ou  não consecutivas, 
#podemos usar a função
#seq(.)

#Pedindo ajuda sobre a função
?seq
help(seq)

seq(from = 1, to = 10, by = 0.5)
seq(-10, 10, 0.1)
seq(by = -0.1, from = 10, to = -10)

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

c("a", "b", "c", "d", "e", "f", "g", "h")
c(letters[1:8])
class(letters[1:8])

c(TRUE, FALSE, TRUE, TRUE)
class(c(TRUE, FALSE, TRUE, TRUE))

c(1,letters[1:8])
class(c(1,letters[1:8])) #Note que o número 1 é convertido em caractere

####Matriz#####

#Utilizamos a função matrix(.) para construit matrizes
?matrix

matrix(1:9, ncol = 3)
matrix(1:12, nrow = 3) #É preciso especificar o número de linhas ou de colunas, não é necessário colocar ambos os argumentos
matrix(1:9, ncol = 3, byrow = TRUE)

matrix(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), nrow = 3, ncol = 4)
class(matrix(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), nrow = 3, ncol = 4))

matrix(letters[1:12], nrow = 3, ncol = 4)
class(matrix(letters[1:12], nrow = 3))


#Usando a função array para criar uma matrix
?array

array(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), dim = c(3, 4))
array(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), dim = c(12))
class(array(c(10, 34, 45, 52, 99, 101, 73, 90, 45, 66, 23, 11), dim = c(3, 4)))
class(array(c(10, 34, 45), dim = c(3, 1)))


#Matrizes e vetores armazenam dados de apenas uma classe
c(1, 2, 3, 4, 5, "Jonas", 14, 21)
class(c(1, 2, 3, 4, 5, "Jonas", 14, 21))

matrix(c(10, 34, 45, 52, "Bárbara", 101, 73, 90, 45, 66, 23, 11), nrow = 3, ncol = 4)

######Lista#####

#Vamos usar a função list(.) nesse caso
?list

#A lista aceita qualquer tipo de dado, vetor, matriz
list(Nomes = c("Erick", "Louise"), Idades = c(32, 25))
class(list(Nomes = c("Erick", "Louise"), Idades = c(32, 25)))

#Elementos dentro da lista podem ter comprimentos diferences
list(Nomes = c("Erick", "Louise", "Carlos"), Idades = c(32, 25))

#Uma lista também pode conter elementos de diferentes dimensões
list(Vetor = seq(1,21,3),
     Matriz = matrix(letters[seq(1,24,2)], nrow = 3, ncol = 4))

####Data Frame#####
#Data frame armazena classes e tipos diferentes em um formato semelhante ao de uma matriz, desde que tenham as mesmas dimensões

#Para criar um data frame utilizamos a função data.frame(.)

data.frame(Id = c(1, 2, 3, 4, 5, 6, 7, 8),
           Nomes = c("Leonardo", "Nadine", "Carlos", "Vanessa", "Luciano", "Elisângela", "Emmanuel", "Flávia"))

data.frame(Id = c(1, 2, 3, 4, 5, 6, 7, 8),
           Nomes = c("Leonardo", "Nadine", "Carlos", "Vanessa", "Luciano", "Elisângela", "Emmanuel", "Flávia"),
           Equipe = rep("projetos",8))
?rep

class(data.frame(Id = c(1, 2, 3, 4, 5, 6, 7, 8),
                 Nomes = c("Leonardo", "Nadine", "Carlos", "Vanessa", "Luciano", "Elisângela", "Emmanuel", "Flávia")))
      

#####Fator######

#Para comunicar o R que uma variável possui valores nominais, vamos utilizar a função factor
?factor

factor(c(rep("masculino", 5), rep("feminino", 8))) #A função rep(.) produz repetições de um elemento, para ver o help digite ?rep no console

factor(c(rep(1, 5), rep(0, 8)))
factor(c(rep(1, 5), rep(0, 8)), labels = c("masculino","feminino"))

class(factor(c(rep(1, 5), rep(0, 8)), labels = c("masculino","feminino")))


#############################################################################################################
###########################################Criação de Variáveis no R#########################################
#############################################################################################################

#Quando começamos a construir sintaxes mais complexas, podemos desejar armazenar determinados valores para 
#nos referirmos a eles posteriormente. Nessas horas, a criação de variáveis pode ser extremamente útil

#Quando falamos de estrutura de dados, também tocamos brevemente no assunto tipos de dados (numérico, caractere, lógico),
#o R aceita a declaração de variáveis que sejam de qualquer um dos tipos suportados pela linguagem.

#O nome da variável é "a" e a forma usada para criá-la é com um sinal de menor e um traço "<-"

a <- 4
class(a)

b <- "olá, pessoal!"
class(b)

c <- TRUE #Cuidado ao nomear a sua variável. Não é recomendado dar um nome que seja uma função do R.
class(c)

#o R não aceita nomear variáveis quando o nome começa com um número (ex: 1aux).

#1aux <- 1:5

#Para visualizar o valor guardado na variável, podemos utilizar a função print(.)
print(a)
print(b)
print(c)

#Ou podemos simplesmentes escrever o nome da variável e rodar
a
b
c

#Também podemos armazenar qualquer uma das estruturas de dados discutidas anteriormente em variáveis

#####Vetor numérico####

meu_vetor <- 1:5
class(meu_vetor)
is.vector(meu_vetor) #Retorna TRUE se o objeto for um vetor
meu_vetor

meu_vetor2 <- seq(1, 10, by = 0.5) #cria uma sequência
class(meu_vetor2)
is.vector(meu_vetor2)
meu_vetor2

#####Vetor de caracteres#####

meu_vetor3 <- c("Ribeiro", "Jonas", "Bárbara", "Karina")
class(meu_vetor3)
is.vector(meu_vetor3)
print(meu_vetor3)

meu_vetor4 <- c(letters[1:5])
class(meu_vetor4)
is.vector(meu_vetor4)
print(meu_vetor4)

######Matrizes#####

matriz1 <- matrix(seq(1, 9, by = 1), ncol = 3)
matriz1 <- matrix(1:9, ncol = 3)
matriz1
class(matriz1) #class(.) também retorna o tipo do objeto
is.matrix(matriz1) #Retorna TRUE se o objeto for uma matriz

matriz2 <- matrix(c(1, 2, "a", 4, 5, 6, "Biral", 44, 100), nrow = 3)
matriz2 #Matrizes só aceitam variáveis de um único tipo, portanto o R força todas as variáveis serem do mesmo tipo, por isso mesmo os números aparecem entre aspas

######Listas######

lista1 <- list(Nomes = c("Adriana", "Werneck", "Lívia"), Instituição = rep("ISP",3))
lista1
class(lista1)
is.list(lista1)

lista2 <- list(titulos = c("Dom Casmurro", "Memórias Póstumas de Brás Cubas"),
               autores = c("Machado de Assis"),
               traducao = c(14, 12))
lista2 #Uma lista pode armazenar elementos de diferentes comprimetos

#####Data Frames####
df1 <- data.frame(Id = 1:8,
                  Nomes = c("Leonardo", "Nadine", "Carlos", "Vanessa", "Luciano", "Elisângela", "Emmanuel", "Flávia"))
df1
class(df1)

#################################################################################################
#########################################Exclusão de variáveis###################################
#################################################################################################

#No caso de listas e data frames podemos usar uma forma especial para excluir um elemento da lista
#ou uma coluna inteira do data frame

lista1$Instituição <- NULL

df1$Id <- NULL

#Para excluirmos variáveis no R podemos utilizar as funções remove(.) e rm(.)

remove(df1)
df1 #Não está mais definido

rm(lista2)
lista2 

#Caso queira remover todas as variáveis armazenadas no 'environment', basta usar

rm(list = ls())

##################################################################################################
#################################Geração de números aleatórios####################################
##################################################################################################

#O ISP precisa gerar máscaras para o número do registro de ocorrência, gerar chaves para o banco de dados,
#entre outras atividades que requerem números aleatórios.

#Os números aleatórios são amostrados de distribuições de probabilidade, o R suporta uma grande quantidade
#dessas distribuições. Dentre elas temos a normal, uniforme, binomail, etc. . .

set.seed(7) #Comando para fixar a geração de valores aleatórios
aux <- rnorm(1000, mean = 500, sd = 25) #Gerando 1000 valores de uma distribuição normal com média 500 e desvio padrão 25
head(aux,20)

set.seed(7)
aux2 <- runif(1000, min = 5, max = 10) #Gerando 1000 valores de uma uniforme no intervalo (5, 10)
head(aux2,20)

##################################################################################################
#################################Instalação e carregamentos de pacotes############################
##################################################################################################

#O R possui uma série de bibliotecas disponíveis na internet de maneira gratuita, sendo necessário
#apenas realizar o download e o carregamento dessa bibliotecas para que todas as funções disponíveis
#nelas possam ser utilizadas.

#Para instalar um pacote vamos utilizar a função install.packages(.)
?install.packages

install.packages("gglopt2") #repare que o nome do pacote deve estar entre aspas
install.packages("foreign")
install.packages("haven")

#Para verificar se o pacote está de fato instalado, basta usar a função installed.packages(.)
?installed.packages

installed.packages("ggplot2")

#Para ativar o pacote e começar a utilizar suas funções, podemos utilizar tanto a função require(.)
#como a função library(.)

#No caso de uma função presente em algum pacote, devemos carregar o pacote para invocar a função


painel_upp <- read.dta13("//10.230.13.210/bd/Sispes/painel_upp.dta")

library("readstata13")
painel_upp <- read.dta13("//10.230.13.210/bd/Sispes/painel_upp.dta")
