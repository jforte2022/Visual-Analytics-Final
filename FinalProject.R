library(lubridate)
library(ggplot2)
library(dplyr)

crime <- read.csv("crime.csv")
crime$DISPATCHED <- gsub(" PM", "", crime$DISPATCHED)
crime$DISPATCHED <- as.Date(crime$DISPATCHED, format = "%m-%d-%Y%H:%M")
crime$weekday <- wday(crime$DISPATCHED, label = T)
crime$DESCRIPTION <- as.factor(crime$DESCRIPTION)
crime$GRID <- as.factor(crime$GRID)

crimeCount <- crime %>% 
  count(DESCRIPTION, weekday) %>% 
  arrange(desc(n))

ggplot(crimeCount, aes(n, DESCRIPTION, fill = weekday)) + 
  geom_col() +
  labs(title = "Crime Counts by Type per Weekday: 4/18/23 to 4/24/23", x = "Count", y = "Crime") + 
  theme(axis.text.y = element_text(size = 7))

ggplot(crimeCount[1:50, ], aes(n, DESCRIPTION, fill = weekday)) + 
  geom_col(show.legend = F) +
  facet_wrap(~weekday, scales = "free") +
  labs(title = "Crime Counts by Type per Weekday: 4/18/23 to 4/24/23", x = "Count", y = "Crime") + 
  theme(axis.text.y = element_text(size = 7),
        axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5))
