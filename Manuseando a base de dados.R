################################################################################################################
###############################################Manuseando a base de dados#######################################
################################################################################################################

#Agora vamos ver como fazer alterações nas nossas variáveis, criação de subconjuntos e outras operações especiais que
#podem ser muito úteis no dia a dia.

#Estabelecendo o diretório
setwd("D:/Curso-R")

getwd() #Verificando se estamos no diretório correto

#Conferindo se o nosso arquivo de fato está no nosso diretório, vamos abrir o arquivo populacao_munic.xlsx

dir() 

library(openxlsx)

pop <- read.xlsx('populacao_munic.xlsx', sheet = 1, startRow = 1)

View(pop)

################################################################################################################
########################################Realizando filtros e transformações#####################################
################################################################################################################

###subset(.)###

#Essa função extrai um subgrupo de acordo com a condição especificada 

?subset

subset(pop, munic == 'Angra dos Reis', select = pop_munic)

subset(pop, pop_munic < 50000, select = munic)


###with(.)###

#Extrai um subgrupo de acordo com uma condição
?with

with(pop, pop_munic[munic == 'Rio de Janeiro'])

with(pop, munic[pop_munic > 500000])


###which(.)###

#Também extrai um subgrupo de acordo com uma condição especificada
?which

which(pop$munic == 'Niterói') #Retorna o índice de Niterói no banco

#Podemos então, observar o valor da linha

pop[48,] 

#Ou ainda

pop[which(pop$munic == 'Niterói'),]

#Usando o which dentro da selação

pop$pop_munic[which(pop$munic == 'Niterói')]


###ifelse(.)###

#Essa função retorna dois valores pré especificados, um caso a condição seja verdadeira e outro caso ela seja falsa
?ifelse

ifelse(pop$munic == 'Niterói', TRUE, FALSE)



#Essa indicadora em muitos casos será usada como função auxiliar para a realização de uma operação no banco de dados

#Por exemplo, se quisermos saber quantas cidades possuem menos de 50000 habitantes

pop$id <- ifelse(pop$pop_munic < 50000, 1, 0) #Cria uma variável que indica os municípios com menos de 50000 habitantes

pop$id

View(pop)

#Se quisermos saber quantas cidades possuem menos de 50000 hab, por exemplo, basta somar essa variável id

sum(pop$id) #54 das 92 cidades do RJ possuem menos de 50000 habitantes


###sample(.)###

#Essa função retira uma amostra aleatória de uma variável. Repare que podemos 

#Amostra aleatória

?sample

sample(pop$munic[which(pop$id == 1)], replace = F, size = 5)

sample(pop$pop_munic, replace = T, size = 10)


################################################################################################################
################################################Alteração de tipos##############################################
################################################################################################################

#Vamos agora abrir o arquivo populacao_munic_mes.xlsx

dir() #Verificando se ele está no diretório

#Alteração de tipo

pop2 <- read.xlsx("populacao_munic_mes.xlsx", sheet = 1, startRow = 1)

#No mundo real não existe fração de uma pessoa

pop2$pop_munic <- as.integer(pop2$pop_munic)

View(pop2)

#Mudar números para nomes dos meses

pop2$mes[which(pop2$mes == 1)] <- 'Jan'
pop2$mes[which(pop2$mes == 2)] <- 'Fev'
pop2$mes[which(pop2$mes == 3)] <- 'Mar'
pop2$mes[which(pop2$mes == 4)] <- 'Abr'
pop2$mes[which(pop2$mes == 5)] <- 'Mai'
pop2$mes[which(pop2$mes == 6)] <- 'Jun'
pop2$mes[which(pop2$mes == 7)] <- 'Jul'
pop2$mes[which(pop2$mes == 8)] <- 'Ago'
pop2$mes[which(pop2$mes == 9)] <- 'Set'
pop2$mes[which(pop2$mes == 10)] <- 'Out'
pop2$mes[which(pop2$mes == 11)] <- 'Nov'
pop2$mes[which(pop2$mes == 12)] <- 'Dez'

View(pop2)

#Mudar meses para fatores 

class(pop2$mes)

#Usando a função str(.) para verificar a estrura do dado
?str

str(pop2$mes) 

levels(pop2$mes) #Veja que como a variável é do tipo caractere, ela não possui níveis, o que não faz o menor sentido
                 #pois sabemos que os meses representam "categorias" diferentes dentro de um mesmo ano

#Transformando em fator

pop2$mes <- factor(pop2$mes, levels = month.name)

class(pop2$mes)

str(pop2$mes)

levels(pop2$mes)

#Ou ainda podemos fazer isso de maneira mais simples

pop2 <- read.xlsx("populacao_munic_mes.xlsx", sheet = 1, startRow = 1)

pop2$mes2 <- factor(pop2$mes,levels=seq(1:12),labels=c("Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"))

#Vamos agora abrir o arquivo "SSP prisoes_apreensoes 2006.sav" para mostrar que podemos usar a mesma lógica de alteração,
#para transformar uma variável de caractere para numérica

dir()

prisao <- read.csv("SSP prisoes_apreensoes 2006.csv", sep = ";")

