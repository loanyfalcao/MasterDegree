install.packages("pacman")
install.packages("ggplot2")
install.packages("lmtest")

library(lmtest)
library(pacman)
library(ggplot2)
pacman::p_load(dplyr, psych, car, MASS, DescTools, QuantPsyc, ggplot2)

setwd("C:/Users/Public/Documents/Python Scripts/MasterDegree")

dados <- read.csv('Arquivos/Logit/df_vitimas_acidentes_2_2010-2022.csv', stringsAsFactors = TRUE, fileEncoding = "latin1")

str(dados)



dados$Gravidade <- factor(dados$Gravidade, levels = c("1", "0")) # Fatal = categoria de referencia
levels(dados$Gravidade)

dados$Sexo <- relevel(dados$Sexo, ref = "M")
dados$Faixa_Etaria <- relevel(dados$Faixa_Etaria, ref = "18-24 anos")
dados$CondicaoPista <- relevel(dados$CondicaoPista, ref = "Seca")
dados$PerfilPista <- relevel(dados$PerfilPista, ref = "Em Nivel")
dados$Estacao <- relevel(dados$Estacao, ref = "Verão")
dados$Local <- relevel(dados$Local, ref = "Principal")
dados$TipoAcidente <- relevel(dados$TipoAcidente, ref = "Queda de Moto")
dados$TracadoPista <- relevel(dados$TracadoPista, ref = "Reta")
dados$TipoLocal <- relevel(dados$TipoLocal, ref = "Rural")
dados$Num_Veiculos <- relevel(dados$Num_Veiculos, ref = "Um")
dados$Motocicleta <- relevel(dados$Motocicleta, ref = "True")
dados$Veiculo_Leve <- relevel(dados$Veiculo_Leve, ref = "True")
dados$Veiculo_Pesado <- relevel(dados$Veiculo_Pesado, ref = "True")
dados$Veiculo_Passageiro <- relevel(dados$Veiculo_Passageiro, ref = "True")
dados$Cluster <- relevel(dados$Cluster, ref = "True")
dados$Ano_2014 <- relevel(dados$Ano_2014, ref = "True")


mod <- glm(Gravidade ~ Sexo + Faixa_Etaria + CondicaoPista + PerfilPista + Estacao + Período + TipoAcidente + TracadoPista + TipoLocal + Motocicleta + Veiculo_Leve + Veiculo_Pesado + Veiculo_Passageiro + Volume_Log + Num_Veiculos + TracadoPista*CondicaoPista,
           family = binomial(link = 'logit'), data = dados)

#teste wald
vcov_mat <- vcov(mod)
wald_stat <- (coef_est / sqrt(diag(vcov_mat)))^2

df <- length(coef_est) #graus de liberdade
p_value <- 1 - pchisq(wald_stat, df)
print(data.frame(Wald_Test_Statistic = wald_stat, P_Value = p_value))


# Obtenha os coeficientes estimados do modelo
coef_est <- coef(mod)
print(coef_est)


dados_filtrados <- dados[c("Sexo", "Faixa_Etaria", "CondicaoPista", "PerfilPista", "Estacao", "Período", "TipoAcidente", "TracadoPista", "TipoLocal", "Motocicleta", "Veiculo_Leve", "Veiculo_Pesado", "Veiculo_Passageiro", "Volume_Log", "Num_Veiculos")]

#Ausencia de outliers/ pontos de alavancagem
boxplot(dados_filtrados)
plot(mod, which = 5)


summary(stdres(mod))


pairs.panels(dados_filtrados) # Multicolinearidade: r > 0.9 (ou 0.8)

VIF(mod)

## Overall effects. Quanto menor o Pvalue, mais influente
Anova(mod, type = 'II', test = "Wald")

## Efeitos especificos
summary(mod)


## Obtencao das razoes de chance com IC 95% (usando erro padrao = SPSS)
exp(cbind(OR = coef(mod), confint.default(mod)))



################################################ Segundo modelo ###############################################################

mod2 <- glm(Gravidade ~ Sexo + Faixa_Etaria + CondicaoPista + PerfilPista + Estacao + Período + TipoAcidente + TracadoPista + TipoLocal + Motocicleta + Veiculo_Pesado + Veiculo_Passageiro + Volume_Log + Num_Veiculos + TracadoPista*CondicaoPista,
            family = binomial(link = 'logit'), data = dados)

#teste wald
vcov_mat <- vcov(mod2)
wald_stat <- (coef_est / sqrt(diag(vcov_mat)))^2

df <- length(coef_est) #graus de liberdade
p_value <- 1 - pchisq(wald_stat, df)
print(data.frame(Wald_Test_Statistic = wald_stat, P_Value = p_value))



coef_est <- coef(mod2) #Obtenha os coeficientes estimados do modelo
print(coef_est)


dados_filtrados2 <- dados[c("Sexo", "Faixa_Etaria", "CondicaoPista", "PerfilPista", "Estacao", "Período", "TipoAcidente", "TracadoPista", "TipoLocal", "Motocicleta", "Veiculo_Pesado", "Veiculo_Passageiro", "Volume_Log", "Num_Veiculos")]


boxplot(dados_filtrados) #Ausencia de outliers/ pontos de alavancagem
plot(mod2, which = 5)


summary(stdres(mod2)) #Precisa ficar entre -3 e 3

pairs.panels(dados_filtrados) #Multicolinearidade: r > 0.9 (ou 0.8)

VIF(mod2)# Multicolinearidade: VIF > 10


## Overall effects. Quanto menor o Pvalue, mais influente
Anova(mod2, type = 'II', test = "Wald")

## Efeitos especificos
summary(mod2)


## Obtencao das razoes de chance com IC 95% (usando erro padrao = SPSS)
exp(cbind(OR = coef(mod2), confint.default(mod2)))


################################################ Comparando modelos ###############################################################

PseudoR2(mod, which = "Nagelkerke")
PseudoR2(mod2, which = "Nagelkerke")


AIC(mod, mod2)
BIC(mod, mod2)




