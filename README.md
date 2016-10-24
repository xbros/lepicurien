Some data manipluation for L'Epicurien
=======================================

install R
```
sudo apt install r-base
```

start R
```
cd /path/to/your/data
R
```

run R script
```{r}
# install packages the first time
install.packages(c("tidyr", "dplyr"))

# run script
source("join_wp_pos.r")

# quit
q()
```