View(prisao)

#Repare que a variável sexo está no formato caracter

summary(prisao$sexo)

#No entanto, é comum codificarmos essa variável pelos seguintes números: 1 - Feminino
#                                                                        2 - Masculino
#                                                                        77 - Ignorado
#                                                                        88 - Não informado

#Podemos usar o mesmo método que empregamos anteriormente para transformar os meses que eram números em caracteres

prisao$sexo[which(prisao$sexo == 'Feminino')] <- 1
prisao$sexo[which(prisao$sexo == 'Masculino')] <- 2
prisao$sexo[which(prisao$sexo == 'Ignorado')] <- 77
prisao$sexo[which(prisao$sexo == 'Sem informação')] <- 88

#Repare que ao rodarmos as linhas de código acima, iremos obter um erro! Esse erro ocorre porque a classe da variável
#sexo é 'factor', portanto estamos tentando colocar nessa variável um fator que não pertence aos seus níves

class(prisao$sexo)

levels(prisao$sexo) #Repare que não enxergamos 1, 2, 77 ou 88 

#Entretanto, repare que o R apagou os campos dessa variável

summary(prisao$sexo)

#Então, vamos ler o arquivo novamente

prisao <- read.csv("SSP prisoes_apreensoes 2006.csv", sep = ";")

summary(prisao$sexo)

summary_genero <- summary(prisao$sexo) #Vamos armazenar essa saída para uso posterior

#Logo vamos convertê-la para caracter para fazermos essa alteração

prisao$sexo <- as.character(prisao$sexo)

prisao$sexo[which(prisao$sexo == 'Feminino')] <- 1
prisao$sexo[which(prisao$sexo == 'Masculino')] <- 2
prisao$sexo[which(prisao$sexo == 'Ignorado')] <- 77
prisao$sexo[which(prisao$sexo == 'Não informado')] <- 88

View(prisao$sexo)

class(prisao$sexo)

#Vamos converter para fator novamente 

prisao$sexo <- as.factor(prisao$sexo)

class(prisao$sexo)

summary(prisao$sexo)

summary_genero #Repare que o resultado obtido é o mesmo

################################################################################################################
###########################################Mudando o formato dos dados##########################################
################################################################################################################

###Adicionando linhas e colunas###

#Por suposição, vamos imaginar que uma nova variável nos foi enviada e que devemos anexar esse variável ao banco de 
#dados de população do ano de 2018. Imagine ainda que essa variável representa o idh da cidade, como anexaríamos 
#ela na nossa matrix de dados?

idh_cidade <- data.frame(Cidade = pop$munic, idh = round(runif(n = 92, min = 0.7, max = 0.96), digits = 3))

View(idh_cidade)

#A forma mais simples de adicionar novas colunas é usando a função cbind(.)

?cbind

#Portanto,

pop <- cbind(pop, idh = idh_cidade$idh) #Repare que podemos dar nomes aos argumentos

View(pop)

#Vamos imaginar agora que depois de uma árdua disputa política entre RJ e SP, a cidade de Queluz-SP passa a ser
#Queluz-RJ, devemos portanto, anexar uma nova linha no nosso banco para representar a 93º cidade do estado do RJ

queluz <- data.frame(fmun_cod = 3309908, 
                     munic = "Queluz",
                     pop_munic = 11309,
                     vano = 2018,
                     id = 1,
                     idh = round(runif(1, min = 0.7, max = 0.96), digits = 3))

#A forma mais simples de adicionar novas linhas é usando a função rbind(.)

?rbind

pop <- rbind(pop, queluz)

#Vamos então ordenar as colunas 

pop <- pop[order(pop$munic),] #Digite ?order no console e clique em Ordering Permutation para acessar o help dessa função


####Reshape####

library(reshape2)

#Os dados da nossa tabela estão num formado chamado wide, podemos querer transformá-lo para o formato long, para
#isso vamos usar a função reshape(.)

?reshape

reshaped <- reshape(pop, 
                    varying = c("pop_munic", "id", "idh"), 
                    v.names = "valor",
                    timevar = "caracteristica", 
                    times = c("pop_munic", "id", "idh"), 
                    new.row.names = 1:279,
                    direction = "long")

ordered_reshaped <- reshaped[order(reshaped$munic),]

#Vamos fazer um outro exemplo

base_dp <- read.csv("Base_DP_consolidado.csv", sep = ";")

names <- c('hom_doloso','lesao_corp_morte','latrocinio','hom_por_interv_policial','tentat_hom','lesao_corp_dolosa','estupro','hom_culposo','lesao_corp_culposa','roubo_comercio','roubo_residencia',	'roubo_veiculo','roubo_carga','roubo_transeunte','roubo_em_coletivo','roubo_banco','roubo_cx_eletronico','roubo_celular','roubo_conducao_saque','roubo_bicicleta','outros_roubos','total_roubos',	'furto_veiculos','furto_bicicleta','outros_furtos','total_furtos','sequestro','extorsao','sequestro_relampago','estelionato','apreensao_drogas','recuperacao_veiculos','apf','aaapai','cmp','cmba',	'ameaca','pessoas_desaparecidas','encontro_cadaver','encontro_ossada','pol_militares_mortos_serv','pol_civis_mortos_serv','indicador_letalidade','indicador_roubo_rua','indicador_roubo_veic',	'registro_ocorrencias')

