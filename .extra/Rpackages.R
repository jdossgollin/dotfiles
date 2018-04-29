if(!require(pacman))
  install.packages('pacman')

# data manipulation
pacman::p_load(tidyverse)
pacman::p_load(data.table)
pacman::p_load(reshape2)

# modeling
pacman::p_load(rstan)
pacman::p_load(rstanarm)
pacman::p_load(bayesplot)
pacman::p_load(loo)
pacman::p_load(projpred)
if (!require(caret)){
  install.packages('caret', dependencies = 'Suggests')
}


# spatial statistics
pacman::p_load(sp)
pacman::p_load(gstat)
pacman::p_load(automap)

# plotting and mapping
pacman::p_load(viridis)
pacman::p_load(ggthemes)
pacman::p_load(leaflet)
pacman::p_load(ggmap)