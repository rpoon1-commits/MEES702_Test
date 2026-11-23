# 1) Message
library(mgcv)
mgcv::lp()

library(gamlss)
gamlss::lp()



# NO Warning
tmp = as.Date(c("2026-11-23", 35))
tmp

# 2) Warning
log(-6)

tmp = c(-1, 20)
tmplog = log(tmp)

# If we decide to proceed
na.omit(tmplog)
tmp[is.na(tmplog)]

# ggplot() + geom_point()


# 3) Error
lm(x ~ y)

# Tools
traceback()