reshaped2 <- reshape(base_dp, 
                     varying = names, 
                     v.names = "valor",
                     timevar = "titulo", 
                     times = names, 
                     new.row.names = 1:1168078,
                     direction = "long",
                     ids = NULL)

ordered_reshaped2 <- reshaped2[order(reshaped2$mes),]

View(ordered_reshaped2)


####Merge####

#É uma forma de juntar duas bases de dados através de atributos comuns a ambas

?merge

base_municipio <- read.csv(file = "Base_Municipio.csv", header = TRUE, sep = ";")

View(base_municipio)

#Vamos fazer o merge com a base pop

base_municipio$mes[which(base_municipio$mes == 1)] <- 'Jan'
base_municipio$mes[which(base_municipio$mes == 2)] <- 'Fev'
base_municipio$mes[which(base_municipio$mes == 3)] <- 'Mar'
base_municipio$mes[which(base_municipio$mes == 4)] <- 'Abr'
base_municipio$mes[which(base_municipio$mes == 5)] <- 'Mai'
base_municipio$mes[which(base_municipio$mes == 6)] <- 'Jun'
base_municipio$mes[which(base_municipio$mes == 7)] <- 'Jul'
base_municipio$mes[which(base_municipio$mes == 8)] <- 'Ago'
base_municipio$mes[which(base_municipio$mes == 9)] <- 'Set'
base_municipio$mes[which(base_municipio$mes == 10)] <- 'Out'
base_municipio$mes[which(base_municipio$mes == 11)] <- 'Nov'
base_municipio$mes[which(base_municipio$mes == 12)] <- 'Dez'


base_municipio <- merge(x = base_municipio,
                        y = pop2[c("mes", "fmun_cod", "pop_munic")],
                        all.x = FALSE,
                        all.y = TRUE,
                        by = c("mes", "fmun_cod"))


################################################################################################################
############################################Família apply de funções############################################
################################################################################################################

#As funções da família apply permitem a manipulação de partes específicas do nossos dados. Além disso, essas 
#funções representam uma estrutura que permite evitar o uso de loops (estrutura de repetição que será vista
#na próxima semana) o que acelera a leitura dos nossos códigos

dir()

#Vamos abrir a base de armas

armas <- read.xlsx('base_armas_site.xlsx', sheet = 1, startRow = 1)

#Caso estejamos interessados em calcular alguma estatística para algum dos tipos de armas apreendidas, podemos
#fazer referência ao seu nome

max(armas$arma_fabricacao_caseira)

####apply####

#No entanto, caso seja necessário extrair o máximo da distribuição empírica de todos os tipos de armas, teríamos que
#fazer isso para cada nome, porém, com a função apply, isso se torna super simples
?apply

apply(X = armas[,6:17], MARGIN = 2, FUN = max)

#Podemos usar qualquer função no argumento FUN

apply(X = armas[,6:17], MARGIN = 2, FUN = mean)

####lapply#####

#A função lapply tem um funcionamento semelhante ao da função apply, no entanto, ela retorna apenas listas

?lapply

lapply(armas[,6:17], mean) #Repare duas coisas: 1 - Não precisamos especificar MARGIN, pois ela assume que estamos trabalhando com colunas
                           #                    2 - Podemos armazenar essa saída em uma variável e fazer referência a ela utilizando o sinal de dólar $


####sapply####

#Funciona exatamente da mesma forma que a função lapply, entretanto essa função simplifica o resultado, sempre que
#possível. Isto é, ela irá retornar uma estrutura de dados mais simples do que uma lista, que pode ser um vetor ou
#uma matriz

?sapply

#No nosso exemplo com a função lapply, retornar uma lista não é necessária, se usarmos sapply, ela irá simplificar
#a saída para um vetor

sapply(armas[,6:17], mean)


####tapply####

#Por fim, a função tapply pode ser usada para calcular estatísticas de maneira agrupada

#Vamos olhar novamente a nossa base de população mensal pop2

View(pop2)

#Caso estejamos interessados em calcular a população média para a cidade de Niterói nos meses 2018, com o que apren
#demos até agora, essa é uma tarefa simples

mean(pop2$pop_munic[which(pop2$munic == 'Niterói')])

#Agora imagine que vamos fazer isso para cada uma das 92 cidades do estado, essa tarefa seria extremamente enfadonha
mean(pop2$pop_munic[which(pop2$munic == 'Angra dos Reis')])
mean(pop2$pop_munic[which(pop2$munic == 'Aperibé')]) #E assim por diante. . .

#Porém utilizando a função tapply(.) isso se torna ridiculamente simples

?tapply

tapply(pop2$pop_munic, pop2$munic, mean)

#Poderíamos também, utilizar a base de armas para calcular a média de apreensão por RISP

tapply(armas$fuzil, armas$risp, mean)
