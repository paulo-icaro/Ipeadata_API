Obtendo dados do Ipeadata via API
================
Paulo Icaro
2025-12-26

## Extraindo os dados

<p>

      Este tutorial visa auxiliar pesquisadores a coletar bases de dados
do Ipeadata disponíveis em sua API. Em sua essência, este repositório
possui três scripts principais: **Ipeadata_Query**[^1],
**Ipeadata_URL**[^2] e **Ipeadata_API**[^3]. As duas últimas funções
atuam em conjunto como a engrenagem para obtenção das bases de dados. Se
por um lado a função **Ipeadata_URL** atua na criação das URLs onde os
dados estão localizados, por outro **Ipeadata_API** é responsável por
extrair a informação lá localizada. Por fim, a função **Ipeadata_Query**
combina estas duas funções de forma a tornar simples o trabalho de
coleta dessas informações.

      Os argumentos da função **Ipeadata_Query** são:

- ipeadata_series_code: codigo das séries a serem extraidas.
- ipeadata_series_name: nome das séries a serem extraidas.
- time_interval: período[^4] (ano) correspondente ao dado a ser
  extraído.
- source_github: Este argumento é opcional e permite ao pesquisador
  escolher acessar a função diretamente deste diretório ou de uma cópia
  das funções disponíveis em sua máquina local.

      Vejamos um exemplo. Suponha que desejamos coletar os dados
referente ao Índice de Preços (IPCA) e ao PIB brasileiro no período
2015-2025. Enquanto a série de preços possui frequência mensal, o PIB
possui frequência anual.

</p>

``` r
# ======================= #
# === Data Extraction === #
# ======================= #

# --- Ipeadata Query Function --- #
source('https://raw.githubusercontent.com/paulo-icaro/Ipeadata_API/refs/heads/main/Ipeadata_Query.R')

# --- Previous Info --- #
series_code = c('PRECOS12_IPCA12', 'WEO_PIBWEOBRA')
series_name = c('br_price_index', 'br_gdp')
period = as.character(x = 2015:2025)


database = ipeadata_query(series_code, series_name, period)
print(head(database, 15), row.names = FALSE)
```

                          data br_price_index   br_gdp
     2015-01-01T00:00:00-02:00        4110.20 1800.046
     2015-02-01T00:00:00-02:00        4160.34       NA
     2015-03-01T00:00:00-03:00        4215.26       NA
     2015-04-01T00:00:00-03:00        4245.19       NA
     2015-05-01T00:00:00-03:00        4276.60       NA
     2015-06-01T00:00:00-03:00        4310.39       NA
     2015-07-01T00:00:00-03:00        4337.11       NA
     2015-08-01T00:00:00-03:00        4346.65       NA
     2015-09-01T00:00:00-03:00        4370.12       NA
     2015-10-01T00:00:00-03:00        4405.95       NA
     2015-11-01T00:00:00-02:00        4450.45       NA
     2015-12-01T00:00:00-02:00        4493.17       NA
     2016-01-01T00:00:00-02:00        4550.23 1796.622
     2016-02-01T00:00:00-02:00        4591.18       NA
     2016-03-01T00:00:00-03:00        4610.92       NA

<p>

      O fato das duas séries terem frequências temporais diferentes
implica em um conjunto de dados desigual. Esse ponto não será um
problema desde que alguns cuidados sejam tomados. Neste exemplo, temos
131 observações mensais versus 10 observações anuais disponibilizadas
sempre no primeiro mês de cada ano. Nesse caso não haverá problema em
razão de que todos os dados foram acessados.  
      Contudo, caso na especificação das variáveis estivesse invertida
(PIB e IPCA), teriamos somente 10 observações no total, onde somente a
primeira observação de cada ano seria aproveitada para o caso da série
de preços.

      Dessa maneira duas soluções para contornar o problema surgem:

- Ao informar as séries a serem coletadas, a ordem de definição das
  variáveis devem sempre ser feita de modo que as séries de
  alta-frequência estejam sempre em primeiro lugar.
- Importar séries juntas de acordo com sua frequência temporal. Nessa
  alternativa será necessário utilizar a função **Ipeadata_Query** mais
  de uma vez.

</p>

[^1]: <https://github.com/paulo-icaro/Ipeadata_API/blob/main/Ipeadata_Query.R>

[^2]: <https://github.com/paulo-icaro/Ipeadata_API/blob/main/Ipeadata_URL.R>

[^3]: <https://github.com/paulo-icaro/Ipeadata_API/blob/main/Ipeadata_API.R>

[^4]: Certamente, existem diversas bases de dados com diferentes
    frequências. No entanto, para uma extração padronizada o código
    somente irá filtrar os dados baseado no ano da série.
