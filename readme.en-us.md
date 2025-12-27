Accessing Ipeadata data via API
================
Paulo Icaro
2025-12-26

## Extracting the data

<p>

     This tutorial focus on helping any research to get Ipeadata
databases by acessing its API. In essence, this repo contains three
script which are **Ipeadata_Query**[^1], **Ipeadata_URL**[^2] and
**Ipeadata_API**[^3]. The last two function are the engine for accessing
the data. The **Ipeadata_URL** function generates the necessary URL
while the **Ipeadata_API** is responsible for extraction the data.
Finally, the **Ipeadata_Query** function combines the former functions
in order to make things easier.

     Put into few words, the researcher only has to put a few arguments
in to the **Ipeadata_Query** function:

- ipeadata_series_code: code of the series to be extracted.
- ipeadata_series_name: name of the series to be extracted.
- time_interval: period[^4] (years) corresponding the data to be
  extracted.
- source_github: this optional argument allows the researcher to choose
  whether to source the function from this repo or from a local folder.

     Let’s see an example. Suppose we want to extract the Brazilian
Price Index and also its GDP in the interval 2015-2025. Meanwhile the
former has a monthly frequency, the latter is a annual series:

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

      The fact that the two time-series have different frequencies imply
an unbalanced dataset. This situation will not mean major problems once
we take some precautions. For this instance, we will have a database
with 131 monthly observations representing the price index series and 10
observations each representing a year always put into the first month of
the dataset. In this case there will be no problem for all the data are
extracted.  
      Inversely, if we had picked the GDP series first, we would face
significant issues. In fact, we would only have 10 observations: the
yearly GDP series observations and the first month Price Index series of
each year.

      Therefore, two solutions to circumvent the problem arise:

- When specifying the series to be collected, **the order of variable
  definition should always be such that the high-frequency series are
  always first**.

- Import series together according to their temporal frequency. This
  alternative will require using the **Ipeadata_Query** function more
  than once.

[^1]: <https://github.com/paulo-icaro/Ipeadata_API/blob/main/Ipeadata_Query.R>

[^2]: <https://github.com/paulo-icaro/Ipeadata_API/blob/main/Ipeadata_URL.R>

[^3]: <https://github.com/paulo-icaro/Ipeadata_API/blob/main/Ipeadata_API.R>

[^4]: Of course there are several databases with different time
    frequencies. However, for a standard extraction the code only
    filters the data based on the years of the series.
