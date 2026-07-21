# ==================== #
# === RENDER FILES === #
# ==================== #

# --- Script by: Paulo Icaro --- #


# ------------------- #
# --- Bibliotecas --- #
# ------------------- #
library(quarto)


# -------------------- #
# --- Renderização --- #
# -------------------- #
files = c('readme_en_us.qmd', 'readme_pt_br.qmd')
formats = c('pdf', 'gfm', 'html')

for (i in seq_along(files)){
  for (j in seq_along(formats)){
    quarto_render(input = files[i], output_format = formats[j])
  }
}


# --------------- #
# --- Limpeza --- #
# --------------- #
rm(files, formats, i, j)