install.packages(c("nycflights13", "Lahman"))

library(dplyr)
iris_tbl <- copy_to(sc, iris)
flights_tbl <- copy_to(sc, nycflights13::flights, "flights")
batting_tbl <- copy_to(sc, Lahman::Batting, "batting")
src_tbls(sc)



delays <- flights_tbl %>% filter(dep_delay == 2)
delays
delays %>% summarise(count=n())

delay <- flights_tbl %>% 
 group_by(tailnum) %>%
 summarise(count = n(), dist = mean(distance), delay = mean(arr_delay)) %>%
 filter(count > 20, dist < 2000, !is.na(delay)) %>%
 collect

# plot delays
library(ggplot2)
#install.packages("mgcv") 
library(mgcv)
ggplot(delay, aes(dist, delay)) +
 geom_point(aes(size = count), alpha = 1/2) +
 geom_smooth() +
 scale_size_area(max_size = 2)