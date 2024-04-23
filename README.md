# MasterDegree
O trabalho tem como objetivo analisar os principais fatores para a ocorrencia de fatalidades.

São dois arquivos:
- Acidentes, onde cada linha é um acidente
- Vitimas, cada linha é uma vitima, e cada acidente pode possuir varias vitimas

1. Primeiramente foi feito o tratamento desses dadados no arquivo [Tratamento]([caminho-para-o-arquivo/arquivo.md](https://github.com/loanyfalcao/MasterDegree/blob/f2f1932f0dabfa23ca230b2faa863452a7197e60/Tratamento.ipynb)):
2. No arquivo [DadosAbertosANTT]([caminho-para-o-arquivo/arquivo.md](https://github.com/loanyfalcao/MasterDegree/blob/f2f1932f0dabfa23ca230b2faa863452a7197e60/Dados_Abertos_ANTT.ipynb)) foi incluido dados abertos da ANTT:
    - Volume de trafego, porém foi necessario fazer uma regressão para tratar dados zerados ou muito discrepantes, para isso foram feito analises com boxblot
    - Marginal: se no ponto havia ou nao marginal
3.  No arquivo [DBSCAN]([caminho-para-o-arquivo/arquivo.md](https://github.com/loanyfalcao/MasterDegree/blob/f2f1932f0dabfa23ca230b2faa863452a7197e60/DBSCAN.ipynb)) foi gerado um modelo de cluster por densidade para analisar as regiões com maior numero de acidentes e assim incluir essa variavel no modelo
4.  [RegressaoLogistica]([caminho-para-o-arquivo/arquivo.md](https://github.com/loanyfalcao/MasterDegree/blob/f2f1932f0dabfa23ca230b2faa863452a7197e60/Regress%C3%A3o%20Log%C3%ADstica%20Bin%C3%A1ria.R)) é o arquivo com o modelo de regressão logistica, no qual foram feitos analises de quais variaveis entrariam ou não no modelo.



### Cluster
TOP15 maiores clusters com base na soma do UPS 
<img src="https://github.com/loanyfalcao/MasterDegree/assets/156198809/97772516-36b1-40af-8102-0c99bd819770" width="500" height="300">

<img src="https://github.com/loanyfalcao/MasterDegree/assets/156198809/57cbaa4c-c995-481f-b647-43f04a23d68e" width="300" height="300">



### Regressão Logistica
#### Os residuos padronizados 
- Entre 3 e -3, sendo aceito
<img width="400" alt="image" src="https://github.com/loanyfalcao/MasterDegree/assets/156198809/f5f0274f-82f5-4add-a09c-01ed46e99fa7">

#### VIF
- Menor que 10
<img width="335" alt="image" src="https://github.com/loanyfalcao/MasterDegree/assets/156198809/931e1560-1549-490a-ac81-26c4c9d79052">

#### Overall effects
- Com excessão de Veiculo_Leve, todos os p_value são menores que 0.05
<img width="383" alt="image" src="https://github.com/loanyfalcao/MasterDegree/assets/156198809/7d0f45b6-df95-4e28-bb99-720112295daf">

#### Residuos especificos
<img src="https://github.com/loanyfalcao/MasterDegree/assets/156198809/abc1ace7-1ddc-423f-a14c-72714aeaf336" width="600" height="500">

#### Razão de chances, considerando os residuos especificos
<img src="https://github.com/loanyfalcao/MasterDegree/assets/156198809/9fe22fc8-d019-42f8-808f-3b26a8f9f31c" width="1000" height="500">



**OBS:** Foi gerado um segundo modelo sem a variavel "Veiculo_Leve", porém os valores de AIC e BIC não tiveram muita variação, o primeiro modelo então foi mantido.





## Resultados
**Genero da vítima**: A razão de chances para uma vítima do sexo masculino foi de 1,31, o que denota que os homens têm 31% mais chance de ser uma vítima fatal ou grave em acidentes, quando comparados às mulheres.

**Condições de pista**: Condições de pista molhada estão associadas a um aumento de 14% na chance de uma vítima ser fatal ou grave em acidentes, em comparação com as condições de pista seca.

**Perfil de pista**: Acidentes em em declive estão associados a uma redução de 13% na chance de uma vítima ser fatal ou grave, em comparação com pistas em nível.

**Estação do Ano**: Durante o verão, a razão de chances foi de 1.12, o que sugere um aumento de 12% na chance de uma vítima ser fatal ou grave em acidentes, e 15% durante a primavera em comparação com o inverno.

**Periodo do dia**: Acidentes que ocorrem durante a noite estão associados a uma redução de 17% na chance de uma vítima ser fatal ou grave, em comparação com os acidentes que ocorrem durante o dia.

**Tipo de Acidente**: Para o tipo de acidente, todas as categorias significativas apresentaram redução na chance de vítima ser fatal ou grave quando comparado com “Queda de Moto”:

•	Colisão Lateral/Transversal: Redução de 21%;

•	Capotamento: Redução de 42%;

•	Choque: Redução de 37%;

•	Saída de Pista: Redução de 21%;

•	Colisão Frontal: Redução de 69%;

•	Atropelamento - Animal: Redução de 42%;

•	Outros (submersão, explosão, incêndio, etc): Redução de 3%;

**Tipo de Rodovia**: Acidentes em áreas urbanas estão associados a um aumento de 19% na chance de uma vítima ser fatal ou grave, em comparação com áreas rurais.

**Motocicleta**: Motocicletas estão associados a um aumento de 29% na chance de uma vítima ser fatal ou grave, em comparação com acidentes que não envolvem motocicletas.

**Veiculo Leve**: Acidentes envolvendo veículos leves estão associados a uma redução de 9% na chance de uma vítima ser fatal ou grave, em comparação com acidentes que não envolvem veículos leves.

**Veiculo Pesado**: Acidentes envolvendo veículos pesados estão associados a um aumento de 89% na chance de uma vítima ser fatal ou grave, em comparação com acidentes que não envolvem veículos pesados.

**Veiculo Passageiro**: Acidentes envolvendo veículos de passageiros estão associados a um aumento de 30% na chance de uma vítima ser fatal ou grave, em comparação com acidentes que não envolvem veículos de passageiros.

**Volume de Trafego**: O aumento de uma unidade no logaritmo do volume está associado a uma redução de cerca de 15% nas chances de uma vítima ser classificada como grave ou fatal. Sendo uma unidade de 'Volume_Log' igual a 217.117 veículos.
Portanto, podemos interpretar que um aumento de 217.117 veículos absolutos mensalmente está correlacionado a uma redução de aproximadamente 15% nas chances de uma vítima ser classificada como grave ou fatal, considerando todas as outras variáveis constantes.

**Dois ou mais veiculos**: Acidentes envolvendo dois ou mais veículos estão associados a uma redução de 15% na chance de uma vítima ser fatal ou grave, em comparação com acidentes envolvendo apenas um veículo.

**Pista molhada + Reta**: Acidentes em pistas molhadas e retas estão associados a um aumento de 25% na chance de uma vítima ser fatal ou grave, em comparação com acidentes em pistas secas e retas.

